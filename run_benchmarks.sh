#!/bin/bash
# Run Hydro benchmarks with various options
# Usage: ./run_benchmarks.sh [options]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -a, --all              Run all benchmarks"
    echo "  -m, --micro            Run micro-operations benchmarks"
    echo "  -r, --reachability     Run reachability benchmarks"
    echo "  -d, --dataflow         Run dataflow pattern benchmarks"
    echo "  -b, --baseline NAME    Save results as baseline"
    echo "  -c, --compare NAME     Compare against baseline"
    echo "  -s, --save-html        Open HTML report after completion"
    echo "  -q, --quick            Quick run (fewer samples)"
    echo "  -h, --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --all                    # Run all benchmarks"
    echo "  $0 --micro --baseline main  # Run micro-ops and save as 'main' baseline"
    echo "  $0 --all --compare main     # Compare all benchmarks against 'main' baseline"
    echo "  $0 --quick --reachability   # Quick run of reachability benchmarks"
}

# Default values
RUN_ALL=false
RUN_MICRO=false
RUN_REACH=false
RUN_DATAFLOW=false
BASELINE=""
COMPARE=""
SAVE_HTML=false
QUICK=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--all)
            RUN_ALL=true
            shift
            ;;
        -m|--micro)
            RUN_MICRO=true
            shift
            ;;
        -r|--reachability)
            RUN_REACH=true
            shift
            ;;
        -d|--dataflow)
            RUN_DATAFLOW=true
            shift
            ;;
        -b|--baseline)
            BASELINE="$2"
            shift 2
            ;;
        -c|--compare)
            COMPARE="$2"
            shift 2
            ;;
        -s|--save-html)
            SAVE_HTML=true
            shift
            ;;
        -q|--quick)
            QUICK=true
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            print_usage
            exit 1
            ;;
    esac
done

# If no specific benchmarks selected, default to all
if [ "$RUN_ALL" = false ] && [ "$RUN_MICRO" = false ] && [ "$RUN_REACH" = false ] && [ "$RUN_DATAFLOW" = false ]; then
    RUN_ALL=true
fi

echo -e "${GREEN}🚀 Starting Hydro Benchmarks${NC}"
echo ""

# Build benchmark arguments
BENCH_ARGS=""
if [ -n "$BASELINE" ]; then
    BENCH_ARGS="$BENCH_ARGS --save-baseline $BASELINE"
    echo -e "${YELLOW}📊 Will save results as baseline: $BASELINE${NC}"
fi

if [ -n "$COMPARE" ]; then
    BENCH_ARGS="$BENCH_ARGS --baseline $COMPARE"
    echo -e "${YELLOW}📊 Will compare against baseline: $COMPARE${NC}"
fi

if [ "$QUICK" = true ]; then
    export CARGO_BENCH_OPTS="--quick"
    echo -e "${YELLOW}⚡ Quick mode enabled (fewer samples)${NC}"
fi

echo ""

# Function to run a benchmark
run_benchmark() {
    local name=$1
    local bench_name=$2
    
    echo -e "${GREEN}Running $name benchmarks...${NC}"
    cd benches
    if cargo bench --bench "$bench_name" -- $BENCH_ARGS; then
        echo -e "${GREEN}✅ $name benchmarks completed${NC}"
    else
        echo -e "${RED}❌ $name benchmarks failed${NC}"
        exit 1
    fi
    cd ..
    echo ""
}

# Run selected benchmarks
if [ "$RUN_ALL" = true ] || [ "$RUN_MICRO" = true ]; then
    run_benchmark "Micro-operations" "micro_ops"
fi

if [ "$RUN_ALL" = true ] || [ "$RUN_REACH" = true ]; then
    run_benchmark "Reachability" "reachability"
fi

if [ "$RUN_ALL" = true ] || [ "$RUN_DATAFLOW" = true ]; then
    run_benchmark "Dataflow patterns" "dataflow_patterns"
fi

echo -e "${GREEN}✨ All benchmarks completed successfully!${NC}"
echo ""
echo "📊 Results saved in: benches/target/criterion/"

# Open HTML report if requested
if [ "$SAVE_HTML" = true ]; then
    echo ""
    echo -e "${GREEN}Opening HTML report...${NC}"
    REPORT_PATH="benches/target/criterion/report/index.html"
    
    if [ -f "$REPORT_PATH" ]; then
        if command -v xdg-open &> /dev/null; then
            xdg-open "$REPORT_PATH"
        elif command -v open &> /dev/null; then
            open "$REPORT_PATH"
        else
            echo -e "${YELLOW}Could not open browser automatically. Report is at: $REPORT_PATH${NC}"
        fi
    else
        echo -e "${YELLOW}HTML report not found at: $REPORT_PATH${NC}"
    fi
fi

echo ""
echo -e "${GREEN}🎉 Done!${NC}"
