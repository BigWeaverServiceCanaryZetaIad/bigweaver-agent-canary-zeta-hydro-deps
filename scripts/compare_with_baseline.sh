#!/bin/bash
# Benchmark Comparison Script
# This script helps compare benchmark results with a saved baseline

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}    Benchmark Comparison Tool${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo

# Check if baseline name is provided
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: $0 <baseline_name> [benchmark_name]${NC}"
    echo
    echo "Examples:"
    echo "  $0 main                    # Compare all benchmarks with 'main' baseline"
    echo "  $0 main micro_ops          # Compare only micro_ops with 'main' baseline"
    echo "  $0 before_optimization     # Compare all with 'before_optimization' baseline"
    echo
    echo "Available operations:"
    echo "  1. Save current results as baseline:   $0 --save <name>"
    echo "  2. Compare with baseline:              $0 <name>"
    echo "  3. List saved baselines:               $0 --list"
    echo
    exit 1
fi

# Navigate to benches directory
cd "$(dirname "$0")/../benches"

BASELINE_NAME="$1"
BENCHMARK_NAME="${2:-}"

# Handle special operations
if [ "$BASELINE_NAME" = "--list" ]; then
    echo -e "${GREEN}Available baselines:${NC}"
    if [ -d "target/criterion" ]; then
        find target/criterion -name "base" -type d | while read -r baseline; do
            parent_dir=$(dirname "$baseline")
            bench_name=$(basename "$parent_dir")
            echo "  - $bench_name"
        done
    else
        echo -e "${YELLOW}  No baselines found. Run benchmarks first.${NC}"
    fi
    exit 0
fi

if [ "$BASELINE_NAME" = "--save" ]; then
    if [ -z "$2" ]; then
        echo -e "${RED}Error: Please provide a name for the baseline${NC}"
        echo "Usage: $0 --save <baseline_name>"
        exit 1
    fi
    
    SAVE_NAME="$2"
    echo -e "${GREEN}Saving current results as baseline '${SAVE_NAME}'...${NC}"
    
    # Run benchmarks and save as baseline
    if [ -n "$3" ]; then
        cargo bench --bench "$3" -- --save-baseline "$SAVE_NAME"
    else
        cargo bench -- --save-baseline "$SAVE_NAME"
    fi
    
    echo
    echo -e "${GREEN}✓ Baseline '${SAVE_NAME}' saved!${NC}"
    echo -e "${YELLOW}To compare with this baseline later, run:${NC}"
    echo -e "  $0 ${SAVE_NAME}"
    exit 0
fi

# Compare with baseline
echo -e "${GREEN}Comparing benchmarks with baseline '${BASELINE_NAME}'...${NC}"
echo

if [ -n "$BENCHMARK_NAME" ]; then
    echo -e "${BLUE}Benchmark: ${BENCHMARK_NAME}${NC}"
    cargo bench --bench "$BENCHMARK_NAME" -- --baseline "$BASELINE_NAME"
else
    echo -e "${BLUE}Running all benchmarks...${NC}"
    cargo bench -- --baseline "$BASELINE_NAME"
fi

echo
echo -e "${GREEN}✓ Comparison complete!${NC}"
echo
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Results:${NC}"
echo -e "  - Detailed output above shows performance differences"
echo -e "  - Check HTML reports for visualizations:"
echo -e "    firefox ../target/criterion/report/index.html"
echo
echo -e "${YELLOW}Understanding the output:${NC}"
echo -e "  ${GREEN}Green${NC} = Performance improved (faster)"
echo -e "  ${RED}Red${NC}   = Performance regressed (slower)"
echo -e "  No change = Within statistical noise threshold"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
