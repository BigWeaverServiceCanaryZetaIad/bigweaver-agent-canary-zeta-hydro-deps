#!/usr/bin/env bash
# Script to run benchmarks that compare DFIR against timely/differential-dataflow
# This repository must be checked out alongside bigweaver-agent-canary-hydro-zeta

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEPS_REPO="$SCRIPT_DIR"
MAIN_REPO="$SCRIPT_DIR/../bigweaver-agent-canary-hydro-zeta"

echo "============================================"
echo "Hydro-Deps Benchmark Runner"
echo "============================================"
echo ""

# Check if the main repository exists
if [ ! -d "$MAIN_REPO" ]; then
    echo "ERROR: Could not find bigweaver-agent-canary-hydro-zeta repository"
    echo "Expected location: $MAIN_REPO"
    echo ""
    echo "Please ensure both repositories are checked out in the same parent directory:"
    echo "  /parent/"
    echo "    ├── bigweaver-agent-canary-hydro-zeta/"
    echo "    └── bigweaver-agent-canary-zeta-hydro-deps/"
    echo ""
    echo "The hydro-deps benchmarks reference DFIR components from the main repository."
    exit 1
fi

# Parse command line arguments
BENCH_PATTERN="${1:-}"

echo "Running comparison benchmarks (timely, differential, DFIR)..."
echo "============================================================"
cd "$DEPS_REPO"
if [ -n "$BENCH_PATTERN" ]; then
    cargo bench -- "$BENCH_PATTERN"
else
    cargo bench
fi
echo ""

echo "============================================"
echo "Benchmark run complete!"
echo "============================================"
echo ""
echo "Results are available in target/criterion/"
echo "Open target/criterion/report/index.html in a browser to view detailed results."
