#!/bin/bash
# Script to compare performance between main repository and deps repository
#
# This script runs benchmarks in both repositories and generates a comparison report.
#
# Usage:
#   ./compare_with_main_repo.sh [main_repo_path]
#
# If main_repo_path is not provided, assumes ../bigweaver-agent-canary-hydro-zeta

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MAIN_REPO="${1:-$SCRIPT_DIR/../bigweaver-agent-canary-hydro-zeta}"
RESULTS_DIR="$SCRIPT_DIR/benchmark_results"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Cross-Repository Benchmark Comparison                    ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Verify main repository exists
if [ ! -d "$MAIN_REPO" ]; then
    echo -e "${YELLOW}Error: Main repository not found at: $MAIN_REPO${NC}"
    echo "Please provide the correct path to bigweaver-agent-canary-hydro-zeta"
    echo ""
    echo "Usage: $0 [path_to_main_repo]"
    exit 1
fi

echo -e "${BLUE}Main repository:${NC} $MAIN_REPO"
echo -e "${BLUE}Deps repository:${NC} $SCRIPT_DIR"
echo ""

# Create results directory
mkdir -p "$RESULTS_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
COMPARISON_DIR="$RESULTS_DIR/comparison_$TIMESTAMP"
mkdir -p "$COMPARISON_DIR"

echo -e "${GREEN}Step 1: Running benchmarks in main repository${NC}"
echo "════════════════════════════════════════════════════════════"
cd "$MAIN_REPO"

# Run dfir_rs benchmarks if they exist
if [ -d "dfir_rs" ]; then
    echo "Running dfir_rs benchmarks..."
    cd dfir_rs
    cargo bench --no-fail-fast 2>&1 | tee "$COMPARISON_DIR/main_dfir_rs.txt" || true
    cd ..
fi

# Run hydro_test benchmarks if they exist
if [ -d "hydro_test" ]; then
    echo "Running hydro_test benchmarks..."
    cd hydro_test
    cargo test --release paxos_bench 2>&1 | tee "$COMPARISON_DIR/main_hydro_test.txt" || true
    cd ..
fi

echo ""
echo -e "${GREEN}Step 2: Running benchmarks in deps repository${NC}"
echo "════════════════════════════════════════════════════════════"
cd "$SCRIPT_DIR"

# Check if deps repository has any benchmarks
if ! grep -q "benchmarks/" Cargo.toml 2>/dev/null; then
    echo -e "${YELLOW}Note: No benchmark crates configured in deps repository yet.${NC}"
    echo "The deps repository is ready but no benchmarks have been added."
else
    echo "Running all deps repository benchmarks..."
    cargo bench --all --no-fail-fast 2>&1 | tee "$COMPARISON_DIR/deps_all.txt" || true
fi

echo ""
echo -e "${GREEN}Step 3: Generating comparison report${NC}"
echo "════════════════════════════════════════════════════════════"

# Create comparison report
cat > "$COMPARISON_DIR/COMPARISON_REPORT.md" << EOF
# Benchmark Comparison Report

Generated: $(date)

## Repositories

- **Main Repository**: $MAIN_REPO
- **Deps Repository**: $SCRIPT_DIR

## Main Repository Results

### dfir_rs benchmarks
\`\`\`
$(cat "$COMPARISON_DIR/main_dfir_rs.txt" 2>/dev/null | tail -30 || echo "No results found")
\`\`\`

### hydro_test benchmarks
\`\`\`
$(cat "$COMPARISON_DIR/main_hydro_test.txt" 2>/dev/null | tail -30 || echo "No results found")
\`\`\`

## Deps Repository Results

### All benchmarks
\`\`\`
$(cat "$COMPARISON_DIR/deps_all.txt" 2>/dev/null | tail -30 || echo "No benchmarks configured yet")
\`\`\`

## Summary

- Main repository benchmarks: Use criterion and standard testing
- Deps repository benchmarks: Designed for timely/differential-dataflow dependencies
- Current status: Deps repository is structured and ready for benchmark migration

## Next Steps

1. Review individual benchmark outputs in the comparison directory
2. Check HTML reports in target/criterion/ directories
3. If performance regressions are found, investigate specific benchmarks
4. Consider moving heavy benchmarks to deps repository if build times are affected

## Files

All detailed outputs are saved in:
$COMPARISON_DIR

EOF

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Comparison Complete                                       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Results saved to: $COMPARISON_DIR"
echo ""
echo "View the comparison report:"
echo "  cat $COMPARISON_DIR/COMPARISON_REPORT.md"
echo ""
echo "View detailed outputs:"
echo "  ls -la $COMPARISON_DIR"
echo ""
