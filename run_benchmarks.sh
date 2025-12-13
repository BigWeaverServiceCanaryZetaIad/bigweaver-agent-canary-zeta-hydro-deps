#!/bin/bash
# Script to run benchmarks comparing DFIR with timely/differential-dataflow

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Hydro Benchmark Runner${NC}"
echo "================================"

# Check if main repository exists
MAIN_REPO="../bigweaver-agent-canary-hydro-zeta"
if [ ! -d "$MAIN_REPO" ]; then
    echo -e "${RED}Error: Main repository not found at $MAIN_REPO${NC}"
    echo "Please ensure both repositories are cloned as siblings:"
    echo "  /projects/"
    echo "    ├── bigweaver-agent-canary-hydro-zeta/"
    echo "    └── bigweaver-agent-canary-zeta-hydro-deps/"
    exit 1
fi

echo -e "${GREEN}✓${NC} Found main repository at $MAIN_REPO"

# Navigate to benches directory
cd benches

# Parse command line arguments
BENCH_FILTER="${1:-}"

if [ -z "$BENCH_FILTER" ]; then
    echo ""
    echo "Running all benchmarks..."
    echo "Tip: You can filter benchmarks by passing an argument:"
    echo "  $0 fan_in          # Run only fan_in benchmarks"
    echo "  $0 fan_in/hydroflow # Run only DFIR implementation"
    echo "  $0 fan_in/timely    # Run only timely implementation"
    echo ""
    cargo bench
else
    echo ""
    echo "Running benchmarks matching: $BENCH_FILTER"
    echo ""
    cargo bench "$BENCH_FILTER"
fi

echo ""
echo -e "${GREEN}Benchmarks complete!${NC}"
echo "Results are in target/criterion/"
echo "Open target/criterion/report/index.html to view detailed results"
