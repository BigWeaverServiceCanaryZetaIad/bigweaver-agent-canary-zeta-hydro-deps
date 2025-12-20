#!/usr/bin/env bash
# Cross-Repository Benchmark Comparison Script
#
# This script facilitates running and comparing benchmarks between:
# - bigweaver-agent-canary-hydro-zeta (DFIR-native benchmarks)
# - bigweaver-agent-canary-zeta-hydro-deps (Timely/Differential comparison benchmarks)
#
# Usage:
#   ./compare_benchmarks.sh [benchmark_name]
#
# Examples:
#   ./compare_benchmarks.sh              # Run all available benchmarks
#   ./compare_benchmarks.sh reachability # Run only reachability benchmarks

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Repository paths (adjust if needed)
HYDRO_REPO="${HYDRO_REPO:-../bigweaver-agent-canary-hydro-zeta}"
DEPS_REPO="${DEPS_REPO:-../bigweaver-agent-canary-zeta-hydro-deps}"

# Benchmark to run (empty for all)
BENCHMARK="${1:-}"

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Cross-Repository Benchmark Comparison${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""

# Function to check if a directory exists
check_repo() {
    local repo_path="$1"
    local repo_name="$2"
    
    if [ ! -d "$repo_path" ]; then
        echo -e "${RED}✗ Error: $repo_name repository not found at: $repo_path${NC}"
        echo -e "${YELLOW}  Set environment variable to override location:${NC}"
        echo -e "${YELLOW}  export ${repo_name^^}_REPO=/path/to/repo${NC}"
        return 1
    fi
    echo -e "${GREEN}✓ Found $repo_name repository${NC}"
    return 0
}

# Check repositories exist
echo "Checking repository locations..."
check_repo "$HYDRO_REPO" "Hydro" || exit 1
check_repo "$DEPS_REPO" "Deps" || exit 1
echo ""

# Function to run benchmarks in a repository
run_benchmarks() {
    local repo_path="$1"
    local repo_name="$2"
    local bench_name="$3"
    
    echo -e "${BLUE}─────────────────────────────────────────────────────────${NC}"
    echo -e "${BLUE}Running benchmarks in: ${repo_name}${NC}"
    echo -e "${BLUE}─────────────────────────────────────────────────────────${NC}"
    
    cd "$repo_path"
    
    if [ -z "$bench_name" ]; then
        echo -e "${YELLOW}Running all benchmarks...${NC}"
        cargo bench --all
    else
        echo -e "${YELLOW}Running benchmark: ${bench_name}${NC}"
        cargo bench --bench "$bench_name" 2>&1 || {
            echo -e "${YELLOW}Note: Benchmark '$bench_name' not found in $repo_name${NC}"
            return 0
        }
    fi
    
    echo ""
}

# Display benchmark availability
echo "Available Benchmarks by Repository:"
echo ""
echo -e "${GREEN}DFIR-Native Benchmarks${NC} (in bigweaver-agent-canary-hydro-zeta):"
echo "  • micro_ops            - Micro-operations performance"
echo "  • futures              - Futures-based operations"
echo "  • symmetric_hash_join  - Symmetric hash join implementation"
echo "  • words_diamond        - Word processing diamond pattern"
echo ""
echo -e "${GREEN}Comparison Benchmarks${NC} (in bigweaver-agent-canary-zeta-hydro-deps):"
echo "  • arithmetic           - Arithmetic operations (Timely/Differential/DFIR)"
echo "  • fan_in               - Fan-in pattern (Timely/Differential/DFIR)"
echo "  • fan_out              - Fan-out pattern (Timely/Differential/DFIR)"
echo "  • fork_join            - Fork-join pattern (Timely/Differential/DFIR)"
echo "  • identity             - Identity operation (Timely/Differential/DFIR)"
echo "  • join                 - Join operation (Timely/Differential/DFIR)"
echo "  • reachability         - Graph reachability (Timely/Differential/DFIR)"
echo "  • upcase               - String transformation (Timely/Differential/DFIR)"
echo ""

# Run benchmarks in comparison repository
if [ -z "$BENCHMARK" ]; then
    echo -e "${YELLOW}Running all comparison benchmarks...${NC}"
    echo ""
fi

run_benchmarks "$DEPS_REPO" "bigweaver-agent-canary-zeta-hydro-deps" "$BENCHMARK"

# If no specific benchmark was requested, also run DFIR-native benchmarks
if [ -z "$BENCHMARK" ]; then
    run_benchmarks "$HYDRO_REPO" "bigweaver-agent-canary-hydro-zeta" ""
fi

echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Benchmark execution completed${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo "Benchmark results are available in:"
echo "  • $DEPS_REPO/target/criterion/"
echo "  • $HYDRO_REPO/target/criterion/"
echo ""
echo "View HTML reports by opening:"
echo "  • file://$DEPS_REPO/target/criterion/report/index.html"
echo "  • file://$HYDRO_REPO/target/criterion/report/index.html"
