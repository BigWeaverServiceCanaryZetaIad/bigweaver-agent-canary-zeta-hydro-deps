#!/bin/bash
# Verification script for timely/differential-dataflow benchmark migration
# Run this script to verify all components are in place

set -e

echo "=========================================================================="
echo "Benchmark Migration Verification Script"
echo "=========================================================================="
echo ""

# Check benchmark files
echo "1. Checking benchmark files..."
EXPECTED_BENCHMARKS=("arithmetic.rs" "fan_in.rs" "fan_out.rs" "fork_join.rs" "identity.rs" "join.rs" "reachability.rs" "upcase.rs")
MISSING_BENCHMARKS=0

for bench in "${EXPECTED_BENCHMARKS[@]}"; do
    if [ -f "benches/benches/$bench" ]; then
        echo "   ✓ $bench"
    else
        echo "   ✗ $bench MISSING"
        MISSING_BENCHMARKS=$((MISSING_BENCHMARKS + 1))
    fi
done

if [ $MISSING_BENCHMARKS -gt 0 ]; then
    echo "   ERROR: $MISSING_BENCHMARKS benchmark(s) missing!"
    exit 1
fi
echo "   All 8 benchmarks present ✓"
echo ""

# Check data files
echo "2. Checking data files..."
if [ -f "benches/benches/reachability_edges.txt" ]; then
    echo "   ✓ reachability_edges.txt"
else
    echo "   ✗ reachability_edges.txt MISSING"
    exit 1
fi

if [ -f "benches/benches/reachability_reachable.txt" ]; then
    echo "   ✓ reachability_reachable.txt"
else
    echo "   ✗ reachability_reachable.txt MISSING"
    exit 1
fi
echo "   All data files present ✓"
echo ""

# Check build infrastructure
echo "3. Checking build infrastructure..."
if [ -f "benches/build.rs" ]; then
    echo "   ✓ build.rs"
else
    echo "   ✗ build.rs MISSING"
    exit 1
fi

if [ -f "benches/benches/.gitignore" ]; then
    echo "   ✓ .gitignore"
else
    echo "   ✗ .gitignore MISSING"
    exit 1
fi
echo "   Build infrastructure present ✓"
echo ""

# Check dependencies in Cargo.toml
echo "4. Checking dependencies in Cargo.toml..."
REQUIRED_DEPS=("criterion" "dfir_rs" "differential-dataflow" "timely" "futures" "nameof" "rand" "tokio")
MISSING_DEPS=0

for dep in "${REQUIRED_DEPS[@]}"; do
    if grep -q "^$dep = " benches/Cargo.toml; then
        echo "   ✓ $dep"
    else
        echo "   ✗ $dep MISSING"
        MISSING_DEPS=$((MISSING_DEPS + 1))
    fi
done

if [ $MISSING_DEPS -gt 0 ]; then
    echo "   ERROR: $MISSING_DEPS dependency(ies) missing!"
    exit 1
fi
echo "   All dependencies configured ✓"
echo ""

# Check for timely/differential usage in benchmarks
echo "5. Checking benchmark imports..."
if grep -q "use timely::" benches/benches/*.rs; then
    echo "   ✓ Benchmarks use timely"
else
    echo "   ✗ No timely imports found"
    exit 1
fi

if grep -q "use differential_dataflow::" benches/benches/*.rs; then
    echo "   ✓ Benchmarks use differential_dataflow"
else
    echo "   ✗ No differential_dataflow imports found"
    exit 1
fi

if grep -q "use dfir_rs::" benches/benches/*.rs; then
    echo "   ✓ Benchmarks use dfir_rs"
else
    echo "   ✗ No dfir_rs imports found"
    exit 1
fi
echo "   All required imports present ✓"
echo ""

# Summary
echo "=========================================================================="
echo "VERIFICATION COMPLETE - ALL CHECKS PASSED ✓"
echo "=========================================================================="
echo ""
echo "The repository is properly configured with:"
echo "  • 8 timely/differential-dataflow benchmarks"
echo "  • 2 data files for reachability testing"
echo "  • Build script for code generation"
echo "  • All required dependencies (including dfir_rs)"
echo ""
echo "To run the benchmarks (requires Rust):"
echo "  cd benches"
echo "  cargo bench"
echo ""
echo "For detailed verification steps, see VERIFICATION.md"
echo ""
