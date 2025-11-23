#!/bin/bash

# Verification script for timely and differential-dataflow benchmarks
# This script verifies that all benchmarks can be built and that the benchmark
# infrastructure is working correctly.

set -e

echo "=================================================="
echo "Benchmark Verification Script"
echo "=================================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ $2${NC}"
    else
        echo -e "${RED}✗ $2${NC}"
        exit 1
    fi
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check that we're in the right directory
if [ ! -f "Cargo.toml" ]; then
    echo -e "${RED}Error: Cargo.toml not found. Please run this script from the repository root.${NC}"
    exit 1
fi

# Verify workspace structure
print_info "Verifying workspace structure..."
if grep -q 'members.*benches' Cargo.toml; then
    print_status 0 "Workspace configuration is correct"
else
    print_status 1 "Workspace configuration is missing benches member"
fi

# Check for required files
print_info "Checking required configuration files..."
for file in rust-toolchain.toml clippy.toml rustfmt.toml; do
    if [ -f "$file" ]; then
        print_status 0 "Found $file"
    else
        print_status 1 "Missing $file"
    fi
done

# Check benches directory structure
print_info "Checking benches directory structure..."
if [ -d "benches/benches" ]; then
    print_status 0 "Benchmark directory structure is correct"
else
    print_status 1 "Benchmark directory structure is incorrect"
fi

# Count benchmark files
BENCH_COUNT=$(find benches/benches -name "*.rs" -type f | wc -l)
print_info "Found $BENCH_COUNT benchmark files"

# Verify key benchmarks exist
print_info "Verifying key benchmark files..."
for bench in arithmetic reachability join fan_in fan_out identity upcase; do
    if [ -f "benches/benches/${bench}.rs" ]; then
        print_status 0 "Found ${bench}.rs"
    else
        print_status 1 "Missing ${bench}.rs"
    fi
done

# Verify data files exist
print_info "Verifying benchmark data files..."
for data in words_alpha.txt reachability_edges.txt reachability_reachable.txt; do
    if [ -f "benches/benches/${data}" ]; then
        print_status 0 "Found ${data}"
    else
        print_status 1 "Missing ${data}"
    fi
done

# Check Cargo.toml dependencies
print_info "Verifying benchmark dependencies..."
cd benches
if grep -q "timely.*timely-master" Cargo.toml; then
    print_status 0 "timely dependency configured"
else
    print_status 1 "timely dependency not found"
fi

if grep -q "differential-dataflow.*differential-dataflow-master" Cargo.toml; then
    print_status 0 "differential-dataflow dependency configured"
else
    print_status 1 "differential-dataflow dependency not found"
fi

if grep -q "dfir_rs.*git" Cargo.toml; then
    print_status 0 "dfir_rs dependency configured (git)"
else
    print_status 1 "dfir_rs dependency not configured correctly"
fi

cd ..

# Attempt to build the benchmarks
print_info "Building benchmarks (this may take a while)..."
if cargo build -p benches --benches 2>&1 | tee build.log; then
    print_status 0 "Benchmarks built successfully"
else
    print_status 1 "Benchmark build failed - check build.log for details"
fi

# Check if criterion benchmarks can be listed
print_info "Verifying benchmark harness..."
if cargo bench -p benches --no-run 2>&1 | grep -q "Finished"; then
    print_status 0 "Benchmark harness is working"
else
    print_status 1 "Benchmark harness verification failed"
fi

echo ""
echo "=================================================="
echo -e "${GREEN}All verification checks passed!${NC}"
echo "=================================================="
echo ""
echo "You can now run benchmarks with:"
echo "  cargo bench -p benches                    # Run all benchmarks"
echo "  cargo bench -p benches --bench arithmetic # Run specific benchmark"
echo ""
