#!/bin/bash
# Script to run a quick subset of benchmarks for fast validation
# Usage: ./run_quick_benchmarks.sh

set -e

echo "======================================"
echo "Running Quick Benchmark Validation"
echo "======================================"
echo "This runs a subset of benchmarks for quick validation."
echo "For comprehensive results, use: ./run_all_benchmarks.sh"
echo ""

echo "Running identity benchmarks..."
cargo bench --bench identity -- --sample-size 20

echo ""
echo "Running arithmetic benchmarks..."
cargo bench --bench arithmetic -- --sample-size 20

echo ""
echo "======================================"
echo "Quick Benchmark Summary"
echo "======================================"
echo "Quick benchmarks completed successfully!"
echo ""
echo "For full benchmark suite, run:"
echo "  ./run_all_benchmarks.sh"
