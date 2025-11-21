#!/bin/bash
# Comprehensive benchmark runner script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Hydroflow External Framework Benchmarks${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Parse command line arguments
MODE="all"
BASELINE=""
QUICK=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --quick)
            QUICK="--quick"
            shift
            ;;
        --baseline)
            BASELINE="--save-baseline $2"
            shift 2
            ;;
        --compare)
            BASELINE="--baseline $2"
            shift 2
            ;;
        --bench)
            MODE="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --quick              Run quick benchmarks (fewer samples)"
            echo "  --baseline NAME      Save results as baseline NAME"
            echo "  --compare NAME       Compare against baseline NAME"
            echo "  --bench NAME         Run specific benchmark (identity, join, reachability, etc.)"
            echo "  --help               Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                                    # Run all benchmarks"
            echo "  $0 --quick                            # Quick run"
            echo "  $0 --baseline my_baseline             # Save baseline"
            echo "  $0 --compare my_baseline              # Compare with baseline"
            echo "  $0 --bench identity                   # Run only identity benchmark"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Check if Cargo.toml exists
if [ ! -f "Cargo.toml" ]; then
    echo -e "${RED}Error: Cargo.toml not found. Are you in the right directory?${NC}"
    exit 1
fi

# Build first
echo -e "${YELLOW}Building in release mode...${NC}"
cargo build --release
echo -e "${GREEN}Build complete!${NC}"
echo ""

# Function to run a benchmark
run_benchmark() {
    local bench_name=$1
    echo -e "${YELLOW}Running $bench_name benchmark...${NC}"
    cargo bench --bench "${bench_name}_comparison" -- $QUICK $BASELINE
    echo -e "${GREEN}$bench_name complete!${NC}"
    echo ""
}

# Run benchmarks based on mode
if [ "$MODE" = "all" ]; then
    echo -e "${YELLOW}Running all benchmarks...${NC}"
    echo ""
    
    run_benchmark "identity"
    run_benchmark "join"
    run_benchmark "reachability"
    run_benchmark "fan_in"
    run_benchmark "fan_out"
    run_benchmark "fork_join"
    run_benchmark "arithmetic"
else
    run_benchmark "$MODE"
fi

# Show results location
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Benchmarks Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "Results saved to: ${YELLOW}target/criterion/${NC}"
echo -e "View HTML report: ${YELLOW}open target/criterion/report/index.html${NC}"
echo ""

if [ -n "$BASELINE" ]; then
    if [[ "$BASELINE" == --save-baseline* ]]; then
        echo -e "${GREEN}Baseline saved for future comparisons${NC}"
    else
        echo -e "${GREEN}Comparison complete${NC}"
    fi
fi
