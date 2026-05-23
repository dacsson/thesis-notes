#!/bin/bash
# Run csmith e2e with ALL default pass pipelines.
# Broad sweep: 10 programs x 9 pipelines = wide coverage.
# Good for finding which passes produce the most sat results.
# 10 programs, 300s Z3 timeout.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTDIR="/tmp/ricover_csmith_all_$(date +%Y%m%d_%H%M%S)"

python3 "$SCRIPT_DIR/csmith_ricover_e2e.py" \
    -n 10 \
    --z3-timeout 300 \
    --max-instrs 50 \
    -o "$OUTDIR"

echo ""
echo "Results saved to: $OUTDIR/results.json"
