#!/bin/bash
# Performance Comparison Script for Hydro Benchmarks
# This script runs benchmarks comparing Hydro (dfir_rs) with timely and differential-dataflow

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
QUICK_MODE=false
SPECIFIC_BENCH=""
FILTER=""
SAVE_BASELINE=false
BASELINE_NAME="baseline"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -q|--quick)
            QUICK_MODE=true
            shift
            ;;
        -b|--bench)
            SPECIFIC_BENCH="$2"
            shift 2
            ;;
        -f|--filter)
            FILTER="$2"
            shift 2
            ;;
        -s|--save-baseline)
            SAVE_BASELINE=true
            shift
            ;;
        --baseline-name)
            BASELINE_NAME="$2"
            shift 2
            ;;
        -h|--help)
            echo "Performance Comparison Script for Hydro Benchmarks"
            echo ""
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -q, --quick              Run benchmarks in quick mode (fewer iterations)"
            echo "  -b, --bench NAME         Run specific benchmark only"
            echo "  -f, --filter PATTERN     Filter benchmarks by pattern (e.g., 'dfir', 'timely', 'differential')"
            echo "  -s, --save-baseline      Save results as baseline for future comparisons"
            echo "  --baseline-name NAME     Name for the baseline (default: 'baseline')"
            echo "  -h, --help               Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                                    # Run all benchmarks"
            echo "  $0 -q                                 # Run all benchmarks in quick mode"
            echo "  $0 -b reachability                    # Run only reachability benchmark"
            echo "  $0 -b reachability -f dfir            # Run only dfir variants of reachability"
            echo "  $0 -s --baseline-name my-baseline     # Save results as 'my-baseline'"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Print header
echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}  Hydro Performance Comparison Benchmarks${NC}"
echo -e "${BLUE}=================================================${NC}"
echo ""

# Check if main repository exists
if [ ! -d "../bigweaver-agent-canary-hydro-zeta/dfir_rs" ]; then
    echo -e "${RED}Error: Main repository not found at ../bigweaver-agent-canary-hydro-zeta${NC}"
    echo "Please ensure the main repository is checked out at the correct location"
    exit 1
fi

echo -e "${GREEN}✓ Main repository found${NC}"
echo ""

# Build configuration
echo -e "${YELLOW}Configuration:${NC}"
echo "  Quick mode: $QUICK_MODE"
echo "  Specific benchmark: ${SPECIFIC_BENCH:-all}"
echo "  Filter: ${FILTER:-none}"
echo "  Save baseline: $SAVE_BASELINE"
if [ "$SAVE_BASELINE" = true ]; then
    echo "  Baseline name: $BASELINE_NAME"
fi
echo ""

# Construct cargo command
CARGO_CMD="cargo bench -p benches-timely-differential"

if [ -n "$SPECIFIC_BENCH" ]; then
    CARGO_CMD="$CARGO_CMD --bench $SPECIFIC_BENCH"
fi

if [ "$QUICK_MODE" = true ] || [ -n "$FILTER" ]; then
    CARGO_CMD="$CARGO_CMD --"
    
    if [ "$QUICK_MODE" = true ]; then
        CARGO_CMD="$CARGO_CMD --quick"
    fi
    
    if [ -n "$FILTER" ]; then
        CARGO_CMD="$CARGO_CMD $FILTER"
    fi
fi

if [ "$SAVE_BASELINE" = true ]; then
    CARGO_CMD="$CARGO_CMD --save-baseline $BASELINE_NAME"
fi

# Run benchmarks
echo -e "${YELLOW}Running benchmarks...${NC}"
echo "Command: $CARGO_CMD"
echo ""

$CARGO_CMD

# Check exit status
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}=================================================${NC}"
    echo -e "${GREEN}  Benchmarks completed successfully!${NC}"
    echo -e "${GREEN}=================================================${NC}"
    echo ""
    echo -e "${BLUE}View detailed results:${NC}"
    echo "  HTML Report: target/criterion/report/index.html"
    echo "  Raw Data: target/criterion/"
    echo ""
    if [ "$SAVE_BASELINE" = true ]; then
        echo -e "${GREEN}Baseline saved as '$BASELINE_NAME'${NC}"
        echo "To compare future runs against this baseline:"
        echo "  cargo bench -p benches-timely-differential -- --baseline $BASELINE_NAME"
        echo ""
    fi
else
    echo ""
    echo -e "${RED}=================================================${NC}"
    echo -e "${RED}  Benchmarks failed!${NC}"
    echo -e "${RED}=================================================${NC}"
    exit 1
fi
