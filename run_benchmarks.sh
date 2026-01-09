#!/bin/bash
# Script to run benchmarks in the hydro-deps repository

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Running timely and differential-dataflow benchmarks..."
echo "======================================================="
echo

cd benches

if [ $# -eq 0 ]; then
    echo "Running all benchmarks..."
    cargo bench
else
    echo "Running benchmark: $1"
    cargo bench --bench "$1"
fi

echo
echo "======================================================="
echo "Benchmark results are available in target/criterion/"
echo "Open target/criterion/report/index.html to view detailed reports"
