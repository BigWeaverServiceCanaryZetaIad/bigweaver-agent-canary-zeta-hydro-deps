#!/bin/bash
# Script to run benchmarks with various configurations

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

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

# Display usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Run Hydroflow external dependency benchmarks

OPTIONS:
    -a, --all           Run all benchmarks (default)
    -b, --bench NAME    Run specific benchmark by name
    -q, --quick         Run benchmarks in quick mode (fewer samples)
    -l, --list          List all available benchmarks
    -s, --save NAME     Save results as baseline with given name
    -c, --compare NAME  Compare against saved baseline
    -h, --help          Display this help message

EXAMPLES:
    $0                          # Run all benchmarks
    $0 --bench arithmetic       # Run only arithmetic benchmark
    $0 --quick                  # Run all benchmarks quickly
    $0 --save main             # Run and save as 'main' baseline
    $0 --compare main          # Run and compare against 'main' baseline
    $0 --bench join --quick    # Run join benchmark quickly

AVAILABLE BENCHMARKS:
    arithmetic      - Arithmetic pipeline operations
    fan_in          - Fan-in pattern (multiple inputs to one)
    fan_out         - Fan-out pattern (one input to multiple)
    fork_join       - Fork-join pattern (split and merge)
    identity        - Identity operations (baseline)
    join            - Hash join operations
    reachability    - Graph reachability algorithms
    upcase          - String uppercase transformations

EOF
}

# List available benchmarks
list_benchmarks() {
    print_info "Available benchmarks:"
    echo "  - arithmetic      : Arithmetic pipeline operations"
    echo "  - fan_in          : Fan-in pattern comparison"
    echo "  - fan_out         : Fan-out pattern comparison"
    echo "  - fork_join       : Fork-join pattern comparison"
    echo "  - identity        : Identity operations comparison"
    echo "  - join            : Hash join operations comparison"
    echo "  - reachability    : Graph reachability comparison"
    echo "  - upcase          : String uppercase comparison"
}

# Parse command line arguments
MODE="all"
BENCH_NAME=""
QUICK=""
BASELINE_SAVE=""
BASELINE_COMPARE=""

while [[ $# -gt 0 ]]; do
    case $1 in
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
            QUICK="--quick"
            shift
            ;;
        -l|--list)
            list_benchmarks
            exit 0
            ;;
        -s|--save)
            BASELINE_SAVE="$2"
            shift 2
            ;;
        -c|--compare)
            BASELINE_COMPARE="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Build the cargo command
CARGO_CMD="cargo bench -p hydro-deps-benches"

if [ "$MODE" = "single" ]; then
    if [ -z "$BENCH_NAME" ]; then
        print_error "Benchmark name not specified"
        exit 1
    fi
    print_info "Running benchmark: $BENCH_NAME"
    CARGO_CMD="$CARGO_CMD --bench $BENCH_NAME"
else
    print_info "Running all benchmarks"
fi

# Add additional flags
BENCH_FLAGS=""
if [ -n "$QUICK" ]; then
    print_warning "Running in quick mode (fewer samples, less accurate)"
    BENCH_FLAGS="$BENCH_FLAGS $QUICK"
fi

if [ -n "$BASELINE_SAVE" ]; then
    print_info "Saving results as baseline: $BASELINE_SAVE"
    BENCH_FLAGS="$BENCH_FLAGS --save-baseline $BASELINE_SAVE"
fi

if [ -n "$BASELINE_COMPARE" ]; then
    print_info "Comparing against baseline: $BASELINE_COMPARE"
    BENCH_FLAGS="$BENCH_FLAGS --baseline $BASELINE_COMPARE"
fi

# Check if cargo is available
if ! command -v cargo &> /dev/null; then
    print_error "Cargo not found. Please install Rust toolchain."
    exit 1
fi

# Run the benchmarks
print_info "Executing: $CARGO_CMD -- $BENCH_FLAGS"
echo ""

if [ -n "$BENCH_FLAGS" ]; then
    $CARGO_CMD -- $BENCH_FLAGS
else
    $CARGO_CMD
fi

EXIT_CODE=$?

echo ""
if [ $EXIT_CODE -eq 0 ]; then
    print_success "Benchmarks completed successfully!"
    echo ""
    print_info "To view detailed HTML reports, open:"
    echo "  target/criterion/report/index.html"
else
    print_error "Benchmarks failed with exit code $EXIT_CODE"
    exit $EXIT_CODE
fi
