#!/bin/bash

# Verification script for bigweaver-agent-canary-zeta-hydro-deps repository
# This script checks that all necessary files are present and properly configured

set -e

echo "========================================="
echo "Hydro Dependencies Repository Verification"
echo "========================================="
echo ""

ERRORS=0
WARNINGS=0

# Function to check if a file exists
check_file() {
    local file=$1
    local required=$2
    if [ -f "$file" ]; then
        echo "✅ Found: $file"
    else
        if [ "$required" = "required" ]; then
            echo "❌ MISSING (required): $file"
            ((ERRORS++))
        else
            echo "⚠️  MISSING (optional): $file"
            ((WARNINGS++))
        fi
    fi
}

# Function to check if a directory exists
check_dir() {
    local dir=$1
    local required=$2
    if [ -d "$dir" ]; then
        echo "✅ Found directory: $dir"
    else
        if [ "$required" = "required" ]; then
            echo "❌ MISSING directory (required): $dir"
            ((ERRORS++))
        else
            echo "⚠️  MISSING directory (optional): $dir"
            ((WARNINGS++))
        fi
    fi
}

echo "Checking root files..."
check_file "README.md" "required"
check_file "Cargo.toml" "required"
check_file "MIGRATION.md" "required"
check_file "QUICKSTART.md" "required"
check_file "CONTRIBUTING.md" "required"
check_file ".gitignore" "required"
check_file "rust-toolchain.toml" "required"
check_file "rustfmt.toml" "required"
check_file "clippy.toml" "required"

echo ""
echo "Checking benches directory..."
check_dir "benches" "required"
check_file "benches/Cargo.toml" "required"
check_file "benches/README.md" "required"
check_file "benches/build.rs" "required"

echo ""
echo "Checking benchmark implementations..."
check_dir "benches/benches" "required"
check_file "benches/benches/.gitignore" "required"
check_file "benches/benches/arithmetic.rs" "required"
check_file "benches/benches/fan_in.rs" "required"
check_file "benches/benches/fan_out.rs" "required"
check_file "benches/benches/fork_join.rs" "required"
check_file "benches/benches/futures.rs" "required"
check_file "benches/benches/identity.rs" "required"
check_file "benches/benches/join.rs" "required"
check_file "benches/benches/micro_ops.rs" "required"
check_file "benches/benches/reachability.rs" "required"
check_file "benches/benches/symmetric_hash_join.rs" "required"
check_file "benches/benches/upcase.rs" "required"
check_file "benches/benches/words_diamond.rs" "required"

echo ""
echo "Checking test data files..."
check_file "benches/benches/reachability_edges.txt" "required"
check_file "benches/benches/reachability_reachable.txt" "required"
check_file "benches/benches/words_alpha.txt" "required"

echo ""
echo "Checking Cargo.toml workspace structure..."
if grep -q '^\[workspace\]' Cargo.toml; then
    echo "✅ Workspace section found"
else
    echo "❌ Workspace section missing"
    ((ERRORS++))
fi

if grep -q '"benches"' Cargo.toml; then
    echo "✅ Benches member configured"
else
    echo "❌ Benches not in workspace members"
    ((ERRORS++))
fi

echo ""
echo "Checking benches/Cargo.toml dependencies..."
if grep -q 'timely' benches/Cargo.toml; then
    echo "✅ Timely dependency found"
else
    echo "❌ Timely dependency missing"
    ((ERRORS++))
fi

if grep -q 'differential-dataflow' benches/Cargo.toml; then
    echo "✅ Differential-dataflow dependency found"
else
    echo "❌ Differential-dataflow dependency missing"
    ((ERRORS++))
fi

if grep -q 'dfir_rs' benches/Cargo.toml; then
    echo "✅ dfir_rs dependency found"
else
    echo "❌ dfir_rs dependency missing"
    ((ERRORS++))
fi

if grep -q 'criterion' benches/Cargo.toml; then
    echo "✅ Criterion dependency found"
else
    echo "❌ Criterion dependency missing"
    ((ERRORS++))
fi

echo ""
echo "Checking benchmark registrations in benches/Cargo.toml..."
BENCHMARKS=(arithmetic fan_in fan_out fork_join futures identity join micro_ops reachability symmetric_hash_join upcase words_diamond)
for bench in "${BENCHMARKS[@]}"; do
    if grep -q "name = \"$bench\"" benches/Cargo.toml; then
        echo "✅ Benchmark registered: $bench"
    else
        echo "❌ Benchmark not registered: $bench"
        ((ERRORS++))
    fi
done

echo ""
echo "Verifying file sizes..."
WORDS_SIZE=$(stat -f%z benches/benches/words_alpha.txt 2>/dev/null || stat -c%s benches/benches/words_alpha.txt 2>/dev/null || echo 0)
if [ "$WORDS_SIZE" -gt 3000000 ]; then
    echo "✅ words_alpha.txt has expected size (~3.8MB)"
else
    echo "⚠️  words_alpha.txt may be incomplete (expected ~3.8MB, found $WORDS_SIZE bytes)"
    ((WARNINGS++))
fi

EDGES_SIZE=$(stat -f%z benches/benches/reachability_edges.txt 2>/dev/null || stat -c%s benches/benches/reachability_edges.txt 2>/dev/null || echo 0)
if [ "$EDGES_SIZE" -gt 500000 ]; then
    echo "✅ reachability_edges.txt has expected size (~533KB)"
else
    echo "⚠️  reachability_edges.txt may be incomplete (expected ~533KB, found $EDGES_SIZE bytes)"
    ((WARNINGS++))
fi

echo ""
echo "========================================="
echo "Verification Summary"
echo "========================================="
echo "Errors: $ERRORS"
echo "Warnings: $WARNINGS"
echo ""

if [ $ERRORS -eq 0 ]; then
    echo "✅ All required checks passed!"
    if [ $WARNINGS -gt 0 ]; then
        echo "⚠️  Some optional warnings were found, but the repository should be functional."
    fi
    echo ""
    echo "Next steps:"
    echo "  1. Try building: cargo build --release -p benches"
    echo "  2. Run a sample benchmark: cargo bench -p benches --bench identity"
    echo "  3. See QUICKSTART.md for more commands"
    exit 0
else
    echo "❌ Verification failed with $ERRORS error(s)"
    echo ""
    echo "Please fix the errors above before proceeding."
    exit 1
fi
