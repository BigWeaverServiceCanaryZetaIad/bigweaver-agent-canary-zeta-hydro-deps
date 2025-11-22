#!/usr/bin/env bash
# Run benchmark suite with various options
# This script provides convenient wrappers around cargo bench

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Default values
MODE="all"
BASELINE=""
SAVE_BASELINE=""
OUTPUT_FORMAT="default"

# Print usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Run performance comparison benchmarks for Hydro, Timely, and Differential Dataflow.

OPTIONS:
    -m, --mode MODE          Benchmark mode: all, quick, specific, patterns, operations (default: all)
    -b, --benchmark NAME     Run specific benchmark (e.g., arithmetic, reachability)
    -l, --baseline NAME      Compare against saved baseline
    -s, --save NAME          Save results as baseline with given name
    -f, --format FORMAT      Output format: default, quiet, verbose (default: default)
    -h, --help               Show this help message

BENCHMARK MODES:
    all          Run all benchmarks (comprehensive)
    quick        Run quick smoke tests (arithmetic, identity)
    specific     Run specific benchmark (requires -b flag)
    patterns     Run dataflow pattern benchmarks (fan_in, fan_out, fork_join)
    operations   Run operation benchmarks (arithmetic, join, identity, upcase)
    iterative    Run iterative benchmarks (reachability)

EXAMPLES:
    # Run all benchmarks
    $0 -m all

    # Quick smoke test
    $0 -m quick

    # Run specific benchmark
    $0 -m specific -b reachability

    # Save baseline
    $0 -m all -s main-branch

    # Compare against baseline
    $0 -m all -l main-branch

    # Run pattern benchmarks quietly
    $0 -m patterns -f quiet

EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--mode)
            MODE="$2"
            shift 2
            ;;
        -b|--benchmark)
            BENCHMARK_NAME="$2"
            shift 2
            ;;
        -l|--baseline)
            BASELINE="$2"
            shift 2
            ;;
        -s|--save)
            SAVE_BASELINE="$2"
            shift 2
            ;;
        -f|--format)
            OUTPUT_FORMAT="$2"
            shift 2
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

# Check if we're in the right directory
cd "$REPO_ROOT"

# Verify main repository is accessible
if [ ! -d "../bigweaver-agent-canary-hydro-zeta/dfir_rs" ]; then
    echo -e "${RED}Error: Main repository not found at ../bigweaver-agent-canary-hydro-zeta${NC}"
    echo -e "${YELLOW}This repository depends on dfir_rs from the main Hydro repository.${NC}"
    exit 1
fi

echo -e "${BLUE}=== Hydro Performance Comparison Benchmarks ===${NC}"
echo -e "${BLUE}Repository: bigweaver-agent-canary-zeta-hydro-deps${NC}"
echo -e "${BLUE}Mode: ${MODE}${NC}"
echo ""

# Build benchmark command
BENCH_CMD="cargo bench -p benches"

# Add output format flags
case $OUTPUT_FORMAT in
    quiet)
        BENCH_CMD="$BENCH_CMD -q"
        ;;
    verbose)
        BENCH_CMD="$BENCH_CMD --verbose"
        ;;
esac

# Add baseline flags if specified
if [ -n "$BASELINE" ]; then
    BENCH_CMD="$BENCH_CMD -- --baseline $BASELINE"
    echo -e "${YELLOW}Comparing against baseline: ${BASELINE}${NC}"
fi

if [ -n "$SAVE_BASELINE" ]; then
    BENCH_CMD="$BENCH_CMD -- --save-baseline $SAVE_BASELINE"
    echo -e "${YELLOW}Saving results as baseline: ${SAVE_BASELINE}${NC}"
fi

echo ""

# Execute benchmarks based on mode
case $MODE in
    all)
        echo -e "${GREEN}Running all benchmarks...${NC}"
        echo "This will take several minutes."
        echo ""
        eval "$BENCH_CMD"
        ;;
    
    quick)
        echo -e "${GREEN}Running quick smoke tests...${NC}"
        echo "Testing: arithmetic, identity"
        echo ""
        eval "$BENCH_CMD --bench arithmetic --bench identity"
        ;;
    
    specific)
        if [ -z "${BENCHMARK_NAME:-}" ]; then
            echo -e "${RED}Error: Specific benchmark name required with -b flag${NC}"
            usage
            exit 1
        fi
        echo -e "${GREEN}Running specific benchmark: ${BENCHMARK_NAME}${NC}"
        echo ""
        eval "$BENCH_CMD --bench $BENCHMARK_NAME"
        ;;
    
    patterns)
        echo -e "${GREEN}Running dataflow pattern benchmarks...${NC}"
        echo "Testing: fan_in, fan_out, fork_join"
        echo ""
        eval "$BENCH_CMD --bench fan_in --bench fan_out --bench fork_join"
        ;;
    
    operations)
        echo -e "${GREEN}Running operation benchmarks...${NC}"
        echo "Testing: arithmetic, join, identity, upcase"
        echo ""
        eval "$BENCH_CMD --bench arithmetic --bench join --bench identity --bench upcase"
        ;;
    
    iterative)
        echo -e "${GREEN}Running iterative benchmarks...${NC}"
        echo "Testing: reachability"
        echo ""
        eval "$BENCH_CMD --bench reachability"
        ;;
    
    *)
        echo -e "${RED}Error: Unknown mode: ${MODE}${NC}"
        usage
        exit 1
        ;;
esac

# Success message
echo ""
echo -e "${GREEN}=== Benchmarks Complete ===${NC}"
echo -e "${BLUE}Results location: ${REPO_ROOT}/target/criterion/${NC}"
echo ""
echo -e "To view HTML reports, open:"
echo -e "  ${REPO_ROOT}/target/criterion/report/index.html"
echo ""

# Show summary of available reports
if [ -d "${REPO_ROOT}/target/criterion" ]; then
    echo -e "${BLUE}Available benchmark reports:${NC}"
    find "${REPO_ROOT}/target/criterion" -name "index.html" -type f | \
        grep -v "/report/index.html" | \
        sed "s|${REPO_ROOT}/target/criterion/||" | \
        sed 's|/index.html||' | \
        sort | \
        head -20 | \
        sed 's/^/  - /'
    echo ""
fi

exit 0
