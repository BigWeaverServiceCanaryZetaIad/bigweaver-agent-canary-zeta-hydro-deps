#!/bin/bash
# Script to run comparison benchmarks between DFIR and timely/differential-dataflow
# This repository contains benchmarks that compare DFIR performance with reference implementations

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEPS_DIR="$(dirname "$SCRIPT_DIR")"

echo "========================================="
echo "Running DFIR vs Timely/Differential Comparison Benchmarks"
echo "========================================="
echo ""

cd "$DEPS_DIR"
echo "Running benchmarks in: $DEPS_DIR"
echo ""

# Check if dfir_rs dependency is available
echo "Checking dependencies..."
if ! cargo fetch 2>/dev/null; then
    echo "Warning: Unable to fetch dependencies. Ensure you have network access."
    echo "The benchmarks require dfir_rs from: https://github.com/hydro-project/hydro.git"
    exit 1
fi

echo ""
echo "Running all comparison benchmarks..."
cargo bench -p hydro-benches-comparison

echo ""
echo "========================================="
echo "Benchmark Results"
echo "========================================="
echo ""
echo "Results location: $DEPS_DIR/target/criterion/"
echo ""
echo "Available benchmarks:"
echo "  - arithmetic: Arithmetic operation comparisons"
echo "  - fan_in: Fan-in pattern comparisons"
echo "  - fan_out: Fan-out pattern comparisons"
echo "  - fork_join: Fork-join pattern comparisons"
echo "  - identity: Identity operation comparisons"
echo "  - join: Join operation comparisons"
echo "  - reachability: Graph reachability comparisons"
echo "  - upcase: String transformation comparisons"
echo ""
echo "Open the HTML reports in your browser to view detailed results."
echo ""
echo "To run a specific benchmark:"
echo "  cargo bench -p hydro-benches-comparison --bench <benchmark-name>"
