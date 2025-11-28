#!/bin/bash
# Verification script for bigweaver-agent-canary-zeta-hydro-deps repository setup

set -e

echo "==================================="
echo "Repository Setup Verification"
echo "==================================="
echo ""

# Check workspace structure
echo "✓ Checking workspace structure..."
if [ -f "Cargo.toml" ]; then
    echo "  ✓ Workspace Cargo.toml found"
else
    echo "  ✗ Workspace Cargo.toml missing"
    exit 1
fi

# Check benches package
echo "✓ Checking benches package..."
if [ -d "benches" ] && [ -f "benches/Cargo.toml" ]; then
    echo "  ✓ Benches package found"
else
    echo "  ✗ Benches package missing"
    exit 1
fi

# Count benchmark files
echo "✓ Checking benchmark files..."
BENCH_COUNT=$(find benches/benches -name "*.rs" 2>/dev/null | wc -l)
DATA_COUNT=$(find benches/benches -name "*.txt" 2>/dev/null | wc -l)
echo "  ✓ Found $BENCH_COUNT benchmark .rs files"
echo "  ✓ Found $DATA_COUNT data .txt files"

if [ "$BENCH_COUNT" -ne 12 ]; then
    echo "  ✗ Expected 12 benchmark files, found $BENCH_COUNT"
    exit 1
fi

if [ "$DATA_COUNT" -ne 3 ]; then
    echo "  ✗ Expected 3 data files, found $DATA_COUNT"
    exit 1
fi

# Check configuration files
echo "✓ Checking configuration files..."
for file in rustfmt.toml clippy.toml rust-toolchain.toml .gitignore; do
    if [ -f "$file" ]; then
        echo "  ✓ $file present"
    else
        echo "  ✗ $file missing"
        exit 1
    fi
done

# Check CI/CD
echo "✓ Checking CI/CD configuration..."
if [ -f ".github/workflows/benchmarks.yml" ]; then
    echo "  ✓ GitHub Actions workflow found"
else
    echo "  ✗ GitHub Actions workflow missing"
    exit 1
fi

# Check documentation
echo "✓ Checking documentation..."
for doc in README.md CHANGES_SUMMARY.md benches/README.md; do
    if [ -f "$doc" ]; then
        echo "  ✓ $doc present"
    else
        echo "  ✗ $doc missing"
        exit 1
    fi
done

# Check dependencies in benches Cargo.toml
echo "✓ Checking dependencies..."
if grep -q "timely" benches/Cargo.toml; then
    echo "  ✓ timely dependency found"
else
    echo "  ✗ timely dependency missing"
    exit 1
fi

if grep -q "differential-dataflow" benches/Cargo.toml; then
    echo "  ✓ differential-dataflow dependency found"
else
    echo "  ✗ differential-dataflow dependency missing"
    exit 1
fi

if grep -q "git.*bigweaver-agent-canary-hydro-zeta" benches/Cargo.toml; then
    echo "  ✓ Git dependencies configured correctly"
else
    echo "  ✗ Git dependencies not configured"
    exit 1
fi

echo ""
echo "==================================="
echo "✓ All verification checks passed!"
echo "==================================="
echo ""
echo "Repository is properly configured with:"
echo "  • $BENCH_COUNT benchmark files"
echo "  • $DATA_COUNT data files"
echo "  • Complete configuration"
echo "  • CI/CD pipeline"
echo "  • Comprehensive documentation"
echo ""
echo "You can now:"
echo "  • Run: cargo build --release -p benches"
echo "  • Test: cargo bench -p benches --bench identity -- --test"
echo "  • Benchmark: cargo bench -p benches"
echo ""
