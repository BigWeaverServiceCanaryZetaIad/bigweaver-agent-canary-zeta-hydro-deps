#!/bin/bash
# Verification script for benchmarks migration

set -e

echo "==================================="
echo "Benchmark Repository Verification"
echo "==================================="
echo ""

# Check for required files
echo "Checking for required files..."
required_files=(
    "Cargo.toml"
    "build.rs"
    "README.md"
    "SETUP.md"
    "MIGRATION.md"
    "QUICK_START.md"
    ".gitignore"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file exists"
    else
        echo "✗ $file missing!"
        exit 1
    fi
done

echo ""
echo "Checking for benchmark files..."
benchmark_files=(
    "benches/arithmetic.rs"
    "benches/fan_in.rs"
    "benches/fan_out.rs"
    "benches/fork_join.rs"
    "benches/futures.rs"
    "benches/identity.rs"
    "benches/join.rs"
    "benches/micro_ops.rs"
    "benches/reachability.rs"
    "benches/symmetric_hash_join.rs"
    "benches/upcase.rs"
    "benches/words_diamond.rs"
)

for file in "${benchmark_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file exists"
    else
        echo "✗ $file missing!"
        exit 1
    fi
done

echo ""
echo "Checking for data files..."
data_files=(
    "benches/reachability_edges.txt"
    "benches/reachability_reachable.txt"
    "benches/words_alpha.txt"
)

for file in "${data_files[@]}"; do
    if [ -f "$file" ]; then
        size=$(du -h "$file" | cut -f1)
        echo "✓ $file exists ($size)"
    else
        echo "✗ $file missing!"
        exit 1
    fi
done

echo ""
echo "Checking Cargo.toml configuration..."

# Check for git dependencies
if grep -q "git = \"https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta\"" Cargo.toml; then
    echo "✓ Git dependencies configured correctly"
else
    echo "✗ Git dependencies not found in Cargo.toml"
    exit 1
fi

# Check for benchmark targets
benchmark_count=$(grep -c "^\[\[bench\]\]" Cargo.toml || true)
if [ "$benchmark_count" -eq 12 ]; then
    echo "✓ All 12 benchmark targets defined"
else
    echo "✗ Expected 12 benchmark targets, found $benchmark_count"
    exit 1
fi

echo ""
echo "==================================="
echo "✓ All verifications passed!"
echo "==================================="
echo ""
echo "To build and run benchmarks:"
echo "  cargo build"
echo "  cargo bench"
echo ""
echo "For more information, see:"
echo "  - README.md for comprehensive documentation"
echo "  - QUICK_START.md for quick reference"
echo "  - SETUP.md for detailed setup instructions"
