#!/bin/bash
# Benchmark Verification Script
# This script verifies that all benchmarks can be built and are ready to run

set -e  # Exit on error

echo "=================================="
echo "Benchmark Verification Script"
echo "=================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for results
PASSED=0
FAILED=0
WARNINGS=0

# Function to print status
print_status() {
    local status=$1
    local message=$2
    
    if [ "$status" == "PASS" ]; then
        echo -e "${GREEN}✓${NC} $message"
        ((PASSED++))
    elif [ "$status" == "FAIL" ]; then
        echo -e "${RED}✗${NC} $message"
        ((FAILED++))
    elif [ "$status" == "WARN" ]; then
        echo -e "${YELLOW}⚠${NC} $message"
        ((WARNINGS++))
    else
        echo "  $message"
    fi
}

# Check Rust toolchain
echo "1. Checking Rust toolchain..."
if command -v rustc &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    print_status "PASS" "Rust is installed: $RUST_VERSION"
else
    print_status "FAIL" "Rust is not installed"
    exit 1
fi

if command -v cargo &> /dev/null; then
    CARGO_VERSION=$(cargo --version)
    print_status "PASS" "Cargo is installed: $CARGO_VERSION"
else
    print_status "FAIL" "Cargo is not installed"
    exit 1
fi

echo ""

# Check repository structure
echo "2. Checking repository structure..."

required_files=(
    "Cargo.toml"
    "benches/Cargo.toml"
    "benches/build.rs"
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
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        print_status "PASS" "Found: $file"
    else
        print_status "FAIL" "Missing: $file"
    fi
done

echo ""

# Check documentation
echo "3. Checking documentation..."

doc_files=(
    "README.md"
    "QUICKSTART.md"
    "BENCHMARK_DETAILS.md"
    "MIGRATION.md"
    "CHANGELOG.md"
)

for file in "${doc_files[@]}"; do
    if [ -f "$file" ]; then
        print_status "PASS" "Found: $file"
    else
        print_status "WARN" "Missing: $file"
    fi
done

echo ""

# Check Cargo.toml for required dependencies
echo "4. Checking dependencies in Cargo.toml..."

required_deps=(
    "criterion"
    "timely"
    "differential-dataflow"
    "dfir_rs"
    "sinktools"
)

for dep in "${required_deps[@]}"; do
    if grep -q "$dep" benches/Cargo.toml; then
        print_status "PASS" "Dependency found: $dep"
    else
        print_status "FAIL" "Dependency missing: $dep"
    fi
done

echo ""

# Build the project
echo "5. Building the project..."
echo "   This may take a few minutes on first run..."
echo ""

if cargo build --all-targets 2>&1 | tee /tmp/build_output.log; then
    print_status "PASS" "Project builds successfully"
else
    print_status "FAIL" "Project failed to build"
    echo ""
    echo "Build output:"
    tail -50 /tmp/build_output.log
    exit 1
fi

echo ""

# Check that benchmarks are registered
echo "6. Verifying benchmark registration..."

benchmarks=(
    "arithmetic"
    "fan_in"
    "fan_out"
    "fork_join"
    "identity"
    "join"
    "reachability"
    "upcase"
)

for bench in "${benchmarks[@]}"; do
    if cargo bench -p timely-differential-benchmarks --bench "$bench" --no-run &> /dev/null; then
        print_status "PASS" "Benchmark registered: $bench"
    else
        print_status "FAIL" "Benchmark not found: $bench"
    fi
done

echo ""

# Check generated files
echo "7. Checking build script output..."

if [ -f "benches/benches/fork_join_20.hf" ]; then
    print_status "PASS" "Build script generated fork_join_20.hf"
else
    print_status "WARN" "fork_join_20.hf not found (may be generated during benchmark run)"
fi

echo ""

# Summary
echo "=================================="
echo "Verification Summary"
echo "=================================="
echo -e "${GREEN}Passed:${NC} $PASSED"
echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
echo -e "${RED}Failed:${NC} $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All critical checks passed!${NC}"
    echo ""
    echo "To run benchmarks:"
    echo "  cargo bench -p timely-differential-benchmarks"
    echo ""
    echo "To run a specific benchmark:"
    echo "  cargo bench -p timely-differential-benchmarks --bench arithmetic"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Some checks failed. Please fix the issues above.${NC}"
    exit 1
fi
