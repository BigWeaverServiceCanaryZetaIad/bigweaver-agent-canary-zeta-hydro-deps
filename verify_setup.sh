#!/bin/bash

# Verification script for bigweaver-agent-canary-zeta-hydro-deps repository setup
# This script verifies that all required files and configurations are in place

set -e

echo "======================================"
echo "Benchmark Repository Verification"
echo "======================================"
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

success_count=0
failure_count=0

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} Found: $1"
        ((success_count++))
        return 0
    else
        echo -e "${RED}✗${NC} Missing: $1"
        ((failure_count++))
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} Found directory: $1"
        ((success_count++))
        return 0
    else
        echo -e "${RED}✗${NC} Missing directory: $1"
        ((failure_count++))
        return 1
    fi
}

echo "Checking Repository Structure..."
echo "--------------------------------"

# Root files
check_file "Cargo.toml"
check_file "README.md"
check_file "CHANGELOG.md"
check_file "MIGRATION_SUMMARY.md"
check_file "QUICK_START.md"
check_file ".gitignore"
check_file "rust-toolchain.toml"
check_file "rustfmt.toml"
check_file "clippy.toml"

echo ""
echo "Checking Benchmark Package..."
echo "--------------------------------"

# Benchmark package
check_dir "benches"
check_file "benches/Cargo.toml"
check_file "benches/README.md"
check_file "benches/build.rs"

echo ""
echo "Checking Benchmark Files..."
echo "--------------------------------"

# Benchmark directory
check_dir "benches/benches"
check_file "benches/benches/.gitignore"

# Core benchmarks
check_file "benches/benches/arithmetic.rs"
check_file "benches/benches/fan_in.rs"
check_file "benches/benches/fan_out.rs"
check_file "benches/benches/fork_join.rs"
check_file "benches/benches/identity.rs"
check_file "benches/benches/join.rs"
check_file "benches/benches/reachability.rs"
check_file "benches/benches/upcase.rs"

# Test data
check_file "benches/benches/reachability_edges.txt"
check_file "benches/benches/reachability_reachable.txt"

echo ""
echo "Verifying Cargo.toml Content..."
echo "--------------------------------"

# Check workspace configuration
if grep -q '\[workspace\]' Cargo.toml; then
    echo -e "${GREEN}✓${NC} Workspace configuration found"
    ((success_count++))
else
    echo -e "${RED}✗${NC} Workspace configuration missing"
    ((failure_count++))
fi

if grep -q 'members = \["benches"\]' Cargo.toml || grep -q 'members = \[.*"benches".*\]' Cargo.toml; then
    echo -e "${GREEN}✓${NC} Benches package included in workspace"
    ((success_count++))
else
    echo -e "${RED}✗${NC} Benches package not in workspace members"
    ((failure_count++))
fi

echo ""
echo "Verifying Benchmark Dependencies..."
echo "--------------------------------"

# Check key dependencies in benches/Cargo.toml
if grep -q 'timely.*=.*{.*package.*=.*"timely-master"' benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Timely dependency configured"
    ((success_count++))
else
    echo -e "${RED}✗${NC} Timely dependency missing or incorrect"
    ((failure_count++))
fi

if grep -q 'differential-dataflow.*=.*{.*package.*=.*"differential-dataflow-master"' benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Differential-dataflow dependency configured"
    ((success_count++))
else
    echo -e "${RED}✗${NC} Differential-dataflow dependency missing or incorrect"
    ((failure_count++))
fi

if grep -q 'criterion' benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Criterion dependency found"
    ((success_count++))
else
    echo -e "${RED}✗${NC} Criterion dependency missing"
    ((failure_count++))
fi

if grep -q 'dfir_rs.*=.*{.*git' benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} dfir_rs git dependency configured"
    ((success_count++))
else
    echo -e "${YELLOW}⚠${NC} dfir_rs git dependency not found (expected for comparison benchmarks)"
fi

echo ""
echo "Verifying Benchmark Definitions..."
echo "--------------------------------"

# Check benchmark definitions
benchmarks=("arithmetic" "fan_in" "fan_out" "fork_join" "identity" "join" "reachability" "upcase")
for bench in "${benchmarks[@]}"; do
    if grep -q "\[\[bench\]\]" benches/Cargo.toml && grep -A1 "\[\[bench\]\]" benches/Cargo.toml | grep -q "name = \"$bench\""; then
        echo -e "${GREEN}✓${NC} Benchmark definition: $bench"
        ((success_count++))
    else
        echo -e "${RED}✗${NC} Missing benchmark definition: $bench"
        ((failure_count++))
    fi
done

echo ""
echo "Checking Rust Configuration..."
echo "--------------------------------"

# Check rust-toolchain.toml
if grep -q 'channel = "1.91.1"' rust-toolchain.toml; then
    echo -e "${GREEN}✓${NC} Rust toolchain version specified (1.91.1)"
    ((success_count++))
else
    echo -e "${YELLOW}⚠${NC} Rust toolchain version may differ from expected"
fi

# Check for components
if grep -q 'rustfmt' rust-toolchain.toml && grep -q 'clippy' rust-toolchain.toml; then
    echo -e "${GREEN}✓${NC} Required components (rustfmt, clippy) specified"
    ((success_count++))
else
    echo -e "${RED}✗${NC} Missing required components in toolchain"
    ((failure_count++))
fi

echo ""
echo "File Size Checks..."
echo "--------------------------------"

# Check that test data files are present and non-empty
if [ -s "benches/benches/reachability_edges.txt" ]; then
    size=$(stat -f%z "benches/benches/reachability_edges.txt" 2>/dev/null || stat -c%s "benches/benches/reachability_edges.txt" 2>/dev/null)
    echo -e "${GREEN}✓${NC} reachability_edges.txt present ($size bytes)"
    ((success_count++))
else
    echo -e "${RED}✗${NC} reachability_edges.txt missing or empty"
    ((failure_count++))
fi

if [ -s "benches/benches/reachability_reachable.txt" ]; then
    size=$(stat -f%z "benches/benches/reachability_reachable.txt" 2>/dev/null || stat -c%s "benches/benches/reachability_reachable.txt" 2>/dev/null)
    echo -e "${GREEN}✓${NC} reachability_reachable.txt present ($size bytes)"
    ((success_count++))
else
    echo -e "${RED}✗${NC} reachability_reachable.txt missing or empty"
    ((failure_count++))
fi

echo ""
echo "======================================"
echo "Verification Summary"
echo "======================================"
echo -e "Successful checks: ${GREEN}$success_count${NC}"
echo -e "Failed checks: ${RED}$failure_count${NC}"
echo ""

if [ $failure_count -eq 0 ]; then
    echo -e "${GREEN}✓ All verifications passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Review the files to ensure correctness"
    echo "  2. Run 'cargo check' to verify dependencies (requires Rust)"
    echo "  3. Run 'cargo bench' to execute benchmarks"
    echo "  4. Commit and push the changes to the repository"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Some verifications failed. Please review the output above.${NC}"
    echo ""
    exit 1
fi
