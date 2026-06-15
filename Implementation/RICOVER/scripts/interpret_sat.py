#!/usr/bin/env python3
"""Interpret a SAT result from RICOVER's CHC equivalence query.

When Z3/Spacer returns SAT on a RICOVER query, this script extracts the
Spacer derivation, solves the bug condition for concrete register values,
and prints a human-readable counterexample.

Usage:
    python3 scripts/interpret_sat.py query.smt2
    python3 scripts/interpret_sat.py query.smt2 --timeout 60
"""

import argparse
import sys

import z3


ABI_NAMES = {
    0: "zero", 1: "ra", 2: "sp", 3: "gp", 4: "tp",
    5: "t0", 6: "t1", 7: "t2", 8: "s0/fp", 9: "s1",
    10: "a0", 11: "a1", 12: "a2", 13: "a3", 14: "a4",
    15: "a5", 16: "a6", 17: "a7",
    18: "s2", 19: "s3", 20: "s4", 21: "s5", 22: "s6",
    23: "s7", 24: "s8", 25: "s9", 26: "s10", 27: "s11",
    28: "t3", 29: "t4", 30: "t5", 31: "t6",
}


def collect_forall_bodies(expr, depth=0, max_depth=20):
    """Recursively walk the proof tree collecting ForAll quantifier bodies."""
    bodies = []
    if depth > max_depth:
        return bodies
    if isinstance(expr, z3.QuantifierRef):
        bodies.append(expr)
        return bodies
    if z3.is_app(expr):
        # Walk into 'asserted', 'hyper-res', 'mp' nodes
        for i in range(expr.num_args()):
            bodies.extend(collect_forall_bodies(expr.arg(i), depth + 1, max_depth))
    return bodies


def find_bug_condition(answer):
    """Extract the bug condition from a Spacer derivation.

    For simple (register-only) programs, the derivation is:
        mp(hyper-res(asserted(ForAll(A, Implies(Not(eq), query!0))), ...), ...)
    and the bug condition is the single ForAll body.

    For complex (memory-involving) programs, the derivation is nested:
        mp(hyper-res(
            asserted(Implies(bad, query!0)),
            hyper-res(
                asserted(ForAll([regs, mem, ...], Implies(And(P1(...), P2(...), Not(mem1[a]==mem2[a])), bad))),
                hyper-res(asserted(ForAll(... P1 definition ...))),
                hyper-res(asserted(ForAll(... P2 definition ...)))
            )
        ), ...)

    We collect all ForAll bodies and conjoin them to form the full bug condition.
    """
    quantifiers = collect_forall_bodies(answer)
    if not quantifiers:
        return None, []

    # For single-quantifier (register-only) case: just return it
    if len(quantifiers) == 1:
        q = quantifiers[0]
        body = q.body()
        # body is Implies(cond, query!0) — extract cond
        if body.decl().name() == "=>":
            return body.arg(0), quantifiers
        return body, quantifiers

    # For multi-quantifier (memory) case: the derivation has the "bad" rule
    # plus program rules. The "bad" rule is typically the one that references
    # the program relations by name, and its condition describes the divergence.
    # We return ALL quantifiers so the caller can build a combined query.
    return None, quantifiers


def build_combined_model_query(quantifiers):
    """For complex derivations (memory), build a combined existential query.

    This extracts the full derivation as constraints and solves them together
    to find concrete register+memory values.
    """
    # Find the "outer" quantifier — the one whose body references 'bad'
    # and contains the divergence condition (Not(mem1[a] == mem2[a]) or similar)
    outer = None
    program_rules = []

    for q in quantifiers:
        body_str = str(q.body())
        if "bad" in body_str or "query" in body_str:
            outer = q
        else:
            program_rules.append(q)

    if outer is None and quantifiers:
        outer = quantifiers[0]

    return outer, program_rules


def interpret_query(smt2_path: str, timeout: int = 300):
    """Run the CHC query and interpret a SAT result."""

    fp = z3.Fixedpoint()
    fp.set("print_answer", True)
    fp.set("timeout", timeout * 1000)

    queries = fp.parse_file(smt2_path)
    if len(queries) == 0:
        print("ERROR: No query found in the file.", file=sys.stderr)
        return 1

    bad = queries[0]
    result = fp.query(bad)

    if result == z3.unsat:
        print("RESULT: unsat (programs are equivalent)")
        return 0
    elif result == z3.unknown:
        print(f"RESULT: unknown ({fp.reason_unknown()})")
        return 2

    # SAT — extract counterexample
    print("RESULT: sat (programs diverge)\n")

    answer = fp.get_answer()
    bug_cond, quantifiers = find_bug_condition(answer)

    if bug_cond is not None:
        # Simple case (register-only): single quantifier with register array
        return _interpret_register_only(bug_cond, quantifiers[0])
    elif quantifiers:
        # Complex case (memory): multiple quantifiers in derivation
        return _interpret_with_memory(quantifiers, answer)
    else:
        print("WARNING: Could not parse derivation. Raw answer:")
        print(f"  {answer}")
        return 0


def _interpret_register_only(bug_cond, quantifier):
    """Handle simple register-only derivations (single quantifier over Regs array)."""

    # The quantifier binds one variable: the register array
    num_vars = quantifier.num_vars()
    var_sort = quantifier.var_sort(0)

    # Find referenced register indices
    reg_indices = set()
    _collect_select_indices(bug_cond, reg_indices)
    if not reg_indices:
        reg_indices = {10, 11}

    print(f"Registers involved: {', '.join(f'x{i} ({ABI_NAMES.get(i, '?')})' for i in sorted(reg_indices))}")

    # Create fresh bitvectors for each register
    reg_vars = {}
    for idx in reg_indices:
        name = ABI_NAMES.get(idx, f"x{idx}")
        reg_vars[idx] = z3.BitVec(f"reg_{name}", 64)

    # Build array with free variables
    A = z3.Array('A', z3.BitVecSort(5), z3.BitVecSort(64))
    for idx, var in reg_vars.items():
        A = z3.Store(A, z3.BitVecVal(idx, 5), var)

    # For multi-var quantifiers, substitute all de Bruijn vars
    # (var 0 is the rightmost in the binding list)
    if num_vars == 1:
        instantiated = z3.substitute_vars(bug_cond, A)
    else:
        # Fill extra vars with unconstrained arrays/values
        subs = []
        for i in range(num_vars):
            sort = quantifier.var_sort(i)
            if sort == z3.ArraySort(z3.BitVecSort(5), z3.BitVecSort(64)):
                subs.append(A)
            elif sort == z3.ArraySort(z3.BitVecSort(64), z3.BitVecSort(8)):
                subs.append(z3.Array(f'mem_sub_{i}', z3.BitVecSort(64), z3.BitVecSort(8)))
            else:
                subs.append(z3.Const(f'sub_{i}', sort))
        instantiated = z3.substitute_vars(bug_cond, *subs)

    # Solve for concrete values
    s = z3.Solver()
    s.set("timeout", 10000)
    s.add(instantiated)
    check = s.check()

    if check != z3.sat:
        print(f"\nCould not find concrete values ({check}).")
        print("Symbolic bug condition:")
        print(f"  {bug_cond}")
        return 0

    m = s.model()
    _print_counterexample(reg_indices, reg_vars, m)

    print("\nSymbolic divergence condition (from Spacer):")
    _print_readable_condition(bug_cond)
    return 0


def _interpret_with_memory(quantifiers, answer):
    """Handle complex derivations involving memory."""

    outer, program_rules = build_combined_model_query(quantifiers)
    if outer is None:
        print("WARNING: Could not identify outer rule in derivation.")
        print(f"  Found {len(quantifiers)} quantifiers.")
        return 0

    num_vars = outer.num_vars()
    body = outer.body()

    # The outer body is Implies(And(P1(..), P2(..), divergence_cond), bad)
    # Extract variable sorts and identify regs/mem arrays
    print(f"Derivation has {len(quantifiers)} rules, {num_vars} variables in outer rule.")

    # Identify which variables are registers vs memory
    reg_array_indices = []
    mem_array_indices = []
    bv64_indices = []
    for i in range(num_vars):
        sort = outer.var_sort(i)
        sort_str = str(sort)
        if "Array(BitVec(5), BitVec(64))" in sort_str:
            reg_array_indices.append(i)
        elif "Array(BitVec(64), BitVec(8))" in sort_str:
            mem_array_indices.append(i)
        elif sort == z3.BitVecSort(64):
            bv64_indices.append(i)

    print(f"  Register arrays: {len(reg_array_indices)}, Memory arrays: {len(mem_array_indices)}, BV64 vars: {len(bv64_indices)}")

    # For memory-involving programs, build substitution vars
    subs = []
    reg_vars = {}
    mem_vars = {}
    bv_vars = {}

    for i in range(num_vars):
        sort = outer.var_sort(i)
        sort_str = str(sort)
        if "Array(BitVec(5), BitVec(64))" in sort_str:
            # Register array — fill with named variables for common registers
            A = z3.Array(f'regs_{i}', z3.BitVecSort(5), z3.BitVecSort(64))
            for ridx in range(32):
                name = ABI_NAMES.get(ridx, f"x{ridx}")
                rv = z3.BitVec(f"r{i}_{name}", 64)
                reg_vars[(i, ridx)] = rv
                A = z3.Store(A, z3.BitVecVal(ridx, 5), rv)
            subs.append(A)
        elif "Array(BitVec(64), BitVec(8))" in sort_str:
            mv = z3.Array(f'mem_{i}', z3.BitVecSort(64), z3.BitVecSort(8))
            mem_vars[i] = mv
            subs.append(mv)
        elif sort == z3.BitVecSort(64):
            bv = z3.BitVec(f'bv_{i}', 64)
            bv_vars[i] = bv
            subs.append(bv)
        else:
            subs.append(z3.Const(f'v_{i}', sort))

    # Instantiate the full outer body (which includes program constraints + divergence)
    instantiated = z3.substitute_vars(body, *reversed(subs))

    # The body is Implies(conjunction, bad) — we want the conjunction to be SAT
    if instantiated.decl().name() == "=>":
        conjunction = instantiated.arg(0)
    else:
        conjunction = instantiated

    s = z3.Solver()
    s.set("timeout", 30000)
    s.add(conjunction)

    # Also add the program rules as constraints
    for pr in program_rules:
        pr_num = pr.num_vars()
        pr_subs = []
        for i in range(pr_num):
            sort = pr.var_sort(i)
            sort_str = str(sort)
            if "Array(BitVec(5), BitVec(64))" in sort_str:
                pr_subs.append(subs[reg_array_indices[0]] if reg_array_indices else
                               z3.Array(f'pr_regs_{i}', z3.BitVecSort(5), z3.BitVecSort(64)))
            elif "Array(BitVec(64), BitVec(8))" in sort_str:
                pr_subs.append(subs[mem_array_indices[0]] if mem_array_indices else
                               z3.Array(f'pr_mem_{i}', z3.BitVecSort(64), z3.BitVecSort(8)))
            else:
                pr_subs.append(z3.Const(f'pr_v_{i}', sort))

    check = s.check()
    if check != z3.sat:
        print(f"\nCould not find concrete values ({check}).")
        print("This may happen for complex memory derivations.")
        print("\nThe derivation proves divergence exists but finding")
        print("a concrete witness requires solving the full program constraint.")
        return 0

    m = s.model()

    # Print initial register values (from the first register array)
    print("\n" + "=" * 60)
    print("COUNTEREXAMPLE (concrete initial state)")
    print("=" * 60)

    if reg_array_indices:
        first_reg_idx = reg_array_indices[0]
        print(f"\nInitial registers (argument registers):")
        print(f"{'Register':<12} {'ABI':<8} {'Hex':<20} {'Decimal'}")
        print("-" * 60)
        for ridx in [10, 11, 12, 13, 14, 15]:  # a0-a5
            key = (first_reg_idx, ridx)
            if key in reg_vars:
                val = m.eval(reg_vars[key], model_completion=True)
                v = val.as_long()
                abi = ABI_NAMES.get(ridx, f"x{ridx}")
                signed = v if v < (1 << 63) else v - (1 << 64)
                dec_str = str(v) if signed >= 0 else f"{v} ({signed})"
                print(f"  x{ridx:<9} {abi:<8} 0x{v:016x}   {dec_str}")
        print("-" * 60)

    if bv_vars:
        print(f"\nAddress of divergence:")
        for i, bv in bv_vars.items():
            val = m.eval(bv, model_completion=True)
            v = val.as_long()
            print(f"  var_{i} = 0x{v:016x}")

    print("\nThe programs write different values to memory at the address above.")
    return 0


def _collect_select_indices(expr, indices, depth=0, max_depth=50):
    """Find all array Select indices in an expression."""
    if depth > max_depth:
        return
    if z3.is_app(expr):
        if expr.decl().name() == "select":
            idx_expr = expr.arg(1)
            if z3.is_bv_value(idx_expr):
                indices.add(idx_expr.as_long())
        for i in range(expr.num_args()):
            _collect_select_indices(expr.arg(i), indices, depth + 1, max_depth)


def _print_counterexample(reg_indices, reg_vars, model):
    """Print a formatted counterexample table."""
    print("\n" + "=" * 60)
    print("COUNTEREXAMPLE (concrete initial register values)")
    print("=" * 60)
    print(f"{'Register':<12} {'ABI':<8} {'Hex':<20} {'Decimal'}")
    print("-" * 60)

    for idx in sorted(reg_indices):
        var = reg_vars[idx]
        val = model.eval(var, model_completion=True)
        v = val.as_long()
        abi = ABI_NAMES.get(idx, f"x{idx}")
        signed = v if v < (1 << 63) else v - (1 << 64)
        dec_str = str(v) if signed >= 0 else f"{v} ({signed})"
        print(f"  x{idx:<9} {abi:<8} 0x{v:016x}   {dec_str}")

    print("-" * 60)
    print("\nWith these initial values, src and tgt produce different results.")


def _print_readable_condition(bug_cond):
    """Print the bug condition with register names substituted."""
    s = str(bug_cond)
    # Replace Var(0)[N] patterns with register names
    for idx, name in ABI_NAMES.items():
        s = s.replace(f"Var(0)[{idx}]", f"{name}")
    # Simplify common patterns
    s = s.replace("Concat(0, Extract(5, 0, ", "trunc6(")
    s = s.replace("Concat(Extract(7, 0, ", "lo8(")
    s = s.replace("), 0) >> 56", ") sext8")
    print(f"  {s}")


def main():
    parser = argparse.ArgumentParser(
        description="Interpret SAT results from RICOVER CHC equivalence queries"
    )
    parser.add_argument("smt2", help="Path to the .smt2 equivalence query")
    parser.add_argument("--timeout", type=int, default=300,
                        help="Z3 timeout in seconds (default: 300)")
    args = parser.parse_args()

    sys.exit(interpret_query(args.smt2, args.timeout))


if __name__ == "__main__":
    main()
