#!/bin/bash
# Run csmith e2e with aggressive passes: gvn, dse, simplifycfg.
# These do more complex transformations (value numbering, dead store
# elimination) and are more likely to expose divergences.
# 20 programs, 300s Z3 timeout.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTDIR="/tmp/ricover_csmith_aggressive_$(date +%Y%m%d_%H%M%S)"

python3 "$SCRIPT_DIR/csmith_ricover_e2e.py" \
    -n 20 \
    --passes \
        'sroa,instcombine<no-verify-fixpoint>,simplifycfg' \
        'sroa,instcombine<no-verify-fixpoint>,simplifycfg,loop-simplify,lcssa,gvn' \
        'sroa,instcombine<no-verify-fixpoint>,simplifycfg,loop-simplify,lcssa,dse' \
    --z3-timeout 300 \
    --max-instrs 50 \
    -o "$OUTDIR"

echo ""
echo "Results saved to: $OUTDIR/results.json"
