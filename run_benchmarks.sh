#!/bin/bash

# Benchmark runner script with performance comparison
# Usage: ./run_benchmarks.sh [options]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default options
RUN_TIMELY=true
RUN_DIFFERENTIAL=true
RUN_COMPARISON=true
BASELINE=""
SAMPLE_SIZE=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --timely-only)
            RUN_DIFFERENTIAL=false
            RUN_COMPARISON=false
            shift
            ;;
        --differential-only)
            RUN_TIMELY=false
            RUN_COMPARISON=false
            shift
            ;;
        --no-comparison)
            RUN_COMPARISON=false
            shift
            ;;
        --baseline)
            BASELINE="$2"
            shift 2
            ;;
        --sample-size)
            SAMPLE_SIZE="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --timely-only         Run only timely benchmarks"
            echo "  --differential-only   Run only differential benchmarks"
            echo "  --no-comparison       Skip comparison analysis"
            echo "  --baseline <name>     Compare against baseline"
            echo "  --sample-size <n>     Set sample size for benchmarks"
            echo "  --help                Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

echo -e "${GREEN}=== Benchmark Suite Runner ===${NC}\n"

# Prepare benchmark arguments
BENCH_ARGS=""
if [ -n "$BASELINE" ]; then
    BENCH_ARGS="$BENCH_ARGS --save-baseline $BASELINE"
fi
if [ -n "$SAMPLE_SIZE" ]; then
    BENCH_ARGS="$BENCH_ARGS --sample-size $SAMPLE_SIZE"
fi

# Run Timely benchmarks
if [ "$RUN_TIMELY" = true ]; then
    echo -e "${YELLOW}Running Timely Dataflow benchmarks...${NC}"
    cargo bench -p timely-benchmarks $BENCH_ARGS
    echo -e "${GREEN}✓ Timely benchmarks complete${NC}\n"
fi

# Run Differential benchmarks
if [ "$RUN_DIFFERENTIAL" = true ]; then
    echo -e "${YELLOW}Running Differential Dataflow benchmarks...${NC}"
    cargo bench -p differential-benchmarks $BENCH_ARGS
    echo -e "${GREEN}✓ Differential benchmarks complete${NC}\n"
fi

# Build comparison tools
if [ "$RUN_COMPARISON" = true ]; then
    echo -e "${YELLOW}Building comparison tools...${NC}"
    cargo build --release -p comparison-tools
    echo -e "${GREEN}✓ Comparison tools built${NC}\n"

    echo -e "${YELLOW}Analyzing benchmark results...${NC}"
    
    # Run analysis
    if [ -d "target/criterion" ]; then
        ./target/release/analyze-results target/criterion
        echo -e "${GREEN}✓ Analysis complete${NC}\n"
        
        # Run comparison if both benchmark types were run
        if [ "$RUN_TIMELY" = true ] && [ "$RUN_DIFFERENTIAL" = true ]; then
            echo -e "${YELLOW}Comparing Timely vs Differential results...${NC}"
            ./target/release/compare-benchmarks \
                target/criterion/timely \
                target/criterion/differential || true
            echo -e "${GREEN}✓ Comparison complete${NC}\n"
        fi
    else
        echo -e "${RED}✗ No benchmark results found in target/criterion${NC}\n"
    fi
fi

# Summary
echo -e "${GREEN}=== Benchmark Suite Complete ===${NC}"
echo ""
echo "Results are available in:"
echo "  - target/criterion/          (raw data)"
echo "  - target/criterion/report/   (HTML reports)"
if [ "$RUN_COMPARISON" = true ]; then
    echo "  - benchmark_comparison.json  (comparison results)"
    echo "  - benchmark_analysis.json    (analysis results)"
fi
echo ""
echo "View HTML reports:"
echo "  open target/criterion/report/index.html"
echo ""
