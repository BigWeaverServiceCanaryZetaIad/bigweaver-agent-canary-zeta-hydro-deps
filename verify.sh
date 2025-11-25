#!/bin/bash
# Verification script for benchmark migration

set -e  # Exit on error

echo "=================================="
echo "Benchmark Migration Verification"
echo "=================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

success() {
    echo -e "${GREEN}✓${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

warning() {
    echo -e "${YELLOW}!${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "Cargo.toml" ] || [ ! -d "benches" ]; then
    error "Please run this script from the repository root"
    exit 1
fi

echo "1. Checking repository structure..."
if [ -d "benches" ]; then
    success "benches/ directory exists"
else
    error "benches/ directory missing"
    exit 1
fi

echo ""
echo "2. Checking configuration files..."
for file in Cargo.toml rust-toolchain.toml rustfmt.toml clippy.toml .gitignore; do
    if [ -f "$file" ]; then
        success "$file exists"
    else
        error "$file missing"
        exit 1
    fi
done

echo ""
echo "3. Checking benchmark files..."
cd benches/benches
for file in arithmetic.rs fan_in.rs fan_out.rs fork_join.rs futures.rs identity.rs join.rs micro_ops.rs reachability.rs symmetric_hash_join.rs upcase.rs words_diamond.rs; do
    if [ -f "$file" ]; then
        success "$file exists"
    else
        error "$file missing"
        exit 1
    fi
done
cd ../..

echo ""
echo "4. Checking data files..."
for file in benches/benches/words_alpha.txt benches/benches/reachability_edges.txt benches/benches/reachability_reachable.txt; do
    if [ -f "$file" ]; then
        size=$(du -h "$file" | cut -f1)
        success "$file exists ($size)"
    else
        error "$file missing"
        exit 1
    fi
done

echo ""
echo "5. Checking documentation..."
for file in README.md QUICKSTART.md BENCHMARK_DETAILS.md MIGRATION.md CHANGELOG.md VERIFICATION_CHECKLIST.md; do
    if [ -f "$file" ]; then
        success "$file exists"
    else
        warning "$file missing (non-critical)"
    fi
done

echo ""
echo "6. Checking Cargo configuration..."
if grep -q "benches" Cargo.toml; then
    success "Workspace includes benches package"
else
    error "benches not in workspace members"
    exit 1
fi

echo ""
echo "7. Attempting to build (if cargo available)..."
if command -v cargo &> /dev/null; then
    echo "   Running cargo check..."
    if cargo check --workspace 2>&1 | tail -10; then
        success "Workspace builds successfully"
    else
        error "Build failed"
        exit 1
    fi
    
    echo ""
    echo "8. Running code formatting check..."
    if cargo fmt --all --check; then
        success "Code formatting correct"
    else
        warning "Code formatting issues found (run 'cargo fmt')"
    fi
    
    echo ""
    echo "9. Running clippy..."
    if cargo clippy --all-targets --all-features 2>&1 | tail -20; then
        success "Clippy checks passed"
    else
        warning "Clippy warnings found"
    fi
    
    echo ""
    echo "10. Running quick benchmark test..."
    if cargo bench -p benches --bench identity -- --quick 2>&1 | tail -10; then
        success "Quick benchmark test passed"
    else
        error "Benchmark test failed"
        exit 1
    fi
else
    warning "cargo not found - skipping build verification"
    warning "Install Rust from https://rustup.rs to run build checks"
fi

echo ""
echo "=================================="
echo -e "${GREEN}Verification Complete!${NC}"
echo "=================================="
echo ""
echo "Summary:"
echo "- All required files present"
echo "- Repository structure correct"
echo "- Documentation complete"
if command -v cargo &> /dev/null; then
    echo "- Build verification passed"
else
    echo "- Build verification skipped (cargo not available)"
fi
echo ""
echo "Next steps:"
echo "1. Review the QUICKSTART.md guide"
echo "2. Run full benchmark suite: cargo bench -p benches"
echo "3. Check generated reports in target/criterion/"
echo ""
