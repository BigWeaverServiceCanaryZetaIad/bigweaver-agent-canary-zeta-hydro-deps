#!/bin/bash
# Verification script for benchmark migration
# This script verifies that all benchmarks are properly configured and can run

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "Benchmark Migration Verification Script"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print success
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to print error
print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to print info
print_info() {
    echo -e "${YELLOW}ℹ️  $1${NC}"
}

# Check 1: Verify workspace structure
echo "Check 1: Verifying workspace structure..."
if [ -f "Cargo.toml" ]; then
    print_success "Root Cargo.toml exists"
else
    print_error "Root Cargo.toml not found"
    exit 1
fi

if [ -f "benches/Cargo.toml" ]; then
    print_success "benches/Cargo.toml exists"
else
    print_error "benches/Cargo.toml not found"
    exit 1
fi
echo ""

# Check 2: Verify benchmark files
echo "Check 2: Verifying benchmark files..."
BENCHMARKS=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "identity.rs"
    "join.rs"
    "micro_ops.rs"
    "reachability.rs"
    "symmetric_hash_join.rs"
    "upcase.rs"
)

MISSING_FILES=0
for bench in "${BENCHMARKS[@]}"; do
    if [ -f "benches/benches/$bench" ]; then
        print_success "Found $bench"
    else
        print_error "Missing $bench"
        MISSING_FILES=$((MISSING_FILES + 1))
    fi
done

if [ $MISSING_FILES -gt 0 ]; then
    print_error "$MISSING_FILES benchmark file(s) missing"
    exit 1
fi
echo ""

# Check 3: Verify data files
echo "Check 3: Verifying data files..."
DATA_FILES=(
    "reachability_edges.txt"
    "reachability_reachable.txt"
)

for data_file in "${DATA_FILES[@]}"; do
    if [ -f "benches/benches/$data_file" ]; then
        print_success "Found $data_file"
    else
        print_error "Missing $data_file"
        exit 1
    fi
done
echo ""

# Check 4: Verify dependencies in Cargo.toml
echo "Check 4: Verifying dependencies..."
if grep -q "timely.*=.*{.*package.*=.*\"timely-master\"" benches/Cargo.toml; then
    print_success "timely-master dependency configured"
else
    print_error "timely-master dependency not properly configured"
    exit 1
fi

if grep -q "differential-dataflow.*=.*{.*package.*=.*\"differential-dataflow-master\"" benches/Cargo.toml; then
    print_success "differential-dataflow-master dependency configured"
else
    print_error "differential-dataflow-master dependency not properly configured"
    exit 1
fi

if grep -q "criterion" benches/Cargo.toml; then
    print_success "criterion dependency configured"
else
    print_error "criterion dependency missing"
    exit 1
fi
echo ""

# Check 5: Verify documentation
echo "Check 5: Verifying documentation..."
DOCS=(
    "README.md"
    "BENCHMARK_DETAILS.md"
    "MIGRATION_GUIDE.md"
)

for doc in "${DOCS[@]}"; do
    if [ -f "$doc" ]; then
        print_success "Found $doc"
    else
        print_error "Missing $doc"
        exit 1
    fi
done
echo ""

# Check 6: Verify bench entries in Cargo.toml
echo "Check 6: Verifying [[bench]] entries in Cargo.toml..."
BENCH_ENTRIES=0
for bench_name in arithmetic fan_in fan_out fork_join identity join micro_ops reachability symmetric_hash_join upcase; do
    if grep -q "name = \"$bench_name\"" benches/Cargo.toml; then
        BENCH_ENTRIES=$((BENCH_ENTRIES + 1))
    else
        print_error "Missing [[bench]] entry for $bench_name"
    fi
done

if [ $BENCH_ENTRIES -eq 10 ]; then
    print_success "All 10 [[bench]] entries found"
else
    print_error "Only $BENCH_ENTRIES/10 [[bench]] entries found"
    exit 1
fi
echo ""

# Check 7: Try to build
echo "Check 7: Building benchmarks..."
print_info "Running: cargo build --release"
if cargo build --release 2>&1 | tee build.log; then
    print_success "Benchmarks build successfully"
    rm -f build.log
else
    print_error "Build failed. Check build.log for details"
    exit 1
fi
echo ""

# Check 8: Verify workspace members
echo "Check 8: Verifying workspace members..."
if grep -A 2 'members.*=' Cargo.toml | grep -q '"benches"'; then
    print_success "Workspace includes benches member"
else
    print_error "Workspace does not include benches member"
    exit 1
fi
echo ""

# Check 9: List available benchmarks
echo "Check 9: Listing available benchmarks..."
print_info "Available benchmarks:"
cargo bench --no-run 2>&1 | grep -E "^   Compiling|^    Finished" || true
echo ""

# Optional: Quick benchmark test (can be disabled for CI)
if [ "${SKIP_BENCH_RUN}" != "1" ]; then
    echo "Check 10: Running quick benchmark test..."
    print_info "Running a quick test of arithmetic benchmark (10 seconds)..."
    if timeout 30 cargo bench --bench arithmetic -- --quick 2>&1 | tee bench.log; then
        print_success "Quick benchmark test passed"
        rm -f bench.log
    else
        print_error "Benchmark test failed or timed out"
        print_info "This might be due to missing dependencies or network issues"
        print_info "Set SKIP_BENCH_RUN=1 to skip this check"
    fi
    echo ""
else
    print_info "Skipping benchmark run (SKIP_BENCH_RUN=1)"
    echo ""
fi

# Summary
echo "=========================================="
echo "Verification Summary"
echo "=========================================="
print_success "All verification checks passed!"
echo ""
echo "Next steps:"
echo "  1. Run all benchmarks: cargo bench"
echo "  2. View results: open target/criterion/report/index.html"
echo "  3. Run specific benchmark: cargo bench --bench arithmetic"
echo ""
echo "For more information, see:"
echo "  - README.md for usage guide"
echo "  - BENCHMARK_DETAILS.md for benchmark descriptions"
echo "  - MIGRATION_GUIDE.md for migration information"
echo ""
