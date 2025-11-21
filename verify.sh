#!/bin/bash
# Verification script for Hydro Performance Benchmarks repository

set -e

echo "🔍 Verifying Hydro Performance Benchmarks Repository Setup"
echo "=========================================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
PASS=0
FAIL=0

check_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASS++))
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAIL++))
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

echo "1. Checking File Structure..."
echo "----------------------------"

# Check for benchmark files
BENCHMARK_FILES=(
    "benches/arithmetic.rs"
    "benches/fan_in.rs"
    "benches/fan_out.rs"
    "benches/fork_join.rs"
    "benches/futures.rs"
    "benches/identity.rs"
    "benches/join.rs"
    "benches/micro_ops.rs"
    "benches/reachability.rs"
    "benches/symmetric_hash_join.rs"
    "benches/upcase.rs"
    "benches/words_diamond.rs"
)

for file in "${BENCHMARK_FILES[@]}"; do
    if [ -f "$file" ]; then
        check_pass "Found $file"
    else
        check_fail "Missing $file"
    fi
done

# Check for test data files
TEST_DATA_FILES=(
    "benches/reachability_edges.txt"
    "benches/reachability_reachable.txt"
    "benches/words_alpha.txt"
)

echo ""
echo "2. Checking Test Data Files..."
echo "------------------------------"

for file in "${TEST_DATA_FILES[@]}"; do
    if [ -f "$file" ]; then
        size=$(du -h "$file" | cut -f1)
        check_pass "Found $file ($size)"
    else
        check_fail "Missing $file"
    fi
done

# Check for configuration files
echo ""
echo "3. Checking Configuration Files..."
echo "----------------------------------"

CONFIG_FILES=(
    "Cargo.toml"
    "build.rs"
    "rust-toolchain.toml"
    ".gitignore"
    "LICENSE"
)

for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$file" ]; then
        check_pass "Found $file"
    else
        check_fail "Missing $file"
    fi
done

# Check for documentation files
echo ""
echo "4. Checking Documentation..."
echo "----------------------------"

DOC_FILES=(
    "README.md"
    "QUICKSTART.md"
    "CONFIGURATION.md"
    "MIGRATION.md"
    "SUMMARY.md"
)

for file in "${DOC_FILES[@]}"; do
    if [ -f "$file" ]; then
        check_pass "Found $file"
    else
        check_fail "Missing $file"
    fi
done

# Check Rust installation
echo ""
echo "5. Checking Rust Installation..."
echo "--------------------------------"

if command -v rustc &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    check_pass "Rust installed: $RUST_VERSION"
else
    check_fail "Rust not found - install from https://rustup.rs/"
fi

if command -v cargo &> /dev/null; then
    CARGO_VERSION=$(cargo --version)
    check_pass "Cargo installed: $CARGO_VERSION"
else
    check_fail "Cargo not found"
fi

# Check Cargo.toml syntax
echo ""
echo "6. Checking Cargo Configuration..."
echo "----------------------------------"

if command -v cargo &> /dev/null; then
    if cargo read-manifest &> /dev/null; then
        check_pass "Cargo.toml is valid"
    else
        check_fail "Cargo.toml has errors"
    fi
    
    # Check for key dependencies
    if grep -q "timely" Cargo.toml; then
        check_pass "Timely dependency configured"
    else
        check_fail "Timely dependency missing"
    fi
    
    if grep -q "differential-dataflow" Cargo.toml; then
        check_pass "Differential-dataflow dependency configured"
    else
        check_fail "Differential-dataflow dependency missing"
    fi
    
    if grep -q "dfir_rs" Cargo.toml; then
        check_pass "DFIR dependency configured"
    else
        check_fail "DFIR dependency missing"
    fi
    
    if grep -q "criterion" Cargo.toml; then
        check_pass "Criterion (benchmark framework) configured"
    else
        check_fail "Criterion dependency missing"
    fi
fi

# Check CI/CD
echo ""
echo "7. Checking CI/CD Configuration..."
echo "----------------------------------"

if [ -f ".github/workflows/benchmarks.yml" ]; then
    check_pass "GitHub Actions workflow configured"
else
    check_warn "No GitHub Actions workflow (optional)"
fi

# Summary
echo ""
echo "=========================================================="
echo "Verification Summary"
echo "=========================================================="
echo -e "${GREEN}Passed: $PASS${NC}"
if [ $FAIL -gt 0 ]; then
    echo -e "${RED}Failed: $FAIL${NC}"
fi
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✓ Repository setup is complete and valid!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Read QUICKSTART.md for getting started"
    echo "  2. Run 'cargo check' to verify dependencies"
    echo "  3. Run 'cargo bench --bench identity' for a quick test"
    echo "  4. Run 'cargo bench' to run all benchmarks"
    exit 0
else
    echo -e "${RED}✗ Some checks failed. Please review the output above.${NC}"
    echo ""
    echo "For help:"
    echo "  - See README.md for setup instructions"
    echo "  - See QUICKSTART.md for quick start guide"
    echo "  - See CONFIGURATION.md for dependency setup"
    exit 1
fi
