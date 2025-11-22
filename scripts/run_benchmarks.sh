#!/bin/bash
# Script to run benchmarks with various options

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to display usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Run benchmarks with various configuration options.

OPTIONS:
    -h, --help              Show this help message
    -a, --all               Run all benchmarks (default)
    -b, --bench NAME        Run specific benchmark (e.g., identity, reachability)
    -f, --fast              Run quick benchmarks only (identity, arithmetic, micro_ops)
    -s, --save NAME         Save results as baseline with given name
    -c, --compare NAME      Compare against saved baseline
    -v, --verbose           Show verbose output
    --sample-size N         Set sample size (default: criterion default)
    --measurement-time N    Set measurement time in seconds (default: 5)
    --list                  List available benchmarks

EXAMPLES:
    $0                                      # Run all benchmarks
    $0 --bench identity                     # Run identity benchmark only
    $0 --fast                               # Run quick benchmarks
    $0 --save main                          # Save baseline as 'main'
    $0 --compare main                       # Compare against 'main' baseline
    $0 --bench reachability --verbose       # Run reachability with verbose output
    $0 --sample-size 50 --measurement-time 10  # Custom sampling parameters

EOF
    exit 0
}

# Parse command line arguments
BENCH_ARGS=""
BENCH_NAME=""
RUN_MODE="all"
BASELINE_NAME=""
BASELINE_MODE=""
VERBOSE=false
SAMPLE_SIZE=""
MEASUREMENT_TIME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -a|--all)
            RUN_MODE="all"
            shift
            ;;
        -b|--bench)
            RUN_MODE="specific"
            BENCH_NAME="$2"
            shift 2
            ;;
        -f|--fast)
            RUN_MODE="fast"
            shift
            ;;
        -s|--save)
            BASELINE_MODE="save"
            BASELINE_NAME="$2"
            shift 2
            ;;
        -c|--compare)
            BASELINE_MODE="compare"
            BASELINE_NAME="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        --sample-size)
            SAMPLE_SIZE="$2"
            shift 2
            ;;
        --measurement-time)
            MEASUREMENT_TIME="$2"
            shift 2
            ;;
        --list)
            print_info "Available benchmarks:"
            echo "  - identity           (Basic data flow and transformation)"
            echo "  - arithmetic         (Arithmetic operations)"
            echo "  - fan_in             (Fan-in patterns)"
            echo "  - fan_out            (Fan-out patterns)"
            echo "  - fork_join          (Fork-join patterns)"
            echo "  - join               (Join operations)"
            echo "  - upcase             (String transformations)"
            echo "  - reachability       (Graph reachability algorithms)"
            echo "  - micro_ops          (Fine-grained operations)"
            echo "  - symmetric_hash_join (Symmetric hash joins)"
            echo "  - words_diamond      (Text processing diamond pattern)"
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Build criterion arguments
CRITERION_ARGS=""

if [ -n "$SAMPLE_SIZE" ]; then
    CRITERION_ARGS="$CRITERION_ARGS --sample-size $SAMPLE_SIZE"
fi

if [ -n "$MEASUREMENT_TIME" ]; then
    CRITERION_ARGS="$CRITERION_ARGS --measurement-time $MEASUREMENT_TIME"
fi

if [ "$BASELINE_MODE" = "save" ]; then
    CRITERION_ARGS="$CRITERION_ARGS --save-baseline $BASELINE_NAME"
    print_info "Will save baseline as: $BASELINE_NAME"
elif [ "$BASELINE_MODE" = "compare" ]; then
    CRITERION_ARGS="$CRITERION_ARGS --baseline $BASELINE_NAME"
    print_info "Will compare against baseline: $BASELINE_NAME"
fi

if [ "$VERBOSE" = true ]; then
    BENCH_ARGS="$BENCH_ARGS --verbose"
fi

# Verify we're in the correct directory
if [ ! -f "Cargo.toml" ]; then
    print_error "Cargo.toml not found. Please run this script from the repository root."
    exit 1
fi

# Check if main repository exists
MAIN_REPO_PATH="../bigweaver-agent-canary-hydro-zeta"
if [ ! -d "$MAIN_REPO_PATH" ]; then
    print_warning "Main repository not found at expected location: $MAIN_REPO_PATH"
    print_warning "Benchmarks may fail if dependencies cannot be resolved."
    print_warning "Please ensure both repositories are cloned as siblings."
fi

# Function to run benchmark
run_benchmark() {
    local bench_name=$1
    print_info "Running benchmark: $bench_name"
    
    if cargo bench --bench "$bench_name" $BENCH_ARGS -- $CRITERION_ARGS; then
        print_success "Benchmark '$bench_name' completed successfully"
        return 0
    else
        print_error "Benchmark '$bench_name' failed"
        return 1
    fi
}

# Main execution
print_info "Starting benchmark run..."
print_info "Mode: $RUN_MODE"

case $RUN_MODE in
    all)
        print_info "Running all benchmarks (this may take several minutes)..."
        if cargo bench $BENCH_ARGS -- $CRITERION_ARGS; then
            print_success "All benchmarks completed successfully"
        else
            print_error "Some benchmarks failed"
            exit 1
        fi
        ;;
    
    specific)
        if [ -z "$BENCH_NAME" ]; then
            print_error "No benchmark name specified"
            exit 1
        fi
        run_benchmark "$BENCH_NAME"
        ;;
    
    fast)
        print_info "Running fast benchmarks only..."
        FAST_BENCHMARKS=("identity" "arithmetic" "micro_ops")
        
        for bench in "${FAST_BENCHMARKS[@]}"; do
            if ! run_benchmark "$bench"; then
                print_error "Fast benchmark suite failed"
                exit 1
            fi
        done
        
        print_success "All fast benchmarks completed successfully"
        ;;
esac

# Show results location
print_info "Benchmark results saved to: target/criterion/"
print_info "View HTML reports at: target/criterion/report/index.html"

# Offer to open the report
if command -v open &> /dev/null; then
    read -p "Open HTML report in browser? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        open target/criterion/report/index.html
    fi
elif command -v xdg-open &> /dev/null; then
    read -p "Open HTML report in browser? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        xdg-open target/criterion/report/index.html
    fi
fi

print_success "Benchmark run complete!"
