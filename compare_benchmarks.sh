#!/bin/bash
# Performance comparison script for benchmarks across repositories
# This script runs benchmarks in both repositories and helps compare results

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HYDRO_REPO="$SCRIPT_DIR/../bigweaver-agent-canary-hydro-zeta"

echo "==================================="
echo "Benchmark Performance Comparison"
echo "==================================="
echo ""

# Check if main hydro repository exists
if [ ! -d "$HYDRO_REPO" ]; then
    echo "Error: Main hydro repository not found at $HYDRO_REPO"
    echo "Please ensure both repositories are in the same parent directory."
    exit 1
fi

# Run benchmarks in hydro-deps repository (timely/differential benchmarks)
echo "Running benchmarks in bigweaver-agent-canary-zeta-hydro-deps..."
echo "-----------------------------------"
cd "$SCRIPT_DIR"
cargo bench -p benches --no-fail-fast

echo ""
echo "-----------------------------------"
echo "Running benchmarks in bigweaver-agent-canary-hydro-zeta..."
echo "-----------------------------------"
cd "$HYDRO_REPO"
cargo bench -p benches --no-fail-fast

echo ""
echo "==================================="
echo "Benchmark runs complete!"
echo "==================================="
echo ""
echo "Results locations:"
echo "  Hydro-deps (timely/differential): $SCRIPT_DIR/target/criterion"
echo "  Hydro (hydroflow):                $HYDRO_REPO/target/criterion"
echo ""
echo "You can compare specific benchmarks by examining the criterion output directories."
echo "For detailed comparisons, use: criterion --compare"
