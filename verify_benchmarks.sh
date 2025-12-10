#!/bin/bash
# Verification script for migrated benchmarks
# Run this script to verify that all benchmarks build and run correctly

set -e

echo "========================================="
echo "Verifying Benchmark Migration"
echo "========================================="
echo ""

# Check if cargo is available
if ! command -v cargo &> /dev/null; then
    echo "ERROR: cargo is not installed. Please install Rust toolchain."
    exit 1
fi

echo "1. Checking workspace configuration..."
cargo metadata --no-deps > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✓ Workspace configuration is valid"
else
    echo "   ✗ Workspace configuration has errors"
    exit 1
fi

echo ""
echo "2. Building benches package..."
cargo build -p benches
if [ $? -eq 0 ]; then
    echo "   ✓ Benches package builds successfully"
else
    echo "   ✗ Benches package build failed"
    exit 1
fi

echo ""
echo "3. Building hydro_benchmarks package..."
cargo build -p hydro_benchmarks
if [ $? -eq 0 ]; then
    echo "   ✓ Hydro benchmarks package builds successfully"
else
    echo "   ✗ Hydro benchmarks package build failed"
    exit 1
fi

echo ""
echo "4. Running a sample benchmark (identity)..."
timeout 60 cargo bench -p benches --bench identity -- --test
if [ $? -eq 0 ]; then
    echo "   ✓ Sample benchmark runs successfully"
else
    echo "   ✗ Sample benchmark failed or timed out"
    exit 1
fi

echo ""
echo "========================================="
echo "All verification checks passed!"
echo "========================================="
echo ""
echo "To run all benchmarks:"
echo "  cargo bench -p benches"
echo ""
echo "To run specific benchmarks:"
echo "  cargo bench -p benches --bench <benchmark_name>"
echo ""
echo "Available benchmarks:"
echo "  - arithmetic"
echo "  - fan_in"
echo "  - fan_out"
echo "  - fork_join"
echo "  - futures"
echo "  - identity"
echo "  - join"
echo "  - micro_ops"
echo "  - reachability"
echo "  - symmetric_hash_join"
echo "  - upcase"
echo "  - words_diamond"
