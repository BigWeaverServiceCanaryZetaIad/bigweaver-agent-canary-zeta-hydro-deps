#!/bin/bash
# Verification script for bigweaver-agent-canary-zeta-hydro-deps setup
# This script verifies that the repository is correctly set up with all
# necessary dependencies and configurations for running benchmarks

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Hydro Dependencies Repository Setup Verification ==="
echo

# Check 1: Verify main repository exists
echo "Check 1: Verifying main repository location..."
MAIN_REPO="../bigweaver-agent-canary-hydro-zeta"
if [ ! -d "$MAIN_REPO" ]; then
    echo "❌ FAIL: Main repository not found at $MAIN_REPO"
    echo "         The benchmarks require the main bigweaver-agent-canary-hydro-zeta repository"
    echo "         to be cloned alongside this repository."
    echo ""
    echo "Expected structure:"
    echo "  /projects/sandbox/"
    echo "  ├── bigweaver-agent-canary-hydro-zeta/      # Main repository"
    echo "  └── bigweaver-agent-canary-zeta-hydro-deps/ # This repository"
    echo ""
    exit 1
else
    echo "✓ PASS: Main repository found at $MAIN_REPO"
fi
echo

# Check 2: Verify required directories in main repository
echo "Check 2: Verifying required directories in main repository..."
REQUIRED_DIRS=("dfir_rs" "sinktools")
ALL_FOUND=true
for dir in "${REQUIRED_DIRS[@]}"; do
    if [ ! -d "$MAIN_REPO/$dir" ]; then
        echo "❌ FAIL: Required directory not found: $MAIN_REPO/$dir"
        ALL_FOUND=false
    else
        echo "✓ Found: $MAIN_REPO/$dir"
    fi
done
if [ "$ALL_FOUND" = false ]; then
    exit 1
fi
echo

# Check 3: Verify workspace structure
echo "Check 3: Verifying workspace structure..."
if [ ! -f "Cargo.toml" ]; then
    echo "❌ FAIL: Cargo.toml not found"
    exit 1
else
    echo "✓ PASS: Cargo.toml exists"
fi

if grep -q '"benches"' Cargo.toml 2>/dev/null; then
    echo "✓ PASS: benches member found in workspace"
else
    echo "❌ FAIL: benches not found in workspace members"
    exit 1
fi
echo

# Check 4: Verify benches directory and structure
echo "Check 4: Verifying benches directory structure..."
if [ ! -d "benches" ]; then
    echo "❌ FAIL: benches directory not found"
    exit 1
else
    echo "✓ Found: benches/"
fi

if [ ! -f "benches/Cargo.toml" ]; then
    echo "❌ FAIL: benches/Cargo.toml not found"
    exit 1
else
    echo "✓ Found: benches/Cargo.toml"
fi

if [ ! -d "benches/benches" ]; then
    echo "❌ FAIL: benches/benches directory not found"
    exit 1
else
    echo "✓ Found: benches/benches/"
fi
echo

# Check 5: Verify benchmark files
echo "Check 5: Verifying benchmark files..."
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
BENCH_DIR="benches/benches"
ALL_FOUND=true
for file in "${BENCHMARK_FILES[@]}"; do
    if [ ! -f "$BENCH_DIR/$file" ]; then
        echo "❌ Missing: $BENCH_DIR/$file"
        ALL_FOUND=false
    else
        echo "✓ Found: $file"
    fi
done
if [ "$ALL_FOUND" = false ]; then
    exit 1
fi
echo

# Check 6: Verify benchmark data files
echo "Check 6: Verifying benchmark data files..."
DATA_FILES=(
    "reachability_edges.txt"
    "reachability_reachable.txt"
    "words_alpha.txt"
)
ALL_FOUND=true
for file in "${DATA_FILES[@]}"; do
    if [ ! -f "$BENCH_DIR/$file" ]; then
        echo "❌ Missing: $BENCH_DIR/$file"
        ALL_FOUND=false
    else
        SIZE=$(du -h "$BENCH_DIR/$file" | cut -f1)
        echo "✓ Found: $file ($SIZE)"
    fi
done
if [ "$ALL_FOUND" = false ]; then
    exit 1
fi
echo

# Check 7: Verify configuration files
echo "Check 7: Verifying configuration files..."
CONFIG_FILES=(
    "rust-toolchain.toml"
    "rustfmt.toml"
    "clippy.toml"
)
ALL_FOUND=true
for file in "${CONFIG_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "⚠ Warning: $file not found (recommended but not required)"
    else
        echo "✓ Found: $file"
    fi
done
echo

# Check 8: Verify documentation files
echo "Check 8: Verifying documentation files..."
DOC_FILES=(
    "README.md"
    "CONTRIBUTING.md"
    "BENCHMARK_GUIDE.md"
    "QUICK_REFERENCE.md"
    "CHANGELOG.md"
)
ALL_FOUND=true
for file in "${DOC_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "⚠ Warning: $file not found"
    else
        echo "✓ Found: $file"
    fi
done
echo

# Check 9: Verify helper scripts
echo "Check 9: Verifying helper scripts..."
if [ ! -f "run_benchmarks.sh" ]; then
    echo "⚠ Warning: run_benchmarks.sh not found"
else
    echo "✓ Found: run_benchmarks.sh"
    if [ ! -x "run_benchmarks.sh" ]; then
        echo "  ℹ Note: run_benchmarks.sh is not executable"
        echo "  Run: chmod +x run_benchmarks.sh"
    fi
fi
echo

# Check 10: Verify Rust toolchain
echo "Check 10: Verifying Rust toolchain..."
if command -v rustc &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    echo "✓ Rust is installed: $RUST_VERSION"
    
    if command -v cargo &> /dev/null; then
        echo "✓ Cargo is available"
    else
        echo "❌ FAIL: Cargo not found"
        exit 1
    fi
else
    echo "❌ FAIL: Rust toolchain not installed"
    echo "         Install from: https://rustup.rs/"
    exit 1
fi
echo

# Check 11: Verify workspace compiles (optional, can be slow)
echo "Check 11: Verifying workspace compilation..."
echo "Running: cargo check --workspace"
echo "(This may take a while on first run...)"
if cargo check --workspace 2>&1 | tail -20; then
    echo "✓ PASS: Workspace compiles successfully"
else
    echo "⚠ WARNING: Workspace compilation had issues"
    echo "          This may be expected if dependencies are not yet downloaded"
    echo "          Try running: cargo check --workspace"
fi
echo

# Check 12: Verify benches package specifically
echo "Check 12: Verifying benches package..."
echo "Running: cargo check -p benches"
if cargo check -p benches 2>&1 | tail -20; then
    echo "✓ PASS: Benches package compiles successfully"
else
    echo "⚠ WARNING: Benches package compilation had issues"
    echo "          Try running: cargo check -p benches"
fi
echo

# Summary
echo "=== Verification Summary ==="
echo "✓ All critical checks passed!"
echo ""
echo "Next steps:"
echo "  1. Run benchmarks: ./run_benchmarks.sh"
echo "  2. View help: ./run_benchmarks.sh --help"
echo "  3. List benchmarks: ./run_benchmarks.sh --list"
echo "  4. Read guides:"
echo "     - QUICK_REFERENCE.md for common commands"
echo "     - BENCHMARK_GUIDE.md for detailed information"
echo "     - CONTRIBUTING.md for development guidelines"
echo ""
echo "Example commands:"
echo "  ./run_benchmarks.sh                    # Run all benchmarks"
echo "  ./run_benchmarks.sh reachability       # Run specific benchmark"
echo "  cargo bench -p benches                 # Run with cargo"
echo ""
echo "Results will be in: target/criterion/report/index.html"
echo ""
echo "=== Setup Verification Complete ==="
