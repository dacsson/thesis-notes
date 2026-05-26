#!/usr/bin/env python3
"""Run a single RICOVER benchmark .s file end-to-end.

Usage:
    python benchmark/run_bench.py benchmark/bench1_BAD.s
    python benchmark/run_bench.py benchmark/constant_folding_simple_SUCCESS.s

The script:
  1. Builds RICOVER (cargo build)
  2. Emits the CHC equivalence query (.smt2)
  3. Runs z3 with a timeout
  4. Reports PASS/FAIL based on the filename suffix (_SUCCESS → unsat, _BAD → sat)
"""

import argparse
import subprocess
import sys
import tempfile
from pathlib import Path

PROJECT_DIR = Path(__file__).resolve().parent.parent
IR_FILE = PROJECT_DIR / "snapshot" / "rv64d.ir"
RICOVER = PROJECT_DIR / "target" / "debug" / "ricover"


def build():
    r = subprocess.run(
        ["cargo", "build", "--quiet"],
        cwd=PROJECT_DIR,
        capture_output=True,
    )
    if r.returncode != 0:
        print("Build failed:", r.stderr.decode(), file=sys.stderr)
        sys.exit(1)


def emit_query(bench_path: Path, out_smt: Path):
    name = bench_path.stem
    cmd = [
        str(RICOVER),
        "check-equiv",
        "--before",
        str(bench_path),
        "--after",
        str(bench_path),
        "--before-fn",
        "src",
        "--after-fn",
        "tgt",
        "-f",
        name,
        "--ir",
        str(IR_FILE),
        "-o",
        str(out_smt),
    ]

    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0:
        print(f"ricover emit failed:\n{r.stderr}", file=sys.stderr)
        return False

    print("\n========== Run logs ==========")
    print(f"{r.stdout}")
    print("==============================\n")

    if r.stderr:
        print("\n========== Warnings ==========")
        # Print warnings (fallback rules, skipped variants) but abbreviated

        # Save all stderr to a log file
        log_file = bench_path.parent / f"{name}.log"
        with open(log_file, "w") as f:
            f.write(r.stderr)

        print(f"  (full log saved to {log_file})")

        for line in r.stderr.splitlines():
            if line.startswith("warning: falling back"):
                print(f"  {line}")
            elif line.startswith("warning: IR transpiler skipped"):
                print(f"  {line.split(';')[0]}")
        print("==============================\n")
    return True


def run_z3(smt_file: Path, timeout: int, extra_flags: list = None) -> str:
    flags = extra_flags or []
    cmd = ["z3", f"-T:{timeout}"] + flags + [str(smt_file)]
    r = subprocess.run(cmd, capture_output=True, text=True)
    for line in r.stdout.splitlines():
        if line.strip() in ("sat", "unsat", "unknown", "timeout"):
            return line.strip()
    return f"error: {r.stdout[:120]}"


def main():
    parser = argparse.ArgumentParser(description="Run a RICOVER benchmark")
    parser.add_argument("file", type=Path, help="Path to .s benchmark file")
    parser.add_argument(
        "--timeout", type=int, default=60, help="z3 timeout in seconds (default: 60)"
    )
    parser.add_argument("--keep", action="store_true", help="Keep generated .smt2 file")
    parser.add_argument("--z3-flags", nargs="+", metavar="FLAG", default=[],
                        help="Extra Z3/Spacer flags (e.g. fp.spacer.global=true)")
    args = parser.parse_args()

    bench = args.file.resolve()
    if not bench.exists():
        print(f"File not found: {bench}", file=sys.stderr)
        sys.exit(1)

    name = bench.stem
    if name.endswith("_SUCCESS"):
        expected = "unsat"
    elif name.endswith("_BAD"):
        expected = "sat"
    else:
        expected = None

    print(f"Benchmark: {bench.name}")
    print(f"Expected:  {expected or '(unknown — no _SUCCESS/_BAD suffix)'}")
    print()

    # Build
    print("Building...", end=" ", flush=True)
    build()
    print("ok")

    # Emit
    if args.keep:
        out_smt = bench.with_suffix(".smt2")
    else:
        tmp = tempfile.NamedTemporaryFile(
            suffix=".smt2", delete=False, prefix=f"{name}_"
        )
        out_smt = Path(tmp.name)
        tmp.close()

    print("Emitting CHC query...", end=" ", flush=True)
    if not emit_query(bench, out_smt):
        sys.exit(1)
    print(f"ok → {out_smt}")

    # Solve
    if args.z3_flags:
        print(f"Z3 flags: {' '.join(args.z3_flags)}")
    print(f"Running z3 (timeout {args.timeout}s)...", end=" ", flush=True)
    result = run_z3(out_smt, args.timeout, args.z3_flags)
    print(result)
    print()

    # Verdict
    if expected is None:
        print(f"Result: {result} (no expected value to compare)")
    elif result == expected:
        print(f"PASS ({result})")
    else:
        print(f"FAIL (expected {expected}, got {result})")
        sys.exit(1)


if __name__ == "__main__":
    main()
