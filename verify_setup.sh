#!/bin/bash

# Verification script for bigweaver-agent-canary-zeta-hydro-deps repository
# This script checks that the repository is properly configured and benchmarks are functional

set -e

echo "========================================"
echo "Benchmark Repository Verification Script"
echo "========================================"
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track pass/fail
TOTAL_CHECKS=0
PASSED_CHECKS=0

check() {
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $1"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        return 1
    fi
}

echo "1. Checking Rust toolchain..."
if command -v cargo &> /dev/null; then
    RUST_VERSION=$(cargo --version)
    check "Cargo found: $RUST_VERSION"
else
    echo -e "${RED}✗${NC} Cargo not found. Please install Rust: https://rustup.rs/"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
fi

echo ""
echo "2. Checking repository structure..."

[ -f "Cargo.toml" ]
check "Workspace Cargo.toml exists"

[ -f "benches/Cargo.toml" ]
check "Benches Cargo.toml exists"

[ -d "benches/benches" ]
check "Benchmarks directory exists"

[ -f "README.md" ]
check "README.md exists"

[ -f "MIGRATION.md" ]
check "MIGRATION.md exists"

[ -f "CHANGELOG.md" ]
check "CHANGELOG.md exists"

[ -f "QUICKSTART.md" ]
check "QUICKSTART.md exists"

[ -f ".gitignore" ]
check ".gitignore exists"

echo ""
echo "3. Checking benchmark files..."

BENCHMARK_FILES=(
    "benches/benches/arithmetic.rs"
    "benches/benches/fan_in.rs"
    "benches/benches/upcase.rs"
    "benches/benches/join.rs"
    "benches/benches/reachability.rs"
)

for file in "${BENCHMARK_FILES[@]}"; do
    if [ -f "$file" ]; then
        check "Found $file"
    else
        echo -e "${RED}✗${NC} Missing $file"
        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    fi
done

echo ""
echo "4. Checking benchmark data files..."

[ -f "benches/benches/reachability_edges.txt" ]
check "reachability_edges.txt exists"

[ -f "benches/benches/reachability_reachable.txt" ]
check "reachability_reachable.txt exists"

echo ""
echo "5. Verifying Cargo.toml configuration..."

if grep -q "timely-master" "benches/Cargo.toml"; then
    check "Timely dependency configured"
else
    echo -e "${RED}✗${NC} Timely dependency not found"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
fi

if grep -q "differential-dataflow-master" "benches/Cargo.toml"; then
    check "Differential-dataflow dependency configured"
else
    echo -e "${RED}✗${NC} Differential-dataflow dependency not found"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
fi

if grep -q "criterion" "benches/Cargo.toml"; then
    check "Criterion dependency configured"
else
    echo -e "${RED}✗${NC} Criterion dependency not found"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
fi

echo ""
echo "6. Checking for unwanted dependencies..."

if grep -q "dfir_rs" "benches/Cargo.toml"; then
    echo -e "${RED}✗${NC} dfir_rs dependency found (should be removed)"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
else
    check "No dfir_rs dependency (correct)"
fi

if grep -q "sinktools" "benches/Cargo.toml"; then
    echo -e "${RED}✗${NC} sinktools dependency found (should be removed)"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
else
    check "No sinktools dependency (correct)"
fi

echo ""
if command -v cargo &> /dev/null; then
    echo "7. Attempting to compile benchmarks..."
    if cargo check --benches 2>&1 | tee /tmp/cargo_check.log; then
        check "Benchmarks compile successfully"
    else
        echo -e "${RED}✗${NC} Benchmark compilation failed"
        echo "See /tmp/cargo_check.log for details"
        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    fi
else
    echo "7. Skipping compilation check (cargo not available)"
fi

echo ""
echo "========================================"
echo "Verification Summary"
echo "========================================"
echo "Passed: $PASSED_CHECKS / $TOTAL_CHECKS checks"

if [ $PASSED_CHECKS -eq $TOTAL_CHECKS ]; then
    echo -e "${GREEN}All checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  - Run benchmarks: cargo bench -p benches"
    echo "  - View results: open target/criterion/report/index.html"
    echo "  - Read QUICKSTART.md for more commands"
    exit 0
else
    FAILED=$((TOTAL_CHECKS - PASSED_CHECKS))
    echo -e "${YELLOW}$FAILED check(s) failed${NC}"
    echo ""
    echo "Please review the failures above and:"
    echo "  - Ensure all required files are present"
    echo "  - Check that dependencies are correctly configured"
    echo "  - Verify Rust toolchain is installed"
    exit 1
fi
