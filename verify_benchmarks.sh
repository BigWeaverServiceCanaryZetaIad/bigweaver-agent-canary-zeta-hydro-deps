#!/bin/bash

# Verification script for timely-differential-benches migration
# This script verifies that all expected benchmarks are present and can be compiled

set -e

echo "=========================================="
echo "Timely/Differential Benchmarks Verification"
echo "=========================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for checks
PASSED=0
FAILED=0

# Function to check if a file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} Found: $1"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC} Missing: $1"
        ((FAILED++))
    fi
}

# Function to check if a string exists in a file
check_string_in_file() {
    if grep -q "$2" "$1"; then
        echo -e "${GREEN}✓${NC} Found '$2' in $1"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC} Missing '$2' in $1"
        ((FAILED++))
    fi
}

echo "Checking repository structure..."
echo ""

# Check root files
check_file "Cargo.toml"
check_file "README.md"
check_file "MIGRATION_NOTES.md"

echo ""
echo "Checking benchmark files..."
echo ""

# Check benchmark source files
check_file "benches/benches/arithmetic.rs"
check_file "benches/benches/fan_in.rs"
check_file "benches/benches/fan_out.rs"
check_file "benches/benches/fork_join.rs"
check_file "benches/benches/identity.rs"
check_file "benches/benches/join.rs"
check_file "benches/benches/reachability.rs"
check_file "benches/benches/upcase.rs"

echo ""
echo "Checking benchmark data files..."
echo ""

check_file "benches/benches/reachability_edges.txt"
check_file "benches/benches/reachability_reachable.txt"

echo ""
echo "Checking configuration files..."
echo ""

check_file "benches/Cargo.toml"
check_file "benches/README.md"
check_file "benches/build.rs"

echo ""
echo "Checking dependencies in benches/Cargo.toml..."
echo ""

check_string_in_file "benches/Cargo.toml" "timely"
check_string_in_file "benches/Cargo.toml" "differential-dataflow"
check_string_in_file "benches/Cargo.toml" "dfir_rs"
check_string_in_file "benches/Cargo.toml" "criterion"

echo ""
echo "Checking benchmark entries in benches/Cargo.toml..."
echo ""

check_string_in_file "benches/Cargo.toml" 'name = "arithmetic"'
check_string_in_file "benches/Cargo.toml" 'name = "fan_in"'
check_string_in_file "benches/Cargo.toml" 'name = "fan_out"'
check_string_in_file "benches/Cargo.toml" 'name = "fork_join"'
check_string_in_file "benches/Cargo.toml" 'name = "identity"'
check_string_in_file "benches/Cargo.toml" 'name = "join"'
check_string_in_file "benches/Cargo.toml" 'name = "reachability"'
check_string_in_file "benches/Cargo.toml" 'name = "upcase"'

echo ""
echo "Attempting to compile benchmarks..."
echo ""

if cargo check --quiet 2>&1; then
    echo -e "${GREEN}✓${NC} Benchmarks compile successfully"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Compilation failed"
    ((FAILED++))
fi

echo ""
echo "=========================================="
echo "Verification Summary"
echo "=========================================="
echo -e "Passed: ${GREEN}${PASSED}${NC}"
echo -e "Failed: ${RED}${FAILED}${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}All checks passed!${NC}"
    echo ""
    echo "To run the benchmarks:"
    echo "  cargo bench -p timely-differential-benches"
    echo ""
    echo "To run a specific benchmark:"
    echo "  cargo bench -p timely-differential-benches --bench arithmetic"
    exit 0
else
    echo -e "${RED}Some checks failed. Please review the output above.${NC}"
    exit 1
fi
