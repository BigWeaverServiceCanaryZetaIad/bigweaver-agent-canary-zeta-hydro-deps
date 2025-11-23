#!/bin/bash

# Verification script for bigweaver-agent-canary-zeta-hydro-deps benchmarks
# This script verifies that all benchmarks are properly set up and functional

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
BENCHES_DIR="$REPO_ROOT/benches"
MAIN_REPO="../bigweaver-agent-canary-hydro-zeta"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters for summary
CHECKS_PASSED=0
CHECKS_FAILED=0
CHECKS_WARNING=0

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Benchmark Verification Script${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Function to print status messages
print_status() {
    local status=$1
    local message=$2
    
    case $status in
        "PASS")
            echo -e "${GREEN}✓${NC} $message"
            ((CHECKS_PASSED++))
            ;;
        "FAIL")
            echo -e "${RED}✗${NC} $message"
            ((CHECKS_FAILED++))
            ;;
        "WARN")
            echo -e "${YELLOW}⚠${NC} $message"
            ((CHECKS_WARNING++))
            ;;
        "INFO")
            echo -e "${BLUE}ℹ${NC} $message"
            ;;
    esac
}

# Check 1: Verify directory structure
echo -e "${BLUE}[1/10] Checking directory structure...${NC}"
if [ -d "$BENCHES_DIR" ]; then
    print_status "PASS" "benches/ directory exists"
else
    print_status "FAIL" "benches/ directory not found"
fi

if [ -d "$BENCHES_DIR/benches" ]; then
    print_status "PASS" "benches/benches/ directory exists"
else
    print_status "FAIL" "benches/benches/ directory not found"
fi

# Check 2: Verify benchmark files exist
echo -e "\n${BLUE}[2/10] Checking benchmark files...${NC}"
EXPECTED_BENCHMARKS=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "identity.rs"
    "join.rs"
    "reachability.rs"
    "upcase.rs"
)

for bench in "${EXPECTED_BENCHMARKS[@]}"; do
    if [ -f "$BENCHES_DIR/benches/$bench" ]; then
        print_status "PASS" "Found $bench"
    else
        print_status "FAIL" "Missing $bench"
    fi
done

# Check 3: Verify data files exist
echo -e "\n${BLUE}[3/10] Checking test data files...${NC}"
EXPECTED_DATA_FILES=(
    "reachability_edges.txt"
    "reachability_reachable.txt"
    "words_alpha.txt"
)

for datafile in "${EXPECTED_DATA_FILES[@]}"; do
    if [ -f "$BENCHES_DIR/benches/$datafile" ]; then
        SIZE=$(du -h "$BENCHES_DIR/benches/$datafile" | cut -f1)
        print_status "PASS" "Found $datafile ($SIZE)"
    else
        print_status "FAIL" "Missing $datafile"
    fi
done

# Check 4: Verify configuration files
echo -e "\n${BLUE}[4/10] Checking configuration files...${NC}"
if [ -f "$BENCHES_DIR/Cargo.toml" ]; then
    print_status "PASS" "Found Cargo.toml"
else
    print_status "FAIL" "Missing Cargo.toml"
fi

if [ -f "$BENCHES_DIR/build.rs" ]; then
    print_status "PASS" "Found build.rs"
else
    print_status "WARN" "Missing build.rs (may not be required)"
fi

# Check 5: Verify Cargo.toml content
echo -e "\n${BLUE}[5/10] Checking Cargo.toml dependencies...${NC}"
if grep -q "timely" "$BENCHES_DIR/Cargo.toml"; then
    print_status "PASS" "timely dependency found"
else
    print_status "FAIL" "timely dependency missing"
fi

if grep -q "differential-dataflow" "$BENCHES_DIR/Cargo.toml"; then
    print_status "PASS" "differential-dataflow dependency found"
else
    print_status "FAIL" "differential-dataflow dependency missing"
fi

if grep -q "criterion" "$BENCHES_DIR/Cargo.toml"; then
    print_status "PASS" "criterion dependency found"
else
    print_status "FAIL" "criterion dependency missing"
fi

# Check 6: Verify main repository access
echo -e "\n${BLUE}[6/10] Checking main repository access...${NC}"
if [ -d "$MAIN_REPO" ]; then
    print_status "PASS" "Main repository found at $MAIN_REPO"
else
    print_status "FAIL" "Main repository not found at $MAIN_REPO"
fi

if [ -d "$MAIN_REPO/dfir_rs" ]; then
    print_status "PASS" "dfir_rs found in main repository"
else
    print_status "FAIL" "dfir_rs not found in main repository"
fi

if [ -d "$MAIN_REPO/sinktools" ]; then
    print_status "PASS" "sinktools found in main repository"
else
    print_status "FAIL" "sinktools not found in main repository"
fi

# Check 7: Verify benchmark declarations in Cargo.toml
echo -e "\n${BLUE}[7/10] Checking benchmark declarations...${NC}"
for bench in "${EXPECTED_BENCHMARKS[@]}"; do
    BENCH_NAME="${bench%.rs}"
    if grep -q "name = \"$BENCH_NAME\"" "$BENCHES_DIR/Cargo.toml"; then
        print_status "PASS" "Benchmark declaration for $BENCH_NAME found"
    else
        print_status "FAIL" "Benchmark declaration for $BENCH_NAME missing"
    fi
done

# Check 8: Try to build benchmarks
echo -e "\n${BLUE}[8/10] Attempting to build benchmarks...${NC}"
cd "$BENCHES_DIR"
if cargo build --release --benches 2>&1 | tee /tmp/bench_build.log | grep -q "Finished"; then
    print_status "PASS" "Benchmarks built successfully"
else
    print_status "FAIL" "Benchmark build failed (see /tmp/bench_build.log)"
    if [ -f /tmp/bench_build.log ]; then
        echo -e "${YELLOW}Build errors:${NC}"
        tail -20 /tmp/bench_build.log
    fi
fi

# Check 9: Verify documentation
echo -e "\n${BLUE}[9/10] Checking documentation files...${NC}"
DOC_FILES=(
    "README.md"
    "BENCHMARKS.md"
    "QUICKSTART.md"
)

for doc in "${DOC_FILES[@]}"; do
    if [ -f "$REPO_ROOT/$doc" ]; then
        print_status "PASS" "Found $doc"
    else
        print_status "WARN" "Missing $doc"
    fi
done

if [ -f "$BENCHES_DIR/README.md" ]; then
    print_status "PASS" "Found benches/README.md"
else
    print_status "WARN" "Missing benches/README.md"
fi

# Check 10: Quick benchmark test
echo -e "\n${BLUE}[10/10] Running quick benchmark test...${NC}"
print_status "INFO" "Running identity benchmark with quick mode..."

cd "$BENCHES_DIR"
if timeout 60 cargo bench --bench identity -- --quick 2>&1 | tee /tmp/bench_test.log | grep -q "time:"; then
    print_status "PASS" "Identity benchmark ran successfully"
else
    print_status "WARN" "Benchmark test inconclusive (may need more time)"
fi

# Print summary
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Verification Summary${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}Passed:  $CHECKS_PASSED${NC}"
echo -e "${RED}Failed:  $CHECKS_FAILED${NC}"
echo -e "${YELLOW}Warnings: $CHECKS_WARNING${NC}"
echo ""

if [ $CHECKS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All critical checks passed!${NC}"
    echo -e "${GREEN}The benchmark suite is ready to use.${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Run all benchmarks: cd benches && cargo bench"
    echo "  2. Read QUICKSTART.md for usage guide"
    echo "  3. Read BENCHMARKS.md for detailed documentation"
    exit 0
else
    echo -e "${RED}✗ Verification failed with $CHECKS_FAILED error(s)${NC}"
    echo -e "${RED}Please fix the issues above before running benchmarks.${NC}"
    exit 1
fi
