#!/bin/bash

# Script to run benchmarks in the hydro-deps repository
# This repository contains benchmarks that depend on timely and differential-dataflow

set -e

echo "Running Hydro benchmarks with timely and differential-dataflow dependencies..."
echo ""

# Check if a specific benchmark was requested
if [ $# -eq 0 ]; then
    echo "Running all benchmarks..."
    cargo bench
else
    BENCH_NAME=$1
    echo "Running benchmark: $BENCH_NAME"
    cargo bench --bench "$BENCH_NAME"
fi

echo ""
echo "Benchmark run complete!"
echo "Results are available in target/criterion/"
