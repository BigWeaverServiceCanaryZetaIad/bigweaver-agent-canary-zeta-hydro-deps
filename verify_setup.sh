#!/bin/bash
# Setup verification script for benchmark repository
# Verifies that all benchmarks and dependencies are correctly configured

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Benchmark Repository Setup Verification                           ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

ERRORS=0

# Function to check file exists
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

# Function to check directory exists
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

echo -e "${YELLOW}Checking repository structure...${NC}"
echo ""

# Check main directories
check_dir "benches"
check_dir "benches/benches"

echo ""
echo -e "${YELLOW}Checking configuration files...${NC}"
echo ""

# Check configuration files
check_file "benches/Cargo.toml"
check_file "benches/README.md"
check_file "benches/build.rs"
check_file "README.md"
check_file "BENCHMARK_MIGRATION.md"

echo ""
echo -e "${YELLOW}Checking benchmark files...${NC}"
echo ""

# Check benchmark source files
BENCHMARKS=(
    "arithmetic"
    "fan_in"
    "fan_out"
    "fork_join"
    "futures"
    "identity"
    "join"
    "micro_ops"
    "reachability"
    "symmetric_hash_join"
    "upcase"
    "words_diamond"
)

for bench in "${BENCHMARKS[@]}"; do
    check_file "benches/benches/${bench}.rs"
done

echo ""
echo -e "${YELLOW}Checking data files...${NC}"
echo ""

# Check data files
check_file "benches/benches/reachability_edges.txt"
check_file "benches/benches/reachability_reachable.txt"
check_file "benches/benches/words_alpha.txt"

echo ""
echo -e "${YELLOW}Checking Cargo.toml dependencies...${NC}"
echo ""

# Check if required dependencies are in Cargo.toml
if grep -q "timely.*timely-master" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Found timely dependency"
else
    echo -e "${RED}✗${NC} Missing timely dependency"
    ((ERRORS++))
fi

if grep -q "differential-dataflow.*differential-dataflow-master" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Found differential-dataflow dependency"
else
    echo -e "${RED}✗${NC} Missing differential-dataflow dependency"
    ((ERRORS++))
fi

if grep -q "dfir_rs.*git" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Found dfir_rs git dependency"
else
    echo -e "${RED}✗${NC} Missing dfir_rs git dependency"
    ((ERRORS++))
fi

if grep -q "sinktools.*git" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Found sinktools git dependency"
else
    echo -e "${RED}✗${NC} Missing sinktools git dependency"
    ((ERRORS++))
fi

echo ""
echo -e "${YELLOW}Checking benchmark configurations in Cargo.toml...${NC}"
echo ""

# Check if all benchmarks are configured
for bench in "${BENCHMARKS[@]}"; do
    if grep -q "name = \"$bench\"" benches/Cargo.toml; then
        echo -e "${GREEN}✓${NC} Benchmark configured: $bench"
    else
        echo -e "${RED}✗${NC} Missing benchmark configuration: $bench"
        ((ERRORS++))
    fi
done

echo ""
echo -e "${YELLOW}Testing Cargo compilation...${NC}"
echo ""

# Try to fetch dependencies
if cargo fetch 2>&1 | grep -q "error"; then
    echo -e "${RED}✗${NC} Cargo fetch failed"
    ((ERRORS++))
else
    echo -e "${GREEN}✓${NC} Cargo dependencies can be fetched"
fi

# Try to check the project
echo ""
echo -e "${YELLOW}Attempting cargo check (this may take a while)...${NC}"
if cargo check 2>&1 | grep -q "error\["; then
    echo -e "${RED}✗${NC} Cargo check failed"
    echo -e "${YELLOW}Run 'cargo check' for detailed error messages${NC}"
    ((ERRORS++))
else
    echo -e "${GREEN}✓${NC} Cargo check passed"
fi

echo ""
echo -e "${BLUE}════════════════════════════════════════════════════════════════════${NC}"

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All verification checks passed!${NC}"
    echo ""
    echo "The benchmark repository is correctly set up."
    echo ""
    echo "Next steps:"
    echo "  1. Run benchmarks: ./run_benchmarks.sh quick"
    echo "  2. View full options: ./run_benchmarks.sh help"
    echo "  3. Run all benchmarks: ./run_benchmarks.sh all"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS error(s) during verification${NC}"
    echo ""
    echo "Please fix the errors above before running benchmarks."
    echo ""
    exit 1
fi
