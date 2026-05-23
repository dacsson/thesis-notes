#!/bin/bash
# Run csmith e2e with instcombine pass (the baseline pass).
# Simplified csmith flags (no arrays/structs/pointers) for higher solve rate.
# 20 programs, 300s Z3 timeout.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTDIR="/tmp/ricover_csmith_instcombine_$(date +%Y%m%d_%H%M%S)"

python3 "$SCRIPT_DIR/csmith_ricover_e2e.py" \
    -n 20 \
    --passes 'sroa,instcombine<no-verify-fixpoint>' \
    --z3-timeout 300 \
    --max-instrs 50 \
    -o "$OUTDIR"

echo ""
echo "Results saved to: $OUTDIR/results.json"
