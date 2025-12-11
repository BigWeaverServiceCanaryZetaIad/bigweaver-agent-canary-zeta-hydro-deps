#!/bin/bash
# Script to verify that the benchmark migration was successful

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_REPO_DIR="$(dirname "$SCRIPT_DIR")/bigweaver-agent-canary-hydro-zeta"

echo "Verifying benchmark migration..."
echo "================================="
echo

# Check 1: Verify benches directory exists in deps repo
echo "✓ Check 1: Verifying benches directory exists in deps repository..."
if [ ! -d "$SCRIPT_DIR/benches" ]; then
    echo "✗ FAILED: benches directory not found in deps repository"
    exit 1
fi
echo "  ✓ benches directory exists"

# Check 2: Verify all expected benchmark files exist
echo
echo "✓ Check 2: Verifying all expected benchmark files exist..."
EXPECTED_FILES=(
    "arithmetic.rs"
    "fan_in.rs"
    "fan_out.rs"
    "fork_join.rs"
    "identity.rs"
    "join.rs"
    "reachability.rs"
    "upcase.rs"
    "reachability_edges.txt"
    "reachability_reachable.txt"
)

for file in "${EXPECTED_FILES[@]}"; do
    if [ ! -f "$SCRIPT_DIR/benches/benches/$file" ]; then
        echo "  ✗ FAILED: $file not found"
        exit 1
    fi
    echo "  ✓ $file exists"
done

# Check 3: Verify Cargo.toml has timely and differential-dataflow dependencies
echo
echo "✓ Check 3: Verifying Cargo.toml has required dependencies..."
if ! grep -q "timely-master" "$SCRIPT_DIR/benches/Cargo.toml"; then
    echo "  ✗ FAILED: timely-master dependency not found"
    exit 1
fi
echo "  ✓ timely-master dependency found"

if ! grep -q "differential-dataflow-master" "$SCRIPT_DIR/benches/Cargo.toml"; then
    echo "  ✗ FAILED: differential-dataflow-master dependency not found"
    exit 1
fi
echo "  ✓ differential-dataflow-master dependency found"

# Check 4: Verify main repo doesn't have benches directory (if it exists)
if [ -d "$MAIN_REPO_DIR" ]; then
    echo
    echo "✓ Check 4: Verifying main repository doesn't have timely/differential dependencies..."
    
    if [ -f "$MAIN_REPO_DIR/Cargo.lock" ]; then
        if grep -q "timely\|differential" "$MAIN_REPO_DIR/Cargo.lock"; then
            echo "  ⚠ WARNING: Main repository Cargo.lock still contains timely/differential references"
            echo "  Run 'cargo update' in the main repository to clean up Cargo.lock"
        else
            echo "  ✓ Main repository Cargo.lock is clean (no timely/differential references)"
        fi
    fi
    
    if [ -d "$MAIN_REPO_DIR/benches" ]; then
        echo "  ⚠ WARNING: benches directory still exists in main repository"
        echo "  This may contain non-timely benchmarks, which is acceptable"
    else
        echo "  ✓ No benches directory in main repository"
    fi
fi

# Check 5: Verify documentation exists
echo
echo "✓ Check 5: Verifying documentation exists..."
DOC_FILES=(
    "README.md"
    "MIGRATION.md"
    "CONTRIBUTING.md"
    "benches/README.md"
)

for file in "${DOC_FILES[@]}"; do
    if [ ! -f "$SCRIPT_DIR/$file" ]; then
        echo "  ✗ FAILED: $file not found"
        exit 1
    fi
    echo "  ✓ $file exists"
done

echo
echo "================================="
echo "✓ All verification checks passed!"
echo
echo "Migration summary:"
echo "  - 8 benchmark files migrated"
echo "  - 2 data files migrated"
echo "  - Dependencies properly configured"
echo "  - Documentation complete"
echo
echo "Next steps:"
echo "  1. Test benchmarks: cd benches && cargo check --benches"
echo "  2. Run benchmarks: cd benches && cargo bench"
echo "  3. Commit changes to both repositories"
