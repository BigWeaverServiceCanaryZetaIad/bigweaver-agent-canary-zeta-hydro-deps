#!/usr/bin/env bash
# Script to verify and run benchmarks

set -e

echo "Checking workspace structure..."
if [ ! -f "Cargo.toml" ]; then
    echo "❌ Root Cargo.toml not found"
    exit 1
fi

if [ ! -d "benches" ]; then
    echo "❌ benches directory not found"
    exit 1
fi

if [ ! -f "benches/Cargo.toml" ]; then
    echo "❌ benches/Cargo.toml not found"
    exit 1
fi

echo "✅ Workspace structure is valid"

echo ""
echo "Checking cargo workspace..."
cargo metadata --no-deps --format-version 1 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Cargo workspace is valid"
else
    echo "❌ Cargo workspace has errors"
    exit 1
fi

echo ""
echo "Checking that benches can be built..."
cargo check -p benches
if [ $? -eq 0 ]; then
    echo "✅ Benchmarks can be built"
else
    echo "❌ Benchmarks have build errors"
    exit 1
fi

echo ""
echo "Running a quick benchmark test..."
cargo bench -p benches --bench identity -- --test
if [ $? -eq 0 ]; then
    echo "✅ Benchmarks can be executed"
else
    echo "❌ Benchmarks have execution errors"
    exit 1
fi

echo ""
echo "=========================================="
echo "All verification checks passed! ✅"
echo "=========================================="
echo ""
echo "To run all benchmarks:"
echo "  cargo bench -p benches"
echo ""
echo "To run a specific benchmark:"
echo "  cargo bench -p benches --bench <benchmark_name>"
echo ""
echo "Available benchmarks:"
cargo metadata --no-deps --format-version 1 | grep -o '"name":"[^"]*"' | grep -A 1 'benches' | grep -v benches | sort -u | sed 's/"name":"//;s/"//g;s/^/  - /'
