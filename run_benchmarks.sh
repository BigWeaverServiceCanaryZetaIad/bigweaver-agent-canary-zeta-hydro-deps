#!/bin/bash
# Script to run Hydro benchmarks with performance comparison capabilities
set -e

# Color output helpers
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Display usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Run Hydro benchmarks with optional performance comparison capabilities.

OPTIONS:
    -h, --help              Show this help message
    -b, --benchmark NAME    Run specific benchmark (default: all)
    -s, --save NAME         Save results with baseline name
    -c, --compare NAME      Compare against saved baseline
    -l, --list              List available benchmarks
    -v, --verbose           Verbose output

EXAMPLES:
    # Run all benchmarks
    $0

    # Run a specific benchmark
    $0 --benchmark reachability

    # Save a baseline
    $0 --save before_optimization

    # Compare against baseline
    $0 --compare before_optimization

    # Run specific benchmark and compare
    $0 --benchmark join --compare baseline_v1
EOF
}

# List available benchmarks
list_benchmarks() {
    print_info "Available benchmarks:"
    echo "  - arithmetic"
    echo "  - fan_in"
    echo "  - fan_out"
    echo "  - fork_join"
    echo "  - futures"
    echo "  - identity"
    echo "  - join"
    echo "  - micro_ops"
    echo "  - reachability"
    echo "  - symmetric_hash_join"
    echo "  - upcase"
    echo "  - words_diamond"
}

# Parse command line arguments
BENCHMARK=""
BASELINE_SAVE=""
BASELINE_COMPARE=""
VERBOSE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -l|--list)
            list_benchmarks
            exit 0
            ;;
        -b|--benchmark)
            BENCHMARK="$2"
            shift 2
            ;;
        -s|--save)
            BASELINE_SAVE="$2"
            shift 2
            ;;
        -c|--compare)
            BASELINE_COMPARE="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE="--verbose"
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Build the cargo bench command
CARGO_CMD="cargo bench -p benches"

if [ -n "$BENCHMARK" ]; then
    CARGO_CMD="$CARGO_CMD --bench $BENCHMARK"
    print_info "Running benchmark: $BENCHMARK"
else
    print_info "Running all benchmarks"
fi

# Add criterion arguments if needed
CRITERION_ARGS=""

if [ -n "$BASELINE_SAVE" ]; then
    CRITERION_ARGS="$CRITERION_ARGS --save-baseline $BASELINE_SAVE"
    print_info "Saving baseline as: $BASELINE_SAVE"
fi

if [ -n "$BASELINE_COMPARE" ]; then
    CRITERION_ARGS="$CRITERION_ARGS --baseline $BASELINE_COMPARE"
    print_info "Comparing against baseline: $BASELINE_COMPARE"
fi

if [ -n "$VERBOSE" ]; then
    CRITERION_ARGS="$CRITERION_ARGS --verbose"
fi

# Execute the benchmark
if [ -n "$CRITERION_ARGS" ]; then
    CARGO_CMD="$CARGO_CMD -- $CRITERION_ARGS"
fi

print_info "Executing: $CARGO_CMD"
eval "$CARGO_CMD"

# Print results location
print_info "Benchmark results available in: target/criterion/"
if [ -n "$BASELINE_SAVE" ]; then
    print_info "Baseline saved for future comparisons"
fi
if [ -n "$BASELINE_COMPARE" ]; then
    print_info "Check the output above for performance comparison results"
fi
