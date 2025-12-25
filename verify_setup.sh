#!/bin/bash

# verify_setup.sh - Verify benchmark repository setup
# This script checks that all prerequisites are met for running benchmarks

set -e

echo "=========================================="
echo "Benchmark Repository Setup Verification"
echo "=========================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SUCCESS=0
WARNINGS=0
ERRORS=0

# Function to print success
print_success() {
    echo -e "${GREEN}✓${NC} $1"
    ((SUCCESS++))
}

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

# Function to print error
print_error() {
    echo -e "${RED}✗${NC} $1"
    ((ERRORS++))
}

echo "1. Checking Rust toolchain..."
if command -v rustc &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    print_success "Rust is installed: $RUST_VERSION"
else
    print_error "Rust is not installed. Install from https://rustup.rs/"
fi

if command -v cargo &> /dev/null; then
    CARGO_VERSION=$(cargo --version)
    print_success "Cargo is installed: $CARGO_VERSION"
else
    print_error "Cargo is not installed"
fi

echo ""
echo "2. Checking repository structure..."

# Check if we're in the correct directory
if [ -f "Cargo.toml" ]; then
    print_success "Found Cargo.toml in current directory"
else
    print_error "Cargo.toml not found. Are you in the correct directory?"
fi

if [ -d "benches" ]; then
    BENCH_COUNT=$(find benches -name "*.rs" | wc -l)
    print_success "Found benches directory with $BENCH_COUNT benchmark files"
else
    print_error "benches directory not found"
fi

echo ""
echo "3. Checking main repository dependencies..."

if [ -d "../bigweaver-agent-canary-hydro-zeta" ]; then
    print_success "Main repository found at ../bigweaver-agent-canary-hydro-zeta"
    
    if [ -d "../bigweaver-agent-canary-hydro-zeta/dfir_rs" ]; then
        print_success "dfir_rs dependency found"
    else
        print_error "dfir_rs not found in main repository"
    fi
    
    if [ -d "../bigweaver-agent-canary-hydro-zeta/sinktools" ]; then
        print_success "sinktools dependency found"
    else
        print_error "sinktools not found in main repository"
    fi
else
    print_error "Main repository not found at ../bigweaver-agent-canary-hydro-zeta"
    echo "         Expected directory structure:"
    echo "         /projects/sandbox/"
    echo "         ├── bigweaver-agent-canary-hydro-zeta/"
    echo "         └── bigweaver-agent-canary-zeta-hydro-deps/"
fi

echo ""
echo "4. Checking benchmark files..."

EXPECTED_BENCHMARKS=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "futures.rs"
    "identity.rs"
    "join.rs"
    "micro_ops.rs"
    "reachability.rs"
    "symmetric_hash_join.rs"
    "upcase.rs"
    "words_diamond.rs"
)

for bench in "${EXPECTED_BENCHMARKS[@]}"; do
    if [ -f "benches/$bench" ]; then
        print_success "Found benchmark: $bench"
    else
        print_error "Missing benchmark: $bench"
    fi
done

echo ""
echo "5. Checking data files..."

if [ -f "benches/reachability_edges.txt" ]; then
    SIZE=$(du -h benches/reachability_edges.txt | cut -f1)
    print_success "Found reachability_edges.txt ($SIZE)"
else
    print_error "Missing reachability_edges.txt"
fi

if [ -f "benches/reachability_reachable.txt" ]; then
    SIZE=$(du -h benches/reachability_reachable.txt | cut -f1)
    print_success "Found reachability_reachable.txt ($SIZE)"
else
    print_error "Missing reachability_reachable.txt"
fi

if [ -f "benches/words_alpha.txt" ]; then
    SIZE=$(du -h benches/words_alpha.txt | cut -f1)
    print_success "Found words_alpha.txt ($SIZE)"
else
    print_error "Missing words_alpha.txt"
fi

echo ""
echo "6. Checking documentation..."

DOCS=(
    "README.md"
    "BENCHMARK_GUIDE.md"
    "PERFORMANCE_COMPARISON.md"
    "QUICK_START.md"
    "CHANGELOG.md"
)

for doc in "${DOCS[@]}"; do
    if [ -f "$doc" ]; then
        print_success "Found documentation: $doc"
    else
        print_warning "Missing documentation: $doc"
    fi
done

echo ""
echo "7. Testing cargo commands..."

if command -v cargo &> /dev/null; then
    echo "   Checking if benchmarks can be compiled..."
    if cargo check --benches > /dev/null 2>&1; then
        print_success "Benchmarks compile successfully"
    else
        print_error "Benchmarks failed to compile. Run 'cargo check --benches' for details"
    fi
else
    print_warning "Skipping compilation check (cargo not available)"
fi

echo ""
echo "=========================================="
echo "Verification Summary"
echo "=========================================="
echo -e "${GREEN}Successes: $SUCCESS${NC}"
if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}Warnings:  $WARNINGS${NC}"
fi
if [ $ERRORS -gt 0 ]; then
    echo -e "${RED}Errors:    $ERRORS${NC}"
fi
echo ""

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ Setup verification passed!${NC}"
    echo ""
    echo "You can now run benchmarks:"
    echo "  cargo bench --bench identity    # Run simple benchmark"
    echo "  cargo bench                     # Run all benchmarks"
    echo ""
    echo "For more information, see:"
    echo "  - QUICK_START.md for getting started"
    echo "  - BENCHMARK_GUIDE.md for detailed benchmark information"
    echo "  - PERFORMANCE_COMPARISON.md for comparison strategies"
    exit 0
else
    echo -e "${RED}✗ Setup verification failed with $ERRORS error(s)${NC}"
    echo ""
    echo "Please fix the errors above before running benchmarks."
    echo "See QUICK_START.md for setup instructions."
    exit 1
fi
