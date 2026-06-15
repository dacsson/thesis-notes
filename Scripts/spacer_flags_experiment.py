#!/usr/bin/env python3
"""
Compare Z3 Spacer configurations on RICOVER benchmarks.

Runs each .smt2 query with several Spacer flag combinations and reports
solve times side-by-side.

Usage:
    python spacer_flags_experiment.py /tmp/ricover_csmith_e2e/prog_*/instcombine/*.smt2
    python spacer_flags_experiment.py --from-benchmarks --timeout 300
    python spacer_flags_experiment.py --from-dir /tmp/ricover_large/prog_*/instcombine/
"""

import argparse
import subprocess
import sys
import time
import json
import tempfile
from pathlib import Path

PROJECT_DIR = Path(__file__).resolve().parent.parent / "Implementation" / "RICOVER"
BENCHMARK_DIR = PROJECT_DIR / "benchmark" / "supported"
IR_FILE = PROJECT_DIR / "snapshot" / "rv64d.ir"
RICOVER = PROJECT_DIR / "target" / "debug" / "ricover"

CONFIGS = {
    "baseline": [],
    "global": ["fp.spacer.global=true"],
    "inline_branch": ["fp.xform.inline_linear_branch=true"],
    "coalesce": ["fp.xform.coalesce_rules=true"],
    "global+inline": [
        "fp.spacer.global=true",
        "fp.xform.inline_linear_branch=true",
        "fp.xform.coalesce_rules=true",
    ],
    "array_blast": ["fp.xform.array_blast=true"],
    "no_array_gen": ["fp.spacer.use_array_eq_generalizer=false"],
    "inst_arrays": ["fp.xform.instantiate_arrays=true"],
    "no_mbqi": ["fp.spacer.mbqi=false"],
}


def run_z3(smt_file: Path, timeout: int, flags: list) -> tuple:
    cmd = ["z3", f"-T:{timeout}"] + flags + [str(smt_file)]
    t0 = time.time()
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout + 10)
        elapsed = time.time() - t0
        for line in r.stdout.splitlines():
            v = line.strip()
            if v in ("sat", "unsat", "unknown", "timeout"):
                return v, round(elapsed, 1)
        return f"error", round(elapsed, 1)
    except subprocess.TimeoutExpired:
        return "timeout", round(time.time() - t0, 1)


def emit_benchmark_smt2(bench_s: Path, timeout: int = 60) -> Path:
    name = bench_s.stem
    out_smt = Path(tempfile.mktemp(suffix=".smt2", prefix=f"{name}_"))
    cmd = [
        str(RICOVER), "check-equiv",
        "--before", str(bench_s), "--after", str(bench_s),
        "--before-fn", "src", "--after-fn", "tgt",
        "-f", name,
        "--ir", str(IR_FILE),
        "-o", str(out_smt),
    ]
    r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
    if r.returncode != 0:
        print(f"  ricover failed for {bench_s.name}: {r.stderr[:120]}", file=sys.stderr)
        return None
    return out_smt


def main():
    parser = argparse.ArgumentParser(description="Spacer flag comparison experiment")
    parser.add_argument("smt_files", nargs="*", type=Path,
                        help=".smt2 files to test (or use --from-benchmarks)")
    parser.add_argument("--from-benchmarks", action="store_true",
                        help="Generate .smt2 from benchmark/supported/*.s")
    parser.add_argument("--from-dir", type=Path, nargs="+",
                        help="Glob directories for .smt2 files")
    parser.add_argument("--timeout", type=int, default=300,
                        help="Z3 timeout per query (default: 300)")
    parser.add_argument("--configs", nargs="+", choices=list(CONFIGS.keys()),
                        default=list(CONFIGS.keys()),
                        help="Which configs to test (default: all)")
    parser.add_argument("-o", "--output", type=Path, default=None,
                        help="Output JSON file")
    args = parser.parse_args()

    smt_files = list(args.smt_files)

    if args.from_benchmarks:
        print("Building RICOVER...", end=" ", flush=True)
        r = subprocess.run(["cargo", "build", "--quiet"], cwd=PROJECT_DIR,
                           capture_output=True)
        if r.returncode != 0:
            print(f"build failed: {r.stderr.decode()[:200]}")
            sys.exit(1)
        print("ok")

        for bench_s in sorted(BENCHMARK_DIR.glob("*.s")):
            print(f"  Emitting {bench_s.name}...", end=" ", flush=True)
            smt = emit_benchmark_smt2(bench_s)
            if smt:
                smt_files.append(smt)
                print(f"ok → {smt}")
            else:
                print("FAILED")

    if args.from_dir:
        for d in args.from_dir:
            for f in sorted(Path(d).glob("*.smt2")):
                smt_files.append(f)

    if not smt_files:
        print("No .smt2 files to test. Use positional args, --from-benchmarks, or --from-dir.")
        sys.exit(1)

    configs_to_test = {k: CONFIGS[k] for k in args.configs}
    print(f"\nTesting {len(smt_files)} queries × {len(configs_to_test)} configs")
    print(f"Timeout: {args.timeout}s\n")

    header = f"{'Query':40s}"
    for cfg in configs_to_test:
        header += f" | {cfg:>16s}"
    print(header, flush=True)
    print("-" * len(header), flush=True)

    all_results = []
    for smt_file in smt_files:
        name = smt_file.stem[:38]
        row = f"{name:40s}"
        row_data = {"query": str(smt_file), "name": smt_file.stem}

        for cfg_name, cfg_flags in configs_to_test.items():
            result, elapsed = run_z3(smt_file, args.timeout, cfg_flags)
            row += f" | {result:>6s} {elapsed:6.1f}s"
            row_data[cfg_name] = {"result": result, "time": elapsed}

        print(row, flush=True)
        all_results.append(row_data)

    print(f"\n{'='*70}")
    print("Config summary (across all queries):")
    for cfg_name in configs_to_test:
        solved = sum(1 for r in all_results if r[cfg_name]["result"] in ("sat", "unsat"))
        times = [r[cfg_name]["time"] for r in all_results if r[cfg_name]["result"] in ("sat", "unsat")]
        timeouts = sum(1 for r in all_results if r[cfg_name]["result"] == "timeout")
        median_t = sorted(times)[len(times)//2] if times else float("inf")
        print(f"  {cfg_name:20s}: {solved}/{len(all_results)} solved, "
              f"{timeouts} timeout, median {median_t:.1f}s")

    if args.output:
        with open(args.output, "w") as f:
            json.dump(all_results, f, indent=2)
        print(f"\nResults saved to {args.output}")


if __name__ == "__main__":
    main()
