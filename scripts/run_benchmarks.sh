#!/bin/bash
#
# Script to run Hydro benchmarks with various configurations
#
# Usage:
#   ./scripts/run_benchmarks.sh [all|<benchmark_name>] [options]
#
# Examples:
#   ./scripts/run_benchmarks.sh all                    # Run all benchmarks
#   ./scripts/run_benchmarks.sh reachability           # Run specific benchmark
#   ./scripts/run_benchmarks.sh all --save-baseline v1 # Save baseline for comparison
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print colored message
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Available benchmarks
BENCHMARKS=(
    "arithmetic"
    "fan_in"
    "fan_out"
    "fork_join"
    "futures"
    "identity"
    "join"
    "micro_ops"
    "reachability"
    "symmetric_hash_join"
    "upcase"
    "words_diamond"
)

# Check if we're in the right directory
if [ ! -f "Cargo.toml" ]; then
    print_error "Must be run from the repository root"
    exit 1
fi

# Parse arguments
BENCHMARK_TARGET="${1:-all}"
shift || true
EXTRA_ARGS="$@"

run_benchmark() {
    local benchmark=$1
    print_status "Running benchmark: $benchmark"
    cargo bench -p benches --bench "$benchmark" $EXTRA_ARGS
}

# Main execution
if [ "$BENCHMARK_TARGET" = "all" ]; then
    print_status "Running all benchmarks..."
    for bench in "${BENCHMARKS[@]}"; do
        run_benchmark "$bench"
        echo ""
    done
    print_status "All benchmarks completed!"
    print_status "View reports in target/criterion/"
elif [[ " ${BENCHMARKS[@]} " =~ " ${BENCHMARK_TARGET} " ]]; then
    run_benchmark "$BENCHMARK_TARGET"
    print_status "Benchmark completed!"
    print_status "View report in target/criterion/$BENCHMARK_TARGET/"
else
    print_error "Unknown benchmark: $BENCHMARK_TARGET"
    echo ""
    echo "Usage: $0 [all|<benchmark_name>] [cargo bench options]"
    echo ""
    echo "Available benchmarks:"
    for bench in "${BENCHMARKS[@]}"; do
        echo "  - $bench"
    done
    echo ""
    echo "Examples:"
    echo "  $0 all                         # Run all benchmarks"
    echo "  $0 reachability                # Run specific benchmark"
    echo "  $0 all --save-baseline v1      # Save baseline"
    echo "  $0 reachability -- --verbose   # Run with verbose output"
    exit 1
fi
