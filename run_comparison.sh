#!/bin/bash
# Script to run benchmark comparisons between implementations

set -e

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "================================================"
echo "  Hydro Performance Comparison Benchmarks"
echo "================================================"
echo ""

# Check if cargo is available
if ! command -v cargo &> /dev/null; then
    echo -e "${YELLOW}Error:${NC} Cargo not found. Please install Rust:"
    echo "  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    exit 1
fi

# Parse command line arguments
MODE="full"
BENCHMARK=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --quick)
            MODE="quick"
            shift
            ;;
        --bench)
            BENCHMARK="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --quick          Run benchmarks in quick mode (faster, less accurate)"
            echo "  --bench NAME     Run only the specified benchmark"
            echo "  --help, -h       Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                           # Run all benchmarks"
            echo "  $0 --quick                   # Run all benchmarks in quick mode"
            echo "  $0 --bench arithmetic        # Run only arithmetic benchmark"
            echo "  $0 --bench identity --quick  # Run identity benchmark in quick mode"
            echo ""
            echo "Available benchmarks:"
            echo "  - identity     : Minimal overhead test"
            echo "  - arithmetic   : Computational operations"
            echo "  - upcase       : String transformations"
            echo "  - fan_in       : Multiple inputs to one output"
            echo "  - fan_out      : One input to multiple outputs"
            echo "  - fork_join    : Split, process, merge pattern"
            echo "  - join         : Stream join operations"
            echo "  - reachability : Graph computation (iterative)"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Run '$0 --help' for usage information"
            exit 1
            ;;
    esac
done

# Function to run a benchmark
run_benchmark() {
    local bench_name=$1
    local mode=$2
    
    echo -e "${BLUE}Running:${NC} $bench_name benchmark"
    
    if [ "$mode" = "quick" ]; then
        cargo bench --bench "$bench_name" -- --quick
    else
        cargo bench --bench "$bench_name"
    fi
    
    echo ""
}

# Main execution
if [ -n "$BENCHMARK" ]; then
    # Run single benchmark
    echo -e "${GREEN}Mode:${NC} Single benchmark ($BENCHMARK)"
    if [ "$MODE" = "quick" ]; then
        echo -e "${GREEN}Speed:${NC} Quick mode (reduced accuracy)"
    else
        echo -e "${GREEN}Speed:${NC} Full mode (accurate results)"
    fi
    echo ""
    
    run_benchmark "$BENCHMARK" "$MODE"
    
else
    # Run all benchmarks
    echo -e "${GREEN}Mode:${NC} All benchmarks"
    if [ "$MODE" = "quick" ]; then
        echo -e "${GREEN}Speed:${NC} Quick mode (reduced accuracy)"
        echo -e "${YELLOW}Note:${NC} Quick mode provides faster results but less statistical confidence"
    else
        echo -e "${GREEN}Speed:${NC} Full mode (accurate results)"
        echo -e "${YELLOW}Note:${NC} Full benchmark suite takes ~15-20 minutes"
    fi
    echo ""
    
    read -p "Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 0
    fi
    
    echo ""
    echo "Running all benchmarks..."
    echo ""
    
    BENCHMARKS=(
        "identity"
        "arithmetic"
        "upcase"
        "fan_in"
        "fan_out"
        "fork_join"
        "join"
        "reachability"
    )
    
    for bench in "${BENCHMARKS[@]}"; do
        run_benchmark "$bench" "$MODE"
    done
fi

echo "================================================"
echo -e "${GREEN}Benchmark comparison complete!${NC}"
echo "================================================"
echo ""
echo "Results are available in:"
echo "  - Terminal output above"
echo "  - HTML reports: target/criterion/report/index.html"
echo ""
echo "To view HTML reports:"
echo "  open target/criterion/report/index.html"
echo ""
echo "To compare specific implementations:"
echo "  cargo bench --bench arithmetic -- arithmetic/dfir arithmetic/timely"
echo ""
