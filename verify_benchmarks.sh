#!/bin/bash
# Verification script for benchmark migration
# This script verifies that all benchmarks are properly configured and can be built

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "======================================"
echo "Benchmark Migration Verification Script"
echo "======================================"
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
    fi
}

# Function to print info
print_info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

# Counter for checks
TOTAL_CHECKS=0
PASSED_CHECKS=0

# Function to run check
run_check() {
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if eval "$1" > /dev/null 2>&1; then
        print_status 0 "$2"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
        return 0
    else
        print_status 1 "$2"
        return 1
    fi
}

echo "1. Checking repository structure..."
echo "-----------------------------------"

# Check workspace files
run_check "test -f Cargo.toml" "Workspace Cargo.toml exists"
run_check "test -f rust-toolchain.toml" "rust-toolchain.toml exists"
run_check "test -f rustfmt.toml" "rustfmt.toml exists"
run_check "test -f clippy.toml" "clippy.toml exists"
run_check "test -f README.md" "Main README.md exists"
run_check "test -f MIGRATION.md" "MIGRATION.md exists"
run_check "test -f BENCHMARK_DETAILS.md" "BENCHMARK_DETAILS.md exists"

echo ""
echo "2. Checking benches directory structure..."
echo "------------------------------------------"

# Check benches directory
run_check "test -d benches" "benches directory exists"
run_check "test -f benches/Cargo.toml" "benches/Cargo.toml exists"
run_check "test -f benches/build.rs" "benches/build.rs exists"
run_check "test -f benches/README.md" "benches/README.md exists"
run_check "test -d benches/benches" "benches/benches directory exists"

echo ""
echo "3. Checking benchmark source files..."
echo "--------------------------------------"

# Check all benchmark files
BENCHMARK_FILES=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "identity.rs"
    "join.rs"
    "reachability.rs"
    "upcase.rs"
)

for file in "${BENCHMARK_FILES[@]}"; do
    run_check "test -f benches/benches/$file" "Benchmark file: $file"
done

echo ""
echo "4. Checking data files..."
echo "-------------------------"

# Check data files
run_check "test -f benches/benches/reachability_edges.txt" "Data file: reachability_edges.txt"
run_check "test -f benches/benches/reachability_reachable.txt" "Data file: reachability_reachable.txt"

echo ""
echo "5. Checking Cargo.toml configuration..."
echo "----------------------------------------"

# Check for required dependencies in benches/Cargo.toml
run_check "grep -q 'timely' benches/Cargo.toml" "timely dependency configured"
run_check "grep -q 'differential-dataflow' benches/Cargo.toml" "differential-dataflow dependency configured"
run_check "grep -q 'criterion' benches/Cargo.toml" "criterion dependency configured"
run_check "grep -q 'dfir_rs' benches/Cargo.toml" "dfir_rs dependency configured"

echo ""
echo "6. Checking benchmark entries in Cargo.toml..."
echo "----------------------------------------------"

# Check benchmark entries
for bench in arithmetic fan_in fan_out fork_join identity join reachability upcase; do
    run_check "grep -A2 '\[\[bench\]\]' benches/Cargo.toml | grep -q 'name = \"$bench\"'" "Benchmark entry: $bench"
done

echo ""
echo "7. Checking file sizes..."
echo "-------------------------"

# Check that files are not empty and have reasonable sizes
check_file_size() {
    if [ -f "$1" ]; then
        size=$(stat -f%z "$1" 2>/dev/null || stat -c%s "$1" 2>/dev/null)
        if [ "$size" -gt "$2" ]; then
            return 0
        fi
    fi
    return 1
}

run_check "check_file_size benches/benches/arithmetic.rs 1000" "arithmetic.rs has reasonable size (>1KB)"
run_check "check_file_size benches/benches/reachability.rs 1000" "reachability.rs has reasonable size (>1KB)"
run_check "check_file_size benches/benches/reachability_edges.txt 100000" "reachability_edges.txt has data (>100KB)"
run_check "check_file_size benches/benches/reachability_reachable.txt 10000" "reachability_reachable.txt has data (>10KB)"

echo ""
echo "8. Testing Cargo commands..."
echo "----------------------------"

print_info "Running 'cargo check' (this may take a while)..."
if cargo check 2>&1 | tee /tmp/cargo_check.log; then
    print_status 0 "cargo check succeeded"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    print_status 1 "cargo check failed - see /tmp/cargo_check.log for details"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    echo ""
    echo "Error details:"
    tail -20 /tmp/cargo_check.log
fi

echo ""
print_info "Running 'cargo bench --no-run' to verify benchmarks compile (this may take a while)..."
if cargo bench --no-run 2>&1 | tee /tmp/cargo_bench.log; then
    print_status 0 "cargo bench --no-run succeeded"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    print_status 1 "cargo bench --no-run failed - see /tmp/cargo_bench.log for details"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    echo ""
    echo "Error details:"
    tail -20 /tmp/cargo_bench.log
fi

echo ""
echo "======================================"
echo "Verification Summary"
echo "======================================"
echo ""
echo "Total checks: $TOTAL_CHECKS"
echo "Passed: $PASSED_CHECKS"
echo "Failed: $((TOTAL_CHECKS - PASSED_CHECKS))"
echo ""

if [ $PASSED_CHECKS -eq $TOTAL_CHECKS ]; then
    echo -e "${GREEN}All checks passed! ✓${NC}"
    echo ""
    echo "The benchmark migration is complete and verified."
    echo "You can now run benchmarks with:"
    echo "  cargo bench                    # Run all benchmarks"
    echo "  cargo bench --bench arithmetic # Run specific benchmark"
    exit 0
else
    echo -e "${RED}Some checks failed. ✗${NC}"
    echo ""
    echo "Please review the errors above and fix any issues."
    exit 1
fi
