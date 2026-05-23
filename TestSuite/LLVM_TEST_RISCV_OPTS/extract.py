#!/usr/bin/env python3
"""
Extract pre-opt and post-opt LLVM IR from LLVM RISC-V test files
by actually running `opt` on the input IR.

For each test file, this:
1. Strips CHECK/RUN/NOTE lines to produce clean pre-opt IR
2. Parses each RUN line into an opt invocation
3. Runs opt to produce real post-opt IR (no FileCheck artifacts)
4. Writes a single output file per RUN variant with clear sections

Usage:
    python3 extract.py /path/to/opt
    python3 extract.py /path/to/opt --dry-run   # just show what would run
    python3 extract.py /path/to/opt --jobs 8     # parallel execution
"""

import argparse
import re
import shlex
import subprocess
import sys
import tempfile
from concurrent.futures import ProcessPoolExecutor, as_completed
from pathlib import Path

LLVM_TEST_DIR = Path("/home/artjom/Tools/llvm-project/llvm/test/Transforms")
OUTPUT_DIR = Path("/home/artjom/Uni/thesis/thesis-notes/TestSuite/LLVM_TEST_RISCV_OPTS")

RUN_LINE_RE = re.compile(r"^;\s*RUN:")
CHECK_DIRECTIVE_RE = re.compile(
    r"^;\s*(?:CHECK|[A-Z][A-Z0-9_-]*)(?:-LABEL|-NEXT|-SAME|-NOT|-DAG|-COUNT-\d+|-EMPTY)?:"
)
NOTE_RE = re.compile(r"^;\s*NOTE:")


def collect_run_lines(lines: list[str]) -> list[str]:
    """Parse RUN lines, joining backslash continuations."""
    run_lines = []
    i = 0
    while i < len(lines):
        stripped = lines[i].strip()
        if RUN_LINE_RE.match(stripped):
            full = stripped
            while full.rstrip().endswith("\\") and i + 1 < len(lines):
                i += 1
                cont = lines[i].strip()
                # Strip leading "; RUN:" or "; " from continuation lines
                cont = re.sub(r"^;\s*RUN:\s*", "", cont)
                cont = re.sub(r"^;\s*", "", cont)
                full = full.rstrip()[:-1] + " " + cont
            run_lines.append(full)
        i += 1
    return run_lines


def extract_check_prefixes(run_lines: list[str]) -> set[str]:
    prefixes = {"CHECK"}
    for line in run_lines:
        for m in re.finditer(r"check-prefix(?:es)?=([^\s|]+)", line):
            for p in m.group(1).split(","):
                prefixes.add(p.strip())
    return prefixes


def is_check_line(line: str, prefixes: set[str]) -> bool:
    stripped = line.lstrip()
    if not stripped.startswith(";"):
        return False
    after_semi = stripped[1:].lstrip()
    for prefix in prefixes:
        if after_semi.startswith(prefix):
            rest = after_semi[len(prefix):]
            if rest == "" or rest[0] in (":", "-"):
                return True
    return False


def extract_clean_ir(lines: list[str], prefixes: set[str]) -> str:
    """Strip RUN/CHECK/NOTE lines, producing clean input IR."""
    clean = []
    i = 0
    while i < len(lines):
        stripped = lines[i].strip()
        if RUN_LINE_RE.match(stripped):
            # Skip RUN lines and their continuations
            while stripped.endswith("\\") and i + 1 < len(lines):
                i += 1
                stripped = lines[i].strip()
            i += 1
            continue
        if NOTE_RE.match(stripped):
            i += 1
            continue
        if is_check_line(lines[i], prefixes):
            i += 1
            continue
        # Skip bare `;` separator lines that were between CHECK blocks and IR
        if re.match(r"^;\s*$", lines[i]):
            i += 1
            continue
        clean.append(lines[i])
        i += 1

    # Strip trailing blank lines
    while clean and clean[-1].strip() == "":
        clean.pop()
    return "\n".join(clean) + "\n"


def parse_run_line(run_line: str) -> dict | None:
    """
    Parse a RUN line into an opt command dict.
    Returns None if this RUN line doesn't produce IR output (e.g., llc, debug-only, FileCheck-only).
    """
    # Strip the ; RUN: prefix
    cmd_str = re.sub(r"^;\s*RUN:\s*", "", run_line).strip()

    # Skip lines that are just FileCheck (continuation artifacts)
    if cmd_str.startswith("FileCheck"):
        return None

    # Split on pipes — we want the opt command, not the FileCheck part
    pipe_parts = cmd_str.split("|")
    opt_part = pipe_parts[0].strip()

    # Skip non-opt commands (llc, etc.)
    if not ("opt" in opt_part.split()[0] if opt_part.split() else False):
        # Some lines start with flags directly (continuation artifacts after parsing)
        # Check if there's an "opt" anywhere
        if "opt " not in opt_part and opt_part != "opt":
            return None

    # Skip if -disable-output (debug-only tests, no IR output)
    if "-disable-output" in opt_part or "--disable-output" in opt_part:
        return None

    # Skip debug-only lines that redirect stderr
    if "-debug-only=" in opt_part or "-debug" in opt_part:
        return None

    # Extract the opt arguments, removing I/O redirection
    # Remove "opt" prefix
    args_str = re.sub(r"^opt\s*", "", opt_part).strip()
    # Remove input file references (both "< %s" and bare "%s")
    args_str = re.sub(r"<\s*%s", "", args_str).strip()
    args_str = re.sub(r"%s", "", args_str).strip()
    # Also remove %t (temp output file refs)
    args_str = re.sub(r"%t\b", "", args_str).strip()
    # Remove output redirection
    args_str = re.sub(r"-o\s*%t\b", "", args_str).strip()
    args_str = re.sub(r"-o\s*-", "", args_str).strip()
    # Remove stderr redirection (2>&1, 2>%t, bare 2> leftovers)
    # Be careful not to match 2> inside pass pipeline strings like 'default<O2>'
    args_str = re.sub(r"\s2>&1", "", args_str).strip()
    args_str = re.sub(r"\s2>\s*%\S*", "", args_str).strip()
    # Bare "2>" at end of string (leftover after %t was stripped)
    args_str = re.sub(r"\s2>\s*$", "", args_str).strip()
    # Remove -S (we add it ourselves in run_opt)
    args_str = re.sub(r"\s-S\b", " ", args_str).strip()
    args_str = re.sub(r"^-S\b", "", args_str).strip()
    # Collapse multiple spaces
    args_str = re.sub(r"\s+", " ", args_str).strip()

    # Extract check prefix for naming
    prefix = "CHECK"
    m = re.search(r"check-prefix[es]*=(\S+)", run_line)
    if m:
        prefix = m.group(1).split(",")[0]

    return {
        "args_str": args_str,
        "prefix": prefix,
        "original_run": run_line,
    }


def build_opt_label(parsed: dict) -> str:
    """Build a short human-readable label for this RUN variant."""
    args = parsed["args_str"]
    parts = []

    m = re.search(r"-mtriple[=\s]+(\S+)", args)
    if m:
        parts.append(m.group(1))

    m = re.search(r"-mattr[=\s]+(\S+)", args)
    if m:
        parts.append(m.group(1))

    m = re.search(r"-passes?[=\s]+(\S+)", args)
    if m:
        parts.append(m.group(1).strip("'\""))
    m = re.search(r"-p\s+'([^']+)'", args)
    if m:
        parts.append(m.group(1))

    if parsed["prefix"] != "CHECK":
        parts.append(parsed["prefix"])

    return "_".join(parts) if parts else parsed["prefix"]


def run_opt(opt_bin: str, args_str: str, input_ir: str, timeout: int = 60) -> tuple[bool, str]:
    """Run opt on the input IR, return (success, output_or_error)."""
    with tempfile.NamedTemporaryFile(mode="w", suffix=".ll", delete=False) as f:
        f.write(input_ir)
        input_path = f.name

    try:
        # Build command: opt [args] -S < input.ll
        # We need to handle the args carefully
        cmd = f"{opt_bin} {args_str} -S {input_path}"
        result = subprocess.run(
            cmd,
            shell=True,
            capture_output=True,
            text=True,
            timeout=timeout,
        )
        if result.returncode != 0:
            return False, result.stderr[:2000]
        return True, result.stdout
    except subprocess.TimeoutExpired:
        return False, "TIMEOUT"
    except Exception as e:
        return False, str(e)
    finally:
        Path(input_path).unlink(missing_ok=True)


def process_file(filepath: Path, opt_bin: str, dry_run: bool = False) -> list[dict]:
    """Process one test file. Returns list of result dicts."""
    lines = filepath.read_text().splitlines()
    run_lines = collect_run_lines(lines)

    if not run_lines:
        return []

    prefixes = extract_check_prefixes(run_lines)
    clean_ir = extract_clean_ir(lines, prefixes)

    results = []
    seen_labels = {}

    for run_line in run_lines:
        parsed = parse_run_line(run_line)
        if parsed is None:
            continue

        label = build_opt_label(parsed)
        # Deduplicate labels
        if label in seen_labels:
            seen_labels[label] += 1
            label = f"{label}_{seen_labels[label]}"
        else:
            seen_labels[label] = 0

        if dry_run:
            results.append({
                "label": label,
                "cmd": f"{opt_bin} {parsed['args_str']} -S <input>",
                "run_line": parsed["original_run"],
                "success": True,
                "pre_opt": clean_ir,
                "post_opt": "(dry run)",
            })
            continue

        success, output = run_opt(opt_bin, parsed["args_str"], clean_ir)
        results.append({
            "label": label,
            "cmd": f"{opt_bin} {parsed['args_str']} -S",
            "run_line": parsed["original_run"],
            "success": success,
            "pre_opt": clean_ir,
            "post_opt": output,
        })

    return results


def write_output(filepath: Path, pass_name: str, test_name: str, result: dict):
    """Write one output file for a single RUN variant."""
    stem = Path(test_name).stem
    label = re.sub(r"[^a-zA-Z0-9_.-]", "_", result["label"])
    out_name = f"{stem}.{label}.ll" if label != "CHECK" else f"{stem}.ll"

    out_dir = OUTPUT_DIR / pass_name
    out_dir.mkdir(parents=True, exist_ok=True)
    out_path = out_dir / out_name

    sections = []
    sections.append(f"; Source: {filepath}")
    sections.append(f"; Variant: {result['label']}")
    sections.append(f"; Command: {result['cmd']}")
    sections.append(f"; Original: {result['run_line'].lstrip('; ')}")
    sections.append("")
    sections.append("; " + "=" * 70)
    sections.append("; PRE-OPT (input IR)")
    sections.append("; " + "=" * 70)
    sections.append("")
    sections.append(result["pre_opt"].rstrip())
    sections.append("")
    sections.append("; " + "=" * 70)
    sections.append("; POST-OPT (actual opt output)")
    sections.append("; " + "=" * 70)
    sections.append("")
    if result["success"]:
        sections.append(result["post_opt"].rstrip())
    else:
        sections.append(f"; ERROR: {result['post_opt']}")
    sections.append("")

    out_path.write_text("\n".join(sections))
    return out_path


def process_one_file(args):
    """Wrapper for parallel execution."""
    filepath, opt_bin, dry_run = args
    parts = filepath.relative_to(LLVM_TEST_DIR).parts
    pass_name = parts[0]
    test_name = parts[-1]

    results = process_file(filepath, opt_bin, dry_run)
    outputs = []
    for r in results:
        out_path = write_output(filepath, pass_name, test_name, r)
        outputs.append((out_path, r["success"]))
    return filepath, outputs


def main():
    parser = argparse.ArgumentParser(description="Extract pre/post-opt IR from LLVM RISC-V tests")
    parser.add_argument("opt_bin", help="Path to the opt binary")
    parser.add_argument("--dry-run", action="store_true", help="Parse and extract IR without running opt")
    parser.add_argument("--jobs", "-j", type=int, default=4, help="Parallel jobs (default: 4)")
    args = parser.parse_args()

    opt_path = Path(args.opt_bin).resolve()
    if not args.dry_run and not opt_path.exists():
        print(f"Error: opt binary not found at {opt_path}", file=sys.stderr)
        sys.exit(1)

    test_files = sorted(LLVM_TEST_DIR.rglob("RISCV/*.ll"))
    print(f"Found {len(test_files)} RISC-V test files under Transforms/")

    if args.dry_run:
        print("DRY RUN — extracting IR and parsing commands only\n")

    total_outputs = 0
    total_success = 0
    total_fail = 0
    failed_files = []

    work_items = [(f, str(opt_path), args.dry_run) for f in test_files]

    with ProcessPoolExecutor(max_workers=args.jobs) as executor:
        futures = {executor.submit(process_one_file, item): item[0] for item in work_items}
        for future in as_completed(futures):
            filepath, outputs = future.result()
            for out_path, success in outputs:
                total_outputs += 1
                if success:
                    total_success += 1
                else:
                    total_fail += 1
                    failed_files.append((filepath, out_path))

    print(f"\nDone!")
    print(f"  Input files:  {len(test_files)}")
    print(f"  Output files: {total_outputs}")
    print(f"  Succeeded:    {total_success}")
    print(f"  Failed:       {total_fail}")
    print(f"  Output dir:   {OUTPUT_DIR}")

    if failed_files:
        print(f"\nFailed files:")
        for src, out in failed_files[:20]:
            print(f"  {src.name} -> {out.name}")
        if len(failed_files) > 20:
            print(f"  ... and {len(failed_files) - 20} more")


if __name__ == "__main__":
    main()
