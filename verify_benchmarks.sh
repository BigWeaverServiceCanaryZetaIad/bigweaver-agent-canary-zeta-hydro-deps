#!/bin/bash
# Verification script for benchmark migration
# This script verifies that all migrated benchmarks are present and functional

set -e

echo "=========================================="
echo "Benchmark Migration Verification Script"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for passed/failed checks
PASSED=0
FAILED=0

# Function to print success
success() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED++))
}

# Function to print failure
failure() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED++))
}

# Function to print info
info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

echo "Step 1: Checking repository structure..."
echo "----------------------------------------"

# Check that benches directory exists
if [ -d "benches" ]; then
    success "benches/ directory exists"
else
    failure "benches/ directory not found"
    exit 1
fi

# Check that benches/benches directory exists
if [ -d "benches/benches" ]; then
    success "benches/benches/ directory exists"
else
    failure "benches/benches/ directory not found"
    exit 1
fi

echo ""
echo "Step 2: Checking configuration files..."
echo "----------------------------------------"

# Check for Cargo.toml files
if [ -f "Cargo.toml" ]; then
    success "Workspace Cargo.toml exists"
else
    failure "Workspace Cargo.toml not found"
fi

if [ -f "benches/Cargo.toml" ]; then
    success "benches/Cargo.toml exists"
else
    failure "benches/Cargo.toml not found"
fi

# Check for README files
if [ -f "README.md" ]; then
    success "Root README.md exists"
else
    failure "Root README.md not found"
fi

if [ -f "benches/README.md" ]; then
    success "benches/README.md exists"
else
    failure "benches/README.md not found"
fi

# Check for documentation files
if [ -f "BENCHMARK_MIGRATION.md" ]; then
    success "BENCHMARK_MIGRATION.md exists"
else
    failure "BENCHMARK_MIGRATION.md not found"
fi

if [ -f "CONTRIBUTING.md" ]; then
    success "CONTRIBUTING.md exists"
else
    failure "CONTRIBUTING.md not found"
fi

# Check for build script
if [ -f "benches/build.rs" ]; then
    success "benches/build.rs exists"
else
    failure "benches/build.rs not found"
fi

echo ""
echo "Step 3: Checking benchmark files..."
echo "----------------------------------------"

# Expected benchmark files
BENCHMARKS=("arithmetic.rs" "fan_in.rs" "fan_out.rs" "fork_join.rs" "identity.rs" "join.rs" "reachability.rs" "upcase.rs")

for bench in "${BENCHMARKS[@]}"; do
    if [ -f "benches/benches/$bench" ]; then
        success "Benchmark file $bench exists"
    else
        failure "Benchmark file $bench not found"
    fi
done

echo ""
echo "Step 4: Checking data files..."
echo "----------------------------------------"

# Expected data files
DATA_FILES=("reachability_edges.txt" "reachability_reachable.txt" "words_alpha.txt")

for data_file in "${DATA_FILES[@]}"; do
    if [ -f "benches/benches/$data_file" ]; then
        success "Data file $data_file exists"
        # Check file size
        size=$(stat -f%z "benches/benches/$data_file" 2>/dev/null || stat -c%s "benches/benches/$data_file" 2>/dev/null || echo "0")
        if [ "$size" -gt 0 ]; then
            info "  Size: $(numfmt --to=iec-i --suffix=B $size 2>/dev/null || echo "${size} bytes")"
        fi
    else
        failure "Data file $data_file not found"
    fi
done

echo ""
echo "Step 5: Verifying Cargo.toml benchmark declarations..."
echo "----------------------------------------"

for bench in "${BENCHMARKS[@]}"; do
    bench_name="${bench%.rs}"
    if grep -q "name = \"$bench_name\"" benches/Cargo.toml; then
        success "Benchmark '$bench_name' declared in Cargo.toml"
    else
        failure "Benchmark '$bench_name' not declared in Cargo.toml"
    fi
done

echo ""
echo "Step 6: Checking dependencies in Cargo.toml..."
echo "----------------------------------------"

# Check for required dependencies
REQUIRED_DEPS=("timely" "differential-dataflow" "criterion" "dfir_rs")

for dep in "${REQUIRED_DEPS[@]}"; do
    if grep -q "$dep" benches/Cargo.toml; then
        success "Dependency '$dep' found in Cargo.toml"
    else
        failure "Dependency '$dep' not found in Cargo.toml"
    fi
done

echo ""
echo "Step 7: Attempting to check compilation..."
echo "----------------------------------------"

info "Running 'cargo check -p benches'..."
if cargo check -p benches 2>&1 | tee /tmp/cargo_check.log; then
    success "Compilation check passed"
else
    failure "Compilation check failed"
    info "Check /tmp/cargo_check.log for details"
fi

echo ""
echo "Step 8: Listing available benchmarks..."
echo "----------------------------------------"

info "Running 'cargo bench -p benches --list'..."
if cargo bench -p benches --list > /tmp/bench_list.txt 2>&1; then
    success "Benchmark list generated"
    echo ""
    info "Available benchmarks:"
    cat /tmp/bench_list.txt | grep -E "^[[:space:]]*[a-z_]+" | sed 's/^/  /'
else
    failure "Could not list benchmarks"
fi

echo ""
echo "=========================================="
echo "Verification Summary"
echo "=========================================="
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All verification checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Run a quick benchmark to verify functionality:"
    echo "     cargo bench -p benches --bench identity"
    echo ""
    echo "  2. Run all benchmarks:"
    echo "     cargo bench -p benches"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Some verification checks failed.${NC}"
    echo "Please review the failures above and fix them before proceeding."
    echo ""
    exit 1
fi
