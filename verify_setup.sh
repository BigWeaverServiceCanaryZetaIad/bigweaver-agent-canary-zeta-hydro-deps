#!/bin/bash
# Verification script for hydro-deps benchmarks repository setup
# This script verifies that the benchmark migration was successful

set -e  # Exit on error

echo "=================================="
echo "Hydro-Deps Benchmarks Verification"
echo "=================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0

# Helper functions
pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED++))
}

fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED++))
}

warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

info() {
    echo "ℹ $1"
}

# Check 1: Verify we're in the right directory
echo "1. Checking directory structure..."
if [[ ! -f "Cargo.toml" ]] || [[ ! -d "benches" ]]; then
    fail "Not in hydro-deps repository root (missing Cargo.toml or benches/)"
    exit 1
fi
pass "In correct repository root"
echo ""

# Check 2: Verify all benchmark files exist
echo "2. Checking benchmark files..."
BENCHMARK_FILES=(
    "benches/arithmetic.rs"
    "benches/fan_in.rs"
    "benches/fan_out.rs"
    "benches/fork_join.rs"
    "benches/identity.rs"
    "benches/join.rs"
    "benches/reachability.rs"
    "benches/upcase.rs"
)

for file in "${BENCHMARK_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        pass "$file exists"
    else
        fail "$file is missing"
    fi
done
echo ""

# Check 3: Verify data files exist
echo "3. Checking data files..."
DATA_FILES=(
    "benches/reachability_edges.txt"
    "benches/reachability_reachable.txt"
)

for file in "${DATA_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        SIZE=$(du -h "$file" | cut -f1)
        pass "$file exists ($SIZE)"
    else
        fail "$file is missing"
    fi
done
echo ""

# Check 4: Verify Cargo.toml configuration
echo "4. Checking Cargo.toml configuration..."

if grep -q "timely.*=.*timely-master" Cargo.toml; then
    pass "timely dependency configured"
else
    fail "timely dependency missing or incorrect"
fi

if grep -q "differential-dataflow.*=.*differential-dataflow-master" Cargo.toml; then
    pass "differential-dataflow dependency configured"
else
    fail "differential-dataflow dependency missing or incorrect"
fi

if grep -q "dfir_rs.*=.*path.*=.*bigweaver-agent-canary-hydro-zeta" Cargo.toml; then
    pass "dfir_rs path dependency configured"
else
    fail "dfir_rs path dependency missing or incorrect"
fi

if grep -q "sinktools.*=.*path.*=.*bigweaver-agent-canary-hydro-zeta" Cargo.toml; then
    pass "sinktools path dependency configured"
else
    fail "sinktools path dependency missing or incorrect"
fi

# Count benchmark declarations
BENCH_COUNT=$(grep -c '^\[\[bench\]\]' Cargo.toml || true)
if [[ $BENCH_COUNT -eq 8 ]]; then
    pass "All 8 benchmark targets configured"
else
    fail "Expected 8 benchmark targets, found $BENCH_COUNT"
fi
echo ""

# Check 5: Verify documentation exists
echo "5. Checking documentation files..."
DOC_FILES=(
    "README.md"
    "BENCHMARK_GUIDE.md"
    "MIGRATION_SUMMARY.md"
    "CHANGELOG.md"
)

for file in "${DOC_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        LINES=$(wc -l < "$file")
        pass "$file exists ($LINES lines)"
    else
        fail "$file is missing"
    fi
done
echo ""

# Check 6: Verify main repository exists (for path dependencies)
echo "6. Checking main repository availability..."
MAIN_REPO="../bigweaver-agent-canary-hydro-zeta"
if [[ -d "$MAIN_REPO" ]]; then
    pass "Main repository found at $MAIN_REPO"
    
    if [[ -d "$MAIN_REPO/dfir_rs" ]]; then
        pass "dfir_rs directory exists in main repository"
    else
        fail "dfir_rs directory not found in main repository"
    fi
    
    if [[ -d "$MAIN_REPO/sinktools" ]]; then
        pass "sinktools directory exists in main repository"
    else
        fail "sinktools directory not found in main repository"
    fi
else
    fail "Main repository not found at $MAIN_REPO"
    warn "Path dependencies will not resolve"
fi
echo ""

# Check 7: Verify benchmark content (sample check)
echo "7. Verifying benchmark content..."

if grep -q "use timely::dataflow::operators" benches/arithmetic.rs; then
    pass "arithmetic.rs uses timely operators"
else
    fail "arithmetic.rs missing timely imports"
fi

if grep -q "use differential_dataflow" benches/reachability.rs; then
    pass "reachability.rs uses differential-dataflow"
else
    fail "reachability.rs missing differential-dataflow imports"
fi

if grep -q "use dfir_rs::dfir_syntax" benches/arithmetic.rs; then
    pass "Benchmarks reference dfir_rs"
else
    fail "Benchmarks missing dfir_rs references"
fi
echo ""

# Check 8: Attempt to validate Cargo.toml syntax (if cargo available)
echo "8. Validating Cargo.toml syntax..."
if command -v cargo &> /dev/null; then
    if cargo metadata --format-version 1 > /dev/null 2>&1; then
        pass "Cargo.toml syntax is valid"
    else
        fail "Cargo.toml has syntax errors"
        warn "Note: This may fail if path dependencies are not yet available"
    fi
else
    warn "cargo command not found, skipping Cargo.toml validation"
fi
echo ""

# Check 9: Verify benchmark file sizes
echo "9. Checking benchmark file sizes..."
for file in "${BENCHMARK_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        SIZE=$(wc -l < "$file")
        if [[ $SIZE -gt 10 ]]; then
            pass "$file has content ($SIZE lines)"
        else
            fail "$file is suspiciously small ($SIZE lines)"
        fi
    fi
done
echo ""

# Summary
echo "=================================="
echo "Verification Summary"
echo "=================================="
echo -e "${GREEN}Passed:${NC} $PASSED"
echo -e "${RED}Failed:${NC} $FAILED"
echo ""

if [[ $FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Try building the benchmarks: cargo build --benches"
    echo "2. Run benchmarks: cargo bench"
    echo "3. View results in target/criterion/"
    exit 0
else
    echo -e "${RED}✗ Some checks failed${NC}"
    echo ""
    echo "Please review the failures above and:"
    echo "1. Ensure all benchmark files are present"
    echo "2. Verify Cargo.toml configuration"
    echo "3. Check that main repository is accessible"
    exit 1
fi
