#!/bin/bash
# Verification script for benchmark repository migration

set -e

echo "=========================================="
echo "Benchmark Repository Verification"
echo "=========================================="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1 (missing)"
        return 1
    fi
}

# Function to check if directory exists
check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $1/"
        return 0
    else
        echo -e "${RED}✗${NC} $1/ (missing)"
        return 1
    fi
}

echo "Checking repository structure..."
echo ""

# Root files
echo "Root Configuration Files:"
check_file "Cargo.toml"
check_file "README.md"
check_file "MIGRATION_GUIDE.md"
check_file ".gitignore"
check_file "rust-toolchain.toml"
check_file "rustfmt.toml"
check_file "clippy.toml"
echo ""

# Benches directory
echo "Benchmark Package:"
check_dir "benches"
check_file "benches/Cargo.toml"
check_file "benches/README.md"
check_file "benches/build.rs"
echo ""

# Benchmark files
echo "Benchmark Implementations:"
check_file "benches/benches/arithmetic.rs"
check_file "benches/benches/fan_in.rs"
check_file "benches/benches/fan_out.rs"
check_file "benches/benches/fork_join.rs"
check_file "benches/benches/futures.rs"
check_file "benches/benches/identity.rs"
check_file "benches/benches/join.rs"
check_file "benches/benches/micro_ops.rs"
check_file "benches/benches/reachability.rs"
check_file "benches/benches/symmetric_hash_join.rs"
check_file "benches/benches/upcase.rs"
check_file "benches/benches/words_diamond.rs"
echo ""

# Test data files
echo "Test Data Files:"
check_file "benches/benches/reachability_edges.txt"
check_file "benches/benches/reachability_reachable.txt"
check_file "benches/benches/words_alpha.txt"
echo ""

# Count files
echo "File Statistics:"
BENCHMARK_COUNT=$(ls -1 benches/benches/*.rs 2>/dev/null | wc -l)
DATA_FILE_COUNT=$(ls -1 benches/benches/*.txt 2>/dev/null | wc -l)
echo -e "  Benchmark files: ${GREEN}${BENCHMARK_COUNT}${NC} (expected: 12)"
echo -e "  Test data files: ${GREEN}${DATA_FILE_COUNT}${NC} (expected: 3)"
echo ""

# Check file sizes
echo "Test Data Sizes:"
if [ -f "benches/benches/words_alpha.txt" ]; then
    WORDS_SIZE=$(du -h benches/benches/words_alpha.txt | cut -f1)
    echo -e "  words_alpha.txt: ${GREEN}${WORDS_SIZE}${NC}"
fi
if [ -f "benches/benches/reachability_edges.txt" ]; then
    EDGES_SIZE=$(du -h benches/benches/reachability_edges.txt | cut -f1)
    echo -e "  reachability_edges.txt: ${GREEN}${EDGES_SIZE}${NC}"
fi
if [ -f "benches/benches/reachability_reachable.txt" ]; then
    REACH_SIZE=$(du -h benches/benches/reachability_reachable.txt | cut -f1)
    echo -e "  reachability_reachable.txt: ${GREEN}${REACH_SIZE}${NC}"
fi
echo ""

# Check Cargo.toml content
echo "Checking Cargo.toml configurations..."
if grep -q "dfir_rs.*git.*https://github.com/hydro-project/hydro" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} dfir_rs uses git dependency"
else
    echo -e "${RED}✗${NC} dfir_rs should use git dependency"
fi

if grep -q "sinktools.*git.*https://github.com/hydro-project/hydro" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} sinktools uses git dependency"
else
    echo -e "${RED}✗${NC} sinktools should use git dependency"
fi

if grep -q "timely.*timely-master" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} timely dependency found"
else
    echo -e "${RED}✗${NC} timely dependency missing"
fi

if grep -q "differential-dataflow.*differential-dataflow-master" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} differential-dataflow dependency found"
else
    echo -e "${RED}✗${NC} differential-dataflow dependency missing"
fi
echo ""

# Check workspace configuration
echo "Checking workspace configuration..."
if grep -A 3 "^\[workspace\]" Cargo.toml | grep -q "benches"; then
    echo -e "${GREEN}✓${NC} Workspace includes benches member"
else
    echo -e "${RED}✗${NC} Workspace should include benches member"
fi
echo ""

# Total size
echo "Repository Size:"
TOTAL_SIZE=$(du -sh . 2>/dev/null | cut -f1)
echo -e "  Total: ${GREEN}${TOTAL_SIZE}${NC}"
echo ""

echo "=========================================="
echo "Verification Complete!"
echo "=========================================="
echo ""
echo -e "${YELLOW}Note:${NC} To test build and run benchmarks, you need:"
echo "  1. Rust toolchain (run: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh)"
echo "  2. Then run: cargo check"
echo "  3. Then run: cargo bench --bench arithmetic"
echo ""
