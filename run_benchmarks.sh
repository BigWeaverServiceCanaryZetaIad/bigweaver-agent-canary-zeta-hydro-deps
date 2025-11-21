#!/bin/bash
# Script to run all benchmarks with performance comparison

set -e

echo "=================================="
echo "Timely & Differential Benchmarks"
echo "=================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Parse command line arguments
FILTER="${1:-}"
SAVE_BASELINE="${2:-}"

if [ ! -z "$SAVE_BASELINE" ]; then
    BASELINE_ARG="--save-baseline $SAVE_BASELINE"
    echo -e "${YELLOW}Saving baseline as: $SAVE_BASELINE${NC}"
else
    BASELINE_ARG=""
fi

# Function to run a benchmark suite
run_benchmark() {
    local name=$1
    local bench_name=$2
    
    echo -e "${BLUE}Running $name...${NC}"
    if [ ! -z "$FILTER" ]; then
        cargo bench -p timely-differential-benches --bench "$bench_name" -- $BASELINE_ARG "$FILTER"
    else
        cargo bench -p timely-differential-benches --bench "$bench_name" -- $BASELINE_ARG
    fi
    echo -e "${GREEN}✓ $name completed${NC}"
    echo ""
}

# Run all benchmark suites
echo "Starting benchmark suite..."
echo ""

run_benchmark "Timely Basic Operations" "timely_basic_ops"
run_benchmark "Timely Reachability" "timely_reachability"
run_benchmark "Differential Basic Operations" "differential_basic_ops"
run_benchmark "Differential Reachability" "differential_reachability"
run_benchmark "Performance Comparison" "comparison"

echo ""
echo -e "${GREEN}=================================="
echo "All benchmarks completed!"
echo "==================================${NC}"
echo ""
echo "View results at: target/criterion/report/index.html"
echo ""

# Check if xdg-open is available to open the report
if command -v xdg-open &> /dev/null; then
    echo "Open report with: xdg-open target/criterion/report/index.html"
elif command -v open &> /dev/null; then
    echo "Open report with: open target/criterion/report/index.html"
fi
