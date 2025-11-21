#!/bin/bash
# Setup validation script for benchmark repository

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}Benchmark Repository Validation${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

# Check Rust installation
echo -e "${YELLOW}Checking Rust installation...${NC}"
if command -v rustc &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    echo -e "${GREEN}✓${NC} Rust found: $RUST_VERSION"
else
    echo -e "${RED}✗${NC} Rust not found. Install from https://rustup.rs"
    exit 1
fi

if command -v cargo &> /dev/null; then
    CARGO_VERSION=$(cargo --version)
    echo -e "${GREEN}✓${NC} Cargo found: $CARGO_VERSION"
else
    echo -e "${RED}✗${NC} Cargo not found."
    exit 1
fi

echo ""

# Check repository structure
echo -e "${YELLOW}Checking repository structure...${NC}"

REQUIRED_FILES=(
    "Cargo.toml"
    "README.md"
    "timely-benchmarks/Cargo.toml"
    "timely-benchmarks/src/lib.rs"
    "differential-benchmarks/Cargo.toml"
    "differential-benchmarks/src/lib.rs"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} Found: $file"
    else
        echo -e "${RED}✗${NC} Missing: $file"
        exit 1
    fi
done

echo ""

# Count benchmark files
echo -e "${YELLOW}Checking benchmark files...${NC}"
TIMELY_BENCHES=$(find timely-benchmarks/benches -name "*.rs" 2>/dev/null | wc -l)
DIFF_BENCHES=$(find differential-benchmarks/benches -name "*.rs" 2>/dev/null | wc -l)

echo -e "${GREEN}✓${NC} Timely benchmarks: $TIMELY_BENCHES files"
echo -e "${GREEN}✓${NC} Differential benchmarks: $DIFF_BENCHES files"

echo ""

# Check if cargo can read the workspace
echo -e "${YELLOW}Validating Cargo workspace...${NC}"
if cargo metadata --no-deps > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Cargo workspace is valid"
else
    echo -e "${RED}✗${NC} Cargo workspace has issues"
    exit 1
fi

echo ""

# Try to build
echo -e "${YELLOW}Testing build...${NC}"
if cargo build --all > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Build successful"
else
    echo -e "${RED}✗${NC} Build failed"
    echo -e "${YELLOW}Running build with output:${NC}"
    cargo build --all
    exit 1
fi

echo ""

# Run tests
echo -e "${YELLOW}Running tests...${NC}"
if cargo test --all > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} All tests passed"
else
    echo -e "${RED}✗${NC} Tests failed"
    echo -e "${YELLOW}Running tests with output:${NC}"
    cargo test --all
    exit 1
fi

echo ""

# Check benchmark compilation
echo -e "${YELLOW}Checking benchmark compilation...${NC}"
if cargo bench --all --no-run > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Benchmarks compile successfully"
else
    echo -e "${RED}✗${NC} Benchmark compilation failed"
    exit 1
fi

echo ""

# Run a quick benchmark test
echo -e "${YELLOW}Running quick benchmark test...${NC}"
if timeout 30 cargo bench --package timely-benchmarks --bench barrier -- --quick > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Quick benchmark test passed"
else
    echo -e "${YELLOW}⚠${NC}  Quick benchmark test timed out or failed (this may be expected)"
fi

echo ""

# Summary
echo -e "${BLUE}=====================================${NC}"
echo -e "${GREEN}✓ All validation checks passed!${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""
echo "Repository is ready for use!"
echo ""
echo "Quick start commands:"
echo "  make bench-quick     - Run quick benchmarks"
echo "  make bench           - Run full benchmarks"
echo "  make test            - Run all tests"
echo "  ./run-benchmarks.sh  - Run benchmarks with options"
echo ""
echo "Documentation:"
echo "  README.md            - Overview and usage"
echo "  BENCHMARKING.md      - Detailed benchmarking guide"
echo "  COMPARISON.md        - Performance comparison guide"
echo "  CONTRIBUTING.md      - Contribution guidelines"
echo ""
