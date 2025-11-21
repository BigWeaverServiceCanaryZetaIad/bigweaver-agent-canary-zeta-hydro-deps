#!/bin/bash
# Verification script for benchmark repository setup

set -e

echo "=========================================="
echo "Benchmark Repository Verification"
echo "=========================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} Found: $1"
        return 0
    else
        echo -e "${RED}✗${NC} Missing: $1"
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} Found: $1"
        return 0
    else
        echo -e "${RED}✗${NC} Missing: $1"
        return 1
    fi
}

ERRORS=0

echo "1. Checking Core Files"
echo "----------------------"
check_file "Cargo.toml" || ((ERRORS++))
check_file "README.md" || ((ERRORS++))
check_file "BENCHMARKS.md" || ((ERRORS++))
check_file "CONTRIBUTING.md" || ((ERRORS++))
check_file "CHANGES.txt" || ((ERRORS++))
check_file "LICENSE" || ((ERRORS++))
check_file ".gitignore" || ((ERRORS++))
echo ""

echo "2. Checking Rust Configuration"
echo "-------------------------------"
check_file "rust-toolchain.toml" || ((ERRORS++))
check_file "rustfmt.toml" || ((ERRORS++))
check_file "clippy.toml" || ((ERRORS++))
echo ""

echo "3. Checking Benchmark Files"
echo "----------------------------"
check_dir "benches" || ((ERRORS++))
check_file "benches/Cargo.toml" || ((ERRORS++))
check_file "benches/README.md" || ((ERRORS++))
check_file "benches/build.rs" || ((ERRORS++))
check_dir "benches/benches" || ((ERRORS++))

echo ""
echo "Checking individual benchmarks..."
BENCHMARKS=(
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

for bench in "${BENCHMARKS[@]}"; do
    check_file "benches/benches/$bench" || ((ERRORS++))
done
echo ""

echo "Checking data files..."
check_file "benches/benches/words_alpha.txt" || ((ERRORS++))
check_file "benches/benches/reachability_edges.txt" || ((ERRORS++))
check_file "benches/benches/reachability_reachable.txt" || ((ERRORS++))
check_file "benches/benches/.gitignore" || ((ERRORS++))
echo ""

echo "4. Checking Core Dependencies"
echo "------------------------------"
DEPS=(
    "dfir_rs"
    "dfir_lang"
    "dfir_macro"
    "lattices"
    "lattices_macro"
    "sinktools"
    "variadics"
    "variadics_macro"
)

for dep in "${DEPS[@]}"; do
    check_dir "$dep" || ((ERRORS++))
    check_file "$dep/Cargo.toml" || ((ERRORS++))
done
echo ""

echo "5. Checking Supporting Dependencies"
echo "------------------------------------"
check_dir "hydro_deploy/core" || ((ERRORS++))
check_dir "hydro_deploy/hydro_deploy_integration" || ((ERRORS++))
check_dir "hydro_build_utils" || ((ERRORS++))
check_dir "include_mdtests" || ((ERRORS++))
check_dir "example_test" || ((ERRORS++))
check_dir "multiplatform_test" || ((ERRORS++))
echo ""

echo "6. Checking CI/CD Infrastructure"
echo "---------------------------------"
check_dir ".github" || ((ERRORS++))
check_dir ".github/workflows" || ((ERRORS++))
check_file ".github/workflows/benchmark.yml" || ((ERRORS++))
check_dir ".github/gh-pages" || ((ERRORS++))
check_file ".github/gh-pages/index.md" || ((ERRORS++))
check_file ".github/gh-pages/.gitignore" || ((ERRORS++))
echo ""

echo "7. Checking Workspace Configuration"
echo "------------------------------------"
echo "Checking workspace members in Cargo.toml..."

REQUIRED_MEMBERS=(
    "benches"
    "dfir_lang"
    "dfir_macro"
    "dfir_rs"
    "example_test"
    "hydro_deploy/core"
    "hydro_deploy/hydro_deploy_integration"
    "hydro_build_utils"
    "include_mdtests"
    "lattices_macro"
    "lattices"
    "multiplatform_test"
    "sinktools"
    "variadics_macro"
    "variadics"
)

for member in "${REQUIRED_MEMBERS[@]}"; do
    if grep -q "\"$member\"" Cargo.toml; then
        echo -e "${GREEN}✓${NC} Workspace member: $member"
    else
        echo -e "${RED}✗${NC} Missing workspace member: $member"
        ((ERRORS++))
    fi
done
echo ""

echo "8. File Size Checks"
echo "-------------------"
WORDS_SIZE=$(stat -f%z "benches/benches/words_alpha.txt" 2>/dev/null || stat -c%s "benches/benches/words_alpha.txt" 2>/dev/null || echo "0")
EDGES_SIZE=$(stat -f%z "benches/benches/reachability_edges.txt" 2>/dev/null || stat -c%s "benches/benches/reachability_edges.txt" 2>/dev/null || echo "0")
REACH_SIZE=$(stat -f%z "benches/benches/reachability_reachable.txt" 2>/dev/null || stat -c%s "benches/benches/reachability_reachable.txt" 2>/dev/null || echo "0")

echo "words_alpha.txt: $(numfmt --to=iec-i --suffix=B $WORDS_SIZE 2>/dev/null || echo "$WORDS_SIZE bytes")"
echo "reachability_edges.txt: $(numfmt --to=iec-i --suffix=B $EDGES_SIZE 2>/dev/null || echo "$EDGES_SIZE bytes")"
echo "reachability_reachable.txt: $(numfmt --to=iec-i --suffix=B $REACH_SIZE 2>/dev/null || echo "$REACH_SIZE bytes")"

if [ "$WORDS_SIZE" -lt 3000000 ]; then
    echo -e "${YELLOW}⚠${NC} Warning: words_alpha.txt seems small (expected ~3.7MB)"
fi
if [ "$EDGES_SIZE" -lt 400000 ]; then
    echo -e "${YELLOW}⚠${NC} Warning: reachability_edges.txt seems small (expected ~521KB)"
fi
echo ""

echo "=========================================="
echo "Verification Summary"
echo "=========================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "The benchmark repository is properly configured."
    echo "You can now:"
    echo "  - Build: cargo build --workspace"
    echo "  - Test: cargo test --workspace"
    echo "  - Benchmark: cargo bench -p benches"
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS error(s)${NC}"
    echo ""
    echo "Please review the missing files/directories above."
    exit 1
fi
