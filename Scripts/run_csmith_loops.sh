#!/bin/bash
# Run csmith e2e with loop transformation passes.
# Loop optimizations (licm, indvars, unroll, deletion) are complex
# transformations that are a rich source of compiler bugs.
# 20 programs, 300s Z3 timeout.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTDIR="/tmp/ricover_csmith_loops_$(date +%Y%m%d_%H%M%S)"

python3 "$SCRIPT_DIR/csmith_ricover_e2e.py" \
    -n 20 \
    --passes \
        'sroa,instcombine<no-verify-fixpoint>,simplifycfg,loop-simplify,lcssa,loop-mssa(licm)' \
        'sroa,instcombine<no-verify-fixpoint>,simplifycfg,loop-simplify,lcssa,indvars' \
        'sroa,instcombine<no-verify-fixpoint>,simplifycfg,loop-simplify,lcssa,indvars,loop-rotate,loop-unroll' \
        'sroa,instcombine<no-verify-fixpoint>,simplifycfg,loop-simplify,lcssa,indvars,loop-deletion' \
    --z3-timeout 300 \
    --max-instrs 50 \
    -o "$OUTDIR"

echo ""
echo "Results saved to: $OUTDIR/results.json"
