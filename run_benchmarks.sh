#!/bin/bash
# Script to run timely and differential-dataflow benchmarks
# This script provides various options for running benchmarks and comparing results

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PACKAGE="timely-differential-benches"
BENCHMARK_DIR="benches"
RESULTS_DIR="target/criterion"

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to print usage
print_usage() {
    cat << EOF
Usage: $0 [OPTIONS] [BENCHMARK]

Run timely and differential-dataflow benchmarks.

OPTIONS:
    -h, --help              Show this help message
    -a, --all               Run all benchmarks (default)
    -l, --list              List available benchmarks
    -f, --filter FILTER     Run benchmarks matching filter
    -q, --quick             Run quick benchmarks (reduced sample size)
    -s, --save NAME         Save results with a name for comparison
    -c, --compare NAME      Compare current run with saved results
    -o, --open              Open HTML report after completion
    --dfir-only             Run only dfir_rs benchmarks
    --timely-only           Run only timely benchmarks

BENCHMARKS:
    arithmetic              Arithmetic operations benchmark
    fan_in                  Fan-in pattern benchmark
    fan_out                 Fan-out pattern benchmark
    fork_join               Fork-join pattern benchmark
    identity                Identity operation benchmark
    join                    Join operations benchmark
    reachability            Graph reachability benchmark
    upcase                  String uppercase benchmark

EXAMPLES:
    $0                      Run all benchmarks
    $0 arithmetic           Run arithmetic benchmark only
    $0 -f dfir              Run benchmarks matching 'dfir'
    $0 --quick arithmetic   Run arithmetic benchmark with reduced samples
    $0 -s baseline          Run all and save as 'baseline'
    $0 -c baseline          Run all and compare with 'baseline'
    $0 --dfir-only          Run only dfir_rs implementations

EOF
}

# Function to list benchmarks
list_benchmarks() {
    print_info "Available benchmarks:"
    echo ""
    echo "  arithmetic       - Arithmetic operations comparison"
    echo "  fan_in          - Multiple inputs to single output"
    echo "  fan_out         - Single input to multiple outputs"
    echo "  fork_join       - Parallel computation with synchronization"
    echo "  identity        - Baseline dataflow overhead"
    echo "  join            - Relational join operations"
    echo "  reachability    - Graph traversal algorithms"
    echo "  upcase          - String transformation"
    echo ""
}

# Function to check if running in workspace
check_workspace() {
    if [ ! -f "Cargo.toml" ]; then
        print_error "Not in repository root. Please run from bigweaver-agent-canary-zeta-hydro-deps/"
        exit 1
    fi
    
    if [ ! -d "$BENCHMARK_DIR" ]; then
        print_error "Benchmark directory not found: $BENCHMARK_DIR"
        exit 1
    fi
}

# Function to save benchmark results
save_results() {
    local name=$1
    local save_dir="benchmark_results/$name"
    
    print_info "Saving benchmark results as '$name'..."
    
    mkdir -p "$save_dir"
    
    if [ -d "$RESULTS_DIR" ]; then
        cp -r "$RESULTS_DIR" "$save_dir/"
        print_success "Results saved to $save_dir"
    else
        print_error "No results found at $RESULTS_DIR"
        exit 1
    fi
}

# Function to compare benchmark results
compare_results() {
    local name=$1
    local save_dir="benchmark_results/$name"
    
    if [ ! -d "$save_dir/criterion" ]; then
        print_error "No saved results found for '$name'"
        print_info "Available saved results:"
        if [ -d "benchmark_results" ]; then
            ls -1 benchmark_results/
        else
            echo "  (none)"
        fi
        exit 1
    fi
    
    print_info "Comparing with saved results '$name'..."
    print_warning "Comparison will be available in the HTML reports"
    print_info "Saved baseline: $save_dir/criterion"
}

# Function to open HTML report
open_report() {
    local report="$RESULTS_DIR/report/index.html"
    
    if [ ! -f "$report" ]; then
        print_error "HTML report not found at $report"
        exit 1
    fi
    
    print_info "Opening benchmark report..."
    
    if command -v xdg-open &> /dev/null; then
        xdg-open "$report"
    elif command -v open &> /dev/null; then
        open "$report"
    else
        print_warning "Could not open browser automatically"
        print_info "Report location: $report"
    fi
}

# Parse arguments
BENCHMARK=""
FILTER=""
QUICK=false
SAVE_NAME=""
COMPARE_NAME=""
OPEN_REPORT=false
IMPL_FILTER=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            print_usage
            exit 0
            ;;
        -a|--all)
            BENCHMARK=""
            shift
            ;;
        -l|--list)
            list_benchmarks
            exit 0
            ;;
        -f|--filter)
            FILTER="$2"
            shift 2
            ;;
        -q|--quick)
            QUICK=true
            shift
            ;;
        -s|--save)
            SAVE_NAME="$2"
            shift 2
            ;;
        -c|--compare)
            COMPARE_NAME="$2"
            shift 2
            ;;
        -o|--open)
            OPEN_REPORT=true
            shift
            ;;
        --dfir-only)
            IMPL_FILTER="dfir"
            shift
            ;;
        --timely-only)
            IMPL_FILTER="timely"
            shift
            ;;
        *)
            if [ -z "$BENCHMARK" ]; then
                BENCHMARK="$1"
            else
                print_error "Unknown option: $1"
                print_usage
                exit 1
            fi
            shift
            ;;
    esac
done

# Main execution
main() {
    check_workspace
    
    print_info "Running timely and differential-dataflow benchmarks"
    echo ""
    
    # Build benchmark command
    CMD="cargo bench -p $PACKAGE"
    
    if [ -n "$BENCHMARK" ]; then
        CMD="$CMD --bench $BENCHMARK"
        print_info "Benchmark: $BENCHMARK"
    else
        print_info "Running all benchmarks"
    fi
    
    # Add filter if specified
    if [ -n "$FILTER" ]; then
        CMD="$CMD -- $FILTER"
        print_info "Filter: $FILTER"
    elif [ -n "$IMPL_FILTER" ]; then
        CMD="$CMD -- $IMPL_FILTER"
        print_info "Implementation filter: $IMPL_FILTER"
    fi
    
    # Handle quick mode
    if [ "$QUICK" = true ]; then
        print_info "Quick mode: Using reduced sample size"
        export CARGO_BENCH_QUICK=1
    fi
    
    # Compare with baseline if specified
    if [ -n "$COMPARE_NAME" ]; then
        compare_results "$COMPARE_NAME"
    fi
    
    echo ""
    print_info "Executing: $CMD"
    echo ""
    
    # Run benchmarks
    if eval "$CMD"; then
        print_success "Benchmarks completed successfully"
    else
        print_error "Benchmarks failed"
        exit 1
    fi
    
    # Save results if requested
    if [ -n "$SAVE_NAME" ]; then
        echo ""
        save_results "$SAVE_NAME"
    fi
    
    # Show results location
    echo ""
    print_info "Results saved to: $RESULTS_DIR"
    print_info "HTML report: $RESULTS_DIR/report/index.html"
    
    # Open report if requested
    if [ "$OPEN_REPORT" = true ]; then
        echo ""
        open_report
    fi
    
    echo ""
    print_success "Done!"
}

# Run main function
main
