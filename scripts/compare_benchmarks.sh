#!/bin/bash
# compare_benchmarks.sh
# Script to run and compare benchmarks between timely/differential and DFIR implementations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPS_REPO_DIR="$(dirname "$SCRIPT_DIR")"
MAIN_REPO_DIR="${DEPS_REPO_DIR}/../bigweaver-agent-canary-hydro-zeta"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "Benchmark Comparison Script"
echo "=========================================="
echo ""

# Check if main repository exists
if [ ! -d "$MAIN_REPO_DIR" ]; then
    echo -e "${RED}Error: Main repository not found at $MAIN_REPO_DIR${NC}"
    echo "Please clone bigweaver-agent-canary-hydro-zeta side-by-side with this repository"
    exit 1
fi

# Check if path dependencies are configured
if ! grep -q "^dfir_rs = { path =" "$DEPS_REPO_DIR/timely-differential-benches/Cargo.toml"; then
    echo -e "${YELLOW}Warning: Path dependencies not configured in Cargo.toml${NC}"
    echo "Please uncomment the following lines in timely-differential-benches/Cargo.toml:"
    echo "  dfir_rs = { path = \"../../bigweaver-agent-canary-hydro-zeta/dfir_rs\", features = [ \"debugging\" ] }"
    echo "  sinktools = { path = \"../../bigweaver-agent-canary-hydro-zeta/sinktools\", version = \"^0.0.1\" }"
    echo ""
    read -p "Do you want to continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo -e "${GREEN}Running benchmarks in deps repository...${NC}"
cd "$DEPS_REPO_DIR/timely-differential-benches"
cargo bench --message-format=short 2>&1 | tee /tmp/deps_benchmark_output.txt

echo ""
echo "=========================================="
echo -e "${GREEN}Benchmark run complete!${NC}"
echo "=========================================="
echo ""
echo "Results are stored in:"
echo "  - $DEPS_REPO_DIR/timely-differential-benches/target/criterion/"
echo ""
echo "To view HTML reports:"
echo "  - Open $DEPS_REPO_DIR/timely-differential-benches/target/criterion/report/index.html"
echo ""
echo "To run benchmarks in the main repository for comparison:"
echo "  cd $MAIN_REPO_DIR/benches"
echo "  cargo bench"
echo ""
