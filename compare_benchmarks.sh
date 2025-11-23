#!/bin/bash
# Script to compare benchmark results between Hydro and timely/differential-dataflow
# This helps analyze performance differences

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRITERION_DIR="$SCRIPT_DIR/target/criterion"

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_info() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC}  $1"
}

show_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Compare benchmark results between Hydro and timely/differential-dataflow.

OPTIONS:
    summary             Show summary of all benchmark comparisons
    <benchmark_name>    Show detailed comparison for specific benchmark
    help                Show this help message

EXAMPLES:
    $0                  # Show summary
    $0 summary          # Show summary
    $0 reachability     # Show detailed reachability comparison

NOTES:
    - You must run benchmarks first using ./run_benchmarks.sh
    - Results are read from target/criterion/ directory
    - HTML reports are available in target/criterion/reports/

EOF
}

check_benchmark_results() {
    if [ ! -d "$CRITERION_DIR" ]; then
        echo "Error: No benchmark results found!"
        echo "Please run benchmarks first: ./run_benchmarks.sh"
        exit 1
    fi
}

show_summary() {
    print_header "Benchmark Comparison Summary"
    echo ""
    
    check_benchmark_results
    
    print_info "Benchmark results location: $CRITERION_DIR"
    echo ""
    
    if [ -d "$CRITERION_DIR/reports" ]; then
        print_info "HTML reports available at: $CRITERION_DIR/reports/index.html"
        echo ""
    fi
    
    echo "Benchmarks with results:"
    for bench_dir in "$CRITERION_DIR"/*; do
        if [ -d "$bench_dir" ] && [ "$(basename "$bench_dir")" != "reports" ]; then
            bench_name=$(basename "$bench_dir")
            echo "  • $bench_name"
        fi
    done
    
    echo ""
    print_info "To view detailed comparison for a benchmark:"
    echo "  $0 <benchmark_name>"
    echo ""
    print_info "To view HTML reports, open in a browser:"
    echo "  file://$CRITERION_DIR/reports/index.html"
}

show_detailed_comparison() {
    local benchmark=$1
    
    print_header "Detailed Comparison: $benchmark"
    echo ""
    
    check_benchmark_results
    
    local bench_dir="$CRITERION_DIR/$benchmark"
    
    if [ ! -d "$bench_dir" ]; then
        echo "Error: No results found for benchmark '$benchmark'"
        echo ""
        echo "Available benchmarks:"
        for dir in "$CRITERION_DIR"/*; do
            if [ -d "$dir" ] && [ "$(basename "$dir")" != "reports" ]; then
                echo "  • $(basename "$dir")"
            fi
        done
        exit 1
    fi
    
    print_info "Results directory: $bench_dir"
    echo ""
    
    # List available comparison groups
    echo "Available comparisons in this benchmark:"
    for group_dir in "$bench_dir"/*; do
        if [ -d "$group_dir" ]; then
            group_name=$(basename "$group_dir")
            echo "  • $group_name"
            
            # Show the report files if they exist
            if [ -f "$group_dir/report/index.html" ]; then
                echo "    Report: file://$group_dir/report/index.html"
            fi
        fi
    done
    
    echo ""
    print_info "For detailed analysis, view the HTML reports in a browser"
    
    if [ -f "$bench_dir/report/index.html" ]; then
        echo ""
        print_info "Main report: file://$bench_dir/report/index.html"
    fi
}

# Main script logic
case "${1:-summary}" in
    -h|--help|help)
        show_usage
        ;;
    summary)
        show_summary
        ;;
    *)
        show_detailed_comparison "$1"
        ;;
esac
