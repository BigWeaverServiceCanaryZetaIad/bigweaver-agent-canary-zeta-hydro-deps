#!/bin/bash
# Performance comparison script for dataflow implementations
# This script runs benchmarks and generates comparison reports

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPS_REPO="$(dirname "$SCRIPT_DIR")"
MAIN_REPO="$DEPS_REPO/../bigweaver-agent-canary-hydro-zeta"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "═══════════════════════════════════════════════════════"
echo "  Dataflow Performance Comparison"
echo "═══════════════════════════════════════════════════════"
echo ""

# Check if main repository exists
if [ ! -d "$MAIN_REPO" ]; then
    echo -e "${RED}Error: Main repository not found at $MAIN_REPO${NC}"
    echo ""
    echo "This script requires both repositories to be cloned side-by-side:"
    echo "  parent-directory/"
    echo "    ├── bigweaver-agent-canary-hydro-zeta/"
    echo "    └── bigweaver-agent-canary-zeta-hydro-deps/"
    echo ""
    echo "Please clone the main repository:"
    echo "  cd $(dirname "$DEPS_REPO")"
    echo "  git clone <repo-url>/bigweaver-agent-canary-hydro-zeta.git"
    exit 1
fi

echo -e "${GREEN}✓${NC} Found main repository at: $MAIN_REPO"
echo -e "${GREEN}✓${NC} Found deps repository at: $DEPS_REPO"
echo ""

# Check if path dependencies are configured
CARGO_TOML="$DEPS_REPO/timely-differential-benches/Cargo.toml"
if grep -q "^# babyflow = { path =" "$CARGO_TOML"; then
    echo -e "${YELLOW}⚠${NC}  Path dependencies are commented out in Cargo.toml"
    echo ""
    read -p "Do you want to uncomment them now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Uncomment path dependencies
        sed -i 's/^# babyflow = { path =/babyflow = { path =/' "$CARGO_TOML"
        sed -i 's/^# dfir_rs = { path =/dfir_rs = { path =/' "$CARGO_TOML"
        sed -i 's/^# hydroflow = { path =/hydroflow = { path =/' "$CARGO_TOML"
        sed -i 's/^# spinachflow = { path =/spinachflow = { path =/' "$CARGO_TOML"
        sed -i 's/^# sinktools = { path =/sinktools = { path =/' "$CARGO_TOML"
        echo -e "${GREEN}✓${NC} Path dependencies enabled"
    else
        echo -e "${YELLOW}⚠${NC}  Running with path dependencies commented out"
        echo "   Only timely/differential benchmarks will run"
    fi
    echo ""
fi

# Parse command line arguments
BASELINE=""
SAVE_BASELINE=""
BENCHMARK=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --baseline)
            BASELINE="--baseline $2"
            shift 2
            ;;
        --save-baseline)
            SAVE_BASELINE="--save-baseline $2"
            shift 2
            ;;
        --bench)
            BENCHMARK="--bench $2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--baseline NAME] [--save-baseline NAME] [--bench BENCHMARK]"
            exit 1
            ;;
    esac
done

# Run benchmarks
echo "Running benchmarks..."
echo "─────────────────────────────────────────────────────"
cd "$DEPS_REPO"

if [ -n "$BENCHMARK" ]; then
    echo "Running specific benchmark: $BENCHMARK"
    cargo bench $BENCHMARK $SAVE_BASELINE $BASELINE
else
    echo "Running all benchmarks"
    cargo bench $SAVE_BASELINE $BASELINE
fi

echo ""
echo "─────────────────────────────────────────────────────"
echo -e "${GREEN}✓${NC} Benchmarks complete!"
echo ""
echo "Results:"
echo "  - Console output above"
echo "  - HTML report: target/criterion/report/index.html"
echo ""

# Open HTML report if available
REPORT="$DEPS_REPO/target/criterion/report/index.html"
if [ -f "$REPORT" ]; then
    echo "To view the HTML report:"
    echo "  open $REPORT"
    echo ""
    
    # Try to open automatically on macOS or Linux
    if command -v open &> /dev/null; then
        read -p "Open HTML report now? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            open "$REPORT"
        fi
    elif command -v xdg-open &> /dev/null; then
        read -p "Open HTML report now? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            xdg-open "$REPORT"
        fi
    fi
fi

echo "═══════════════════════════════════════════════════════"
echo "  Comparison Complete"
echo "═══════════════════════════════════════════════════════"
