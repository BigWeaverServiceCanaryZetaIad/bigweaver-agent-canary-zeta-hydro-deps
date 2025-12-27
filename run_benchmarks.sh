#!/usr/bin/env bash
#
# Helper script for running Hydro benchmarks with common options
#
# Usage:
#   ./run_benchmarks.sh                    # Run all benchmarks
#   ./run_benchmarks.sh reachability       # Run specific benchmark
#   ./run_benchmarks.sh --quick            # Quick run with reduced samples
#   ./run_benchmarks.sh --save baseline    # Save results as baseline
#   ./run_benchmarks.sh --compare baseline # Compare against baseline

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
BENCHMARK=""
BASELINE=""
SAVE_BASELINE=""
QUICK=false
SAMPLE_SIZE=""
WARM_UP_TIME=""
FILTER=""

# Print usage information
usage() {
    cat << EOF
Usage: $0 [OPTIONS] [BENCHMARK]

Run Hydro performance benchmarks with convenient options.

OPTIONS:
    -h, --help              Show this help message
    -q, --quick             Quick run with reduced samples (faster iteration)
    -s, --save NAME         Save results as baseline with given NAME
    -c, --compare NAME      Compare results against baseline NAME
    -f, --filter PATTERN    Filter tests by pattern
    -n, --sample-size N     Set number of samples (default: auto)
    -w, --warm-up-time N    Set warm-up time in seconds (default: 3)
    --list                  List all available benchmarks

BENCHMARK:
    Name of specific benchmark to run. If omitted, runs all benchmarks.
    Available benchmarks:
        arithmetic, fan_in, fan_out, fork_join, futures, identity,
        join, micro_ops, reachability, symmetric_hash_join, upcase, words_diamond

EXAMPLES:
    # Run all benchmarks
    $0

    # Run specific benchmark
    $0 reachability

    # Quick iteration during development
    $0 --quick micro_ops

    # Save baseline before optimization
    $0 --save before-opt

    # Compare after optimization
    $0 --compare before-opt

    # Run and filter to Hydro implementations only
    $0 --filter dfir_rs reachability

    # Quick comparison workflow
    $0 -q -s main           # Save quick baseline
    # ... make changes ...
    $0 -q -c main           # Compare changes

EOF
    exit 0
}

# List available benchmarks
list_benchmarks() {
    cat << EOF
Available Benchmarks:
  arithmetic           - Chain of arithmetic operations
  fan_in               - Multiple inputs merging to single output
  fan_out              - Single input splitting to multiple outputs
  fork_join            - Fork-join pattern with filtering
  futures              - Async future handling
  identity             - Pass-through baseline benchmark
  join                 - Hash join operations
  micro_ops            - Individual operator microbenchmarks
  reachability         - Graph reachability algorithm
  symmetric_hash_join  - Symmetric hash join with varying selectivity
  upcase               - String transformation operations
  words_diamond        - Diamond dataflow pattern

Run '$0 --help' for more information.
EOF
    exit 0
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        --list)
            list_benchmarks
            ;;
        -q|--quick)
            QUICK=true
            shift
            ;;
        -s|--save)
            SAVE_BASELINE="$2"
            shift 2
            ;;
        -c|--compare)
            BASELINE="$2"
            shift 2
            ;;
        -f|--filter)
            FILTER="$2"
            shift 2
            ;;
        -n|--sample-size)
            SAMPLE_SIZE="$2"
            shift 2
            ;;
        -w|--warm-up-time)
            WARM_UP_TIME="$2"
            shift 2
            ;;
        -*)
            echo -e "${RED}Error: Unknown option $1${NC}" >&2
            usage
            ;;
        *)
            BENCHMARK="$1"
            shift
            ;;
    esac
done

# Build cargo bench command
CARGO_CMD="cargo bench -p benches"

# Add specific benchmark if specified
if [[ -n "$BENCHMARK" ]]; then
    CARGO_CMD="$CARGO_CMD --bench $BENCHMARK"
fi

# Build criterion arguments
CRITERION_ARGS=""

# Quick mode
if [[ "$QUICK" == true ]]; then
    SAMPLE_SIZE="${SAMPLE_SIZE:-10}"
    WARM_UP_TIME="${WARM_UP_TIME:-1}"
fi

# Add criterion options
if [[ -n "$SAMPLE_SIZE" ]]; then
    CRITERION_ARGS="$CRITERION_ARGS --sample-size $SAMPLE_SIZE"
fi

if [[ -n "$WARM_UP_TIME" ]]; then
    CRITERION_ARGS="$CRITERION_ARGS --warm-up-time $WARM_UP_TIME"
fi

if [[ -n "$SAVE_BASELINE" ]]; then
    CRITERION_ARGS="$CRITERION_ARGS --save-baseline $SAVE_BASELINE"
fi

if [[ -n "$BASELINE" ]]; then
    CRITERION_ARGS="$CRITERION_ARGS --baseline $BASELINE"
fi

if [[ -n "$FILTER" ]]; then
    CRITERION_ARGS="$CRITERION_ARGS $FILTER"
fi

# Add criterion args if any
if [[ -n "$CRITERION_ARGS" ]]; then
    CARGO_CMD="$CARGO_CMD -- $CRITERION_ARGS"
fi

# Print configuration
echo -e "${BLUE}=== Hydro Benchmark Runner ===${NC}"
echo -e "${YELLOW}Configuration:${NC}"
[[ -n "$BENCHMARK" ]] && echo "  Benchmark: $BENCHMARK" || echo "  Benchmark: ALL"
[[ "$QUICK" == true ]] && echo "  Mode: Quick (reduced samples)"
[[ -n "$SAVE_BASELINE" ]] && echo "  Save baseline: $SAVE_BASELINE"
[[ -n "$BASELINE" ]] && echo "  Compare baseline: $BASELINE"
[[ -n "$FILTER" ]] && echo "  Filter: $FILTER"
[[ -n "$SAMPLE_SIZE" ]] && echo "  Sample size: $SAMPLE_SIZE"
[[ -n "$WARM_UP_TIME" ]] && echo "  Warm-up time: ${WARM_UP_TIME}s"
echo ""

# Check if we're in the right directory
if [[ ! -f "benches/Cargo.toml" ]]; then
    echo -e "${RED}Error: Must be run from repository root${NC}" >&2
    echo "Current directory: $(pwd)"
    echo "Expected to find: benches/Cargo.toml"
    exit 1
fi

# Run the benchmark
echo -e "${GREEN}Running: $CARGO_CMD${NC}"
echo ""

# Execute the command
eval "$CARGO_CMD"

EXIT_CODE=$?

# Print results location
if [[ $EXIT_CODE -eq 0 ]]; then
    echo ""
    echo -e "${GREEN}=== Benchmark Complete ===${NC}"
    echo -e "Results saved to: ${BLUE}target/criterion/${NC}"
    echo -e "HTML Report: ${BLUE}target/criterion/report/index.html${NC}"
    
    if [[ -n "$SAVE_BASELINE" ]]; then
        echo -e "Baseline saved as: ${YELLOW}$SAVE_BASELINE${NC}"
        echo -e "To compare later: ${BLUE}$0 --compare $SAVE_BASELINE${NC}"
    fi
    
    if [[ -n "$BASELINE" ]]; then
        echo -e "Compared against baseline: ${YELLOW}$BASELINE${NC}"
    fi
else
    echo -e "${RED}=== Benchmark Failed ===${NC}" >&2
    exit $EXIT_CODE
fi
