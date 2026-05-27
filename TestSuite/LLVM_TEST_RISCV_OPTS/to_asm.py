#!/usr/bin/env python3
"""
Convert extracted pre/post-opt .ll files into RISC-V assembly (.s) files
with src/tgt function pairs.

Strategy: for each function @foo, compile the full pre-opt IR (with @foo
renamed to @src, all other funcs intact) and the full post-opt IR (with @foo
renamed to @tgt, all other funcs intact) separately, then concatenate the
assembly outputs.

This avoids module assembly issues (conflicting definitions, missing metadata)
because each llc invocation gets a complete, valid module.

Usage:
    python3 to_asm.py [--input-dir DIR] [--output-dir DIR] [--llc PATH] [-j N]
"""

import argparse
import re
import subprocess
import sys
import tempfile
from concurrent.futures import ProcessPoolExecutor, as_completed
from pathlib import Path

DEFAULT_INPUT = Path(__file__).parent
DEFAULT_OUTPUT = Path(__file__).parent / "asm"
DEFAULT_LLC = "/home/artjom/Tools/llvm-project/build/bin/llc"


def split_sections(text: str) -> tuple[str, str]:
    """Split file into pre-opt IR and post-opt IR."""
    marker = "; POST-OPT"
    idx = text.find(marker)
    if idx == -1:
        raise ValueError("No POST-OPT marker found")
    pre = text[:idx]
    post = text[idx:]

    pre_lines = []
    for line in pre.splitlines():
        if (
            line.startswith("; Source:")
            or line.startswith("; Variant:")
            or line.startswith("; Command:")
            or line.startswith("; Original:")
            or line.startswith("; =====")
            or line.strip() == "; PRE-OPT (input IR)"
        ):
            continue
        pre_lines.append(line)

    post_lines = []
    started = False
    for line in post.splitlines():
        if not started:
            if line.strip() and not line.startswith(";"):
                started = True
                post_lines.append(line)
        else:
            post_lines.append(line)

    return "\n".join(pre_lines).strip() + "\n", "\n".join(post_lines).strip() + "\n"


def find_function_names(text: str) -> list[str]:
    return re.findall(r"^define\s+.*?@(\w+)\s*\(", text, re.MULTILINE)


def rename_function_in_module(module_text: str, old_name: str, new_name: str) -> str:
    """Rename one function definition @old_name -> @new_name in a full module.
    Also renames all references (@old_name) to avoid broken calls."""
    return re.sub(rf"@{re.escape(old_name)}\b", f"@{new_name}", module_text)


def compile_to_asm(
    llc: str,
    ir_text: str,
    triple: str,
    attrs: str,
    func_name: str | None = None,
    timeout: int = 60,
    opt_level: int = 0,
) -> tuple[bool, str]:
    """Compile LLVM IR to RISC-V assembly via llc."""
    with tempfile.NamedTemporaryFile(mode="w", suffix=".ll", delete=False) as f:
        f.write(ir_text)
        input_path = f.name

    try:
        cmd = [llc, "-mtriple", triple]
        if attrs:
            cmd.extend(["-mattr", attrs])
        cmd.extend([input_path, "-o", "-", f"-O{opt_level}"])
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
        if result.returncode != 0:
            return False, result.stderr[:2000]
        return True, result.stdout
    except subprocess.TimeoutExpired:
        return False, "TIMEOUT"
    except Exception as e:
        return False, str(e)
    finally:
        Path(input_path).unlink(missing_ok=True)


def extract_asm_function(asm_text: str, func_label: str) -> str:
    """Extract assembly for a specific function from full module assembly."""
    lines = asm_text.splitlines()
    start = None
    end = None
    # Look for the function label and its surrounding directives
    for i, line in enumerate(lines):
        stripped = line.strip()
        if (
            stripped == f"{func_label}:"
            or stripped
            == f"{func_label}:                                    # @{func_label}"
        ):
            # Walk back to find .globl or .p2align
            start = i
            for j in range(i - 1, max(i - 10, -1), -1):
                sl = lines[j].strip()
                if (
                    sl.startswith(f".globl\t{func_label}")
                    or sl.startswith(f".globl {func_label}")
                    or sl.startswith(".p2align")
                    or sl.startswith(f".type\t{func_label}")
                    or sl.startswith(f".type {func_label}")
                    or sl == ""
                    or sl.startswith("# --")
                ):
                    start = j
                else:
                    break
            break

    if start is None:
        return ""

    # Find end: next function or end of file
    for i in range(start + 1, len(lines)):
        stripped = lines[i].strip()
        if stripped.startswith("# -- End function"):
            end = i + 1
            break
        if stripped.startswith(f".size\t{func_label},") or stripped.startswith(
            f".size {func_label},"
        ):
            # Include a few more lines (cfi_endproc, End function comment)
            end = i + 1
            for j in range(i + 1, min(i + 5, len(lines))):
                end = j + 1
                if lines[j].strip().startswith("# -- End function"):
                    end = j + 1
                    break

            break

    if end is None:
        end = len(lines)

    return "\n".join(lines[start:end])


def extract_triple_and_attrs(filepath: Path) -> tuple[str, str]:
    with open(filepath) as f:
        for line in f:
            if line.startswith("; Command:") or line.startswith("; Original:"):
                m = re.search(r"-mtriple[=\s]+(\S+)", line)
                triple = m.group(1) if m else ""
                m = re.search(r"-mattr[=\s]+(\S+)", line)
                attrs = m.group(1) if m else ""
                if triple:
                    return triple, attrs
    return "riscv64", "v"


def process_file(
    filepath: Path, llc: str, output_dir: Path
) -> list[tuple[Path, bool, str]]:
    text = filepath.read_text()
    results = []

    try:
        pre_text, post_text = split_sections(text)
    except ValueError as e:
        return [(filepath, False, str(e))]

    pre_funcs = find_function_names(pre_text)
    post_funcs_set = set(find_function_names(post_text))
    matched = [f for f in pre_funcs if f in post_funcs_set]

    triple_cmd, attrs_cmd = extract_triple_and_attrs(filepath)

    try:
        rel = filepath.relative_to(DEFAULT_INPUT)
    except ValueError:
        rel = filepath.name

    for func_name in matched:
        # Create renamed modules
        src_module = rename_function_in_module(pre_text, func_name, "src")
        tgt_module = rename_function_in_module(post_text, func_name, "tgt")

        # Compile both to assembly
        src_ok, src_asm = compile_to_asm(llc, src_module, triple_cmd, attrs_cmd)
        if not src_ok:
            stem = filepath.stem
            out_name = f"{stem}.{func_name}.s" if len(matched) > 1 else f"{stem}.s"
            out_dir = output_dir / filepath.parent.name
            out_dir.mkdir(parents=True, exist_ok=True)
            out_path = out_dir / out_name
            out_path.write_text(
                f"# FAILED (src): {src_asm}\n# Source: {rel}\n# Function: {func_name}\n"
            )
            results.append((out_path, False, src_asm))
            continue

        tgt_ok, tgt_asm = compile_to_asm(llc, tgt_module, triple_cmd, attrs_cmd)
        if not tgt_ok:
            stem = filepath.stem
            out_name = f"{stem}.{func_name}.s" if len(matched) > 1 else f"{stem}.s"
            out_dir = output_dir / filepath.parent.name
            out_dir.mkdir(parents=True, exist_ok=True)
            out_path = out_dir / out_name
            out_path.write_text(
                f"# FAILED (tgt): {tgt_asm}\n# Source: {rel}\n# Function: {func_name}\n"
            )
            results.append((out_path, False, tgt_asm))
            continue

        # Extract just the target function from each full assembly
        src_func_asm = extract_asm_function(src_asm, "src")
        tgt_func_asm = extract_asm_function(tgt_asm, "tgt")

        if not src_func_asm or not tgt_func_asm:
            # Fallback: include full assembly
            src_func_asm = src_func_asm or "# (src function not found in asm output)\n"
            tgt_func_asm = tgt_func_asm or "# (tgt function not found in asm output)\n"

        # Write combined output
        stem = filepath.stem
        out_name = f"{stem}.{func_name}.s" if len(matched) > 1 else f"{stem}.s"
        out_dir = output_dir / filepath.parent.name
        out_dir.mkdir(parents=True, exist_ok=True)
        out_path = out_dir / out_name

        header = (
            f"# Source: {rel}\n"
            f"# Function: {func_name}\n"
            f"# src = pre-opt ({func_name}), tgt = post-opt ({func_name})\n"
            f"# Triple: {triple_cmd}, Attrs: {attrs_cmd or 'none'}\n"
            f"#\n"
        )
        combined = header + "\n" + src_func_asm + "\n\n" + tgt_func_asm + "\n"
        out_path.write_text(combined)
        results.append((out_path, True, ""))

    return results


def process_one(args):
    filepath, llc, output_dir = args
    return filepath, process_file(filepath, llc, output_dir)


def main():
    parser = argparse.ArgumentParser(
        description="Convert pre/post-opt .ll to RISC-V assembly with src/tgt pairs"
    )
    parser.add_argument(
        "--input-dir",
        type=Path,
        default=DEFAULT_INPUT,
        help="Directory with extracted .ll files",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=DEFAULT_OUTPUT,
        help="Output directory for .s files",
    )
    parser.add_argument("--llc", default=DEFAULT_LLC, help="Path to llc binary")
    parser.add_argument("-j", "--jobs", type=int, default=4, help="Parallel jobs")
    args = parser.parse_args()

    if not Path(args.llc).exists():
        print(f"Error: llc not found at {args.llc}", file=sys.stderr)
        sys.exit(1)

    ll_files = sorted(args.input_dir.rglob("*.ll"))
    ll_files = [f for f in ll_files if f.parent != args.input_dir]
    print(f"Found {len(ll_files)} .ll files")

    total_asm = 0
    total_ok = 0
    total_fail = 0
    failures = []

    work = [(f, args.llc, args.output_dir) for f in ll_files]
    with ProcessPoolExecutor(max_workers=args.jobs) as executor:
        futures = {executor.submit(process_one, w): w[0] for w in work}
        for future in as_completed(futures):
            filepath, results = future.result()
            for out_path, success, err in results:
                total_asm += 1
                if success:
                    total_ok += 1
                else:
                    total_fail += 1
                    failures.append((filepath.name, out_path.name, err[:120]))

    print(f"\nDone!")
    print(f"  Input .ll files: {len(ll_files)}")
    print(f"  Output .s files: {total_asm}")
    print(f"  Succeeded:       {total_ok}")
    print(f"  Failed:          {total_fail}")
    print(f"  Output dir:      {args.output_dir}")

    if failures:
        print(f"\nFailures:")
        for src, out, err in failures[:20]:
            print(f"  {src} -> {out}: {err}")
        if len(failures) > 20:
            print(f"  ... and {len(failures) - 20} more")


if __name__ == "__main__":
    main()
