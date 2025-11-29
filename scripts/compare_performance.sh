#!/bin/bash
#
# Script to compare benchmark performance between baselines
#
# Usage:
#   ./scripts/compare_performance.sh <baseline1> <baseline2> [benchmark]
#
# Examples:
#   ./scripts/compare_performance.sh old new                # Compare all benchmarks
#   ./scripts/compare_performance.sh v1 v2 reachability     # Compare specific benchmark
#

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check arguments
if [ "$#" -lt 2 ]; then
    print_error "Insufficient arguments"
    echo ""
    echo "Usage: $0 <baseline1> <baseline2> [benchmark]"
    echo ""
    echo "Examples:"
    echo "  $0 old new                 # Compare all benchmarks"
    echo "  $0 v1 v2 reachability      # Compare specific benchmark"
    echo ""
    echo "To create baselines, run benchmarks with --save-baseline:"
    echo "  cargo bench -p benches -- --save-baseline baseline_name"
    exit 1
fi

BASELINE1=$1
BASELINE2=$2
BENCHMARK=${3:-}

# Check if we're in the right directory
if [ ! -f "Cargo.toml" ]; then
    print_error "Must be run from the repository root"
    exit 1
fi

# Run comparison
print_status "Comparing baselines: $BASELINE1 vs $BASELINE2"
echo ""

if [ -z "$BENCHMARK" ]; then
    # Compare all benchmarks
    cargo bench -p benches -- --baseline "$BASELINE1" --load-baseline "$BASELINE2"
else
    # Compare specific benchmark
    cargo bench -p benches --bench "$BENCHMARK" -- --baseline "$BASELINE1" --load-baseline "$BASELINE2"
fi

print_status "Comparison completed!"
