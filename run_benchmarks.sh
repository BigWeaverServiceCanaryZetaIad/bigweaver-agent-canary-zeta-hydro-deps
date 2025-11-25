#!/bin/bash
# Script to run benchmarks from the hydro-deps repository
# This provides a convenient interface for running performance comparisons

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Hydro Dependencies Benchmark Runner ==="
echo

# Check if the main repository exists
MAIN_REPO="../bigweaver-agent-canary-hydro-zeta"
if [ ! -d "$MAIN_REPO" ]; then
    echo "⚠ WARNING: Main repository not found at $MAIN_REPO"
    echo "For local development, clone bigweaver-agent-canary-hydro-zeta alongside this repository"
    echo
fi

# Parse arguments
if [ $# -eq 0 ]; then
    echo "Running all benchmarks..."
    echo "Command: cargo bench -p benches"
    echo
    cargo bench -p benches
elif [ "$1" = "--list" ]; then
    echo "Available benchmarks:"
    echo "  - arithmetic"
    echo "  - fan_in"
    echo "  - fan_out"
    echo "  - fork_join"
    echo "  - identity"
    echo "  - upcase"
    echo "  - join"
    echo "  - reachability"
    echo "  - micro_ops"
    echo "  - symmetric_hash_join"
    echo "  - words_diamond"
    echo "  - futures"
    echo
    echo "Usage: $0 [benchmark_name]"
    echo "       $0 --list           (show this list)"
    echo "       $0                  (run all benchmarks)"
elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Usage: $0 [OPTIONS] [BENCHMARK_NAME]"
    echo
    echo "Run performance benchmarks for DFIR and timely/differential-dataflow"
    echo
    echo "Options:"
    echo "  --list          List all available benchmarks"
    echo "  --help, -h      Show this help message"
    echo
    echo "Examples:"
    echo "  $0                    # Run all benchmarks"
    echo "  $0 reachability       # Run only the reachability benchmark"
    echo "  $0 arithmetic         # Run only the arithmetic benchmark"
    echo
    echo "Results are saved to target/criterion/ with HTML reports"
else
    BENCHMARK_NAME="$1"
    echo "Running benchmark: $BENCHMARK_NAME"
    echo "Command: cargo bench -p benches --bench $BENCHMARK_NAME"
    echo
    cargo bench -p benches --bench "$BENCHMARK_NAME"
fi

echo
echo "=== Benchmark Complete ==="
echo "Results are available in: target/criterion/"
echo "Open target/criterion/report/index.html for detailed HTML reports"
