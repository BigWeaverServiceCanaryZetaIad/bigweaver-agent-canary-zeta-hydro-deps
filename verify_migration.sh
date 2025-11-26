#!/bin/bash
# Verification script for benchmark migration

set -e

echo "=== Benchmark Migration Verification Script ==="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print success
success() {
    echo -e "${GREEN}✓${NC} $1"
}

# Function to print error
error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to print warning
warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "Cargo.toml" ] || [ ! -d "benches" ]; then
    error "Not in the correct directory. Please run from repository root."
    exit 1
fi

echo "1. Checking repository structure..."

# Check for essential files
if [ -f "Cargo.toml" ]; then
    success "Root Cargo.toml exists"
else
    error "Root Cargo.toml missing"
    exit 1
fi

if [ -f "README.md" ]; then
    success "README.md exists"
else
    error "README.md missing"
    exit 1
fi

if [ -f "BENCHMARK_MIGRATION_SUMMARY.md" ]; then
    success "BENCHMARK_MIGRATION_SUMMARY.md exists"
else
    error "BENCHMARK_MIGRATION_SUMMARY.md missing"
    exit 1
fi

if [ -f "rust-toolchain.toml" ]; then
    success "rust-toolchain.toml exists"
else
    error "rust-toolchain.toml missing"
    exit 1
fi

if [ -f "rustfmt.toml" ]; then
    success "rustfmt.toml exists"
else
    error "rustfmt.toml missing"
    exit 1
fi

if [ -f "clippy.toml" ]; then
    success "clippy.toml exists"
else
    error "clippy.toml missing"
    exit 1
fi

if [ -f ".gitignore" ]; then
    success ".gitignore exists"
else
    warning ".gitignore missing (optional but recommended)"
fi

if [ -f "LICENSE" ]; then
    success "LICENSE exists"
else
    warning "LICENSE missing"
fi

echo ""
echo "2. Checking benches directory structure..."

if [ -d "benches" ]; then
    success "benches/ directory exists"
else
    error "benches/ directory missing"
    exit 1
fi

if [ -f "benches/Cargo.toml" ]; then
    success "benches/Cargo.toml exists"
else
    error "benches/Cargo.toml missing"
    exit 1
fi

if [ -f "benches/README.md" ]; then
    success "benches/README.md exists"
else
    error "benches/README.md missing"
    exit 1
fi

if [ -f "benches/build.rs" ]; then
    success "benches/build.rs exists"
else
    error "benches/build.rs missing"
    exit 1
fi

if [ -d "benches/benches" ]; then
    success "benches/benches/ directory exists"
else
    error "benches/benches/ directory missing"
    exit 1
fi

echo ""
echo "3. Checking benchmark files..."

# Expected benchmark files
BENCHMARK_FILES=(
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

for file in "${BENCHMARK_FILES[@]}"; do
    if [ -f "benches/benches/$file" ]; then
        success "benches/benches/$file exists"
    else
        error "benches/benches/$file missing"
        exit 1
    fi
done

echo ""
echo "4. Checking data files..."

# Expected data files
DATA_FILES=(
    "reachability_edges.txt"
    "reachability_reachable.txt"
    "words_alpha.txt"
)

for file in "${DATA_FILES[@]}"; do
    if [ -f "benches/benches/$file" ]; then
        success "benches/benches/$file exists"
    else
        error "benches/benches/$file missing"
        exit 1
    fi
done

echo ""
echo "5. Checking Cargo.toml configurations..."

# Check workspace member
if grep -q 'members = \[' Cargo.toml && grep -q '"benches"' Cargo.toml; then
    success "Workspace includes benches member"
else
    error "Workspace does not include benches member"
    exit 1
fi

# Check git dependencies in benches/Cargo.toml
if grep -q 'git = "https://github.com/hydro-project/hydro"' benches/Cargo.toml; then
    success "benches/Cargo.toml uses git dependencies"
else
    error "benches/Cargo.toml still uses path dependencies"
    exit 1
fi

# Check that path dependencies are removed
if grep -q 'path = "\.\./dfir_rs"' benches/Cargo.toml; then
    error "benches/Cargo.toml still has path dependency to dfir_rs"
    exit 1
else
    success "No path dependency to dfir_rs"
fi

if grep -q 'path = "\.\./sinktools"' benches/Cargo.toml; then
    error "benches/Cargo.toml still has path dependency to sinktools"
    exit 1
else
    success "No path dependency to sinktools"
fi

echo ""
echo "6. Checking for required dependencies..."

# Check for critical dependencies
if grep -q 'timely' benches/Cargo.toml; then
    success "timely dependency present"
else
    error "timely dependency missing"
    exit 1
fi

if grep -q 'differential-dataflow' benches/Cargo.toml; then
    success "differential-dataflow dependency present"
else
    error "differential-dataflow dependency missing"
    exit 1
fi

if grep -q 'criterion' benches/Cargo.toml; then
    success "criterion dependency present"
else
    error "criterion dependency missing"
    exit 1
fi

echo ""
echo "7. Checking benchmark configurations..."

# Count benchmark configurations
BENCH_COUNT=$(grep -c '^\[\[bench\]\]' benches/Cargo.toml || true)
if [ "$BENCH_COUNT" -eq 12 ]; then
    success "All 12 benchmark configurations present"
else
    error "Expected 12 benchmark configurations, found $BENCH_COUNT"
    exit 1
fi

echo ""
echo "8. Verifying file counts..."

RS_COUNT=$(find benches/benches -name "*.rs" | wc -l)
if [ "$RS_COUNT" -eq 12 ]; then
    success "Found 12 .rs benchmark files"
else
    error "Expected 12 .rs files, found $RS_COUNT"
    exit 1
fi

TXT_COUNT=$(find benches/benches -name "*.txt" | wc -l)
if [ "$TXT_COUNT" -eq 3 ]; then
    success "Found 3 .txt data files"
else
    error "Expected 3 .txt files, found $TXT_COUNT"
    exit 1
fi

echo ""
echo "=== Verification Complete ==="
echo ""
echo -e "${GREEN}All checks passed!${NC}"
echo ""
echo "Next steps:"
echo "1. Review the changes with: git diff --staged"
echo "2. Commit the changes"
echo "3. Create a pull request"
echo "4. Make companion changes to the source repository"
echo ""
echo "See BENCHMARK_MIGRATION_SUMMARY.md for detailed information."
