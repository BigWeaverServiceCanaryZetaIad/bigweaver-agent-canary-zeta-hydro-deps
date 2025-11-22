#!/usr/bin/env bash
# Verification script for bigweaver-agent-canary-zeta-hydro-deps repository setup

set -e

echo "═══════════════════════════════════════════════════════════════"
echo "  Verification Script for Timely/Differential Benchmarks"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check counters
PASSED=0
FAILED=0

# Function to check file exists
check_file() {
    local file=$1
    local description=$2
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $description: $file"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: $file (MISSING)"
        ((FAILED++))
        return 1
    fi
}

# Function to check directory exists
check_dir() {
    local dir=$1
    local description=$2
    
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $description: $dir"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description: $dir (MISSING)"
        ((FAILED++))
        return 1
    fi
}

# Function to check file contains string
check_content() {
    local file=$1
    local pattern=$2
    local description=$3
    
    if grep -q "$pattern" "$file" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $description"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description (NOT FOUND)"
        ((FAILED++))
        return 1
    fi
}

echo "1. Checking Repository Structure"
echo "─────────────────────────────────"
check_dir "." "Root directory"
check_dir "benches" "Benches directory"
check_dir "benches/benches" "Benchmark files directory"
echo ""

echo "2. Checking Configuration Files"
echo "─────────────────────────────────"
check_file "Cargo.toml" "Workspace Cargo.toml"
check_file "benches/Cargo.toml" "Benchmarks Cargo.toml"
check_file "benches/build.rs" "Build script"
echo ""

echo "3. Checking Documentation Files"
echo "─────────────────────────────────"
check_file "README.md" "Main README"
check_file "GETTING_STARTED.md" "Getting Started guide"
check_file "PERFORMANCE_COMPARISON.md" "Performance comparison guide"
check_file "RELATIONSHIP_TO_MAIN_REPO.md" "Repository relationship docs"
check_file "CHANGELOG.md" "Changelog"
echo ""

echo "4. Checking Benchmark Files"
echo "─────────────────────────────────"
check_file "benches/benches/identity.rs" "Identity benchmark"
check_file "benches/benches/arithmetic.rs" "Arithmetic benchmark"
check_file "benches/benches/fan_in.rs" "Fan-in benchmark"
check_file "benches/benches/fan_out.rs" "Fan-out benchmark"
check_file "benches/benches/fork_join.rs" "Fork-join benchmark"
check_file "benches/benches/join.rs" "Join benchmark"
check_file "benches/benches/upcase.rs" "Upcase benchmark"
check_file "benches/benches/reachability.rs" "Reachability benchmark"
echo ""

echo "5. Checking Test Data Files"
echo "─────────────────────────────────"
check_file "benches/benches/reachability_edges.txt" "Reachability edges data"
check_file "benches/benches/reachability_reachable.txt" "Reachability expected results"
check_file "benches/benches/words_alpha.txt" "Words alpha data"
echo ""

echo "6. Checking Dependencies in Cargo.toml"
echo "─────────────────────────────────"
check_content "benches/Cargo.toml" "timely" "Timely dependency"
check_content "benches/Cargo.toml" "differential-dataflow" "Differential-Dataflow dependency"
check_content "benches/Cargo.toml" "criterion" "Criterion dependency"
echo ""

echo "7. Checking Benchmark Definitions"
echo "─────────────────────────────────"
check_content "benches/Cargo.toml" "name = \"identity\"" "Identity benchmark definition"
check_content "benches/Cargo.toml" "name = \"arithmetic\"" "Arithmetic benchmark definition"
check_content "benches/Cargo.toml" "name = \"reachability\"" "Reachability benchmark definition"
echo ""

echo "8. Checking Workspace Configuration"
echo "─────────────────────────────────"
check_content "Cargo.toml" "members" "Workspace members"
check_content "Cargo.toml" "benches" "Benches in workspace"
check_content "Cargo.toml" "edition = \"2024\"" "Rust 2024 edition"
echo ""

echo "9. Verifying Benchmark Content"
echo "─────────────────────────────────"
check_content "benches/benches/identity.rs" "benchmark_timely" "Identity has timely benchmark"
check_content "benches/benches/reachability.rs" "benchmark_timely" "Reachability has timely benchmark"
check_content "benches/benches/reachability.rs" "benchmark_differential" "Reachability has differential benchmark"
check_content "benches/benches/arithmetic.rs" "criterion_main" "Arithmetic has criterion main"
echo ""

echo "10. Checking File Sizes"
echo "─────────────────────────────────"
# Check that data files are not empty and have reasonable sizes
if [ -f "benches/benches/reachability_edges.txt" ]; then
    size=$(stat -f%z "benches/benches/reachability_edges.txt" 2>/dev/null || stat -c%s "benches/benches/reachability_edges.txt" 2>/dev/null)
    if [ "$size" -gt 100000 ]; then
        echo -e "${GREEN}✓${NC} Reachability edges file has appropriate size ($size bytes)"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} Reachability edges file seems small ($size bytes)"
    fi
fi

if [ -f "benches/benches/words_alpha.txt" ]; then
    size=$(stat -f%z "benches/benches/words_alpha.txt" 2>/dev/null || stat -c%s "benches/benches/words_alpha.txt" 2>/dev/null)
    if [ "$size" -gt 1000000 ]; then
        echo -e "${GREEN}✓${NC} Words alpha file has appropriate size ($size bytes)"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} Words alpha file seems small ($size bytes)"
    fi
fi
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  Verification Summary"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Ensure Rust toolchain is installed (edition 2024)"
    echo "  2. Run 'cargo check' to verify compilation"
    echo "  3. Run 'cargo bench --bench identity -- --test' for quick test"
    echo "  4. Run 'cargo bench' to execute all benchmarks"
    echo ""
    echo "Documentation:"
    echo "  - Getting Started: ./GETTING_STARTED.md"
    echo "  - Performance Comparison: ./PERFORMANCE_COMPARISON.md"
    echo "  - Repository Relationship: ./RELATIONSHIP_TO_MAIN_REPO.md"
    exit 0
else
    echo -e "${RED}✗ Some checks failed. Please review the output above.${NC}"
    exit 1
fi
