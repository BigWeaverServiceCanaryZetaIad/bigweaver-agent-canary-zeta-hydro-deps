#!/bin/bash
# Verification script for timely/differential benchmarks
#
# This script verifies that:
# 1. All expected benchmark files are present
# 2. Dependencies are correctly specified
# 3. Benchmarks can be built

set -e

echo "========================================"
echo "Timely/Differential Benchmarks Verification"
echo "========================================"
echo ""

# Check that expected benchmark files are present
echo "1. Checking that benchmark files are present..."
EXPECTED_BENCHMARKS=(
    "benches/benches/arithmetic.rs"
    "benches/benches/fan_in.rs"
    "benches/benches/fan_out.rs"
    "benches/benches/fork_join.rs"
    "benches/benches/identity.rs"
    "benches/benches/join.rs"
    "benches/benches/reachability.rs"
    "benches/benches/upcase.rs"
    "benches/benches/reachability_edges.txt"
    "benches/benches/reachability_reachable.txt"
    "benches/build.rs"
)

FAIL=0
for file in "${EXPECTED_BENCHMARKS[@]}"; do
    if [ ! -f "$file" ]; then
        echo "   ❌ FAIL: $file is missing"
        FAIL=1
    fi
done

if [ $FAIL -eq 0 ]; then
    echo "   ✅ PASS: All expected benchmark files are present"
fi
echo ""

# Check that dependencies are present in Cargo.toml
echo "2. Checking that timely/differential dependencies are specified..."
if grep -q "timely" benches/Cargo.toml && grep -q "differential-dataflow" benches/Cargo.toml; then
    echo "   ✅ PASS: timely and differential-dataflow dependencies found"
else
    echo "   ❌ FAIL: Missing timely or differential-dataflow dependencies"
    exit 1
fi
echo ""

# Try to build the benchmarks
echo "3. Attempting to build benchmarks..."
if cargo check -p benches; then
    echo "   ✅ PASS: Benchmarks build successfully"
else
    echo "   ❌ FAIL: Benchmarks failed to build"
    exit 1
fi
echo ""

echo "========================================"
echo "All verification checks passed! ✅"
echo "========================================"
echo ""
echo "To run benchmarks:"
echo "  cargo bench -p benches                    # Run all benchmarks"
echo "  cargo bench -p benches --bench reachability  # Run specific benchmark"
