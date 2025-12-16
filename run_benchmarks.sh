#!/bin/bash
# Script to run timely/differential-dataflow comparison benchmarks

set -e

echo "Running Timely/Differential-Dataflow Comparison Benchmarks"
echo "==========================================================="
echo ""

if [ $# -eq 0 ]; then
    echo "Running all benchmarks..."
    cargo bench
else
    echo "Running benchmark: $1"
    cargo bench --bench "$1"
fi

echo ""
echo "Benchmark results are available in target/criterion/"
echo "Open target/criterion/report/index.html in a browser to view detailed results"
