#!/usr/bin/env bash
# Setup and verification script for Hydro benchmarks

set -e

echo "========================================"
echo "Hydro Benchmark Setup and Verification"
echo "========================================"
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if we're in the right directory
if [[ ! -f "Cargo.toml" ]] || [[ ! -d "benches" ]]; then
    echo -e "${RED}Error: Must be run from the benches directory${NC}"
    echo "Expected: /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/benches"
    exit 1
fi

echo "✓ Running from benches directory"
echo

# Check for Rust toolchain
echo "Checking Rust toolchain..."
if ! command -v cargo &> /dev/null; then
    echo -e "${RED}Error: cargo not found${NC}"
    echo "Please install Rust: https://rustup.rs/"
    exit 1
fi
echo -e "${GREEN}✓ Cargo found: $(cargo --version)${NC}"
echo -e "${GREEN}✓ Rustc found: $(rustc --version)${NC}"
echo

# Verify main Hydro repository exists
echo "Checking for main Hydro repository..."
HYDRO_REPO="../../bigweaver-agent-canary-hydro-zeta"
if [[ ! -d "$HYDRO_REPO" ]]; then
    echo -e "${RED}Error: Main Hydro repository not found at $HYDRO_REPO${NC}"
    echo "Please ensure both repositories are cloned in the same parent directory:"
    echo "  /projects/sandbox/bigweaver-agent-canary-hydro-zeta"
    echo "  /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps"
    exit 1
fi
echo -e "${GREEN}✓ Main Hydro repository found${NC}"

# Check for required dependencies from main repo
echo "Checking required dependencies..."
if [[ ! -d "$HYDRO_REPO/dfir_rs" ]]; then
    echo -e "${RED}Error: dfir_rs not found in main repository${NC}"
    exit 1
fi
echo -e "${GREEN}✓ dfir_rs found${NC}"

if [[ ! -d "$HYDRO_REPO/sinktools" ]]; then
    echo -e "${RED}Error: sinktools not found in main repository${NC}"
    exit 1
fi
echo -e "${GREEN}✓ sinktools found${NC}"
echo

# Check for benchmark files
echo "Checking benchmark files..."
BENCH_COUNT=$(ls -1 benches/*.rs 2>/dev/null | wc -l)
if [[ $BENCH_COUNT -eq 0 ]]; then
    echo -e "${RED}Error: No benchmark files found${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Found $BENCH_COUNT benchmark files${NC}"

# Check for test data
DATA_FILES=("benches/reachability_edges.txt" "benches/reachability_reachable.txt" "benches/words_alpha.txt")
for file in "${DATA_FILES[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo -e "${YELLOW}Warning: Test data file not found: $file${NC}"
    else
        SIZE=$(du -h "$file" | cut -f1)
        echo "  ✓ $file ($SIZE)"
    fi
done
echo

# Verify Cargo.toml configuration
echo "Verifying Cargo.toml configuration..."
if grep -q "path = \"../../bigweaver-agent-canary-hydro-zeta/dfir_rs\"" Cargo.toml; then
    echo -e "${GREEN}✓ dfir_rs path correctly configured${NC}"
else
    echo -e "${RED}Error: dfir_rs path not correctly configured${NC}"
    exit 1
fi

if grep -q "path = \"../../bigweaver-agent-canary-hydro-zeta/sinktools\"" Cargo.toml; then
    echo -e "${GREEN}✓ sinktools path correctly configured${NC}"
else
    echo -e "${RED}Error: sinktools path not correctly configured${NC}"
    exit 1
fi
echo

# List available benchmarks
echo "Available benchmarks:"
grep -E "^\[\[bench\]\]" Cargo.toml -A 1 | grep "name = " | sed 's/name = "\(.*\)"/  - \1/' | sort
echo

# Try to check dependencies (without building)
echo "Checking if dependencies can be resolved..."
echo "(This may take a moment...)"
if cargo metadata --format-version 1 > /dev/null 2>&1; then
    echo -e "${GREEN}✓ All dependencies resolved successfully${NC}"
else
    echo -e "${YELLOW}Warning: Some dependencies could not be resolved${NC}"
    echo "You may need to run 'cargo fetch' or 'cargo build' to download dependencies"
fi
echo

echo "========================================"
echo "Setup verification complete!"
echo "========================================"
echo
echo "To run benchmarks:"
echo "  cargo bench                    # Run all benchmarks"
echo "  cargo bench --bench NAME       # Run specific benchmark"
echo "  cargo bench -- --help          # See more options"
echo
echo "Example:"
echo "  cargo bench --bench reachability"
echo
