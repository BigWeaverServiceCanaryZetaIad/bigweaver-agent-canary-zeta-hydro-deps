#!/bin/bash

# Verification script for bigweaver-agent-canary-zeta-hydro-deps setup
# This script verifies that all files are in place and the repository is ready to use

set -e

echo "=================================================="
echo "Verifying bigweaver-agent-canary-zeta-hydro-deps"
echo "=================================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check counters
PASSED=0
FAILED=0
WARNINGS=0

# Function to print success
check_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED++))
}

# Function to print failure
check_fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED++))
}

# Function to print warning
check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

echo "1. Checking Repository Structure..."
echo "-----------------------------------"

# Check root files
[ -f "Cargo.toml" ] && check_pass "Cargo.toml exists" || check_fail "Cargo.toml missing"
[ -f "README.md" ] && check_pass "README.md exists" || check_fail "README.md missing"
[ -f ".gitignore" ] && check_pass ".gitignore exists" || check_fail ".gitignore missing"
[ -f "rust-toolchain.toml" ] && check_pass "rust-toolchain.toml exists" || check_fail "rust-toolchain.toml missing"
[ -f "rustfmt.toml" ] && check_pass "rustfmt.toml exists" || check_fail "rustfmt.toml missing"
[ -f "clippy.toml" ] && check_pass "clippy.toml exists" || check_fail "clippy.toml missing"
[ -f "IMPLEMENTATION_SUMMARY.md" ] && check_pass "IMPLEMENTATION_SUMMARY.md exists" || check_fail "IMPLEMENTATION_SUMMARY.md missing"

echo ""
echo "2. Checking Benchmark Directory Structure..."
echo "--------------------------------------------"

[ -d "benches" ] && check_pass "benches/ directory exists" || check_fail "benches/ directory missing"
[ -f "benches/Cargo.toml" ] && check_pass "benches/Cargo.toml exists" || check_fail "benches/Cargo.toml missing"
[ -f "benches/README.md" ] && check_pass "benches/README.md exists" || check_fail "benches/README.md missing"
[ -f "benches/build.rs" ] && check_pass "benches/build.rs exists" || check_fail "benches/build.rs missing"
[ -d "benches/benches" ] && check_pass "benches/benches/ directory exists" || check_fail "benches/benches/ directory missing"

echo ""
echo "3. Checking Benchmark Source Files..."
echo "-------------------------------------"

# Timely benchmarks
benchmark_files=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "identity.rs"
    "join.rs"
    "upcase.rs"
)

echo "Timely comparative benchmarks:"
for file in "${benchmark_files[@]}"; do
    [ -f "benches/benches/$file" ] && check_pass "  $file" || check_fail "  $file missing"
done

echo ""
echo "Differential-dataflow comparative benchmarks:"
[ -f "benches/benches/reachability.rs" ] && check_pass "  reachability.rs" || check_fail "  reachability.rs missing"

echo ""
echo "Hydro-specific benchmarks:"
hydro_benchmarks=(
    "micro_ops.rs"
    "futures.rs"
    "symmetric_hash_join.rs"
    "words_diamond.rs"
)

for file in "${hydro_benchmarks[@]}"; do
    [ -f "benches/benches/$file" ] && check_pass "  $file" || check_fail "  $file missing"
done

echo ""
echo "4. Checking Data Files..."
echo "-------------------------"

data_files=(
    "reachability_edges.txt"
    "reachability_reachable.txt"
    "words_alpha.txt"
)

for file in "${data_files[@]}"; do
    if [ -f "benches/benches/$file" ]; then
        size=$(du -h "benches/benches/$file" | cut -f1)
        check_pass "$file ($size)"
    else
        check_fail "$file missing"
    fi
done

echo ""
echo "5. Checking Cargo.toml Dependencies..."
echo "---------------------------------------"

if grep -q "timely.*timely-master" benches/Cargo.toml; then
    check_pass "timely dependency configured"
else
    check_fail "timely dependency not found in Cargo.toml"
fi

if grep -q "differential-dataflow.*differential-dataflow-master" benches/Cargo.toml; then
    check_pass "differential-dataflow dependency configured"
else
    check_fail "differential-dataflow dependency not found in Cargo.toml"
fi

if grep -q "dfir_rs.*path.*bigweaver-agent-canary-hydro-zeta" benches/Cargo.toml; then
    check_pass "dfir_rs path dependency configured"
else
    check_fail "dfir_rs path dependency not found in Cargo.toml"
fi

if grep -q "sinktools.*path.*bigweaver-agent-canary-hydro-zeta" benches/Cargo.toml; then
    check_pass "sinktools path dependency configured"
else
    check_fail "sinktools path dependency not found in Cargo.toml"
fi

echo ""
echo "6. Checking Benchmark Configurations..."
echo "----------------------------------------"

benchmark_configs=(
    "arithmetic"
    "fan_in"
    "fan_out"
    "fork_join"
    "identity"
    "join"
    "upcase"
    "reachability"
    "micro_ops"
    "futures"
    "symmetric_hash_join"
    "words_diamond"
)

for bench in "${benchmark_configs[@]}"; do
    if grep -q "name = \"$bench\"" benches/Cargo.toml; then
        check_pass "[[bench]] configuration for $bench"
    else
        check_fail "[[bench]] configuration for $bench missing"
    fi
done

echo ""
echo "7. Checking Cross-Repository Dependencies..."
echo "---------------------------------------------"

if [ -d "../bigweaver-agent-canary-hydro-zeta" ]; then
    check_pass "Companion repository found at ../bigweaver-agent-canary-hydro-zeta"
    
    if [ -d "../bigweaver-agent-canary-hydro-zeta/dfir_rs" ]; then
        check_pass "dfir_rs directory exists in companion repository"
    else
        check_fail "dfir_rs directory not found in companion repository"
    fi
    
    if [ -d "../bigweaver-agent-canary-hydro-zeta/sinktools" ]; then
        check_pass "sinktools directory exists in companion repository"
    else
        check_fail "sinktools directory not found in companion repository"
    fi
else
    check_warn "Companion repository not found at ../bigweaver-agent-canary-hydro-zeta"
    echo "         This is required for building benchmarks."
fi

echo ""
echo "8. Counting Files..."
echo "--------------------"

rs_count=$(find benches/benches -name "*.rs" -type f | wc -l)
txt_count=$(find benches/benches -name "*.txt" -type f | wc -l)

if [ "$rs_count" -eq 12 ]; then
    check_pass "Correct number of benchmark files: $rs_count"
else
    check_warn "Expected 12 benchmark files, found $rs_count"
fi

if [ "$txt_count" -eq 3 ]; then
    check_pass "Correct number of data files: $txt_count"
else
    check_warn "Expected 3 data files, found $txt_count"
fi

echo ""
echo "=================================================="
echo "Verification Summary"
echo "=================================================="
echo -e "${GREEN}Passed:${NC}   $PASSED"
echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
echo -e "${RED}Failed:${NC}   $FAILED"
echo ""

if [ $FAILED -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed! Repository is ready to use.${NC}"
    exit 0
elif [ $FAILED -eq 0 ]; then
    echo -e "${YELLOW}⚠ Some warnings found. Review the warnings above.${NC}"
    exit 0
else
    echo -e "${RED}✗ Some checks failed. Please review the failures above.${NC}"
    exit 1
fi
