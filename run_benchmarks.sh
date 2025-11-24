#!/bin/bash

# Script to run benchmarks with various options
# Usage: ./run_benchmarks.sh [options]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
MODE="all"
QUICK=false
BENCH_NAME=""

# Function to display usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Run Timely and Differential-Dataflow benchmarks

OPTIONS:
    -h, --help              Display this help message
    -a, --all               Run all benchmarks (default)
    -b, --bench NAME        Run specific benchmark
    -q, --quick             Run quick benchmarks (fewer iterations)
    -l, --list              List available benchmarks
    -c, --compile-only      Only compile benchmarks, don't run
    -v, --verify            Verify benchmarks compile and run quickly

EXAMPLES:
    $0                              # Run all benchmarks
    $0 --quick                      # Run all benchmarks quickly
    $0 --bench reachability         # Run only reachability benchmark
    $0 --bench arithmetic --quick   # Run arithmetic benchmark quickly
    $0 --list                       # List all available benchmarks
    $0 --verify                     # Quick verification that all work

EOF
}

# Function to list benchmarks
list_benchmarks() {
    echo -e "${GREEN}Available benchmarks:${NC}"
    echo "  - arithmetic           : Arithmetic operation benchmarks"
    echo "  - fan_in              : Fan-in pattern benchmarks"
    echo "  - fan_out             : Fan-out pattern benchmarks"
    echo "  - fork_join           : Fork-join pattern benchmarks"
    echo "  - identity            : Identity operation benchmarks"
    echo "  - upcase              : String case transformation benchmarks"
    echo "  - join                : Join operation benchmarks"
    echo "  - reachability        : Graph reachability benchmarks"
    echo "  - micro_ops           : Micro-operation benchmarks"
    echo "  - symmetric_hash_join : Symmetric hash join benchmarks"
    echo "  - words_diamond       : Word processing diamond pattern benchmarks"
    echo "  - futures             : Async futures benchmarks"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -a|--all)
            MODE="all"
            shift
            ;;
        -b|--bench)
            MODE="single"
            BENCH_NAME="$2"
            shift 2
            ;;
        -q|--quick)
            QUICK=true
            shift
            ;;
        -l|--list)
            list_benchmarks
            exit 0
            ;;
        -c|--compile-only)
            MODE="compile"
            shift
            ;;
        -v|--verify)
            MODE="verify"
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            exit 1
            ;;
    esac
done

# Main execution
echo -e "${GREEN}=== Timely and Differential-Dataflow Benchmarks ===${NC}"
echo ""

case $MODE in
    compile)
        echo -e "${YELLOW}Compiling benchmarks...${NC}"
        cargo bench --no-run
        echo -e "${GREEN}✓ All benchmarks compiled successfully${NC}"
        ;;
    
    verify)
        echo -e "${YELLOW}Verifying benchmarks...${NC}"
        echo "1. Compiling..."
        cargo bench --no-run
        echo -e "${GREEN}✓ Compilation successful${NC}"
        echo ""
        echo "2. Running quick test..."
        cargo bench --bench identity -- --quick
        echo -e "${GREEN}✓ Verification complete${NC}"
        ;;
    
    single)
        if [ -z "$BENCH_NAME" ]; then
            echo -e "${RED}Error: Benchmark name required${NC}"
            usage
            exit 1
        fi
        
        echo -e "${YELLOW}Running benchmark: $BENCH_NAME${NC}"
        if [ "$QUICK" = true ]; then
            cargo bench --bench "$BENCH_NAME" -- --quick
        else
            cargo bench --bench "$BENCH_NAME"
        fi
        echo -e "${GREEN}✓ Benchmark complete${NC}"
        ;;
    
    all)
        echo -e "${YELLOW}Running all benchmarks...${NC}"
        if [ "$QUICK" = true ]; then
            cargo bench -- --quick
        else
            cargo bench
        fi
        echo -e "${GREEN}✓ All benchmarks complete${NC}"
        ;;
esac

echo ""
echo -e "${GREEN}Results are available in: target/criterion/${NC}"
echo "Open target/criterion/report/index.html to view detailed results"
