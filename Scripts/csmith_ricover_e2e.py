#!/usr/bin/env python3
"""
Csmith → RICOVER end-to-end pipeline.

Generates random C programs with csmith, applies specific LLVM IR passes,
and verifies equivalence of the base vs. pass-applied assembly using RICOVER + Z3.

Pipeline:
  csmith → .c → clang -O0 -emit-llvm → .ll (base IR)
    ├─ llc -O1 → base.s
    └─ opt -passes='...' → llc -O1 → pass.s
  For each function that differs between base.s and pass.s:
    → generate ricover .s file (src: base, tgt: pass)
    → RICOVER check-equiv → .smt2
    → z3 → sat/unsat

Usage:
    python csmith_ricover_e2e.py                          # 1 program, default passes
    python csmith_ricover_e2e.py -n 5                     # 5 programs
    python csmith_ricover_e2e.py --passes 'sroa,instcombine' 'licm'
    python csmith_ricover_e2e.py --list-passes             # show default pipelines
"""

import argparse
import subprocess
import sys
import json
from pathlib import Path
from typing import Dict, List, Optional

SCRIPT_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(SCRIPT_DIR))
from riscv_opt_diff import (
    read_assembly_file,
    split_into_functions,
    has_relocation,
    generate_ricover_file,
)
PROJECT_DIR = SCRIPT_DIR.parent / "Implementation" / "RICOVER"
IR_FILE = PROJECT_DIR / "snapshot" / "rv64d.ir"
RICOVER = PROJECT_DIR / "target" / "debug" / "ricover"

CSMITH = Path.home() / "Tools" / "csmith" / "src" / "csmith"
CSMITH_RUNTIME = Path.home() / "Tools" / "csmith" / "runtime"
CLANG = Path.home() / "Tools" / "llvm-project" / "build" / "bin" / "clang"
OPT = Path.home() / "Tools" / "llvm-project" / "build" / "bin" / "opt"
LLC = Path.home() / "Tools" / "llvm-project" / "build" / "bin" / "llc"

LLVM_TARGET = "riscv64-linux-gnu"
LLVM_TRIPLE = "riscv64-unknown-linux-gnu"
LLC_ATTRS = "+m,+a,+f,+d,+c"

PREREQ_PASSES = "sroa,instcombine<no-verify-fixpoint>,simplifycfg,loop-simplify,lcssa"

DEFAULT_PIPELINES = {
    "instcombine": "sroa,instcombine<no-verify-fixpoint>",
    "simplifycfg": "sroa,instcombine<no-verify-fixpoint>,simplifycfg",
    "gvn": f"{PREREQ_PASSES},gvn",
    "dse": f"{PREREQ_PASSES},dse",
    "licm": f"{PREREQ_PASSES},loop-mssa(licm)",
    "indvars": f"{PREREQ_PASSES},indvars",
    "loop-rotate": f"{PREREQ_PASSES},loop-rotate",
    "loop-unroll": f"{PREREQ_PASSES},indvars,loop-rotate,loop-unroll",
    "loop-deletion": f"{PREREQ_PASSES},indvars,loop-deletion",
}


def parse_args():
    p = argparse.ArgumentParser(description="Csmith → RICOVER e2e pipeline")
    p.add_argument("-n", "--num-programs", type=int, default=1,
                   help="Number of csmith programs to generate (default: 1)")
    p.add_argument("--passes", nargs="+", metavar="PIPELINE",
                   help="Custom opt -passes pipelines (overrides defaults)")
    p.add_argument("--list-passes", action="store_true",
                   help="List default pass pipelines and exit")
    p.add_argument("-o", "--output-dir", type=Path, default=Path("/tmp/ricover_csmith_e2e"),
                   help="Output directory (default: /tmp/ricover_csmith_e2e)")
    p.add_argument("--llc-opt", default="1", choices=["0", "1", "2"],
                   help="LLC optimization level for both sides (default: 1)")
    p.add_argument("--z3-timeout", type=int, default=60,
                   help="Z3 timeout in seconds (default: 60)")
    p.add_argument("--keep", action="store_true",
                   help="Keep all intermediate files")
    p.add_argument("--seed", type=int, default=None,
                   help="Csmith seed (only for single program)")
    p.add_argument("--include-helpers", action="store_true",
                   help="Include csmith helper functions (safe_*, crc*, platform_*)")
    p.add_argument("--max-instrs", type=int, default=200,
                   help="Skip functions with more than N instructions in src (default: 200)")
    p.add_argument("--csmith", type=Path, default=CSMITH)
    p.add_argument("--clang", type=Path, default=CLANG)
    p.add_argument("--opt", type=Path, default=OPT)
    p.add_argument("--llc", type=Path, default=LLC)
    return p.parse_args()


def run(cmd: List[str], timeout: int = 60, **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, timeout=timeout, **kw)


def generate_csmith(csmith: Path, outfile: Path, seed: Optional[int] = None) -> bool:
    cmd = [str(csmith), "--no-checksum", "--no-argc", "--no-global-variables",
           "--no-safe-math", "--no-pointers"]
    if seed is not None:
        cmd += ["--seed", str(seed)]
    try:
        r = run(cmd, timeout=30)
        if r.returncode != 0:
            print(f"  csmith failed: {r.stderr[:200]}")
            return False
        src = r.stdout.replace("static ", "")
        outfile.write_text(src)
        return True
    except subprocess.TimeoutExpired:
        print("  csmith timed out")
        return False


def compile_to_ir(clang: Path, c_file: Path, out_ll: Path) -> bool:
    cmd = [
        str(clang), f"--target={LLVM_TARGET}",
        "--sysroot=/usr/riscv64-linux-gnu",
        "-march=rv64gc", "-mabi=lp64d",
        "-O0", "-Xclang", "-disable-O0-optnone",
        "-fno-discard-value-names",
        "-fno-asynchronous-unwind-tables", "-fno-unwind-tables",
        f"-I{CSMITH_RUNTIME}",
        "-emit-llvm", "-S", "-o", str(out_ll), str(c_file),
    ]
    try:
        r = run(cmd, timeout=30)
        if r.returncode != 0:
            print(f"  clang failed: {r.stderr[:300]}")
            return False
        return True
    except subprocess.TimeoutExpired:
        print("  clang timed out")
        return False


def run_opt(opt_bin: Path, in_ll: Path, out_ll: Path, passes: str) -> bool:
    cmd = [str(opt_bin), f"-passes={passes}", "-S", str(in_ll), "-o", str(out_ll)]
    try:
        r = run(cmd, timeout=60)
        if r.returncode != 0:
            print(f"  opt failed: {r.stderr[:300]}")
            return False
        return True
    except subprocess.TimeoutExpired:
        print("  opt timed out")
        return False


def run_llc(llc_bin: Path, in_ll: Path, out_s: Path, opt_level: str = "1") -> bool:
    cmd = [
        str(llc_bin), f"-mtriple={LLVM_TRIPLE}",
        f"-mattr={LLC_ATTRS}", f"-O{opt_level}",
        "-o", str(out_s), str(in_ll),
    ]
    try:
        r = run(cmd, timeout=60)
        if r.returncode != 0:
            print(f"  llc failed: {r.stderr[:300]}")
            return False
        return True
    except subprocess.TimeoutExpired:
        print("  llc timed out")
        return False


def build_ricover() -> bool:
    r = run(["cargo", "build", "--quiet"], timeout=120, cwd=PROJECT_DIR)
    if r.returncode != 0:
        print(f"RICOVER build failed: {r.stderr[:300]}")
        return False
    return True


def run_ricover(bench_s: Path, func_name: str, out_smt: Path) -> Optional[str]:
    cmd = [
        str(RICOVER), "check-equiv",
        "--before", str(bench_s), "--after", str(bench_s),
        "--before-fn", "src", "--after-fn", "tgt",
        "-f", func_name,
        "--ir", str(IR_FILE),
        "-o", str(out_smt),
    ]
    try:
        r = run(cmd, timeout=60)
        stderr = r.stderr if r.stderr else ""
        if r.returncode != 0:
            return f"ricover-error: {stderr[:200]}"
        fallbacks = [l for l in stderr.splitlines() if "falling back" in l]
        return "ok" + (f" ({fallbacks[0].strip()})" if fallbacks else "")
    except subprocess.TimeoutExpired:
        return "ricover-timeout"


def run_z3(smt_file: Path, timeout: int) -> str:
    cmd = ["z3", f"-T:{timeout}", str(smt_file)]
    try:
        r = run(cmd, timeout=timeout + 10)
        for line in r.stdout.splitlines():
            v = line.strip()
            if v in ("sat", "unsat", "unknown", "timeout"):
                return v
        return f"error: {r.stdout[:120]}"
    except subprocess.TimeoutExpired:
        return "timeout"


def process_one_program(
    prog_idx: int,
    args,
    pipelines: Dict[str, str],
    out_dir: Path,
) -> List[dict]:
    results = []
    prog_dir = out_dir / f"prog_{prog_idx:03d}"
    prog_dir.mkdir(parents=True, exist_ok=True)

    c_file = prog_dir / "program.c"
    base_ll = prog_dir / "base.ll"
    base_s = prog_dir / "base.s"

    seed = args.seed if args.num_programs == 1 and args.seed is not None else None
    print(f"\n{'='*60}")
    print(f"Program {prog_idx}" + (f" (seed={seed})" if seed else ""))
    print(f"{'='*60}")

    print("  Generating csmith program...", end=" ", flush=True)
    if not generate_csmith(args.csmith, c_file, seed):
        return results
    print("ok")

    print("  Compiling to LLVM IR...", end=" ", flush=True)
    if not compile_to_ir(args.clang, c_file, base_ll):
        return results
    print("ok")

    print("  Compiling base IR to assembly...", end=" ", flush=True)
    if not run_llc(args.llc, base_ll, base_s, args.llc_opt):
        return results
    print("ok")

    base_funcs = split_into_functions(read_assembly_file(str(base_s)))
    print(f"  Base has {len(base_funcs)} functions")

    for pipe_name, pipe_passes in pipelines.items():
        pipe_dir = prog_dir / pipe_name
        pipe_dir.mkdir(exist_ok=True)

        opt_ll = pipe_dir / "optimized.ll"
        opt_s = pipe_dir / "optimized.s"

        print(f"\n  --- Pipeline: {pipe_name} ({pipe_passes}) ---")
        print(f"  Running opt...", end=" ", flush=True)
        if not run_opt(args.opt, base_ll, opt_ll, pipe_passes):
            continue
        print("ok")

        print(f"  Running llc...", end=" ", flush=True)
        if not run_llc(args.llc, opt_ll, opt_s, args.llc_opt):
            continue
        print("ok")

        opt_funcs = split_into_functions(read_assembly_file(str(opt_s)))

        all_funcs = set(base_funcs.keys()) | set(opt_funcs.keys())
        diff_count = 0
        skip_count = 0

        CSMITH_HELPERS = ("safe_", "crc", "platform_", "__undefined")

        for fname in sorted(all_funcs):
            if not args.include_helpers and any(fname.startswith(p) for p in CSMITH_HELPERS):
                continue

            src = base_funcs.get(fname, [])
            tgt = opt_funcs.get(fname, [])
            if src == tgt:
                continue

            if has_relocation(src) or has_relocation(tgt):
                skip_count += 1
                continue

            if not src or not tgt:
                continue

            if len(src) > args.max_instrs:
                skip_count += 1
                continue

            diff_count += 1
            generate_ricover_file(
                fname, src, tgt, pipe_name, str(pipe_dir),
                str(c_file), "base",
            )
            bench_s = pipe_dir / f"{fname}_Obase_vs_{pipe_name}.s"
            smt_file = pipe_dir / f"{fname}.smt2"

            ricover_status = run_ricover(bench_s, fname, smt_file)
            z3_result = "skipped"
            if ricover_status and ricover_status.startswith("ok") and smt_file.exists():
                z3_result = run_z3(smt_file, args.z3_timeout)

            result = {
                "program": prog_idx,
                "pipeline": pipe_name,
                "function": fname,
                "src_instrs": len(src),
                "tgt_instrs": len(tgt),
                "ricover": ricover_status,
                "z3": z3_result,
                "file": str(bench_s),
            }
            results.append(result)

            status_icon = {
                "unsat": "EQUIV",
                "sat": "DIFF",
                "timeout": "TIMEOUT",
                "unknown": "UNKNOWN",
            }.get(z3_result, z3_result.upper())
            print(f"    {fname}: {len(src)}→{len(tgt)} instrs | {status_icon}")

        if diff_count == 0:
            print(f"  No differing functions (skipped {skip_count} with relocations)")
        else:
            print(f"  {diff_count} functions differ ({skip_count} skipped for relocations)")

    return results


def print_summary(all_results: List[dict]):
    print(f"\n{'='*70}")
    print("SUMMARY")
    print(f"{'='*70}")

    if not all_results:
        print("No functions were tested.")
        return

    total = len(all_results)
    by_z3 = {}
    for r in all_results:
        by_z3.setdefault(r["z3"], []).append(r)

    print(f"Total functions tested: {total}")
    for status in ["unsat", "sat", "timeout", "unknown", "skipped"]:
        if status in by_z3:
            print(f"  {status:10s}: {len(by_z3[status])}")

    for status in by_z3:
        if status not in ("unsat", "sat", "timeout", "unknown", "skipped"):
            print(f"  {status:10s}: {len(by_z3[status])}")

    if "sat" in by_z3:
        print(f"\n--- Potential divergences (sat) ---")
        for r in by_z3["sat"]:
            print(f"  prog={r['program']} pipe={r['pipeline']} func={r['function']} "
                  f"({r['src_instrs']}→{r['tgt_instrs']} instrs)")
            print(f"    file: {r['file']}")

    errs = [r for r in all_results if r["z3"].startswith("error") or
            (r["ricover"] and r["ricover"].startswith("ricover-error"))]
    if errs:
        print(f"\n--- Errors ---")
        for r in errs:
            print(f"  prog={r['program']} pipe={r['pipeline']} func={r['function']}")
            if r["ricover"] and r["ricover"].startswith("ricover-error"):
                print(f"    ricover: {r['ricover'][:120]}")
            if r["z3"].startswith("error"):
                print(f"    z3: {r['z3'][:120]}")


def main():
    args = parse_args()

    if args.list_passes:
        print("Default pass pipelines:")
        for name, passes in DEFAULT_PIPELINES.items():
            print(f"  {name:20s} → {passes}")
        sys.exit(0)

    if args.passes:
        pipelines = {}
        for p in args.passes:
            name = p.split(",")[-1].replace("(", "").replace(")", "")
            pipelines[name] = p
    else:
        pipelines = DEFAULT_PIPELINES

    args.output_dir.mkdir(parents=True, exist_ok=True)

    for tool, path in [("csmith", args.csmith), ("clang", args.clang),
                        ("opt", args.opt), ("llc", args.llc)]:
        if not path.exists():
            print(f"Error: {tool} not found at {path}")
            sys.exit(1)

    if not IR_FILE.exists():
        print(f"Error: IR file not found at {IR_FILE}")
        sys.exit(1)

    print("Building RICOVER...", end=" ", flush=True)
    if not build_ricover():
        sys.exit(1)
    print("ok")

    print(f"Output: {args.output_dir}")
    print(f"Pipelines: {', '.join(pipelines.keys())}")
    print(f"LLC opt level: O{args.llc_opt}")

    all_results = []
    for i in range(args.num_programs):
        results = process_one_program(i, args, pipelines, args.output_dir)
        all_results.extend(results)

    print_summary(all_results)

    results_file = args.output_dir / "results.json"
    with open(results_file, "w") as f:
        json.dump(all_results, f, indent=2)
    print(f"\nFull results saved to {results_file}")


if __name__ == "__main__":
    main()
