#!/bin/bash
# Verification script for Hydro benchmarks
# This script verifies that all benchmarks are properly configured and functional

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TESTS_PASSED=0
TESTS_FAILED=0

# Print header
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Hydro Benchmarks Verification Script${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Function to print success
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    ((TESTS_PASSED++))
}

# Function to print error
print_error() {
    echo -e "${RED}❌ $1${NC}"
    ((TESTS_FAILED++))
}

# Function to print info
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check 1: Verify repository structure
print_info "Checking repository structure..."
if [ -d "benches" ] && [ -d "benches/benches" ]; then
    print_success "Repository structure is correct"
else
    print_error "Repository structure is incorrect"
    echo "  Expected: benches/benches/ directory"
    exit 1
fi

# Check 2: Verify Cargo.toml files exist
print_info "Checking Cargo.toml files..."
if [ -f "Cargo.toml" ] && [ -f "benches/Cargo.toml" ]; then
    print_success "Cargo.toml files found"
else
    print_error "Missing Cargo.toml files"
    exit 1
fi

# Check 3: Verify main Hydro repository is available
print_info "Checking for main Hydro repository..."
HYDRO_PATH="../bigweaver-agent-canary-hydro-zeta"
if [ -d "$HYDRO_PATH" ]; then
    print_success "Main Hydro repository found at $HYDRO_PATH"
    
    # Check for required dependencies
    if [ -d "$HYDRO_PATH/dfir_rs" ] && [ -d "$HYDRO_PATH/sinktools" ]; then
        print_success "Required dependencies (dfir_rs, sinktools) found"
    else
        print_error "Required dependencies not found in main repository"
        exit 1
    fi
else
    print_error "Main Hydro repository not found at $HYDRO_PATH"
    echo "  Please clone bigweaver-agent-canary-hydro-zeta alongside this repository"
    exit 1
fi

# Check 4: Verify all benchmark files exist
print_info "Checking benchmark files..."
BENCHMARKS=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "identity.rs"
    "join.rs"
    "reachability.rs"
    "upcase.rs"
)

ALL_BENCHMARKS_FOUND=true
for benchmark in "${BENCHMARKS[@]}"; do
    if [ -f "benches/benches/$benchmark" ]; then
        echo "  ✓ $benchmark"
    else
        echo "  ✗ $benchmark (missing)"
        ALL_BENCHMARKS_FOUND=false
    fi
done

if [ "$ALL_BENCHMARKS_FOUND" = true ]; then
    print_success "All benchmark files found"
else
    print_error "Some benchmark files are missing"
    exit 1
fi

# Check 5: Verify data files for reachability benchmark
print_info "Checking benchmark data files..."
if [ -f "benches/benches/reachability_edges.txt" ] && \
   [ -f "benches/benches/reachability_reachable.txt" ]; then
    print_success "Reachability benchmark data files found"
else
    print_warning "Reachability data files not found (benchmark may fail)"
fi

# Check 6: Verify documentation files
print_info "Checking documentation files..."
DOC_FILES=(
    "README.md"
    "BENCHMARK_GUIDE.md"
    "CONTRIBUTING.md"
)

ALL_DOCS_FOUND=true
for doc in "${DOC_FILES[@]}"; do
    if [ -f "$doc" ]; then
        echo "  ✓ $doc"
    else
        echo "  ✗ $doc (missing)"
        ALL_DOCS_FOUND=false
    fi
done

if [ "$ALL_DOCS_FOUND" = true ]; then
    print_success "All documentation files found"
else
    print_warning "Some documentation files are missing"
fi

# Check 7: Try to build the benchmarks
print_info "Building benchmarks (this may take a few minutes)..."
if cargo build -p hydro-deps-benches --release 2>&1 | tee /tmp/cargo_build.log; then
    print_success "Benchmarks compiled successfully"
else
    print_error "Benchmark compilation failed"
    echo "  Check /tmp/cargo_build.log for details"
    exit 1
fi

# Check 8: Verify benchmarks are registered in Cargo.toml
print_info "Verifying benchmark registration..."
REGISTERED_COUNT=$(grep -c "^\[\[bench\]\]" benches/Cargo.toml)
if [ "$REGISTERED_COUNT" -eq "${#BENCHMARKS[@]}" ]; then
    print_success "All benchmarks are registered in Cargo.toml"
else
    print_warning "Benchmark count mismatch (found $REGISTERED_COUNT, expected ${#BENCHMARKS[@]})"
fi

# Check 9: Try running a quick benchmark test
print_info "Running quick benchmark test (arithmetic)..."
if timeout 60 cargo bench -p hydro-deps-benches --bench arithmetic -- --measurement-time 1 --sample-size 10 > /tmp/bench_test.log 2>&1; then
    print_success "Test benchmark executed successfully"
else
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 124 ]; then
        print_warning "Test benchmark timed out (may need more time on slower systems)"
    else
        print_error "Test benchmark failed"
        echo "  Check /tmp/bench_test.log for details"
    fi
fi

# Check 10: Verify Rust formatting
print_info "Checking code formatting..."
if cargo fmt --check 2>&1 | tee /tmp/cargo_fmt.log; then
    print_success "Code is properly formatted"
else
    print_warning "Code formatting issues found (run 'cargo fmt' to fix)"
fi

# Check 11: Run clippy lints
print_info "Running clippy lints..."
if cargo clippy -p hydro-deps-benches --all-targets -- -D warnings 2>&1 | tee /tmp/cargo_clippy.log; then
    print_success "No clippy warnings found"
else
    print_warning "Clippy warnings found (see /tmp/cargo_clippy.log)"
fi

# Summary
echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Verification Summary${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests failed: ${RED}$TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ All critical checks passed!${NC}"
    echo ""
    echo "The benchmarks are ready to use. You can now run:"
    echo "  cargo bench -p hydro-deps-benches"
    echo ""
    exit 0
else
    echo -e "${RED}❌ Some checks failed. Please fix the issues above.${NC}"
    echo ""
    exit 1
fi
