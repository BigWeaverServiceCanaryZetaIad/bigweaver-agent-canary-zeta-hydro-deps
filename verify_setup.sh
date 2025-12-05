#!/bin/bash
# Verification script for bigweaver-agent-canary-zeta-hydro-deps setup

set -e

echo "🔍 Verifying bigweaver-agent-canary-zeta-hydro-deps Setup"
echo "========================================================="
echo

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track status
ALL_CHECKS_PASSED=true

check_pass() {
    echo -e "${GREEN}✓${NC} $1"
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
    ALL_CHECKS_PASSED=false
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check 1: Repository structure
echo "1. Checking repository structure..."
if [ -d "benches" ] && [ -d "benches/benches" ]; then
    check_pass "benches/ directory exists"
else
    check_fail "benches/ directory missing"
fi

# Check 2: Benchmark files
echo
echo "2. Checking benchmark files..."
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

for bench in "${EXPECTED_BENCHMARKS[@]}"; do
    if [ -f "benches/benches/$bench" ]; then
        check_pass "Found $bench"
    else
        check_fail "Missing $bench"
    fi
done

# Check 3: Test data files
echo
echo "3. Checking test data files..."
DATA_FILES=(
    "reachability_edges.txt"
    "reachability_reachable.txt"
    "words_alpha.txt"
)

for data in "${DATA_FILES[@]}"; do
    if [ -f "benches/benches/$data" ]; then
        check_pass "Found $data"
    else
        check_fail "Missing $data"
    fi
done

# Check 4: Configuration files
echo
echo "4. Checking configuration files..."
CONFIG_FILES=(
    "Cargo.toml"
    "benches/Cargo.toml"
    "benches/build.rs"
    "README.md"
    "BENCHMARK_MIGRATION.md"
    "BENCHMARK_IMPLEMENTATIONS.md"
    "QUICK_START.md"
)

for config in "${CONFIG_FILES[@]}"; do
    if [ -f "$config" ]; then
        check_pass "Found $config"
    else
        check_fail "Missing $config"
    fi
done

# Check 5: Path dependencies
echo
echo "5. Checking path dependencies..."
if [ -d "../bigweaver-agent-canary-hydro-zeta" ]; then
    check_pass "Main repository found at ../bigweaver-agent-canary-hydro-zeta"
    
    if [ -d "../bigweaver-agent-canary-hydro-zeta/dfir_rs" ]; then
        check_pass "dfir_rs dependency path exists"
    else
        check_fail "dfir_rs dependency path missing"
    fi
    
    if [ -d "../bigweaver-agent-canary-hydro-zeta/sinktools" ]; then
        check_pass "sinktools dependency path exists"
    else
        check_fail "sinktools dependency path missing"
    fi
else
    check_fail "Main repository not found at ../bigweaver-agent-canary-hydro-zeta"
    check_warn "Benchmarks require path dependencies from main repository"
fi

# Check 6: Timely implementations
echo
echo "6. Checking Timely Dataflow implementations..."
TIMELY_BENCHMARKS=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "identity.rs"
    "join.rs"
    "upcase.rs"
    "reachability.rs"
)

for bench in "${TIMELY_BENCHMARKS[@]}"; do
    if [ -f "benches/benches/$bench" ]; then
        if grep -q "benchmark_timely" "benches/benches/$bench"; then
            check_pass "$bench has Timely implementation"
        else
            check_fail "$bench missing Timely implementation"
        fi
    fi
done

# Check 7: Differential Dataflow implementations
echo
echo "7. Checking Differential Dataflow implementations..."
if [ -f "benches/benches/reachability.rs" ]; then
    if grep -q "benchmark_differential" "benches/benches/reachability.rs"; then
        check_pass "reachability.rs has Differential implementation"
    else
        check_fail "reachability.rs missing Differential implementation"
    fi
fi

# Check 8: Cargo workspace configuration
echo
echo "8. Checking Cargo workspace configuration..."
if grep -q "members = \[" "Cargo.toml" && grep -q '"benches"' "Cargo.toml"; then
    check_pass "Workspace properly configured with benches member"
else
    check_fail "Workspace configuration issue"
fi

# Check 9: Dependencies in benches/Cargo.toml
echo
echo "9. Checking benchmark dependencies..."
if [ -f "benches/Cargo.toml" ]; then
    if grep -q "timely-master" "benches/Cargo.toml"; then
        check_pass "timely dependency configured"
    else
        check_fail "timely dependency missing"
    fi
    
    if grep -q "differential-dataflow-master" "benches/Cargo.toml"; then
        check_pass "differential-dataflow dependency configured"
    else
        check_fail "differential-dataflow dependency missing"
    fi
    
    if grep -q "dfir_rs.*path.*bigweaver-agent-canary-hydro-zeta" "benches/Cargo.toml"; then
        check_pass "dfir_rs path dependency configured"
    else
        check_fail "dfir_rs path dependency missing or incorrect"
    fi
fi

# Check 10: Rust toolchain
echo
echo "10. Checking Rust environment..."
if command -v cargo &> /dev/null; then
    RUST_VERSION=$(cargo --version)
    check_pass "Cargo found: $RUST_VERSION"
else
    check_warn "Cargo not found in PATH (required to build benchmarks)"
fi

# Final summary
echo
echo "========================================================="
if [ "$ALL_CHECKS_PASSED" = true ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo
    echo "You can now run benchmarks:"
    echo "  cargo bench -p benches"
    echo
    echo "For more information, see:"
    echo "  - BENCHMARK_IMPLEMENTATIONS.md"
    echo "  - QUICK_START.md"
    exit 0
else
    echo -e "${RED}✗ Some checks failed${NC}"
    echo
    echo "Please review the errors above and fix any issues."
    echo "See BENCHMARK_MIGRATION.md for setup instructions."
    exit 1
fi
