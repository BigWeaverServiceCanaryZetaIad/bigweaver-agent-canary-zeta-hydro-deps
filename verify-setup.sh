#!/usr/bin/env bash
# Verification script for benchmark repository setup

set -e

echo "🔍 Verifying benchmark repository setup..."
echo ""

# Check if we're in the right directory
if [ ! -f "Cargo.toml" ] || [ ! -d "benches" ]; then
    echo "❌ Error: Must be run from bigweaver-agent-canary-zeta-hydro-deps root"
    exit 1
fi

echo "✅ In correct directory"

# Check if main hydro repository is accessible
HYDRO_PATH="../bigweaver-agent-canary-hydro-zeta"
if [ ! -d "$HYDRO_PATH" ]; then
    echo "❌ Error: Main hydro repository not found at $HYDRO_PATH"
    echo "   Please clone it: git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git"
    exit 1
fi

echo "✅ Main hydro repository found"

# Check for required dependencies in hydro repo
if [ ! -d "$HYDRO_PATH/dfir_rs" ]; then
    echo "❌ Error: dfir_rs not found in main repository"
    exit 1
fi

if [ ! -d "$HYDRO_PATH/sinktools" ]; then
    echo "❌ Error: sinktools not found in main repository"
    exit 1
fi

echo "✅ Required dependencies found in main repository"

# Check if benchmarks directory exists
if [ ! -d "benches/benches" ]; then
    echo "❌ Error: Benchmark files directory not found"
    exit 1
fi

echo "✅ Benchmark files present"

# Count benchmark files
BENCH_COUNT=$(find benches/benches -name "*.rs" -type f | wc -l)
echo "✅ Found $BENCH_COUNT benchmark files"

# Try to check if project compiles (optional, can be slow)
if command -v cargo &> /dev/null; then
    echo ""
    echo "🔨 Checking if benchmarks compile..."
    if cargo check -p benches --quiet 2>&1 | grep -q "error"; then
        echo "⚠️  Warning: Benchmark compilation check had errors"
        echo "   Run 'cargo check -p benches' for details"
    else
        echo "✅ Benchmarks compile successfully"
    fi
else
    echo "⚠️  cargo not found, skipping compilation check"
fi

echo ""
echo "✨ Setup verification complete!"
echo ""
echo "To run benchmarks:"
echo "  cargo bench -p benches                    # Run all benchmarks"
echo "  cargo bench -p benches --bench reachability  # Run specific benchmark"
