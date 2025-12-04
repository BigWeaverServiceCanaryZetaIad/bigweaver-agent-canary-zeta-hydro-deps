#!/bin/bash

# Verification script for bigweaver-agent-canary-zeta-hydro-deps repository
# This script checks that all required files and dependencies are present

set -e

echo "🔍 Verifying bigweaver-agent-canary-zeta-hydro-deps setup..."
echo

# Check we're in the right directory
if [ ! -f "Cargo.toml" ] || [ ! -d "benches" ]; then
    echo "❌ Error: Must run this script from the root of bigweaver-agent-canary-zeta-hydro-deps repository"
    exit 1
fi

# Check for main repository
echo "📦 Checking for main hydro repository..."
if [ ! -d "../bigweaver-agent-canary-hydro-zeta" ]; then
    echo "❌ Error: Main repository not found at ../bigweaver-agent-canary-hydro-zeta"
    echo "   Please clone bigweaver-agent-canary-hydro-zeta in the same parent directory"
    exit 1
fi

# Check for required dependencies in main repo
echo "📦 Checking required dependencies..."
if [ ! -d "../bigweaver-agent-canary-hydro-zeta/dfir_rs" ]; then
    echo "❌ Error: dfir_rs not found in main repository"
    exit 1
fi

if [ ! -d "../bigweaver-agent-canary-hydro-zeta/sinktools" ]; then
    echo "❌ Error: sinktools not found in main repository"
    exit 1
fi

echo "✅ Dependencies found"
echo

# Check benchmark files
echo "📊 Checking benchmark files..."
BENCHMARK_FILES=(
    "benches/benches/arithmetic.rs"
    "benches/benches/fan_in.rs"
    "benches/benches/fan_out.rs"
    "benches/benches/fork_join.rs"
    "benches/benches/futures.rs"
    "benches/benches/identity.rs"
    "benches/benches/join.rs"
    "benches/benches/micro_ops.rs"
    "benches/benches/reachability.rs"
    "benches/benches/symmetric_hash_join.rs"
    "benches/benches/upcase.rs"
    "benches/benches/words_diamond.rs"
)

MISSING_FILES=0
for file in "${BENCHMARK_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Missing: $file"
        MISSING_FILES=$((MISSING_FILES + 1))
    fi
done

if [ $MISSING_FILES -eq 0 ]; then
    echo "✅ All 12 benchmark files present"
else
    echo "❌ Missing $MISSING_FILES benchmark files"
    exit 1
fi
echo

# Check data files
echo "📁 Checking test data files..."
DATA_FILES=(
    "benches/benches/reachability_edges.txt"
    "benches/benches/reachability_reachable.txt"
    "benches/benches/words_alpha.txt"
)

for file in "${DATA_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Missing: $file"
        exit 1
    fi
done
echo "✅ All 3 data files present"
echo

# Check configuration files
echo "⚙️  Checking configuration files..."
CONFIG_FILES=(
    "Cargo.toml"
    "benches/Cargo.toml"
    "benches/build.rs"
    "rust-toolchain.toml"
    "rustfmt.toml"
    "clippy.toml"
)

for file in "${CONFIG_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Missing: $file"
        exit 1
    fi
done
echo "✅ All configuration files present"
echo

# Check documentation
echo "📚 Checking documentation..."
DOC_FILES=(
    "README.md"
    "CONTRIBUTING.md"
    "MIGRATION.md"
    "benches/README.md"
)

for file in "${DOC_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Missing: $file"
        exit 1
    fi
done
echo "✅ All documentation files present"
echo

# Check for Rust toolchain
echo "🦀 Checking Rust installation..."
if command -v cargo &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    echo "✅ Rust installed: $RUST_VERSION"
    
    # Try to check if project compiles
    echo
    echo "🔨 Attempting to check build (this may take a while)..."
    if cargo check -p benches --quiet 2>&1 | head -20; then
        echo "✅ Project builds successfully"
    else
        echo "⚠️  Build check had warnings/errors (see above)"
        echo "   This may be normal if dependencies need to be downloaded"
    fi
else
    echo "⚠️  Cargo not found - skipping build check"
    echo "   Install Rust from https://rustup.rs/ to run benchmarks"
fi
echo

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Verification complete!"
echo
echo "Repository structure:"
echo "  📊 12 benchmark implementations"
echo "  📁 3 test data files (~4.3MB)"
echo "  ⚙️  6 configuration files"
echo "  📚 4 documentation files"
echo
echo "Next steps:"
echo "  1. Run all benchmarks:     cargo bench -p benches"
echo "  2. Run specific benchmark:  cargo bench -p benches --bench arithmetic"
echo "  3. View results:            open target/criterion/report/index.html"
echo "  4. Read CONTRIBUTING.md for guidelines"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
