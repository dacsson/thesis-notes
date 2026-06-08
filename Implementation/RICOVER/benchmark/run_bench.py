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

try:
    import z3
    HAS_Z3PY = True
except ImportError:
    HAS_Z3PY = False

PROJECT_DIR = Path(__file__).resolve().parent.parent
IR_FILE = PROJECT_DIR / "snapshot" / "rv64d.ir"
RICOVER = PROJECT_DIR / "target" / "debug" / "ricover"

ABI_NAMES = {
    0: "zero", 1: "ra", 2: "sp", 3: "gp", 4: "tp",
    5: "t0", 6: "t1", 7: "t2", 8: "s0/fp", 9: "s1",
    10: "a0", 11: "a1", 12: "a2", 13: "a3", 14: "a4",
    15: "a5", 16: "a6", 17: "a7",
    18: "s2", 19: "s3", 20: "s4", 21: "s5", 22: "s6",
    23: "s7", 24: "s8", 25: "s9", 26: "s10", 27: "s11",
    28: "t3", 29: "t4", 30: "t5", 31: "t6",
}


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


def interpret_sat_model(smt_file: Path, timeout: int = 60):
    """On SAT, extract a concrete counterexample from the Spacer derivation."""
    if not HAS_Z3PY:
        print("  (install z3-solver Python package for concrete counterexamples)")
        return

    fp = z3.Fixedpoint()
    fp.set("print_answer", True)
    fp.set("timeout", timeout * 1000)

    try:
        queries = fp.parse_file(str(smt_file))
    except z3.Z3Exception:
        print("  (could not parse query for model extraction)")
        return

    if len(queries) == 0:
        return

    result = fp.query(queries[0])
    if result != z3.sat:
        return

    answer = fp.get_answer()

    # Navigate proof tree to find the bug condition
    try:
        quantifiers = _collect_quantifiers(answer)
        if not quantifiers:
            return

        if len(quantifiers) == 1:
            _show_register_model(quantifiers[0])
        else:
            _show_memory_model(quantifiers)
    except Exception as e:
        print(f"  (model extraction failed: {e})")


def _collect_quantifiers(expr, depth=0, max_depth=20):
    """Recursively collect ForAll quantifiers from the proof tree."""
    result = []
    if depth > max_depth:
        return result
    if isinstance(expr, z3.QuantifierRef):
        result.append(expr)
        return result
    if z3.is_app(expr):
        for i in range(expr.num_args()):
            result.extend(_collect_quantifiers(expr.arg(i), depth + 1, max_depth))
    return result


def _collect_select_indices(expr, indices, depth=0, max_depth=50):
    """Find all 5-bit array Select indices (register reads)."""
    if depth > max_depth:
        return
    if z3.is_app(expr):
        if expr.decl().name() == "select":
            idx_expr = expr.arg(1)
            if z3.is_bv_value(idx_expr) and idx_expr.size() == 5:
                indices.add(idx_expr.as_long())
        for i in range(expr.num_args()):
            _collect_select_indices(expr.arg(i), indices, depth + 1, max_depth)


def _show_register_model(quantifier):
    """Extract concrete register values for single-quantifier (register-only) derivations."""
    body = quantifier.body()
    bug_cond = body.arg(0) if body.decl().name() == "=>" else body

    reg_indices = set()
    _collect_select_indices(bug_cond, reg_indices)
    if not reg_indices:
        reg_indices = {10, 11}

    reg_vars = {}
    for idx in reg_indices:
        reg_vars[idx] = z3.BitVec(f"r_{ABI_NAMES.get(idx, f'x{idx}')}", 64)

    A = z3.Array('A', z3.BitVecSort(5), z3.BitVecSort(64))
    for idx, var in reg_vars.items():
        A = z3.Store(A, z3.BitVecVal(idx, 5), var)

    num_vars = quantifier.num_vars()
    if num_vars == 1:
        instantiated = z3.substitute_vars(bug_cond, A)
    else:
        subs = []
        for i in range(num_vars):
            sort = quantifier.var_sort(i)
            if sort == z3.ArraySort(z3.BitVecSort(5), z3.BitVecSort(64)):
                subs.append(A)
            elif sort == z3.ArraySort(z3.BitVecSort(64), z3.BitVecSort(8)):
                subs.append(z3.Array(f'mem_{i}', z3.BitVecSort(64), z3.BitVecSort(8)))
            else:
                subs.append(z3.Const(f'v_{i}', sort))
        instantiated = z3.substitute_vars(bug_cond, *subs)

    s = z3.Solver()
    s.set("timeout", 10000)
    s.add(instantiated)

    if s.check() != z3.sat:
        print("  (could not find concrete counterexample)")
        return

    m = s.model()
    print("\n  Counterexample (initial register values):")
    for idx in sorted(reg_indices):
        val = m.eval(reg_vars[idx], model_completion=True)
        v = val.as_long()
        abi = ABI_NAMES.get(idx, f"x{idx}")
        signed = v if v < (1 << 63) else v - (1 << 64)
        dec = f"{v}" if signed >= 0 else f"{signed}"
        print(f"    x{idx} ({abi}) = 0x{v:016x} ({dec})")


def _show_memory_model(quantifiers):
    """Extract concrete values for multi-quantifier (memory) derivations."""
    # Find the outer rule (references 'bad')
    outer = None
    for q in quantifiers:
        if "bad" in str(q.body()) or "query" in str(q.body()):
            outer = q
            break
    if outer is None:
        outer = quantifiers[0]

    num_vars = outer.num_vars()
    body = outer.body()
    conjunction = body.arg(0) if body.decl().name() == "=>" else body

    # Build substitution with named variables
    subs = []
    reg_vars = {}
    for i in range(num_vars):
        sort = outer.var_sort(i)
        sort_str = str(sort)
        if "Array(BitVec(5), BitVec(64))" in sort_str:
            A = z3.Array(f'regs_{i}', z3.BitVecSort(5), z3.BitVecSort(64))
            for ridx in [10, 11, 12, 13, 14, 15]:
                rv = z3.BitVec(f'r{i}_{ABI_NAMES[ridx]}', 64)
                reg_vars[(i, ridx)] = rv
                A = z3.Store(A, z3.BitVecVal(ridx, 5), rv)
            subs.append(A)
        elif "Array(BitVec(64), BitVec(8))" in sort_str:
            subs.append(z3.Array(f'mem_{i}', z3.BitVecSort(64), z3.BitVecSort(8)))
        elif sort == z3.BitVecSort(64):
            subs.append(z3.BitVec(f'bv_{i}', 64))
        else:
            subs.append(z3.Const(f'v_{i}', sort))

    instantiated = z3.substitute_vars(conjunction, *reversed(subs))

    s = z3.Solver()
    s.set("timeout", 30000)
    s.add(instantiated)

    if s.check() != z3.sat:
        print("  (could not find concrete counterexample for memory divergence)")
        return

    m = s.model()
    print("\n  Counterexample (initial register values):")
    # Print argument registers from the first register array
    first_regs = [(k, v) for k, v in reg_vars.items() if k[0] == min(k2[0] for k2 in reg_vars)]
    for (_, ridx), var in sorted(first_regs, key=lambda x: x[0][1]):
        val = m.eval(var, model_completion=True)
        v = val.as_long()
        abi = ABI_NAMES.get(ridx, f"x{ridx}")
        signed = v if v < (1 << 63) else v - (1 << 64)
        dec = f"{v}" if signed >= 0 else f"{signed}"
        print(f"    x{ridx} ({abi}) = 0x{v:016x} ({dec})")


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

    # On SAT, extract and display a concrete counterexample
    if result == "sat":
        interpret_sat_model(out_smt, args.timeout)

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
