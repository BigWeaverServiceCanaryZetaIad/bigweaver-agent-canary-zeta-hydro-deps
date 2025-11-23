#!/bin/bash
# Verification script for benchmark setup

set -e

echo "=========================================="
echo "Benchmark Repository Verification Script"
echo "=========================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
    fi
}

# Check for required files
echo "Checking required files..."
echo ""

FILES=(
    "Cargo.toml"
    "rust-toolchain.toml"
    "README.md"
    "BENCHMARKS.md"
    "src/lib.rs"
    ".gitignore"
)

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        print_status 0 "$file exists"
    else
        print_status 1 "$file is missing"
        exit 1
    fi
done

echo ""
echo "Checking benchmark files..."
echo ""

BENCHMARK_FILES=(
    "benches/arithmetic.rs"
    "benches/fan_in.rs"
    "benches/fan_out.rs"
    "benches/fork_join.rs"
    "benches/identity.rs"
    "benches/join.rs"
    "benches/reachability.rs"
    "benches/upcase.rs"
)

for file in "${BENCHMARK_FILES[@]}"; do
    if [ -f "$file" ]; then
        print_status 0 "$file exists"
    else
        print_status 1 "$file is missing"
        exit 1
    fi
done

echo ""
echo "Checking test data files..."
echo ""

DATA_FILES=(
    "benches/reachability_edges.txt"
    "benches/reachability_reachable.txt"
)

for file in "${DATA_FILES[@]}"; do
    if [ -f "$file" ]; then
        size=$(du -h "$file" | cut -f1)
        print_status 0 "$file exists ($size)"
    else
        print_status 1 "$file is missing"
        exit 1
    fi
done

echo ""
echo "Verifying Cargo.toml configuration..."
echo ""

# Check for required dependencies
REQUIRED_DEPS=(
    "timely"
    "differential-dataflow"
    "dfir_rs"
    "criterion"
)

for dep in "${REQUIRED_DEPS[@]}"; do
    if grep -q "$dep" Cargo.toml; then
        print_status 0 "Dependency '$dep' found in Cargo.toml"
    else
        print_status 1 "Dependency '$dep' missing from Cargo.toml"
        exit 1
    fi
done

echo ""
echo "Verifying benchmark declarations..."
echo ""

BENCHMARKS=(
    "arithmetic"
    "fan_in"
    "fan_out"
    "fork_join"
    "identity"
    "join"
    "reachability"
    "upcase"
)

for bench in "${BENCHMARKS[@]}"; do
    if grep -q "name = \"$bench\"" Cargo.toml; then
        print_status 0 "Benchmark '$bench' declared in Cargo.toml"
    else
        print_status 1 "Benchmark '$bench' missing from Cargo.toml"
        exit 1
    fi
done

echo ""
echo "=========================================="
echo -e "${GREEN}All verification checks passed!${NC}"
echo "=========================================="
echo ""

# Check if cargo is available
if command -v cargo &> /dev/null; then
    echo "Rust toolchain detected. Running additional checks..."
    echo ""
    
    echo "Checking benchmark compilation..."
    if cargo check --benches --quiet 2>&1; then
        print_status 0 "All benchmarks compile successfully"
    else
        print_status 1 "Benchmark compilation failed"
        echo ""
        echo "Run 'cargo check --benches' for detailed error messages"
        exit 1
    fi
    
    echo ""
    echo "You can now run benchmarks with:"
    echo "  cargo bench                    # Run all benchmarks"
    echo "  cargo bench --bench arithmetic # Run specific benchmark"
    echo "  cargo bench -- --quick         # Quick mode for testing"
else
    echo -e "${YELLOW}Note:${NC} Rust toolchain not detected in PATH"
    echo "Install Rust to compile and run benchmarks: https://rustup.rs/"
fi

echo ""
echo "For more information, see:"
echo "  - README.md for overview and quick start"
echo "  - BENCHMARKS.md for detailed benchmark guide"
echo ""
