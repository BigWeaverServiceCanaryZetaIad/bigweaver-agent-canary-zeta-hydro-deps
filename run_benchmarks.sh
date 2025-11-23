#!/bin/bash
# Script to run benchmarks with various options
# This provides a convenient interface for running the benchmark suite

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_info() {
    echo -e "${GREEN}ℹ${NC}  $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC}  $1"
}

show_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Run benchmarks for Hydro, timely-dataflow, and differential-dataflow.

OPTIONS:
    all                 Run all benchmarks (default)
    list                List all available benchmarks
    quick               Run a quick subset of benchmarks
    <benchmark_name>    Run a specific benchmark
    
BENCHMARK NAMES:
    arithmetic          Basic arithmetic operations
    fan_in              Fan-in patterns
    fan_out             Fan-out patterns
    fork_join           Fork-join patterns
    futures             Async futures operations
    identity            Identity transformations
    join                Join operations
    micro_ops           Micro-operations
    reachability        Graph reachability (differential-dataflow)
    symmetric_hash_join Symmetric hash join operations
    upcase              String uppercase operations
    words_diamond       Word processing diamond pattern

EXAMPLES:
    $0                  # Run all benchmarks
    $0 all              # Run all benchmarks
    $0 quick            # Run quick subset
    $0 reachability     # Run reachability benchmark only
    $0 list             # List available benchmarks

EOF
}

list_benchmarks() {
    print_header "Available Benchmarks"
    echo ""
    echo "Benchmarks using timely-dataflow:"
    echo "  • arithmetic"
    echo "  • fan_in"
    echo "  • fan_out"
    echo "  • fork_join"
    echo "  • identity"
    echo "  • join"
    echo "  • upcase"
    echo ""
    echo "Benchmarks using differential-dataflow:"
    echo "  • reachability"
    echo ""
    echo "Other benchmarks:"
    echo "  • futures"
    echo "  • micro_ops"
    echo "  • symmetric_hash_join"
    echo "  • words_diamond"
    echo ""
    echo "Total: 12 benchmarks"
    echo ""
}

run_all_benchmarks() {
    print_header "Running All Benchmarks"
    print_info "This will run all 12 benchmarks and generate performance reports..."
    echo ""
    
    cd "$SCRIPT_DIR"
    cargo bench -p benches
    
    echo ""
    print_info "All benchmarks completed!"
    print_info "Results are saved in target/criterion/"
}

run_quick_benchmarks() {
    print_header "Running Quick Benchmark Suite"
    print_info "Running a subset of benchmarks for quick validation..."
    echo ""
    
    cd "$SCRIPT_DIR"
    
    # Run a representative subset
    for bench in identity arithmetic join; do
        print_info "Running $bench..."
        cargo bench -p benches --bench "$bench"
    done
    
    echo ""
    print_info "Quick benchmarks completed!"
}

run_specific_benchmark() {
    local benchmark_name=$1
    
    print_header "Running Specific Benchmark: $benchmark_name"
    echo ""
    
    cd "$SCRIPT_DIR"
    
    if [ ! -f "benches/benches/${benchmark_name}.rs" ]; then
        echo "Error: Benchmark '$benchmark_name' not found!"
        echo ""
        echo "Available benchmarks:"
        list_benchmarks
        exit 1
    fi
    
    print_info "Running $benchmark_name benchmark..."
    cargo bench -p benches --bench "$benchmark_name"
    
    echo ""
    print_info "Benchmark completed!"
    print_info "Results are saved in target/criterion/$benchmark_name/"
}

# Main script logic
cd "$SCRIPT_DIR"

case "${1:-all}" in
    -h|--help|help)
        show_usage
        ;;
    list)
        list_benchmarks
        ;;
    all)
        run_all_benchmarks
        ;;
    quick)
        run_quick_benchmarks
        ;;
    arithmetic|fan_in|fan_out|fork_join|futures|identity|join|micro_ops|reachability|symmetric_hash_join|upcase|words_diamond)
        run_specific_benchmark "$1"
        ;;
    *)
        echo "Error: Unknown option or benchmark: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac
