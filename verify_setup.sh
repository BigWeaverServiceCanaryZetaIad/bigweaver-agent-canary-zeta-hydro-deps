#!/bin/bash
# Verification script for bigweaver-agent-canary-zeta-hydro-deps repository
# This script verifies that all benchmarks and dependencies are correctly set up

set -e  # Exit on error

echo "=========================================="
echo "Benchmark Repository Verification Script"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
PASS=0
FAIL=0

# Function to check file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} Found: $1"
        ((PASS++))
        return 0
    else
        echo -e "${RED}✗${NC} Missing: $1"
        ((FAIL++))
        return 1
    fi
}

# Function to check directory exists
check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} Found directory: $1"
        ((PASS++))
        return 0
    else
        echo -e "${RED}✗${NC} Missing directory: $1"
        ((FAIL++))
        return 1
    fi
}

echo "1. Checking core files..."
echo "-------------------------------------------"
check_file "Cargo.toml"
check_file "build.rs"
check_file "README.md"
check_file "RUNNING_BENCHMARKS.md"
check_file "MIGRATION.md"
check_file "LICENSE"
check_file ".gitignore"
echo ""

echo "2. Checking benchmark directory..."
echo "-------------------------------------------"
check_dir "benches"
echo ""

echo "3. Checking benchmark files..."
echo "-------------------------------------------"
check_file "benches/identity.rs"
check_file "benches/fork_join.rs"
check_file "benches/join.rs"
check_file "benches/upcase.rs"
check_file "benches/fan_in.rs"
check_file "benches/fan_out.rs"
check_file "benches/arithmetic.rs"
check_file "benches/reachability.rs"
echo ""

echo "4. Checking data files..."
echo "-------------------------------------------"
check_file "benches/words_alpha.txt"
check_file "benches/reachability_edges.txt"
check_file "benches/reachability_reachable.txt"
echo ""

echo "5. Verifying file sizes..."
echo "-------------------------------------------"
WORDS_SIZE=$(wc -c < "benches/words_alpha.txt" 2>/dev/null || echo "0")
EDGES_SIZE=$(wc -c < "benches/reachability_edges.txt" 2>/dev/null || echo "0")
REACH_SIZE=$(wc -c < "benches/reachability_reachable.txt" 2>/dev/null || echo "0")

if [ "$WORDS_SIZE" -gt 3000000 ]; then
    echo -e "${GREEN}✓${NC} words_alpha.txt size OK: $(numfmt --to=iec $WORDS_SIZE)"
    ((PASS++))
else
    echo -e "${RED}✗${NC} words_alpha.txt size too small: $WORDS_SIZE bytes"
    ((FAIL++))
fi

if [ "$EDGES_SIZE" -gt 500000 ]; then
    echo -e "${GREEN}✓${NC} reachability_edges.txt size OK: $(numfmt --to=iec $EDGES_SIZE)"
    ((PASS++))
else
    echo -e "${RED}✗${NC} reachability_edges.txt size too small: $EDGES_SIZE bytes"
    ((FAIL++))
fi

if [ "$REACH_SIZE" -gt 30000 ]; then
    echo -e "${GREEN}✓${NC} reachability_reachable.txt size OK: $(numfmt --to=iec $REACH_SIZE)"
    ((PASS++))
else
    echo -e "${RED}✗${NC} reachability_reachable.txt size too small: $REACH_SIZE bytes"
    ((FAIL++))
fi
echo ""

echo "6. Checking Cargo.toml configuration..."
echo "-------------------------------------------"
if grep -q "timely" Cargo.toml; then
    echo -e "${GREEN}✓${NC} timely dependency found"
    ((PASS++))
else
    echo -e "${RED}✗${NC} timely dependency missing"
    ((FAIL++))
fi

if grep -q "differential-dataflow" Cargo.toml; then
    echo -e "${GREEN}✓${NC} differential-dataflow dependency found"
    ((PASS++))
else
    echo -e "${RED}✗${NC} differential-dataflow dependency missing"
    ((FAIL++))
fi

if grep -q "dfir_rs" Cargo.toml; then
    echo -e "${GREEN}✓${NC} dfir_rs dependency found"
    ((PASS++))
else
    echo -e "${RED}✗${NC} dfir_rs dependency missing"
    ((FAIL++))
fi

if grep -q "criterion" Cargo.toml; then
    echo -e "${GREEN}✓${NC} criterion dependency found"
    ((PASS++))
else
    echo -e "${RED}✗${NC} criterion dependency missing"
    ((FAIL++))
fi
echo ""

echo "7. Checking benchmark definitions in Cargo.toml..."
echo "-------------------------------------------"
BENCHMARKS=("identity" "fork_join" "join" "upcase" "fan_in" "fan_out" "arithmetic" "reachability")
for bench in "${BENCHMARKS[@]}"; do
    if grep -q "name = \"$bench\"" Cargo.toml; then
        echo -e "${GREEN}✓${NC} Benchmark '$bench' defined in Cargo.toml"
        ((PASS++))
    else
        echo -e "${RED}✗${NC} Benchmark '$bench' not defined in Cargo.toml"
        ((FAIL++))
    fi
done
echo ""

echo "8. Checking Rust installation..."
echo "-------------------------------------------"
if command -v rustc &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    echo -e "${GREEN}✓${NC} Rust installed: $RUST_VERSION"
    ((PASS++))
else
    echo -e "${RED}✗${NC} Rust not installed"
    ((FAIL++))
fi

if command -v cargo &> /dev/null; then
    CARGO_VERSION=$(cargo --version)
    echo -e "${GREEN}✓${NC} Cargo installed: $CARGO_VERSION"
    ((PASS++))
else
    echo -e "${RED}✗${NC} Cargo not installed"
    ((FAIL++))
fi
echo ""

echo "9. Optional: Testing build (this may take several minutes)..."
echo "-------------------------------------------"
read -p "Do you want to test the build? This will download dependencies (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Building benchmarks (this may take a while)..."
    if cargo build --benches 2>&1 | tee /tmp/build.log; then
        echo -e "${GREEN}✓${NC} Build successful"
        ((PASS++))
    else
        echo -e "${RED}✗${NC} Build failed"
        echo "See /tmp/build.log for details"
        ((FAIL++))
    fi
else
    echo -e "${YELLOW}⊘${NC} Build test skipped"
fi
echo ""

echo "=========================================="
echo "Verification Summary"
echo "=========================================="
echo -e "Passed: ${GREEN}$PASS${NC}"
echo -e "Failed: ${RED}$FAIL${NC}"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Run benchmarks: cargo bench"
    echo "  2. Run specific benchmark: cargo bench --bench identity"
    echo "  3. View results: open target/criterion/report/index.html"
    echo "  4. Read documentation: README.md, RUNNING_BENCHMARKS.md"
    exit 0
else
    echo -e "${RED}✗ Some checks failed${NC}"
    echo ""
    echo "Please fix the issues above before running benchmarks."
    exit 1
fi
