#!/bin/bash
# Comprehensive benchmark runner script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default configuration
WORKERS=${TIMELY_WORKER_THREADS:-1}
QUICK=${QUICK:-false}
SAVE_BASELINE=${SAVE_BASELINE:-}
BASELINE=${BASELINE:-}
PACKAGE=${PACKAGE:-all}

# Help message
show_help() {
    cat << EOF
Usage: ${0##*/} [OPTIONS]

Run timely and differential-dataflow benchmarks.

OPTIONS:
    -h, --help              Show this help message
    -w, --workers N         Number of worker threads (default: 1)
    -q, --quick             Run quick benchmarks (less accurate)
    -s, --save-baseline N   Save results as baseline named N
    -b, --baseline N        Compare against baseline named N
    -p, --package PKG       Run specific package (timely, differential, or all)
    --timely-only           Run only timely benchmarks
    --differential-only     Run only differential benchmarks

EXAMPLES:
    # Run all benchmarks with default settings
    ./run-benchmarks.sh

    # Run with 4 worker threads
    ./run-benchmarks.sh --workers 4

    # Quick run for development
    ./run-benchmarks.sh --quick

    # Save baseline before optimization
    ./run-benchmarks.sh --save-baseline before-opt

    # Compare against baseline
    ./run-benchmarks.sh --baseline before-opt

    # Run only timely benchmarks
    ./run-benchmarks.sh --timely-only

EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -w|--workers)
            WORKERS="$2"
            shift 2
            ;;
        -q|--quick)
            QUICK=true
            shift
            ;;
        -s|--save-baseline)
            SAVE_BASELINE="$2"
            shift 2
            ;;
        -b|--baseline)
            BASELINE="$2"
            shift 2
            ;;
        -p|--package)
            PACKAGE="$2"
            shift 2
            ;;
        --timely-only)
            PACKAGE="timely"
            shift
            ;;
        --differential-only)
            PACKAGE="differential"
            shift
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Print configuration
echo -e "${GREEN}=== Benchmark Configuration ===${NC}"
echo "Workers: $WORKERS"
echo "Quick mode: $QUICK"
echo "Package: $PACKAGE"
[ -n "$SAVE_BASELINE" ] && echo "Save baseline: $SAVE_BASELINE"
[ -n "$BASELINE" ] && echo "Compare baseline: $BASELINE"
echo ""

# Set environment
export TIMELY_WORKER_THREADS=$WORKERS

# Build benchmark command
BENCH_CMD="cargo bench"

# Add package filter
if [ "$PACKAGE" = "timely" ]; then
    BENCH_CMD="$BENCH_CMD --package timely-benchmarks"
elif [ "$PACKAGE" = "differential" ]; then
    BENCH_CMD="$BENCH_CMD --package differential-benchmarks"
fi

# Add baseline options
BENCH_ARGS=""
if [ -n "$SAVE_BASELINE" ]; then
    BENCH_ARGS="$BENCH_ARGS --save-baseline $SAVE_BASELINE"
fi
if [ -n "$BASELINE" ]; then
    BENCH_ARGS="$BENCH_ARGS --baseline $BASELINE"
fi
if [ "$QUICK" = true ]; then
    BENCH_ARGS="$BENCH_ARGS -- --quick"
else
    BENCH_ARGS="$BENCH_ARGS --"
fi

# Run benchmarks
echo -e "${GREEN}=== Running Benchmarks ===${NC}"
echo "Command: $BENCH_CMD $BENCH_ARGS"
echo ""

if eval "$BENCH_CMD $BENCH_ARGS"; then
    echo ""
    echo -e "${GREEN}=== Benchmarks Completed Successfully ===${NC}"
    echo ""
    echo "Results are available in: target/criterion/"
    echo "Open target/criterion/report/index.html in a browser to view detailed reports"
    exit 0
else
    echo ""
    echo -e "${RED}=== Benchmarks Failed ===${NC}"
    exit 1
fi
