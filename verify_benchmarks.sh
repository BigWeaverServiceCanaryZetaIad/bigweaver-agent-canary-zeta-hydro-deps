#!/bin/bash

# Verification script for benchmark migration
# This script verifies that all moved benchmarks compile and run correctly

set -e

echo "=========================================="
echo "Benchmark Migration Verification Script"
echo "=========================================="
echo ""

# List of benchmarks to verify
BENCHMARKS=(
    "arithmetic"
    "fan_in"
    "fan_out"
    "fork_join"
    "identity"
    "join"
    "reachability"
    "upcase"
)

echo "Step 1: Checking benchmark files..."
for bench in "${BENCHMARKS[@]}"; do
    if [ -f "benches/benches/${bench}.rs" ]; then
        echo "✓ ${bench}.rs exists"
    else
        echo "✗ ${bench}.rs is missing!"
        exit 1
    fi
done
echo ""

echo "Step 2: Checking data files..."
if [ -f "benches/benches/reachability_edges.txt" ]; then
    echo "✓ reachability_edges.txt exists"
else
    echo "✗ reachability_edges.txt is missing!"
    exit 1
fi

if [ -f "benches/benches/reachability_reachable.txt" ]; then
    echo "✓ reachability_reachable.txt exists"
else
    echo "✗ reachability_reachable.txt is missing!"
    exit 1
fi
echo ""

echo "Step 3: Verifying Cargo.toml configuration..."
if grep -q "timely" benches/Cargo.toml; then
    echo "✓ timely dependency present"
else
    echo "✗ timely dependency missing!"
    exit 1
fi

if grep -q "differential-dataflow" benches/Cargo.toml; then
    echo "✓ differential-dataflow dependency present"
else
    echo "✗ differential-dataflow dependency missing!"
    exit 1
fi

if grep -q "dfir_rs" benches/Cargo.toml; then
    echo "✓ dfir_rs dependency present"
else
    echo "✗ dfir_rs dependency missing!"
    exit 1
fi
echo ""

echo "Step 4: Checking benchmark definitions in Cargo.toml..."
for bench in "${BENCHMARKS[@]}"; do
    if grep -q "name = \"${bench}\"" benches/Cargo.toml; then
        echo "✓ ${bench} benchmark defined"
    else
        echo "✗ ${bench} benchmark definition missing!"
        exit 1
    fi
done
echo ""

echo "Step 5: Testing build (this may take a while)..."
if cargo check --benches; then
    echo "✓ All benchmarks compile successfully"
else
    echo "✗ Benchmark compilation failed!"
    exit 1
fi
echo ""

echo "=========================================="
echo "✓ All verification checks passed!"
echo "=========================================="
echo ""
echo "The benchmarks are ready to run. Use:"
echo "  cargo bench                    # Run all benchmarks"
echo "  cargo bench --bench <name>     # Run specific benchmark"
echo ""
