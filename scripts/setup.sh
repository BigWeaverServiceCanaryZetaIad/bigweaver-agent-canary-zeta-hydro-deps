#!/usr/bin/env bash
# Setup script for benchmark repository
# Verifies dependencies and repository structure

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo -e "${BLUE}=== Hydro Benchmark Repository Setup ===${NC}"
echo ""

# Check for Rust/Cargo
echo -n "Checking for Rust installation... "
if command -v cargo &> /dev/null; then
    RUST_VERSION=$(cargo --version | awk '{print $2}')
    echo -e "${GREEN}✓${NC} (version $RUST_VERSION)"
else
    echo -e "${RED}✗${NC}"
    echo -e "${YELLOW}Rust is not installed. Install from: https://rustup.rs/${NC}"
    exit 1
fi

# Check for main Hydro repository
echo -n "Checking for main Hydro repository... "
MAIN_REPO="${REPO_ROOT}/../bigweaver-agent-canary-hydro-zeta"
if [ -d "$MAIN_REPO" ]; then
    echo -e "${GREEN}✓${NC}"
    
    # Check for required packages
    echo -n "Checking for dfir_rs... "
    if [ -d "$MAIN_REPO/dfir_rs" ]; then
        echo -e "${GREEN}✓${NC}"
    else
        echo -e "${RED}✗${NC}"
        echo -e "${YELLOW}Warning: dfir_rs not found in main repository${NC}"
    fi
    
    echo -n "Checking for sinktools... "
    if [ -d "$MAIN_REPO/sinktools" ]; then
        echo -e "${GREEN}✓${NC}"
    else
        echo -e "${RED}✗${NC}"
        echo -e "${YELLOW}Warning: sinktools not found in main repository${NC}"
    fi
else
    echo -e "${RED}✗${NC}"
    echo -e "${YELLOW}Main repository not found at: $MAIN_REPO${NC}"
    echo -e "${YELLOW}This repository requires the main Hydro repository to be checked out.${NC}"
    exit 1
fi

# Check benchmark files
echo -n "Checking benchmark files... "
BENCH_DIR="${REPO_ROOT}/benches/benches"
EXPECTED_BENCHMARKS=("arithmetic.rs" "fan_in.rs" "fan_out.rs" "fork_join.rs" "identity.rs" "join.rs" "reachability.rs" "upcase.rs")
MISSING_BENCHMARKS=()

for bench in "${EXPECTED_BENCHMARKS[@]}"; do
    if [ ! -f "$BENCH_DIR/$bench" ]; then
        MISSING_BENCHMARKS+=("$bench")
    fi
done

if [ ${#MISSING_BENCHMARKS[@]} -eq 0 ]; then
    echo -e "${GREEN}✓${NC} (${#EXPECTED_BENCHMARKS[@]} benchmarks found)"
else
    echo -e "${YELLOW}!${NC} (${#MISSING_BENCHMARKS[@]} missing)"
    for bench in "${MISSING_BENCHMARKS[@]}"; do
        echo -e "  ${YELLOW}Missing: $bench${NC}"
    done
fi

# Check test data files
echo -n "Checking test data files... "
EXPECTED_DATA=("reachability_edges.txt" "reachability_reachable.txt" "words_alpha.txt")
MISSING_DATA=()

for data in "${EXPECTED_DATA[@]}"; do
    if [ ! -f "$BENCH_DIR/$data" ]; then
        MISSING_DATA+=("$data")
    fi
done

if [ ${#MISSING_DATA[@]} -eq 0 ]; then
    echo -e "${GREEN}✓${NC} (${#EXPECTED_DATA[@]} data files found)"
else
    echo -e "${YELLOW}!${NC} (${#MISSING_DATA[@]} missing)"
    for data in "${MISSING_DATA[@]}"; do
        echo -e "  ${YELLOW}Missing: $data${NC}"
    done
fi

# Check Cargo.toml configuration
echo -n "Checking Cargo.toml configuration... "
if grep -q "timely-master" "${REPO_ROOT}/benches/Cargo.toml" && \
   grep -q "differential-dataflow-master" "${REPO_ROOT}/benches/Cargo.toml"; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    echo -e "${YELLOW}Warning: Missing timely or differential-dataflow dependencies${NC}"
fi

# Check for documentation
echo -n "Checking documentation... "
DOCS=("README.md" "DEVELOPMENT.md" "BENCHMARKS_COMPARISON.md")
MISSING_DOCS=()

for doc in "${DOCS[@]}"; do
    if [ ! -f "$REPO_ROOT/$doc" ]; then
        MISSING_DOCS+=("$doc")
    fi
done

if [ ${#MISSING_DOCS[@]} -eq 0 ]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}!${NC} (${#MISSING_DOCS[@]} missing)"
fi

echo ""
echo -e "${BLUE}=== Setup Summary ===${NC}"
echo ""

# Determine overall status
if [ ${#MISSING_BENCHMARKS[@]} -eq 0 ] && [ ${#MISSING_DATA[@]} -eq 0 ] && [ -d "$MAIN_REPO/dfir_rs" ]; then
    echo -e "${GREEN}✓ Repository is properly configured${NC}"
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo "  1. Run quick smoke test:"
    echo "     ./scripts/run_benchmarks.sh -m quick"
    echo ""
    echo "  2. Run all benchmarks:"
    echo "     ./scripts/run_benchmarks.sh -m all"
    echo ""
    echo "  3. View results:"
    echo "     Open target/criterion/report/index.html"
    echo ""
    exit 0
else
    echo -e "${YELLOW}! Setup has warnings${NC}"
    echo ""
    echo -e "${YELLOW}Some components are missing or misconfigured.${NC}"
    echo "Review the warnings above and fix any issues."
    echo ""
    exit 1
fi
