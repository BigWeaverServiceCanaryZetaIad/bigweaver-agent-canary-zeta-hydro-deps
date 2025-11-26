#!/bin/bash
# Verification script to ensure all benchmarks can be built and run

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HYDRO_DEPS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Hydro Benchmarks Verification Tool ===${NC}\n"

cd "$HYDRO_DEPS_DIR"

# List of all benchmarks
BENCHMARKS=(
    "arithmetic"
    "fan_in"
    "fan_out"
    "fork_join"
    "identity"
    "join"
    "reachability"
    "upcase"
    "futures"
    "micro_ops"
    "symmetric_hash_join"
    "words_diamond"
)

echo -e "${GREEN}Step 1: Checking workspace structure${NC}"
if [ ! -f "Cargo.toml" ]; then
    echo -e "${RED}✗ Workspace Cargo.toml not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Workspace Cargo.toml found${NC}"

if [ ! -f "benches/Cargo.toml" ]; then
    echo -e "${RED}✗ Benches Cargo.toml not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Benches Cargo.toml found${NC}"

if [ ! -f "benches/build.rs" ]; then
    echo -e "${RED}✗ Benches build.rs not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Benches build.rs found${NC}"

echo -e "\n${GREEN}Step 2: Checking benchmark files${NC}"
MISSING_FILES=0
for bench in "${BENCHMARKS[@]}"; do
    if [ -f "benches/benches/${bench}.rs" ]; then
        echo -e "${GREEN}✓${NC} ${bench}.rs"
    else
        echo -e "${RED}✗${NC} ${bench}.rs (MISSING)"
        MISSING_FILES=$((MISSING_FILES + 1))
    fi
done

if [ $MISSING_FILES -gt 0 ]; then
    echo -e "\n${RED}Error: $MISSING_FILES benchmark file(s) missing${NC}"
    exit 1
fi

echo -e "\n${GREEN}Step 3: Checking data files${NC}"
DATA_FILES=(
    "benches/benches/reachability_edges.txt"
    "benches/benches/reachability_reachable.txt"
    "benches/benches/words_alpha.txt"
)

MISSING_DATA=0
for file in "${DATA_FILES[@]}"; do
    if [ -f "$file" ]; then
        SIZE=$(du -h "$file" | cut -f1)
        echo -e "${GREEN}✓${NC} $(basename "$file") ($SIZE)"
    else
        echo -e "${RED}✗${NC} $(basename "$file") (MISSING)"
        MISSING_DATA=$((MISSING_DATA + 1))
    fi
done

if [ $MISSING_DATA -gt 0 ]; then
    echo -e "\n${RED}Error: $MISSING_DATA data file(s) missing${NC}"
    exit 1
fi

echo -e "\n${GREEN}Step 4: Building benchmarks${NC}"
echo "Running: cargo build -p benches"
if cargo build -p benches; then
    echo -e "${GREEN}✓ Benchmarks built successfully${NC}"
else
    echo -e "${RED}✗ Benchmark build failed${NC}"
    exit 1
fi

echo -e "\n${GREEN}Step 5: Running quick benchmark tests${NC}"
echo "This will run each benchmark for a short time to verify they work..."
echo ""

FAILED_BENCHMARKS=()
for bench in "${BENCHMARKS[@]}"; do
    echo -ne "Testing ${bench}... "
    # Run benchmark with very short warm-up and measurement time for quick verification
    if cargo bench -p benches --bench "$bench" -- --warm-up-time 0.1 --measurement-time 0.5 > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC}"
    else
        echo -e "${RED}✗${NC}"
        FAILED_BENCHMARKS+=("$bench")
    fi
done

echo ""

if [ ${#FAILED_BENCHMARKS[@]} -gt 0 ]; then
    echo -e "${RED}Error: ${#FAILED_BENCHMARKS[@]} benchmark(s) failed:${NC}"
    for bench in "${FAILED_BENCHMARKS[@]}"; do
        echo -e "  ${RED}✗${NC} $bench"
    done
    echo ""
    echo "Run the following to see detailed error:"
    echo "  cargo bench -p benches --bench ${FAILED_BENCHMARKS[0]}"
    exit 1
fi

echo -e "${GREEN}=== All Verification Steps Passed ===${NC}\n"
echo "Summary:"
echo "  ✓ Workspace structure correct"
echo "  ✓ All ${#BENCHMARKS[@]} benchmark files present"
echo "  ✓ All ${#DATA_FILES[@]} data files present"
echo "  ✓ Benchmarks build successfully"
echo "  ✓ All benchmarks can be executed"
echo ""
echo -e "${BLUE}You can now run full benchmarks with:${NC}"
echo "  cargo bench -p benches"
echo ""
echo -e "${BLUE}Or run a specific benchmark with:${NC}"
echo "  cargo bench -p benches --bench arithmetic"
