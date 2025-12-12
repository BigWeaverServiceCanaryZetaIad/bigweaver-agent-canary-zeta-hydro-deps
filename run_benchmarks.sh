#!/bin/bash
# Benchmark runner script for bigweaver-agent-canary-zeta-hydro-deps
#
# Usage:
#   ./run_benchmarks.sh [options]
#
# Options:
#   --all              Run all benchmarks
#   --package <name>   Run benchmarks for specific package
#   --baseline <name>  Save results as baseline for comparison
#   --compare <name>   Compare against saved baseline
#   --help             Show this help message

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
MODE="all"
PACKAGE=""
BASELINE=""
COMPARE=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --all)
            MODE="all"
            shift
            ;;
        --package)
            MODE="package"
            PACKAGE="$2"
            shift 2
            ;;
        --baseline)
            BASELINE="$2"
            shift 2
            ;;
        --compare)
            COMPARE="$2"
            shift 2
            ;;
        --help)
            echo "Benchmark runner for bigweaver-agent-canary-zeta-hydro-deps"
            echo ""
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --all              Run all benchmarks (default)"
            echo "  --package <name>   Run benchmarks for specific package"
            echo "  --baseline <name>  Save results as baseline for comparison"
            echo "  --compare <name>   Compare against saved baseline"
            echo "  --help             Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0 --all"
            echo "  $0 --package dataflow_benchmarks"
            echo "  $0 --all --baseline before_optimization"
            echo "  $0 --all --compare before_optimization"
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            exit 1
            ;;
    esac
done

echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Benchmark Runner - Hydro Deps Repository                 ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if workspace has any benchmark members
if ! grep -q "members.*=" Cargo.toml; then
    echo -e "${YELLOW}Warning: No benchmark crates found in workspace.${NC}"
    echo "The workspace is configured but no benchmark crates have been added yet."
    echo ""
    echo "To add a benchmark crate:"
    echo "  1. Create a new crate: cargo new --lib benchmarks/my_benchmark"
    echo "  2. Add it to workspace members in Cargo.toml"
    echo "  3. Implement benchmarks in the crate"
    echo ""
    exit 0
fi

# Build command based on options
BENCH_CMD="cargo bench"

if [ "$MODE" = "package" ]; then
    if [ -z "$PACKAGE" ]; then
        echo -e "${RED}Error: --package requires a package name${NC}"
        exit 1
    fi
    BENCH_CMD="$BENCH_CMD --package $PACKAGE"
    echo "Running benchmarks for package: $PACKAGE"
elif [ "$MODE" = "all" ]; then
    BENCH_CMD="$BENCH_CMD --all"
    echo "Running all benchmarks"
fi

# Add baseline/compare options
if [ -n "$BASELINE" ]; then
    BENCH_CMD="$BENCH_CMD -- --save-baseline $BASELINE"
    echo "Saving results as baseline: $BASELINE"
fi

if [ -n "$COMPARE" ]; then
    BENCH_CMD="$BENCH_CMD -- --baseline $COMPARE"
    echo "Comparing against baseline: $COMPARE"
fi

echo ""
echo -e "${GREEN}Command:${NC} $BENCH_CMD"
echo ""

# Run the benchmark
$BENCH_CMD

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Benchmark Complete                                        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Results available at: target/criterion/report/index.html"
echo ""
echo "To view results:"
echo "  open target/criterion/report/index.html"
echo ""
