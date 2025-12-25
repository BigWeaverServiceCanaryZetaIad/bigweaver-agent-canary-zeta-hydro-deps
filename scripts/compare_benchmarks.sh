#!/bin/bash

# compare_benchmarks.sh
# Script to run and compare benchmarks across different dataflow implementations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
BENCH_DIR="$REPO_DIR/timely-differential-benches"
MAIN_REPO_DIR="$(dirname "$REPO_DIR")/bigweaver-agent-canary-hydro-zeta"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Benchmark Comparison Script${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if main repository exists
if [ ! -d "$MAIN_REPO_DIR" ]; then
    echo -e "${RED}Error: Main repository not found at $MAIN_REPO_DIR${NC}"
    echo -e "${YELLOW}Please clone both repositories side-by-side:${NC}"
    echo "  git clone <repo-url>/bigweaver-agent-canary-hydro-zeta.git"
    echo "  git clone <repo-url>/bigweaver-agent-canary-zeta-hydro-deps.git"
    exit 1
fi

echo -e "${GREEN}✓ Found main repository at $MAIN_REPO_DIR${NC}"

# Check if path dependencies are configured
if ! grep -q "^babyflow = { path" "$BENCH_DIR/Cargo.toml" 2>/dev/null; then
    echo -e "${YELLOW}Warning: Path dependencies not configured${NC}"
    echo -e "${YELLOW}Cross-repository benchmarks will not run.${NC}"
    echo ""
    echo "To enable cross-repository benchmarks, edit $BENCH_DIR/Cargo.toml"
    echo "and uncomment the path dependencies section."
    echo ""
    read -p "Continue with standalone benchmarks only? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Navigate to benchmark directory
cd "$BENCH_DIR"

echo ""
echo -e "${BLUE}Running benchmarks...${NC}"
echo ""

# Run benchmarks
if cargo bench --all; then
    echo ""
    echo -e "${GREEN}✓ Benchmarks completed successfully${NC}"
    echo ""
    echo -e "${BLUE}Benchmark results are saved in:${NC}"
    echo "  $BENCH_DIR/target/criterion"
    echo ""
    echo -e "${BLUE}To view detailed results:${NC}"
    echo "  1. Open $BENCH_DIR/target/criterion/report/index.html in a browser"
    echo "  2. Or check individual benchmark reports in target/criterion/<benchmark-name>/"
    echo ""
else
    echo ""
    echo -e "${RED}✗ Benchmarks failed${NC}"
    exit 1
fi

# Optional: Compare with previous results if they exist
if [ -d "$BENCH_DIR/target/criterion" ]; then
    echo -e "${BLUE}Available benchmark reports:${NC}"
    find "$BENCH_DIR/target/criterion" -name "index.html" -type f | while read -r report; do
        echo "  - $(dirname "$report")"
    done
    echo ""
fi

echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}Benchmark comparison complete!${NC}"
echo -e "${BLUE}========================================${NC}"
