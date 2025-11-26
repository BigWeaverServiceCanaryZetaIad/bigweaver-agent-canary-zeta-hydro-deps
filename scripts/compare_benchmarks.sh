#!/bin/bash
# Script to compare benchmark performance between the hydro-deps repository
# and the main hydro repository (if benchmarks still exist there)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HYDRO_DEPS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
HYDRO_MAIN_DIR="${HYDRO_MAIN_DIR:-../../bigweaver-agent-canary-hydro-zeta}"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Hydro Benchmark Comparison Tool ===${NC}\n"

# Function to display usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -b, --baseline NAME       Baseline name for comparison (default: 'baseline')"
    echo "  -n, --new NAME           New benchmark name (default: 'current')"
    echo "  -f, --filter PATTERN     Only run benchmarks matching pattern"
    echo "  -m, --main-repo PATH     Path to main hydro repository"
    echo "  -h, --help               Show this help message"
    echo ""
    echo "Environment Variables:"
    echo "  HYDRO_MAIN_DIR           Path to main hydro repository (default: ../../bigweaver-agent-canary-hydro-zeta)"
    echo ""
    echo "Examples:"
    echo "  $0                                           # Run all benchmarks with default names"
    echo "  $0 --filter arithmetic                       # Run only arithmetic benchmarks"
    echo "  $0 --baseline old --new optimized            # Compare 'old' vs 'optimized' baselines"
    exit 1
}

# Default values
BASELINE_NAME="baseline"
NEW_NAME="current"
FILTER=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -b|--baseline)
            BASELINE_NAME="$2"
            shift 2
            ;;
        -n|--new)
            NEW_NAME="$2"
            shift 2
            ;;
        -f|--filter)
            FILTER="$2"
            shift 2
            ;;
        -m|--main-repo)
            HYDRO_MAIN_DIR="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Check if hydro-deps directory exists
if [ ! -d "$HYDRO_DEPS_DIR" ]; then
    echo -e "${YELLOW}Error: Hydro-deps directory not found: $HYDRO_DEPS_DIR${NC}"
    exit 1
fi

echo -e "${GREEN}Step 1: Running benchmarks in hydro-deps repository${NC}"
echo "Repository: $HYDRO_DEPS_DIR"
echo "Baseline name: $NEW_NAME"
echo ""

cd "$HYDRO_DEPS_DIR"

if [ -n "$FILTER" ]; then
    echo "Running benchmarks with filter: $FILTER"
    cargo bench -p benches --bench "$FILTER" -- --save-baseline "$NEW_NAME"
else
    echo "Running all benchmarks"
    cargo bench -p benches -- --save-baseline "$NEW_NAME"
fi

echo -e "\n${GREEN}✓ Benchmarks completed in hydro-deps repository${NC}\n"

# Check if main repository exists and has benchmarks
if [ -d "$HYDRO_MAIN_DIR" ] && [ -f "$HYDRO_MAIN_DIR/benches/Cargo.toml" ]; then
    echo -e "${YELLOW}Note: Benchmarks found in main repository${NC}"
    echo "If you want to compare with the main repository, run benchmarks there manually:"
    echo ""
    echo "  cd $HYDRO_MAIN_DIR"
    echo "  cargo bench -p benches -- --save-baseline $BASELINE_NAME"
    echo ""
    echo "Then compare using Criterion's comparison tools."
else
    echo -e "${BLUE}Note: No benchmarks found in main repository (as expected after migration)${NC}"
fi

# Check if baseline exists for comparison
CRITERION_DIR="$HYDRO_DEPS_DIR/target/criterion"
if [ -d "$CRITERION_DIR" ]; then
    echo -e "\n${GREEN}Benchmark results saved to: $CRITERION_DIR${NC}"
    echo ""
    echo "To view results:"
    echo "  - Open: $CRITERION_DIR/<benchmark_name>/report/index.html"
    echo "  - Or use: cargo bench -p benches -- --baseline $NEW_NAME"
    echo ""
    
    # Check if we can do a comparison
    if [ -d "$CRITERION_DIR" ] && ls "$CRITERION_DIR"/*/base 2>/dev/null | grep -q .; then
        echo -e "${YELLOW}Tip: To compare with previous baseline, run:${NC}"
        echo "  cargo bench -p benches -- --baseline $BASELINE_NAME"
    fi
else
    echo -e "\n${YELLOW}No criterion directory found. Results may be in a different location.${NC}"
fi

echo -e "\n${BLUE}=== Benchmark Comparison Complete ===${NC}"
