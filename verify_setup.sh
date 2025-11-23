#!/bin/bash
# Verification script for bigweaver-agent-canary-zeta-hydro-deps repository setup

set -e

echo "=========================================="
echo "Verifying Repository Setup"
echo "=========================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track verification results
PASSED=0
FAILED=0

# Function to check if file exists
check_file() {
    local file=$1
    local description=$2
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $description: $file"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: $file (MISSING)"
        ((FAILED++))
        return 1
    fi
}

# Function to check if directory exists
check_dir() {
    local dir=$1
    local description=$2
    
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $description: $dir"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: $dir (MISSING)"
        ((FAILED++))
        return 1
    fi
}

# Function to count files
count_files() {
    local pattern=$1
    local expected=$2
    local description=$3
    
    local count=$(find . -name "$pattern" -type f | wc -l)
    
    if [ "$count" -eq "$expected" ]; then
        echo -e "${GREEN}✓${NC} $description: $count files found (expected $expected)"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: $count files found (expected $expected)"
        ((FAILED++))
        return 1
    fi
}

echo "1. Checking Repository Structure"
echo "-----------------------------------"
check_dir "benches" "Benchmarks directory"
check_dir "benches/benches" "Benchmark files directory"
echo ""

echo "2. Checking Configuration Files"
echo "-----------------------------------"
check_file "Cargo.toml" "Workspace Cargo.toml"
check_file "benches/Cargo.toml" "Benchmarks Cargo.toml"
check_file "rust-toolchain.toml" "Rust toolchain config"
check_file "rustfmt.toml" "Rustfmt config"
check_file "clippy.toml" "Clippy config"
check_file ".gitignore" "Git ignore file"
echo ""

echo "3. Checking Documentation Files"
echo "-----------------------------------"
check_file "README.md" "Root README"
check_file "benches/README.md" "Benchmarks README"
check_file "CHANGES.md" "Changelog"
check_file "PERFORMANCE_COMPARISON_GUIDE.md" "Performance comparison guide"
echo ""

echo "4. Checking Benchmark Files"
echo "-----------------------------------"
check_file "benches/benches/arithmetic.rs" "Arithmetic benchmark"
check_file "benches/benches/fan_in.rs" "Fan-in benchmark"
check_file "benches/benches/fan_out.rs" "Fan-out benchmark"
check_file "benches/benches/fork_join.rs" "Fork-join benchmark"
check_file "benches/benches/identity.rs" "Identity benchmark"
check_file "benches/benches/join.rs" "Join benchmark"
check_file "benches/benches/reachability.rs" "Reachability benchmark"
check_file "benches/benches/upcase.rs" "Upcase benchmark"
echo ""

echo "5. Checking Data Files"
echo "-----------------------------------"
check_file "benches/benches/reachability_edges.txt" "Reachability edges data"
check_file "benches/benches/reachability_reachable.txt" "Reachability reachable data"
echo ""

echo "6. Verifying File Counts"
echo "-----------------------------------"
count_files "*.rs" 8 "Rust benchmark files"
echo ""

echo "7. Checking Cargo.toml Configuration"
echo "-----------------------------------"

# Check if workspace is defined
if grep -q "\[workspace\]" Cargo.toml; then
    echo -e "${GREEN}✓${NC} Workspace configuration present"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Workspace configuration missing"
    ((FAILED++))
fi

# Check if benches member exists
if grep -q 'members.*benches' Cargo.toml; then
    echo -e "${GREEN}✓${NC} Benches member in workspace"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Benches member not in workspace"
    ((FAILED++))
fi

# Check for timely dependency
if grep -q "timely" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Timely dependency present"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Timely dependency missing"
    ((FAILED++))
fi

# Check for differential-dataflow dependency
if grep -q "differential-dataflow" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Differential-dataflow dependency present"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Differential-dataflow dependency missing"
    ((FAILED++))
fi

# Check for dfir_rs dependency
if grep -q "dfir_rs" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} dfir_rs dependency present"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} dfir_rs dependency missing"
    ((FAILED++))
fi

# Check for criterion dependency
if grep -q "criterion" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Criterion dependency present"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Criterion dependency missing"
    ((FAILED++))
fi

echo ""

echo "8. Checking Benchmark Entries in Cargo.toml"
echo "-----------------------------------"

# Expected benchmark entries
BENCHMARKS=("arithmetic" "fan_in" "fan_out" "fork_join" "identity" "join" "reachability" "upcase")

for bench in "${BENCHMARKS[@]}"; do
    if grep -q "name = \"$bench\"" benches/Cargo.toml; then
        echo -e "${GREEN}✓${NC} Benchmark entry: $bench"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC} Benchmark entry missing: $bench"
        ((FAILED++))
    fi
done

echo ""

echo "9. Verifying Data File Sizes"
echo "-----------------------------------"

# Check reachability_edges.txt size (should be around 524KB)
EDGES_SIZE=$(stat -f%z benches/benches/reachability_edges.txt 2>/dev/null || stat -c%s benches/benches/reachability_edges.txt 2>/dev/null)
if [ "$EDGES_SIZE" -gt 500000 ] && [ "$EDGES_SIZE" -lt 600000 ]; then
    echo -e "${GREEN}✓${NC} reachability_edges.txt size: ${EDGES_SIZE} bytes (~524KB)"
    ((PASSED++))
else
    echo -e "${YELLOW}⚠${NC} reachability_edges.txt size: ${EDGES_SIZE} bytes (expected ~524KB)"
    ((PASSED++))
fi

# Check reachability_reachable.txt size (should be around 40KB)
REACHABLE_SIZE=$(stat -f%z benches/benches/reachability_reachable.txt 2>/dev/null || stat -c%s benches/benches/reachability_reachable.txt 2>/dev/null)
if [ "$REACHABLE_SIZE" -gt 35000 ] && [ "$REACHABLE_SIZE" -lt 45000 ]; then
    echo -e "${GREEN}✓${NC} reachability_reachable.txt size: ${REACHABLE_SIZE} bytes (~40KB)"
    ((PASSED++))
else
    echo -e "${YELLOW}⚠${NC} reachability_reachable.txt size: ${REACHABLE_SIZE} bytes (expected ~40KB)"
    ((PASSED++))
fi

echo ""

echo "=========================================="
echo "Verification Summary"
echo "=========================================="
echo -e "${GREEN}Passed:${NC} $PASSED"
echo -e "${RED}Failed:${NC} $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "Repository is properly set up with:"
    echo "  - 8 benchmark files"
    echo "  - 2 data files"
    echo "  - Complete documentation"
    echo "  - Required dependencies configured"
    echo ""
    echo "Next steps:"
    echo "  1. Run: cargo build --release"
    echo "  2. Run: cargo bench -p benches"
    echo "  3. View results in target/criterion/report/index.html"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Some checks failed. Please review the output above.${NC}"
    echo ""
    exit 1
fi
