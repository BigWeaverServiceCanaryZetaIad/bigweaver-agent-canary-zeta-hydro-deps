#!/bin/bash

# run_benchmarks.sh - Convenience script for running benchmarks
# Usage: ./run_benchmarks.sh [options]

set -e

# Default values
BENCHMARK=""
BASELINE=""
SAVE_BASELINE=""
SAMPLE_SIZE=""
MEASUREMENT_TIME=""
QUICK_MODE=false

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Help message
show_help() {
    cat << EOF
Usage: ./run_benchmarks.sh [OPTIONS]

Run benchmarks with various options and configurations.

OPTIONS:
    -b, --bench BENCHMARK    Run specific benchmark (e.g., arithmetic, identity)
    -a, --all                Run all benchmarks
    -q, --quick              Quick mode (reduced sample size and time)
    --baseline NAME          Compare against saved baseline
    --save NAME              Save results as baseline with NAME
    --sample-size N          Set sample size to N
    --measurement-time N     Set measurement time to N seconds
    -h, --help               Show this help message

EXAMPLES:
    # Run all benchmarks
    ./run_benchmarks.sh --all

    # Run specific benchmark
    ./run_benchmarks.sh --bench arithmetic

    # Quick test run
    ./run_benchmarks.sh --quick --bench identity

    # Save baseline
    ./run_benchmarks.sh --all --save initial_baseline

    # Compare against baseline
    ./run_benchmarks.sh --all --baseline initial_baseline

    # Custom sample size
    ./run_benchmarks.sh --bench arithmetic --sample-size 50

BENCHMARK OPTIONS:
    arithmetic, fan_in, fan_out, fork_join, futures, identity, join,
    micro_ops, reachability, symmetric_hash_join, upcase, words_diamond

For more information, see:
    - QUICK_START.md for getting started
    - BENCHMARK_GUIDE.md for detailed benchmark documentation
    - PERFORMANCE_COMPARISON.md for comparison strategies
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -b|--bench)
            BENCHMARK="$2"
            shift 2
            ;;
        -a|--all)
            BENCHMARK=""
            shift
            ;;
        -q|--quick)
            QUICK_MODE=true
            shift
            ;;
        --baseline)
            BASELINE="$2"
            shift 2
            ;;
        --save)
            SAVE_BASELINE="$2"
            shift 2
            ;;
        --sample-size)
            SAMPLE_SIZE="$2"
            shift 2
            ;;
        --measurement-time)
            MEASUREMENT_TIME="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Build cargo command
CARGO_CMD="cargo bench"

if [ -n "$BENCHMARK" ]; then
    CARGO_CMD="$CARGO_CMD --bench $BENCHMARK"
fi

# Build criterion arguments
CRITERION_ARGS=""

if [ "$QUICK_MODE" = true ]; then
    CRITERION_ARGS="$CRITERION_ARGS --sample-size 10 --measurement-time 1"
elif [ -n "$SAMPLE_SIZE" ] || [ -n "$MEASUREMENT_TIME" ]; then
    if [ -n "$SAMPLE_SIZE" ]; then
        CRITERION_ARGS="$CRITERION_ARGS --sample-size $SAMPLE_SIZE"
    fi
    if [ -n "$MEASUREMENT_TIME" ]; then
        CRITERION_ARGS="$CRITERION_ARGS --measurement-time $MEASUREMENT_TIME"
    fi
fi

if [ -n "$BASELINE" ]; then
    CRITERION_ARGS="$CRITERION_ARGS --baseline $BASELINE"
fi

if [ -n "$SAVE_BASELINE" ]; then
    CRITERION_ARGS="$CRITERION_ARGS --save-baseline $SAVE_BASELINE"
fi

# Add criterion args if any
if [ -n "$CRITERION_ARGS" ]; then
    CARGO_CMD="$CARGO_CMD -- $CRITERION_ARGS"
fi

# Print configuration
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Running Benchmarks${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

if [ -n "$BENCHMARK" ]; then
    echo -e "Benchmark:    ${GREEN}$BENCHMARK${NC}"
else
    echo -e "Benchmark:    ${GREEN}all${NC}"
fi

if [ "$QUICK_MODE" = true ]; then
    echo -e "Mode:         ${YELLOW}quick (reduced accuracy)${NC}"
else
    echo -e "Mode:         ${GREEN}full${NC}"
fi

if [ -n "$BASELINE" ]; then
    echo -e "Baseline:     ${GREEN}$BASELINE${NC}"
fi

if [ -n "$SAVE_BASELINE" ]; then
    echo -e "Save as:      ${GREEN}$SAVE_BASELINE${NC}"
fi

if [ -n "$SAMPLE_SIZE" ]; then
    echo -e "Sample size:  ${GREEN}$SAMPLE_SIZE${NC}"
fi

if [ -n "$MEASUREMENT_TIME" ]; then
    echo -e "Measure time: ${GREEN}${MEASUREMENT_TIME}s${NC}"
fi

echo ""
echo -e "${BLUE}Command:${NC} $CARGO_CMD"
echo ""
echo -e "${BLUE}========================================${NC}"
echo ""

# Run the command
$CARGO_CMD

# Print completion message
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✓ Benchmarks complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo "Results saved to: target/criterion/"
echo ""
echo "View HTML reports:"
if command -v open &> /dev/null; then
    echo "  open target/criterion/report/index.html"
elif command -v xdg-open &> /dev/null; then
    echo "  xdg-open target/criterion/report/index.html"
else
    echo "  Open file: target/criterion/report/index.html"
fi
echo ""

# Offer to open reports
if command -v open &> /dev/null || command -v xdg-open &> /dev/null; then
    read -p "Open HTML reports now? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v open &> /dev/null; then
            open target/criterion/report/index.html
        elif command -v xdg-open &> /dev/null; then
            xdg-open target/criterion/report/index.html
        fi
    fi
fi
