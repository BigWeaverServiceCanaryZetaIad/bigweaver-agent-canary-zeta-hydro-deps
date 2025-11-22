#!/bin/bash
# Convenience script for running benchmarks in the hydro-deps repository

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_usage() {
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  all             Run all benchmarks"
    echo "  quick           Run all benchmarks with reduced samples (faster)"
    echo "  list            List available benchmarks"
    echo "  <benchmark>     Run a specific benchmark (e.g., arithmetic, identity)"
    echo "  compare         Compare with main repository benchmarks"
    echo ""
    echo "Options:"
    echo "  --save-baseline NAME    Save results as baseline NAME"
    echo "  --baseline NAME         Compare against baseline NAME"
    echo "  --open                  Open HTML report after completion"
    echo ""
    echo "Examples:"
    echo "  $0 all                              # Run all benchmarks"
    echo "  $0 quick                            # Quick run with fewer samples"
    echo "  $0 arithmetic                       # Run only arithmetic benchmark"
    echo "  $0 all --save-baseline v1.0         # Save baseline for future comparison"
    echo "  $0 all --baseline v1.0 --open       # Compare with baseline and open report"
}

list_benchmarks() {
    echo -e "${BLUE}Available benchmarks:${NC}"
    echo "  - arithmetic       Pipeline arithmetic operations"
    echo "  - fan_in           Multiple input streams merging"
    echo "  - fan_out          Single stream broadcasting"
    echo "  - fork_join        Parallel processing patterns"
    echo "  - identity         Identity/passthrough operations"
    echo "  - join             Join operations"
    echo "  - reachability     Graph reachability algorithms"
    echo "  - upcase           String transformations"
}

run_benchmark() {
    local bench_name="$1"
    shift
    local extra_args="$@"
    
    echo -e "${GREEN}Running benchmark: ${bench_name}${NC}"
    cargo bench -p hydro-deps-benchmarks --bench "$bench_name" $extra_args
}

run_all_benchmarks() {
    local extra_args="$@"
    
    echo -e "${GREEN}Running all benchmarks...${NC}"
    cargo bench -p hydro-deps-benchmarks $extra_args
}

run_quick_benchmarks() {
    echo -e "${YELLOW}Running quick benchmarks (reduced samples)...${NC}"
    cargo bench -p hydro-deps-benchmarks -- --quick
}

compare_with_main() {
    echo -e "${BLUE}Comparing with main repository benchmarks...${NC}"
    
    local main_repo="../bigweaver-agent-canary-hydro-zeta"
    
    if [ ! -d "$main_repo" ]; then
        echo -e "${YELLOW}Warning: Main repository not found at $main_repo${NC}"
        echo "Clone the main repository to enable comparison:"
        echo "  git clone <repo-url> $main_repo"
        exit 1
    fi
    
    echo -e "${GREEN}Running hydro-deps benchmarks...${NC}"
    cargo bench -p hydro-deps-benchmarks --bench identity --bench arithmetic
    
    echo ""
    echo -e "${GREEN}Running main repository benchmarks...${NC}"
    cd "$main_repo"
    cargo bench -p benches --bench micro_ops
    cd "$SCRIPT_DIR"
    
    echo ""
    echo -e "${BLUE}Comparison complete!${NC}"
    echo "View detailed reports:"
    echo "  Hydro-deps: file://$SCRIPT_DIR/target/criterion/report/index.html"
    echo "  Main repo:  file://$main_repo/target/criterion/report/index.html"
}

open_report() {
    local report_path="$SCRIPT_DIR/target/criterion/report/index.html"
    
    if [ ! -f "$report_path" ]; then
        echo -e "${YELLOW}No report found. Run benchmarks first.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}Opening benchmark report...${NC}"
    
    # Try different commands based on OS
    if command -v xdg-open &> /dev/null; then
        xdg-open "$report_path"
    elif command -v open &> /dev/null; then
        open "$report_path"
    elif command -v start &> /dev/null; then
        start "$report_path"
    else
        echo "Report location: file://$report_path"
        echo "Open this file in your browser"
    fi
}

# Main script logic
if [ $# -eq 0 ]; then
    print_usage
    exit 1
fi

COMMAND="$1"
shift

# Parse flags
OPEN_REPORT=false
EXTRA_ARGS=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --open)
            OPEN_REPORT=true
            shift
            ;;
        --save-baseline|--baseline)
            EXTRA_ARGS="$EXTRA_ARGS -- $1 $2"
            shift 2
            ;;
        *)
            EXTRA_ARGS="$EXTRA_ARGS $1"
            shift
            ;;
    esac
done

# Execute command
case $COMMAND in
    all)
        run_all_benchmarks $EXTRA_ARGS
        ;;
    quick)
        run_quick_benchmarks
        ;;
    list)
        list_benchmarks
        ;;
    compare)
        compare_with_main
        ;;
    arithmetic|fan_in|fan_out|fork_join|identity|join|reachability|upcase)
        run_benchmark "$COMMAND" $EXTRA_ARGS
        ;;
    *)
        echo -e "${YELLOW}Unknown command: $COMMAND${NC}"
        echo ""
        print_usage
        exit 1
        ;;
esac

# Open report if requested
if [ "$OPEN_REPORT" = true ]; then
    open_report
fi

echo ""
echo -e "${GREEN}Done!${NC}"
echo "View results: file://$SCRIPT_DIR/target/criterion/report/index.html"
