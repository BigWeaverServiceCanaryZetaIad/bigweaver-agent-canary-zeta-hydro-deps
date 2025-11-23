#!/bin/bash
# Script to compare benchmark results between this repository and the main repository
# This enables performance comparison after the migration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
MAIN_REPO="../bigweaver-agent-canary-hydro-zeta"
MAIN_BENCH_PACKAGE="benches"
THIS_BENCH_PACKAGE="timely-differential-benches"

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

# Function to print usage
print_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Compare benchmark results between this repository (timely/differential benchmarks)
and the main repository (remaining benchmarks).

This script helps verify that:
1. Performance is consistent between repositories
2. The migration didn't introduce performance regressions
3. Shared dfir_rs code performs similarly in both contexts

OPTIONS:
    -h, --help              Show this help message
    -m, --main-repo PATH    Path to main repository (default: ../bigweaver-agent-canary-hydro-zeta)
    -r, --run-both          Run benchmarks in both repositories before comparing
    -o, --output FILE       Save comparison report to file

EXAMPLES:
    $0                              Compare existing results
    $0 -r                           Run benchmarks in both repos, then compare
    $0 -m /path/to/main -r          Use custom path and run benchmarks
    $0 -o comparison_report.txt     Save comparison to file

EOF
}

# Function to check if main repository exists
check_main_repo() {
    if [ ! -d "$MAIN_REPO" ]; then
        print_error "Main repository not found at: $MAIN_REPO"
        print_info "Use -m option to specify the correct path"
        exit 1
    fi
    
    if [ ! -f "$MAIN_REPO/Cargo.toml" ]; then
        print_error "Invalid main repository path (no Cargo.toml found)"
        exit 1
    fi
}

# Function to run benchmarks in main repository
run_main_benchmarks() {
    print_info "Running benchmarks in main repository..."
    echo ""
    
    cd "$MAIN_REPO"
    
    # Run the remaining benchmarks in main repo
    if cargo bench -p "$MAIN_BENCH_PACKAGE" -- dfir 2>&1; then
        print_success "Main repository benchmarks completed"
    else
        print_warning "Some main repository benchmarks may have failed"
    fi
    
    cd - > /dev/null
    echo ""
}

# Function to run benchmarks in this repository
run_this_benchmarks() {
    print_info "Running benchmarks in this repository..."
    echo ""
    
    # Run timely/differential benchmarks
    if cargo bench -p "$THIS_BENCH_PACKAGE" -- dfir 2>&1; then
        print_success "This repository benchmarks completed"
    else
        print_warning "Some benchmarks may have failed"
    fi
    
    echo ""
}

# Function to extract benchmark results
extract_results() {
    local results_dir=$1
    local output_file=$2
    
    if [ ! -d "$results_dir" ]; then
        print_error "Results directory not found: $results_dir"
        return 1
    fi
    
    # Find all benchmark result files
    find "$results_dir" -name "base/estimates.json" | while read -r file; do
        # Extract benchmark name from path
        local bench_name=$(echo "$file" | sed 's|.*/criterion/\(.*\)/base/estimates.json|\1|')
        
        # Extract mean time if file exists and is valid JSON
        if [ -f "$file" ]; then
            local mean_value=$(jq -r '.mean.point_estimate // empty' "$file" 2>/dev/null)
            if [ -n "$mean_value" ]; then
                echo "$bench_name: $mean_value ns" >> "$output_file"
            fi
        fi
    done
}

# Function to compare results
compare_results() {
    local output_file=$1
    
    print_info "Comparing benchmark results..."
    echo ""
    
    local main_results="$MAIN_REPO/target/criterion"
    local this_results="target/criterion"
    
    # Check if results exist
    if [ ! -d "$main_results" ]; then
        print_error "No benchmark results found in main repository"
        print_info "Run with -r option to execute benchmarks first"
        exit 1
    fi
    
    if [ ! -d "$this_results" ]; then
        print_error "No benchmark results found in this repository"
        print_info "Run with -r option to execute benchmarks first"
        exit 1
    fi
    
    # Check if jq is available for JSON parsing
    if ! command -v jq &> /dev/null; then
        print_warning "jq not found - detailed comparison unavailable"
        print_info "Install jq for detailed JSON parsing: apt-get install jq or brew install jq"
        print_info ""
        print_info "Basic comparison:"
        echo ""
        echo "Main repository benchmarks:"
        ls -1 "$main_results" | grep -v "^report$" || echo "  (none found)"
        echo ""
        echo "This repository benchmarks:"
        ls -1 "$this_results" | grep -v "^report$" || echo "  (none found)"
        return 0
    fi
    
    # Extract and compare results
    local main_file=$(mktemp)
    local this_file=$(mktemp)
    
    print_info "Extracting results from main repository..."
    extract_results "$main_results" "$main_file"
    
    print_info "Extracting results from this repository..."
    extract_results "$this_results" "$this_file"
    
    # Generate comparison report
    {
        echo "================================================================================"
        echo "BENCHMARK COMPARISON REPORT"
        echo "================================================================================"
        echo ""
        echo "Generated: $(date)"
        echo "Main repository: $MAIN_REPO"
        echo "This repository: $(pwd)"
        echo ""
        echo "================================================================================"
        echo "MAIN REPOSITORY BENCHMARKS (dfir_rs implementations)"
        echo "================================================================================"
        echo ""
        if [ -s "$main_file" ]; then
            cat "$main_file" | sort
        else
            echo "No results found or extracted"
        fi
        echo ""
        echo "================================================================================"
        echo "THIS REPOSITORY BENCHMARKS (timely/differential with dfir_rs comparison)"
        echo "================================================================================"
        echo ""
        if [ -s "$this_file" ]; then
            cat "$this_file" | sort
        else
            echo "No results found or extracted"
        fi
        echo ""
        echo "================================================================================"
        echo "NOTES"
        echo "================================================================================"
        echo ""
        echo "- Main repository contains: futures, micro_ops, symmetric_hash_join, words_diamond"
        echo "- This repository contains: arithmetic, fan_in, fan_out, fork_join, identity,"
        echo "                           join, reachability, upcase"
        echo "- Both repositories share dfir_rs dependency for comparison benchmarks"
        echo "- Times are in nanoseconds (ns)"
        echo "- For detailed reports, see HTML files in target/criterion/report/"
        echo ""
        echo "================================================================================"
    } | tee "$output_file"
    
    # Cleanup temp files
    rm -f "$main_file" "$this_file"
    
    print_success "Comparison complete"
    
    if [ -n "$output_file" ] && [ "$output_file" != "/dev/stdout" ]; then
        print_info "Report saved to: $output_file"
    fi
}

# Parse arguments
RUN_BENCHMARKS=false
OUTPUT_FILE="/dev/stdout"

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            print_usage
            exit 0
            ;;
        -m|--main-repo)
            MAIN_REPO="$2"
            shift 2
            ;;
        -r|--run-both)
            RUN_BENCHMARKS=true
            shift
            ;;
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        *)
            print_error "Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

# Main execution
main() {
    print_info "Benchmark Comparison Tool"
    echo ""
    
    check_main_repo
    
    if [ "$RUN_BENCHMARKS" = true ]; then
        print_info "Running benchmarks in both repositories..."
        echo ""
        
        run_main_benchmarks
        run_this_benchmarks
        
        print_success "All benchmarks completed"
        echo ""
    fi
    
    compare_results "$OUTPUT_FILE"
    
    echo ""
    print_info "For detailed HTML reports:"
    print_info "  Main repo: $MAIN_REPO/target/criterion/report/index.html"
    print_info "  This repo: target/criterion/report/index.html"
    echo ""
    
    print_success "Done!"
}

# Run main function
main
