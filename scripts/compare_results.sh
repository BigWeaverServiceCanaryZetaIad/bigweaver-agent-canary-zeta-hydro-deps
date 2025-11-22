#!/usr/bin/env bash
# Compare benchmark results between baselines or systems
# This script helps analyze Criterion output

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Compare benchmark results and analyze performance.

OPTIONS:
    -1, --baseline1 NAME     First baseline name
    -2, --baseline2 NAME     Second baseline name
    -b, --benchmark NAME     Compare specific benchmark only
    -l, --list               List available baselines
    -r, --report             Generate comparison report
    -h, --help               Show this help message

EXAMPLES:
    # List available baselines
    $0 -l

    # Compare two baselines
    $0 -1 main -2 feature-branch

    # Compare specific benchmark
    $0 -1 main -2 feature-branch -b reachability

    # Generate full comparison report
    $0 -1 main -2 feature-branch -r

EOF
}

# Parse arguments
LIST_BASELINES=false
GENERATE_REPORT=false
BASELINE1=""
BASELINE2=""
BENCHMARK_NAME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -1|--baseline1)
            BASELINE1="$2"
            shift 2
            ;;
        -2|--baseline2)
            BASELINE2="$2"
            shift 2
            ;;
        -b|--benchmark)
            BENCHMARK_NAME="$2"
            shift 2
            ;;
        -l|--list)
            LIST_BASELINES=true
            shift
            ;;
        -r|--report)
            GENERATE_REPORT=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            usage
            exit 1
            ;;
    esac
done

cd "$REPO_ROOT"

# List baselines
if [ "$LIST_BASELINES" = true ]; then
    echo -e "${BLUE}=== Available Baselines ===${NC}"
    echo ""
    
    CRITERION_DIR="${REPO_ROOT}/target/criterion"
    
    if [ ! -d "$CRITERION_DIR" ]; then
        echo -e "${YELLOW}No benchmark results found yet.${NC}"
        echo "Run benchmarks first with: ./scripts/run_benchmarks.sh"
        exit 0
    fi
    
    # Find all baseline directories
    echo -e "${GREEN}Baselines found:${NC}"
    find "$CRITERION_DIR" -type d -name "base" -o -type d -name "new" | \
        sed "s|$CRITERION_DIR/||" | \
        sed 's|/base$||' | \
        sed 's|/new$||' | \
        sort -u | \
        sed 's/^/  - /'
    
    echo ""
    echo -e "${BLUE}Note:${NC} 'base' is the default baseline name when using --save-baseline"
    exit 0
fi

# Validate inputs for comparison
if [ -z "$BASELINE1" ] || [ -z "$BASELINE2" ]; then
    echo -e "${RED}Error: Both baseline names required for comparison${NC}"
    usage
    exit 1
fi

echo -e "${BLUE}=== Comparing Benchmark Results ===${NC}"
echo -e "Baseline 1: ${GREEN}${BASELINE1}${NC}"
echo -e "Baseline 2: ${GREEN}${BASELINE2}${NC}"

if [ -n "$BENCHMARK_NAME" ]; then
    echo -e "Benchmark: ${YELLOW}${BENCHMARK_NAME}${NC}"
fi

echo ""

# Check if baselines exist (simplified check)
CRITERION_DIR="${REPO_ROOT}/target/criterion"

if [ ! -d "$CRITERION_DIR" ]; then
    echo -e "${RED}Error: No benchmark results found${NC}"
    echo "Run benchmarks first with: ./scripts/run_benchmarks.sh"
    exit 1
fi

# Run comparison using Criterion's baseline feature
echo -e "${YELLOW}Running comparison benchmarks...${NC}"
echo ""

BENCH_CMD="cargo bench -p benches"

if [ -n "$BENCHMARK_NAME" ]; then
    BENCH_CMD="$BENCH_CMD --bench $BENCHMARK_NAME"
fi

# Compare with baseline
BENCH_CMD="$BENCH_CMD -- --baseline $BASELINE1"

echo "Command: $BENCH_CMD"
echo ""

# Note about Criterion's comparison
echo -e "${BLUE}Note:${NC} Criterion will show performance changes between current run and baseline."
echo -e "Results will be displayed with change percentages and confidence intervals."
echo ""

eval "$BENCH_CMD" || true

echo ""
echo -e "${GREEN}=== Comparison Complete ===${NC}"
echo ""

if [ "$GENERATE_REPORT" = true ]; then
    echo -e "${YELLOW}Generating comparison report...${NC}"
    
    REPORT_FILE="${REPO_ROOT}/comparison_report_${BASELINE1}_vs_${BASELINE2}.txt"
    
    {
        echo "Benchmark Comparison Report"
        echo "Generated: $(date)"
        echo "Baseline 1: $BASELINE1"
        echo "Baseline 2: $BASELINE2"
        echo ""
        echo "For detailed results, see:"
        echo "  ${CRITERION_DIR}/report/index.html"
        echo ""
        echo "Individual benchmark reports:"
        find "$CRITERION_DIR" -name "index.html" | grep -v "/report/index.html" | sed "s|$CRITERION_DIR/||" | sort
    } > "$REPORT_FILE"
    
    echo -e "${GREEN}Report saved to: ${REPORT_FILE}${NC}"
fi

echo -e "${BLUE}View HTML reports at:${NC}"
echo -e "  ${CRITERION_DIR}/report/index.html"
echo ""

exit 0
