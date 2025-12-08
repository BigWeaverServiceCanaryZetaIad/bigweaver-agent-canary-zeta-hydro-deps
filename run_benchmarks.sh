#!/bin/bash
# Script to run performance benchmarks for Hydro
# This script provides convenient ways to run benchmarks and compare performance

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Run Hydro performance benchmarks with timely and differential-dataflow.

OPTIONS:
    -a, --all               Run all benchmarks
    -b, --bench NAME        Run specific benchmark (e.g., reachability, arithmetic)
    -l, --list              List available benchmarks
    -h, --help              Show this help message
    --baseline NAME         Save results as baseline for comparison
    --compare NAME          Compare current run against saved baseline

EXAMPLES:
    $0 --all                          # Run all benchmarks
    $0 --bench reachability          # Run reachability benchmark
    $0 --all --baseline before-opt   # Run all and save as baseline
    $0 --all --compare before-opt    # Compare against baseline

BENCHMARK RESULTS:
    HTML reports are generated in: target/criterion/<benchmark>/report/index.html
EOF
}

list_benchmarks() {
    echo -e "${GREEN}Available Benchmarks:${NC}"
    echo "  - arithmetic          : Arithmetic operation throughput"
    echo "  - fan_in              : Fan-in communication patterns"
    echo "  - fan_out             : Fan-out communication patterns"
    echo "  - fork_join           : Fork-join parallelism patterns"
    echo "  - futures             : Futures-based async operations"
    echo "  - identity            : Identity/passthrough operations"
    echo "  - join                : Join operations"
    echo "  - micro_ops           : Micro-level operations"
    echo "  - reachability        : Graph reachability algorithms"
    echo "  - symmetric_hash_join : Symmetric hash join operations"
    echo "  - upcase              : String transformation operations"
    echo "  - words_diamond       : Diamond communication patterns"
}

run_benchmark() {
    local bench_name=$1
    local baseline=${2:-}
    local compare=${3:-}
    
    echo -e "${GREEN}Running benchmark: ${bench_name}${NC}"
    
    local cmd="cargo bench -p benches --bench ${bench_name}"
    
    if [ -n "$baseline" ]; then
        cmd="$cmd -- --save-baseline ${baseline}"
        echo -e "${YELLOW}Saving results as baseline: ${baseline}${NC}"
    elif [ -n "$compare" ]; then
        cmd="$cmd -- --baseline ${compare}"
        echo -e "${YELLOW}Comparing against baseline: ${compare}${NC}"
    fi
    
    eval "$cmd"
    
    echo -e "${GREEN}Benchmark complete!${NC}"
    echo -e "Results: target/criterion/${bench_name}/report/index.html"
}

run_all_benchmarks() {
    local baseline=${1:-}
    local compare=${2:-}
    
    echo -e "${GREEN}Running all benchmarks...${NC}"
    
    local cmd="cargo bench -p benches"
    
    if [ -n "$baseline" ]; then
        cmd="$cmd -- --save-baseline ${baseline}"
        echo -e "${YELLOW}Saving results as baseline: ${baseline}${NC}"
    elif [ -n "$compare" ]; then
        cmd="$cmd -- --baseline ${compare}"
        echo -e "${YELLOW}Comparing against baseline: ${compare}${NC}"
    fi
    
    eval "$cmd"
    
    echo -e "${GREEN}All benchmarks complete!${NC}"
    echo -e "Results in: target/criterion/*/report/index.html"
}

# Parse command line arguments
BENCH_NAME=""
RUN_ALL=false
LIST_ONLY=false
BASELINE=""
COMPARE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--all)
            RUN_ALL=true
            shift
            ;;
        -b|--bench)
            BENCH_NAME="$2"
            shift 2
            ;;
        -l|--list)
            LIST_ONLY=true
            shift
            ;;
        --baseline)
            BASELINE="$2"
            shift 2
            ;;
        --compare)
            COMPARE="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            exit 1
            ;;
    esac
done

# Execute based on options
if [ "$LIST_ONLY" = true ]; then
    list_benchmarks
elif [ "$RUN_ALL" = true ]; then
    run_all_benchmarks "$BASELINE" "$COMPARE"
elif [ -n "$BENCH_NAME" ]; then
    run_benchmark "$BENCH_NAME" "$BASELINE" "$COMPARE"
else
    echo -e "${RED}Error: No action specified${NC}"
    echo ""
    usage
    exit 1
fi
