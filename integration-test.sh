#!/bin/bash
# Integration test to verify the complete benchmark setup

set -e

echo "=========================================="
echo "Integration Test for Benchmark Repository"
echo "=========================================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

FAILED_TESTS=0
TOTAL_TESTS=0

# Test function
run_test() {
    local test_name="$1"
    local command="$2"
    
    echo -n "Testing $test_name... "
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if eval "$command" > /dev/null 2>&1; then
        echo -e "${GREEN}PASS${NC}"
    else
        echo -e "${RED}FAIL${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        echo "  Command: $command"
    fi
}

# File existence tests
echo "1. Checking file structure..."
run_test "Main Cargo.toml" "[ -f Cargo.toml ]"
run_test "Main README" "[ -f README.md ]"
run_test "Installation guide" "[ -f INSTALLATION.md ]"
run_test "Benchmarking guide" "[ -f BENCHMARKING.md ]"
run_test "Comparison guide" "[ -f COMPARISON.md ]"
run_test "Contributing guide" "[ -f CONTRIBUTING.md ]"
run_test "Project summary" "[ -f PROJECT_SUMMARY.md ]"
run_test "Makefile" "[ -f Makefile ]"
run_test "Runner script" "[ -f run-benchmarks.sh ]"
run_test "Validation script" "[ -f setup-validation.sh ]"
run_test "GitIgnore" "[ -f .gitignore ]"
run_test "GitHub Actions" "[ -f .github/workflows/benchmarks.yml ]"

echo ""
echo "2. Checking timely-benchmarks structure..."
run_test "Timely Cargo.toml" "[ -f timely-benchmarks/Cargo.toml ]"
run_test "Timely README" "[ -f timely-benchmarks/README.md ]"
run_test "Timely lib.rs" "[ -f timely-benchmarks/src/lib.rs ]"
run_test "Barrier benchmark" "[ -f timely-benchmarks/benches/barrier.rs ]"
run_test "Exchange benchmark" "[ -f timely-benchmarks/benches/exchange.rs ]"
run_test "Dataflow construction benchmark" "[ -f timely-benchmarks/benches/dataflow_construction.rs ]"
run_test "Progress tracking benchmark" "[ -f timely-benchmarks/benches/progress_tracking.rs ]"
run_test "Unary operators benchmark" "[ -f timely-benchmarks/benches/unary_operators.rs ]"

echo ""
echo "3. Checking differential-benchmarks structure..."
run_test "Differential Cargo.toml" "[ -f differential-benchmarks/Cargo.toml ]"
run_test "Differential README" "[ -f differential-benchmarks/README.md ]"
run_test "Differential lib.rs" "[ -f differential-benchmarks/src/lib.rs ]"
run_test "Arrange benchmark" "[ -f differential-benchmarks/benches/arrange.rs ]"
run_test "Join benchmark" "[ -f differential-benchmarks/benches/join.rs ]"
run_test "Count benchmark" "[ -f differential-benchmarks/benches/count.rs ]"
run_test "Consolidate benchmark" "[ -f differential-benchmarks/benches/consolidate.rs ]"
run_test "Distinct benchmark" "[ -f differential-benchmarks/benches/distinct.rs ]"

echo ""
echo "4. Checking content quality..."
run_test "Non-empty main README" "[ -s README.md ]"
run_test "Workspace members in Cargo.toml" "grep -q 'members.*timely-benchmarks' Cargo.toml"
run_test "Workspace members differential" "grep -q 'differential-benchmarks' Cargo.toml"
run_test "Timely dependencies" "grep -q 'timely.*workspace' timely-benchmarks/Cargo.toml"
run_test "Differential dependencies" "grep -q 'differential-dataflow.*workspace' differential-benchmarks/Cargo.toml"
run_test "Criterion dependencies" "grep -q 'criterion.*workspace' */Cargo.toml"

echo ""
echo "5. Checking script permissions..."
run_test "Runner script executable" "[ -x run-benchmarks.sh ]"
run_test "Validation script executable" "[ -x setup-validation.sh ]"

echo ""
echo "6. Checking benchmark structure..."
run_test "Barrier criterion imports" "grep -q 'use criterion' timely-benchmarks/benches/barrier.rs"
run_test "Join criterion imports" "grep -q 'use criterion' differential-benchmarks/benches/join.rs"
run_test "Timely imports in benchmarks" "grep -q 'timely::' timely-benchmarks/benches/*.rs"
run_test "Differential imports in benchmarks" "grep -q 'differential_dataflow::' differential-benchmarks/benches/*.rs"

echo ""
echo "7. Checking documentation links..."
run_test "Installation link in README" "grep -q 'INSTALLATION.md' README.md"
run_test "Benchmarking guide link" "grep -q 'BENCHMARKING.md' README.md"
run_test "Comparison guide link" "grep -q 'COMPARISON.md' README.md"

echo ""
echo "8. Checking Make targets..."
run_test "Makefile help target" "grep -q '^help:' Makefile"
run_test "Makefile bench target" "grep -q '^bench:' Makefile"
run_test "Makefile test target" "grep -q '^test:' Makefile"
run_test "Makefile clean target" "grep -q '^clean:' Makefile"

echo ""
echo "9. Checking runner script functionality..."
run_test "Runner help option" "./run-benchmarks.sh --help | grep -q 'Usage:'"
run_test "Script handles workers option" "grep -q 'workers' run-benchmarks.sh"
run_test "Script handles baseline option" "grep -q 'baseline' run-benchmarks.sh"

echo ""
echo "10. Checking CI configuration..."
run_test "GitHub Actions on push" "grep -q 'on:.*push' .github/workflows/benchmarks.yml"
run_test "Matrix strategy" "grep -q 'matrix:' .github/workflows/benchmarks.yml"
run_test "Benchmark job" "grep -q 'benchmark:' .github/workflows/benchmarks.yml"
run_test "Upload artifacts" "grep -q 'upload-artifact' .github/workflows/benchmarks.yml"

echo ""
echo "=========================================="
echo "Integration Test Results"
echo "=========================================="

PASSED_TESTS=$((TOTAL_TESTS - FAILED_TESTS))

echo "Total tests: $TOTAL_TESTS"
echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed: ${RED}$FAILED_TESTS${NC}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ All integration tests passed!${NC}"
    echo ""
    echo "The benchmark repository setup is complete and validated."
    echo ""
    echo "Next steps:"
    echo "1. Install Rust: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    echo "2. Run: ./setup-validation.sh"
    echo "3. Try: make bench-quick"
    echo ""
    exit 0
else
    echo ""
    echo -e "${RED}✗ Some tests failed!${NC}"
    echo ""
    echo "Please check the failed tests above and fix any issues."
    exit 1
fi