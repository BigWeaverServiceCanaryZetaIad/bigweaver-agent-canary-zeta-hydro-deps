#!/bin/bash
# Script to run all benchmarks in this repository
# Usage: ./run_benchmarks.sh [benchmark_name]

set -e

if [ -n "$1" ]; then
    echo "Running benchmark: $1"
    cargo bench -p hydro-benches-comparison --bench "$1"
else
    echo "Running all benchmarks..."
    cargo bench -p hydro-benches-comparison
fi

echo "Benchmark results are saved in target/criterion/"
