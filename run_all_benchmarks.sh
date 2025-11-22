#!/bin/bash
# Script to run all benchmarks and generate reports
# Usage: ./run_all_benchmarks.sh [baseline_name]

set -e

BASELINE=""
if [ -n "$1" ]; then
    BASELINE="--save-baseline $1"
    echo "Running benchmarks and saving as baseline: $1"
else
    echo "Running benchmarks without saving baseline"
fi

echo "======================================"
echo "Running Timely Dataflow Benchmarks"
echo "======================================"
cargo bench -p timely-benchmarks $BASELINE

echo ""
echo "======================================"
echo "Running Differential Dataflow Benchmarks"
echo "======================================"
cargo bench -p differential-benchmarks $BASELINE

echo ""
echo "======================================"
echo "Benchmark Summary"
echo "======================================"
echo "All benchmarks completed successfully!"
echo ""
echo "Results are available in:"
echo "  - target/criterion/ (raw data)"
echo "  - target/criterion/report/index.html (HTML report)"
echo ""

if [ -n "$1" ]; then
    echo "Baseline '$1' has been saved."
    echo "To compare future runs against this baseline, use:"
    echo "  cargo bench -- --baseline $1"
fi
