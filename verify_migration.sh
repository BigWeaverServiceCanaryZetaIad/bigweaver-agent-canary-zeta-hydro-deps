#!/bin/bash

# Verification script for benchmark migration to hydro-deps repository
# This script verifies that all expected files are present and the repository is properly configured

set -e  # Exit on error

echo "================================"
echo "Benchmark Migration Verification"
echo "================================"
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

# Function to check if a file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} Found: $1"
        return 0
    else
        echo -e "${RED}✗${NC} Missing: $1"
        ((ERRORS++))
        return 1
    fi
}

# Function to check if a directory exists
check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} Found directory: $1"
        return 0
    else
        echo -e "${RED}✗${NC} Missing directory: $1"
        ((ERRORS++))
        return 1
    fi
}

# Function to check file contains text
check_contains() {
    if grep -q "$2" "$1" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $1 contains '$2'"
        return 0
    else
        echo -e "${YELLOW}⚠${NC} $1 does not contain '$2'"
        ((WARNINGS++))
        return 1
    fi
}

echo "1. Checking Directory Structure"
echo "--------------------------------"
check_dir "benches"
check_dir "benches/benches"
echo ""

echo "2. Checking Documentation Files"
echo "--------------------------------"
check_file "README.md"
check_file "QUICK_START.md"
check_file "MIGRATION_NOTES.md"
check_file "benches/README.md"
echo ""

echo "3. Checking Configuration Files"
echo "--------------------------------"
check_file "Cargo.toml"
check_file "benches/Cargo.toml"
check_file "benches/build.rs"
echo ""

echo "4. Checking Benchmark Files"
echo "----------------------------"
BENCHMARKS=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "identity.rs"
    "join.rs"
    "reachability.rs"
    "upcase.rs"
)

for bench in "${BENCHMARKS[@]}"; do
    check_file "benches/benches/$bench"
done
echo ""

echo "5. Checking Data Files"
echo "----------------------"
check_file "benches/benches/reachability_edges.txt"
check_file "benches/benches/reachability_reachable.txt"

# Check data file sizes
if [ -f "benches/benches/reachability_edges.txt" ]; then
    SIZE=$(stat -f%z "benches/benches/reachability_edges.txt" 2>/dev/null || stat -c%s "benches/benches/reachability_edges.txt" 2>/dev/null)
    if [ "$SIZE" -gt 500000 ]; then
        echo -e "${GREEN}✓${NC} reachability_edges.txt has expected size (~533KB)"
    else
        echo -e "${YELLOW}⚠${NC} reachability_edges.txt size is $SIZE bytes (expected ~533KB)"
        ((WARNINGS++))
    fi
fi

if [ -f "benches/benches/reachability_reachable.txt" ]; then
    SIZE=$(stat -f%z "benches/benches/reachability_reachable.txt" 2>/dev/null || stat -c%s "benches/benches/reachability_reachable.txt" 2>/dev/null)
    if [ "$SIZE" -gt 30000 ]; then
        echo -e "${GREEN}✓${NC} reachability_reachable.txt has expected size (~38KB)"
    else
        echo -e "${YELLOW}⚠${NC} reachability_reachable.txt size is $SIZE bytes (expected ~38KB)"
        ((WARNINGS++))
    fi
fi
echo ""

echo "6. Checking Dependencies in Cargo.toml"
echo "---------------------------------------"
check_contains "benches/Cargo.toml" "timely"
check_contains "benches/Cargo.toml" "differential-dataflow"
check_contains "benches/Cargo.toml" "criterion"
check_contains "benches/Cargo.toml" "dfir_rs"
check_contains "benches/Cargo.toml" "sinktools"
echo ""

echo "7. Checking Benchmark Definitions"
echo "----------------------------------"
for bench in "${BENCHMARKS[@]}"; do
    BENCH_NAME="${bench%.rs}"
    check_contains "benches/Cargo.toml" "name = \"$BENCH_NAME\""
done
echo ""

echo "8. Verifying Build Configuration"
echo "---------------------------------"
if cargo check --workspace 2>&1 | tee /tmp/cargo_check.log | grep -q "error"; then
    echo -e "${RED}✗${NC} Cargo check failed"
    echo "See /tmp/cargo_check.log for details"
    ((ERRORS++))
else
    echo -e "${GREEN}✓${NC} Cargo check passed"
fi
echo ""

echo "9. Checking Workspace Configuration"
echo "------------------------------------"
check_contains "Cargo.toml" "benches"
check_contains "Cargo.toml" "[workspace]"
echo ""

echo "================================"
echo "Verification Summary"
echo "================================"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "The migration appears to be complete and correct."
    echo ""
    echo "Next steps:"
    echo "  1. Run 'cargo build' to build the benchmarks"
    echo "  2. Run 'cargo bench' to execute the benchmarks"
    echo "  3. Check 'target/criterion/report/index.html' for results"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠ Verification completed with $WARNINGS warnings${NC}"
    echo ""
    echo "The migration is functional but has some non-critical issues."
    echo "Review the warnings above and address them if needed."
    exit 0
else
    echo -e "${RED}✗ Verification failed with $ERRORS errors and $WARNINGS warnings${NC}"
    echo ""
    echo "The migration is incomplete. Please review and fix the errors above."
    exit 1
fi
