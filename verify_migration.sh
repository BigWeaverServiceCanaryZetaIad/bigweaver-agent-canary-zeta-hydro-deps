#!/bin/bash
#
# Verification Script for Benchmark Migration
#
# This script verifies that all benchmarks have been successfully migrated
# and are functional in the new repository.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_REPO_DIR="$(cd "${SCRIPT_DIR}/../bigweaver-agent-canary-hydro-zeta" && pwd)"

echo "=== Benchmark Migration Verification ==="
echo ""

# Track verification status
CHECKS_PASSED=0
CHECKS_FAILED=0

# Function to report check result
check_passed() {
    echo -e "${GREEN}✓${NC} $1"
    ((CHECKS_PASSED++))
}

check_failed() {
    echo -e "${RED}✗${NC} $1"
    ((CHECKS_FAILED++))
}

check_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check 1: Verify all benchmark files exist
echo "Check 1: Verifying benchmark files exist..."
EXPECTED_BENCHMARKS=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "futures.rs"
    "identity.rs"
    "join.rs"
    "micro_ops.rs"
    "reachability.rs"
    "symmetric_hash_join.rs"
    "upcase.rs"
    "words_diamond.rs"
)

ALL_BENCHMARKS_EXIST=true
for bench in "${EXPECTED_BENCHMARKS[@]}"; do
    if [ -f "${SCRIPT_DIR}/benches/${bench}" ]; then
        check_passed "Found benchmark: ${bench}"
    else
        check_failed "Missing benchmark: ${bench}"
        ALL_BENCHMARKS_EXIST=false
    fi
done

# Check 2: Verify data files exist
echo ""
echo "Check 2: Verifying data files exist..."
DATA_FILES=(
    "words_alpha.txt"
    "reachability_edges.txt"
    "reachability_reachable.txt"
)

ALL_DATA_FILES_EXIST=true
for data_file in "${DATA_FILES[@]}"; do
    if [ -f "${SCRIPT_DIR}/benches/${data_file}" ]; then
        SIZE=$(du -h "${SCRIPT_DIR}/benches/${data_file}" | cut -f1)
        check_passed "Found data file: ${data_file} (${SIZE})"
    else
        check_failed "Missing data file: ${data_file}"
        ALL_DATA_FILES_EXIST=false
    fi
done

# Check 3: Verify Cargo.toml configuration
echo ""
echo "Check 3: Verifying Cargo.toml configuration..."
if [ -f "${SCRIPT_DIR}/Cargo.toml" ]; then
    check_passed "Cargo.toml exists"
    
    # Check for required dependencies
    if grep -q "timely" "${SCRIPT_DIR}/Cargo.toml"; then
        check_passed "timely dependency found"
    else
        check_failed "timely dependency not found"
    fi
    
    if grep -q "differential-dataflow" "${SCRIPT_DIR}/Cargo.toml"; then
        check_passed "differential-dataflow dependency found"
    else
        check_failed "differential-dataflow dependency not found"
    fi
    
    if grep -q "criterion" "${SCRIPT_DIR}/Cargo.toml"; then
        check_passed "criterion dependency found"
    else
        check_failed "criterion dependency not found"
    fi
    
    # Check benchmark definitions
    BENCH_COUNT=$(grep -c "^\[\[bench\]\]" "${SCRIPT_DIR}/Cargo.toml" || true)
    if [ "$BENCH_COUNT" -eq 12 ]; then
        check_passed "All 12 benchmark definitions found"
    else
        check_failed "Expected 12 benchmark definitions, found ${BENCH_COUNT}"
    fi
else
    check_failed "Cargo.toml not found"
fi

# Check 4: Verify build.rs exists
echo ""
echo "Check 4: Verifying build script..."
if [ -f "${SCRIPT_DIR}/build.rs" ]; then
    check_passed "build.rs exists"
else
    check_failed "build.rs not found"
fi

# Check 5: Verify documentation exists
echo ""
echo "Check 5: Verifying documentation..."
if [ -f "${SCRIPT_DIR}/README.md" ]; then
    check_passed "README.md exists"
    
    # Check for key sections
    if grep -q "## Available Benchmarks" "${SCRIPT_DIR}/README.md"; then
        check_passed "README contains benchmark list"
    else
        check_warning "README missing benchmark list section"
    fi
    
    if grep -q "## Performance Comparison" "${SCRIPT_DIR}/README.md"; then
        check_passed "README contains performance comparison section"
    else
        check_warning "README missing performance comparison section"
    fi
else
    check_failed "README.md not found"
fi

if [ -f "${SCRIPT_DIR}/CHANGES.md" ]; then
    check_passed "CHANGES.md exists"
else
    check_warning "CHANGES.md not found (recommended)"
fi

# Check 6: Verify comparison script exists
echo ""
echo "Check 6: Verifying comparison tools..."
if [ -f "${SCRIPT_DIR}/compare_performance.sh" ]; then
    check_passed "compare_performance.sh exists"
    
    if [ -x "${SCRIPT_DIR}/compare_performance.sh" ]; then
        check_passed "compare_performance.sh is executable"
    else
        check_warning "compare_performance.sh is not executable (run: chmod +x compare_performance.sh)"
    fi
else
    check_failed "compare_performance.sh not found"
fi

# Check 7: Verify main repository path dependency
echo ""
echo "Check 7: Verifying main repository access..."
if [ -d "${MAIN_REPO_DIR}" ]; then
    check_passed "Main repository found at: ${MAIN_REPO_DIR}"
    
    # Check for required crates
    if [ -d "${MAIN_REPO_DIR}/dfir_rs" ]; then
        check_passed "dfir_rs crate found in main repository"
    else
        check_failed "dfir_rs crate not found in main repository"
    fi
    
    if [ -d "${MAIN_REPO_DIR}/sinktools" ]; then
        check_passed "sinktools crate found in main repository"
    else
        check_failed "sinktools crate not found in main repository"
    fi
else
    check_failed "Main repository not found at: ${MAIN_REPO_DIR}"
    check_warning "Benchmarks require main repository at ../bigweaver-agent-canary-hydro-zeta"
fi

# Check 8: Verify benchmarks were removed from main repository
echo ""
echo "Check 8: Verifying benchmarks removed from main repository..."
if [ -d "${MAIN_REPO_DIR}" ]; then
    if [ -d "${MAIN_REPO_DIR}/benches" ]; then
        check_warning "benches directory still exists in main repository"
    else
        check_passed "benches directory removed from main repository"
    fi
    
    if grep -q '"benches"' "${MAIN_REPO_DIR}/Cargo.toml" 2>/dev/null; then
        check_warning "benches still referenced in main repository Cargo.toml"
    else
        check_passed "benches removed from main repository workspace"
    fi
fi

# Check 9: Test build (optional, can be slow)
echo ""
echo "Check 9: Testing build (optional)..."
if command -v cargo &> /dev/null; then
    check_passed "Cargo is available"
    
    echo "  Checking if project builds..."
    cd "${SCRIPT_DIR}"
    if cargo check --benches 2>&1 | tee /tmp/cargo_check.log; then
        check_passed "Project builds successfully"
    else
        check_failed "Project build failed (see /tmp/cargo_check.log for details)"
    fi
else
    check_warning "Cargo not available, skipping build test"
fi

# Print summary
echo ""
echo "=== Verification Summary ==="
echo -e "Checks passed: ${GREEN}${CHECKS_PASSED}${NC}"
echo -e "Checks failed: ${RED}${CHECKS_FAILED}${NC}"
echo ""

if [ $CHECKS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All critical checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Run benchmarks: cargo bench"
    echo "  2. View results: xdg-open target/criterion/report/index.html"
    echo "  3. Compare performance: ./compare_performance.sh"
    exit 0
else
    echo -e "${RED}✗ Some checks failed. Please review the issues above.${NC}"
    exit 1
fi
