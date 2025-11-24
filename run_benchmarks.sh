#!/bin/bash
# Benchmark execution script for timely and differential-dataflow benchmarks
# This script provides convenient commands for running various benchmark suites

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Timely & Differential-Dataflow Benchmark Runner                   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to display usage
usage() {
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  all          Run all benchmarks (comprehensive, takes longer)"
    echo "  quick        Run quick benchmark suite (arithmetic, identity, join)"
    echo "  dataflow     Run dataflow pattern benchmarks (fan_in, fan_out, fork_join)"
    echo "  complex      Run complex workload benchmarks (reachability, words_diamond)"
    echo "  timely       Run benchmarks that compare with timely"
    echo "  differential Run benchmarks that use differential-dataflow"
    echo "  <name>       Run specific benchmark (e.g., 'arithmetic', 'reachability')"
    echo "  list         List all available benchmarks"
    echo "  help         Display this help message"
    echo ""
    echo "Examples:"
    echo "  $0 all                  # Run all benchmarks"
    echo "  $0 quick                # Run quick comparison suite"
    echo "  $0 reachability         # Run only reachability benchmark"
    echo ""
}

# Function to list all benchmarks
list_benchmarks() {
    echo -e "${GREEN}Available Benchmarks:${NC}"
    echo ""
    echo "Basic Operations:"
    echo "  - arithmetic           : Chain of arithmetic operations"
    echo "  - identity             : Pass-through operations"
    echo "  - upcase               : String transformation operations"
    echo ""
    echo "Dataflow Patterns:"
    echo "  - fan_in               : Multiple inputs converging"
    echo "  - fan_out              : One input splitting"
    echo "  - fork_join            : Fork and join pattern"
    echo "  - join                 : Join operations"
    echo "  - symmetric_hash_join  : Symmetric hash join"
    echo ""
    echo "Complex Workloads:"
    echo "  - reachability         : Graph reachability (differential-dataflow)"
    echo "  - words_diamond        : Diamond dataflow on word processing"
    echo "  - micro_ops            : Micro-operations benchmarks"
    echo ""
    echo "Async Operations:"
    echo "  - futures              : Async operations and futures"
    echo ""
}

# Parse command line arguments
COMMAND=${1:-help}

case "$COMMAND" in
    all)
        echo -e "${GREEN}Running all benchmarks...${NC}"
        echo -e "${YELLOW}Note: This will take a while. Get some coffee! ☕${NC}"
        echo ""
        cargo bench
        ;;
    
    quick)
        echo -e "${GREEN}Running quick benchmark suite...${NC}"
        echo "Benchmarks: arithmetic, identity, join"
        echo ""
        cargo bench --bench arithmetic --bench identity --bench join
        ;;
    
    dataflow)
        echo -e "${GREEN}Running dataflow pattern benchmarks...${NC}"
        echo "Benchmarks: fan_in, fan_out, fork_join, join"
        echo ""
        cargo bench --bench fan_in --bench fan_out --bench fork_join --bench join
        ;;
    
    complex)
        echo -e "${GREEN}Running complex workload benchmarks...${NC}"
        echo "Benchmarks: reachability, words_diamond"
        echo ""
        cargo bench --bench reachability --bench words_diamond
        ;;
    
    timely)
        echo -e "${GREEN}Running timely comparison benchmarks...${NC}"
        echo "Benchmarks: arithmetic, identity, fan_in, fan_out, fork_join, join, upcase"
        echo ""
        cargo bench --bench arithmetic --bench identity --bench fan_in \
                   --bench fan_out --bench fork_join --bench join --bench upcase
        ;;
    
    differential)
        echo -e "${GREEN}Running differential-dataflow benchmarks...${NC}"
        echo "Benchmarks: reachability"
        echo ""
        cargo bench --bench reachability
        ;;
    
    list)
        list_benchmarks
        ;;
    
    help)
        usage
        ;;
    
    arithmetic|fan_in|fan_out|fork_join|identity|join|micro_ops|reachability|symmetric_hash_join|upcase|words_diamond|futures)
        echo -e "${GREEN}Running benchmark: $COMMAND${NC}"
        echo ""
        cargo bench --bench "$COMMAND"
        ;;
    
    *)
        echo -e "${YELLOW}Unknown option: $COMMAND${NC}"
        echo ""
        usage
        exit 1
        ;;
esac

# Display results location
if [ "$COMMAND" != "help" ] && [ "$COMMAND" != "list" ]; then
    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}✓ Benchmarks completed!${NC}"
    echo ""
    echo "HTML reports available at:"
    echo "  target/criterion/report/index.html"
    echo ""
    echo "To view in browser:"
    echo "  open target/criterion/report/index.html"
    echo -e "${BLUE}════════════════════════════════════════════════════════════════════${NC}"
fi
