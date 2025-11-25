#!/bin/bash
# Verification script for bigweaver-agent-canary-zeta-hydro-deps setup
# This script verifies that all benchmark files and dependencies are correctly set up

set -e

echo "=========================================="
echo "Verifying bigweaver-agent-canary-zeta-hydro-deps Setup"
echo "=========================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track status
ALL_PASSED=true

# Function to check file existence
check_file() {
    local file=$1
    local description=$2
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $description: $file"
        return 0
    else
        echo -e "${RED}✗${NC} $description: $file (MISSING)"
        ALL_PASSED=false
        return 1
    fi
}

# Function to check directory existence
check_dir() {
    local dir=$1
    local description=$2
    
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $description: $dir"
        return 0
    else
        echo -e "${RED}✗${NC} $description: $dir (MISSING)"
        ALL_PASSED=false
        return 1
    fi
}

# Navigate to repository root
cd "$(dirname "$0")"
REPO_ROOT=$(pwd)

echo "Repository root: $REPO_ROOT"
echo ""

echo "Checking root configuration files..."
check_file "Cargo.toml" "Root Cargo.toml"
check_file "rust-toolchain.toml" "Rust toolchain config"
check_file "README.md" "Main README"
check_file "BENCHMARK_GUIDE.md" "Benchmark guide"
echo ""

echo "Checking benchmark directory structure..."
check_dir "benches" "Benches directory"
check_dir "benches/benches" "Benchmark implementations directory"
echo ""

echo "Checking benchmark configuration..."
check_file "benches/Cargo.toml" "Benchmark Cargo.toml"
check_file "benches/README.md" "Benchmark README"
check_file "benches/build.rs" "Build script"
echo ""

echo "Checking timely benchmark files..."
check_file "benches/benches/arithmetic.rs" "Arithmetic benchmark"
check_file "benches/benches/fan_in.rs" "Fan-in benchmark"
check_file "benches/benches/fan_out.rs" "Fan-out benchmark"
check_file "benches/benches/fork_join.rs" "Fork-join benchmark"
check_file "benches/benches/identity.rs" "Identity benchmark"
check_file "benches/benches/join.rs" "Join benchmark"
check_file "benches/benches/upcase.rs" "Upcase benchmark"
echo ""

echo "Checking differential-dataflow benchmark files..."
check_file "benches/benches/reachability.rs" "Reachability benchmark"
check_file "benches/benches/reachability_edges.txt" "Reachability edges data"
check_file "benches/benches/reachability_reachable.txt" "Reachability reachable data"
echo ""

echo "Checking dependencies in Cargo.toml..."
if grep -q "timely.*timely-master.*0.13.0-dev.1" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Timely dependency configured"
else
    echo -e "${RED}✗${NC} Timely dependency not found or incorrect"
    ALL_PASSED=false
fi

if grep -q "differential-dataflow.*differential-dataflow-master.*0.13.0-dev.1" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Differential-dataflow dependency configured"
else
    echo -e "${RED}✗${NC} Differential-dataflow dependency not found or incorrect"
    ALL_PASSED=false
fi

if grep -q "criterion.*0.5.0" benches/Cargo.toml; then
    echo -e "${GREEN}✓${NC} Criterion dependency configured"
else
    echo -e "${RED}✗${NC} Criterion dependency not found or incorrect"
    ALL_PASSED=false
fi
echo ""

echo "Counting benchmark entries in Cargo.toml..."
BENCH_COUNT=$(grep -c '\[\[bench\]\]' benches/Cargo.toml || true)
echo "Found $BENCH_COUNT benchmark entries"

EXPECTED_BENCHES=8
if [ "$BENCH_COUNT" -eq "$EXPECTED_BENCHES" ]; then
    echo -e "${GREEN}✓${NC} Expected $EXPECTED_BENCHES benchmarks, found $BENCH_COUNT"
else
    echo -e "${YELLOW}⚠${NC} Expected $EXPECTED_BENCHES benchmarks, found $BENCH_COUNT"
fi
echo ""

echo "Checking benchmark implementations use correct dependencies..."
TIMELY_BENCHES="arithmetic fan_in fan_out fork_join identity join upcase"
for bench in $TIMELY_BENCHES; do
    if grep -q "use timely" "benches/benches/${bench}.rs" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} ${bench}.rs uses timely"
    else
        echo -e "${YELLOW}⚠${NC} ${bench}.rs may not use timely"
    fi
done

if grep -q "use differential_dataflow" "benches/benches/reachability.rs" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} reachability.rs uses differential-dataflow"
else
    echo -e "${YELLOW}⚠${NC} reachability.rs may not use differential-dataflow"
fi
echo ""

echo "File size summary..."
echo "Benchmark files:"
du -sh benches/benches/*.rs 2>/dev/null | head -10

echo ""
echo "Data files:"
du -sh benches/benches/*.txt 2>/dev/null
echo ""

echo "=========================================="
if [ "$ALL_PASSED" = true ]; then
    echo -e "${GREEN}✓ All verification checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Run 'cargo check' to verify compilation"
    echo "2. Run 'cargo bench -- --test' for a quick smoke test"
    echo "3. Run 'cargo bench' for full benchmarks"
    echo "4. Review documentation in README.md and BENCHMARK_GUIDE.md"
    exit 0
else
    echo -e "${RED}✗ Some verification checks failed!${NC}"
    echo ""
    echo "Please review the errors above and fix missing or incorrect files."
    exit 1
fi
