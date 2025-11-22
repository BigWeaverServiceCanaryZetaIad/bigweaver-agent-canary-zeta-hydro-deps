#!/bin/bash
# Verification script for timely and differential-dataflow benchmark migration

set -e

echo "=========================================="
echo "Migration Verification Script"
echo "=========================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track overall success
VERIFICATION_PASSED=true

# Function to print success message
success() {
    echo -e "${GREEN}✓${NC} $1"
}

# Function to print failure message
failure() {
    echo -e "${RED}✗${NC} $1"
    VERIFICATION_PASSED=false
}

# Function to print warning message
warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

echo "Verifying destination repository (bigweaver-agent-canary-zeta-hydro-deps)..."
echo ""

# Check if we're in the correct directory
DEST_REPO="/projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps"
if [ ! -d "$DEST_REPO" ]; then
    failure "Destination repository not found at $DEST_REPO"
    exit 1
fi

cd "$DEST_REPO"

# Check workspace Cargo.toml exists
if [ -f "Cargo.toml" ]; then
    success "Workspace Cargo.toml exists"
else
    failure "Workspace Cargo.toml not found"
fi

# Check documentation files exist
DOCS=("README.md" "MIGRATION_NOTES.md" "REMOVAL_SUMMARY.md" "CHANGES_README.md")
for doc in "${DOCS[@]}"; do
    if [ -f "$doc" ]; then
        success "Documentation file $doc exists"
    else
        failure "Documentation file $doc not found"
    fi
done

# Check benches directory structure
if [ -d "benches" ]; then
    success "benches/ directory exists"
else
    failure "benches/ directory not found"
fi

if [ -f "benches/Cargo.toml" ]; then
    success "benches/Cargo.toml exists"
else
    failure "benches/Cargo.toml not found"
fi

if [ -f "benches/README.md" ]; then
    success "benches/README.md exists"
else
    failure "benches/README.md not found"
fi

# Check benchmark source files
BENCHMARKS=("arithmetic.rs" "fan_in.rs" "fan_out.rs" "fork_join.rs" "identity.rs" "join.rs" "reachability.rs" "upcase.rs")
echo ""
echo "Checking migrated benchmark files..."
for bench in "${BENCHMARKS[@]}"; do
    if [ -f "benches/benches/$bench" ]; then
        success "Benchmark $bench exists"
    else
        failure "Benchmark $bench not found"
    fi
done

# Check data files
echo ""
echo "Checking data files..."
DATA_FILES=("reachability_edges.txt" "reachability_reachable.txt" ".gitignore")
for data in "${DATA_FILES[@]}"; do
    if [ -f "benches/benches/$data" ]; then
        success "Data file $data exists"
    else
        failure "Data file $data not found"
    fi
done

# Verify Cargo.toml contains required dependencies
echo ""
echo "Checking benches/Cargo.toml configuration..."
if grep -q "timely-differential-benches" "benches/Cargo.toml"; then
    success "Package name is correctly set to 'timely-differential-benches'"
else
    failure "Package name not correctly set in benches/Cargo.toml"
fi

if grep -q "timely.*timely-master" "benches/Cargo.toml"; then
    success "Timely dependency configured"
else
    failure "Timely dependency not found in benches/Cargo.toml"
fi

if grep -q "differential-dataflow.*differential-dataflow-master" "benches/Cargo.toml"; then
    success "Differential-dataflow dependency configured"
else
    failure "Differential-dataflow dependency not found in benches/Cargo.toml"
fi

# Count benchmark declarations
BENCH_COUNT=$(grep -c '^\[\[bench\]\]' benches/Cargo.toml || true)
if [ "$BENCH_COUNT" -eq 8 ]; then
    success "All 8 benchmarks declared in Cargo.toml"
else
    failure "Expected 8 benchmark declarations, found $BENCH_COUNT"
fi

# Check source repository
echo ""
echo "=========================================="
echo "Verifying source repository (bigweaver-agent-canary-hydro-zeta)..."
echo "=========================================="
echo ""

SOURCE_REPO="/projects/sandbox/bigweaver-agent-canary-hydro-zeta"
if [ ! -d "$SOURCE_REPO" ]; then
    failure "Source repository not found at $SOURCE_REPO"
    exit 1
fi

cd "$SOURCE_REPO"

# Check that migrated files have been removed
echo "Checking that migrated files were removed from source..."
for bench in "${BENCHMARKS[@]}"; do
    if [ -f "benches/benches/$bench" ]; then
        warning "Benchmark $bench still exists in source repository (should be removed)"
    else
        success "Benchmark $bench removed from source repository"
    fi
done

# Check that data files were removed (except those still needed)
if [ -f "benches/benches/reachability_edges.txt" ]; then
    warning "reachability_edges.txt still exists in source repository (should be removed)"
else
    success "reachability_edges.txt removed from source repository"
fi

if [ -f "benches/benches/reachability_reachable.txt" ]; then
    warning "reachability_reachable.txt still exists in source repository (should be removed)"
else
    success "reachability_reachable.txt removed from source repository"
fi

# Check that retained files still exist
echo ""
echo "Checking that retained benchmarks still exist in source..."
RETAINED=("futures.rs" "micro_ops.rs" "symmetric_hash_join.rs" "words_diamond.rs" "words_alpha.txt")
for retained in "${RETAINED[@]}"; do
    if [ -f "benches/benches/$retained" ]; then
        success "Retained file $retained still exists"
    else
        failure "Retained file $retained not found (should still exist)"
    fi
done

# Summary
echo ""
echo "=========================================="
echo "Verification Summary"
echo "=========================================="
echo ""

if [ "$VERIFICATION_PASSED" = true ]; then
    success "All verification checks passed!"
    echo ""
    echo "Next steps:"
    echo "1. Update benches/Cargo.toml in source repository to remove timely/differential dependencies"
    echo "2. Update benches/Cargo.toml to remove benchmark declarations for migrated benchmarks"
    echo "3. Update benches/README.md in source repository with migration notes"
    echo "4. Test that both repositories build successfully"
    echo "5. Run benchmarks in both repositories to verify functionality"
    exit 0
else
    failure "Some verification checks failed. Please review the output above."
    exit 1
fi
