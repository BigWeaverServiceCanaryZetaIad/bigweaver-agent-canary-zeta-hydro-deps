#!/usr/bin/env bash
# Verification script for bigweaver-agent-canary-zeta-hydro-deps
# This script verifies that the benchmarks can be built and run

set -e

echo "================================================"
echo "Verifying bigweaver-agent-canary-zeta-hydro-deps"
echo "================================================"
echo ""

# Check for cargo
if ! command -v cargo &> /dev/null; then
    echo "❌ Error: cargo is not installed"
    echo "Please install Rust from https://rustup.rs/"
    exit 1
fi

echo "✅ cargo found: $(cargo --version)"
echo ""

# Check Rust version
echo "Checking Rust version..."
RUST_VERSION=$(rustc --version)
echo "✅ Rust version: $RUST_VERSION"
echo ""

# Build benchmarks (without running)
echo "Building benchmarks..."
if cargo bench --no-run; then
    echo "✅ All benchmarks build successfully"
else
    echo "❌ Error: Benchmarks failed to build"
    exit 1
fi
echo ""

# List available benchmarks
echo "Available benchmarks:"
echo "  - arithmetic"
echo "  - fan_in"
echo "  - fan_out"
echo "  - fork_join"
echo "  - identity"
echo "  - join"
echo "  - reachability"
echo "  - upcase"
echo ""

# Optionally run a quick benchmark if requested
if [ "$1" == "--run" ]; then
    echo "Running arithmetic benchmark as a test..."
    if cargo bench --bench arithmetic -- --test; then
        echo "✅ Benchmark execution test passed"
    else
        echo "❌ Error: Benchmark execution test failed"
        exit 1
    fi
    echo ""
fi

echo "================================================"
echo "✅ Verification complete!"
echo "================================================"
echo ""
echo "To run benchmarks:"
echo "  cargo bench"
echo ""
echo "To run a specific benchmark:"
echo "  cargo bench --bench <benchmark_name>"
echo ""
echo "For more information, see SETUP.md"
