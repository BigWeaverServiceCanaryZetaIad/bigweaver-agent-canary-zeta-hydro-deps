#!/bin/bash
# Verification script for benchmark repository setup
# This script verifies that all necessary files and dependencies are in place

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_REPO="../bigweaver-agent-canary-hydro-zeta"

echo "=== Benchmark Repository Setup Verification ==="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

success_count=0
fail_count=0

check_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((success_count++))
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
    ((fail_count++))
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# 1. Check repository structure
echo "1. Checking repository structure..."
if [ -d "$SCRIPT_DIR/benches" ]; then
    check_pass "benches/ directory exists"
else
    check_fail "benches/ directory missing"
fi

if [ -d "$SCRIPT_DIR/benches/benches" ]; then
    check_pass "benches/benches/ directory exists"
else
    check_fail "benches/benches/ directory missing"
fi

# 2. Check configuration files
echo ""
echo "2. Checking configuration files..."
for file in "Cargo.toml" "README.md" "CONTRIBUTING.md" "benches/Cargo.toml" "benches/README.md" "benches/build.rs"; do
    if [ -f "$SCRIPT_DIR/$file" ]; then
        check_pass "$file exists"
    else
        check_fail "$file missing"
    fi
done

# 3. Check benchmark files
echo ""
echo "3. Checking benchmark files..."
benchmarks=("arithmetic" "fan_in" "fan_out" "fork_join" "identity" "join" "reachability" "upcase")
for bench in "${benchmarks[@]}"; do
    if [ -f "$SCRIPT_DIR/benches/benches/${bench}.rs" ]; then
        check_pass "${bench}.rs exists"
    else
        check_fail "${bench}.rs missing"
    fi
done

# 4. Check data files
echo ""
echo "4. Checking data files..."
data_files=("reachability_edges.txt" "reachability_reachable.txt" "words_alpha.txt")
for data in "${data_files[@]}"; do
    if [ -f "$SCRIPT_DIR/benches/benches/$data" ]; then
        size=$(du -h "$SCRIPT_DIR/benches/benches/$data" | cut -f1)
        check_pass "$data exists (${size})"
    else
        check_fail "$data missing"
    fi
done

# 5. Check main repository dependencies
echo ""
echo "5. Checking path dependencies to main repository..."
if [ -d "$SCRIPT_DIR/$MAIN_REPO" ]; then
    check_pass "Main repository found at $MAIN_REPO"
    
    if [ -f "$SCRIPT_DIR/$MAIN_REPO/dfir_rs/Cargo.toml" ]; then
        check_pass "dfir_rs crate found"
    else
        check_fail "dfir_rs crate missing in main repository"
    fi
    
    if [ -f "$SCRIPT_DIR/$MAIN_REPO/sinktools/Cargo.toml" ]; then
        check_pass "sinktools crate found"
    else
        check_fail "sinktools crate missing in main repository"
    fi
else
    check_fail "Main repository not found at $MAIN_REPO"
    check_warn "This repository requires bigweaver-agent-canary-hydro-zeta to be in a sibling directory"
fi

# 6. Verify Cargo.toml benchmark registrations
echo ""
echo "6. Checking Cargo.toml benchmark registrations..."
for bench in "${benchmarks[@]}"; do
    if grep -q "name = \"$bench\"" "$SCRIPT_DIR/benches/Cargo.toml"; then
        check_pass "$bench registered in Cargo.toml"
    else
        check_fail "$bench not registered in Cargo.toml"
    fi
done

# 7. Check for required dependencies in Cargo.toml
echo ""
echo "7. Checking dependencies in Cargo.toml..."
deps=("timely" "differential-dataflow" "criterion" "dfir_rs" "sinktools")
for dep in "${deps[@]}"; do
    if grep -q "$dep" "$SCRIPT_DIR/benches/Cargo.toml"; then
        check_pass "$dep dependency found"
    else
        check_fail "$dep dependency missing"
    fi
done

# 8. Verify benchmark files use timely/differential
echo ""
echo "8. Verifying benchmarks use timely/differential-dataflow..."
for bench in "${benchmarks[@]}"; do
    bench_file="$SCRIPT_DIR/benches/benches/${bench}.rs"
    if [ -f "$bench_file" ]; then
        if grep -q "timely\|differential" "$bench_file"; then
            check_pass "${bench}.rs uses timely/differential imports"
        else
            check_warn "${bench}.rs might not use timely/differential (check manually)"
        fi
    fi
done

# Summary
echo ""
echo "=== Verification Summary ==="
echo -e "${GREEN}Passed: $success_count${NC}"
echo -e "${RED}Failed: $fail_count${NC}"
echo ""

if [ $fail_count -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "The benchmark repository is properly set up."
    echo "You can run benchmarks with:"
    echo "  cargo bench -p hydro-timely-differential-benches"
    exit 0
else
    echo -e "${RED}✗ Some checks failed.${NC}"
    echo ""
    echo "Please review the failures above and ensure:"
    echo "  1. All benchmark files are present"
    echo "  2. Main repository is in the correct location"
    echo "  3. All dependencies are properly configured"
    exit 1
fi
