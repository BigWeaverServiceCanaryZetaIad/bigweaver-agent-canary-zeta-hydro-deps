#!/bin/bash
#
# Performance Comparison Script
# 
# This script runs benchmarks in both the main hydro repository and this
# benchmark repository, then compares the results.
#
# Usage:
#   ./compare_performance.sh                    # Compare with current state
#   ./compare_performance.sh --baseline <ref>   # Compare with specific baseline
#   ./compare_performance.sh --help             # Show help

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_REPO_DIR="$(cd "${SCRIPT_DIR}/../bigweaver-agent-canary-hydro-zeta" && pwd)"
BENCHMARK_REPO_DIR="${SCRIPT_DIR}"
RESULTS_DIR="${SCRIPT_DIR}/comparison_results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Available benchmarks
BENCHMARKS=(
    "arithmetic"
    "fan_in"
    "fan_out"
    "fork_join"
    "futures"
    "identity"
    "join"
    "micro_ops"
    "reachability"
    "symmetric_hash_join"
    "upcase"
    "words_diamond"
)

# Function to print colored messages
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

# Function to show usage
show_help() {
    cat << EOF
Performance Comparison Tool for Hydro Benchmarks

Usage: $0 [OPTIONS]

Options:
    --baseline <ref>    Compare with specific git reference (commit, branch, tag)
    --bench <name>      Run only specific benchmark (can be specified multiple times)
    --list              List available benchmarks
    --no-rebuild        Skip rebuilding, use existing binaries
    --help              Show this help message

Examples:
    $0                              # Compare current state
    $0 --baseline main              # Compare with main branch
    $0 --baseline abc123            # Compare with specific commit
    $0 --bench reachability         # Run only reachability benchmark
    $0 --bench fan_in --bench fan_out  # Run multiple specific benchmarks

Available benchmarks:
EOF
    for bench in "${BENCHMARKS[@]}"; do
        echo "    - $bench"
    done
}

# Function to list benchmarks
list_benchmarks() {
    print_info "Available benchmarks:"
    for bench in "${BENCHMARKS[@]}"; do
        echo "  - $bench"
    done
}

# Parse command line arguments
BASELINE_REF=""
SELECTED_BENCHMARKS=()
REBUILD=true

while [[ $# -gt 0 ]]; do
    case $1 in
        --baseline)
            BASELINE_REF="$2"
            shift 2
            ;;
        --bench)
            SELECTED_BENCHMARKS+=("$2")
            shift 2
            ;;
        --list)
            list_benchmarks
            exit 0
            ;;
        --no-rebuild)
            REBUILD=false
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Use all benchmarks if none specified
if [ ${#SELECTED_BENCHMARKS[@]} -eq 0 ]; then
    SELECTED_BENCHMARKS=("${BENCHMARKS[@]}")
fi

# Check if main repository exists
if [ ! -d "${MAIN_REPO_DIR}" ]; then
    print_error "Main repository not found at: ${MAIN_REPO_DIR}"
    print_info "Please ensure bigweaver-agent-canary-hydro-zeta is cloned in the parent directory"
    exit 1
fi

# Create results directory
mkdir -p "${RESULTS_DIR}"

print_info "=== Hydro Performance Comparison ==="
print_info "Benchmark Repository: ${BENCHMARK_REPO_DIR}"
print_info "Main Repository: ${MAIN_REPO_DIR}"
print_info "Results Directory: ${RESULTS_DIR}"
print_info "Timestamp: ${TIMESTAMP}"
echo ""

# Function to run benchmarks in this repository
run_benchmark_repo() {
    local bench_name=$1
    local output_file="${RESULTS_DIR}/${TIMESTAMP}_benchmark_${bench_name}.json"
    
    print_info "Running benchmark '${bench_name}' in benchmark repository..."
    
    cd "${BENCHMARK_REPO_DIR}"
    
    if [ "$REBUILD" = true ]; then
        print_info "Building benchmark repository..."
        cargo build --release --benches
    fi
    
    # Run benchmark with JSON output
    cargo bench --bench "${bench_name}" -- --save-baseline "benchmark_repo_${TIMESTAMP}"
    
    print_success "Completed benchmark '${bench_name}' in benchmark repository"
}

# Function to check if benchmark exists in main repo
check_main_repo_benchmark() {
    local bench_name=$1
    # The main repo no longer has the benches, so this will always return false
    return 1
}

# Main execution
print_info "Starting performance comparison..."
echo ""

# Store benchmark results summary
SUMMARY_FILE="${RESULTS_DIR}/${TIMESTAMP}_summary.txt"
echo "Performance Comparison Summary" > "${SUMMARY_FILE}"
echo "===============================" >> "${SUMMARY_FILE}"
echo "Date: $(date)" >> "${SUMMARY_FILE}"
echo "Benchmark Repository: ${BENCHMARK_REPO_DIR}" >> "${SUMMARY_FILE}"
echo "Main Repository: ${MAIN_REPO_DIR}" >> "${SUMMARY_FILE}"
if [ -n "${BASELINE_REF}" ]; then
    echo "Baseline Reference: ${BASELINE_REF}" >> "${SUMMARY_FILE}"
fi
echo "" >> "${SUMMARY_FILE}"
echo "Benchmarks Run:" >> "${SUMMARY_FILE}"

# Run selected benchmarks
for bench in "${SELECTED_BENCHMARKS[@]}"; do
    echo "  - ${bench}" >> "${SUMMARY_FILE}"
    
    print_info "----------------------------------------"
    print_info "Processing benchmark: ${bench}"
    print_info "----------------------------------------"
    
    # Run in benchmark repository
    run_benchmark_repo "${bench}" || print_warning "Benchmark '${bench}' failed in benchmark repository"
    
    echo ""
done

# Generate comparison report
print_info "Generating comparison report..."

REPORT_FILE="${RESULTS_DIR}/${TIMESTAMP}_report.md"
cat > "${REPORT_FILE}" << EOF
# Hydro Performance Comparison Report

**Date:** $(date)
**Benchmark Repository:** ${BENCHMARK_REPO_DIR}
**Main Repository:** ${MAIN_REPO_DIR}

## Summary

This report contains performance comparison results for Hydro benchmarks.

### Benchmarks Executed

EOF

for bench in "${SELECTED_BENCHMARKS[@]}"; do
    echo "- ${bench}" >> "${REPORT_FILE}"
done

cat >> "${REPORT_FILE}" << EOF

## Results Location

Detailed benchmark results are available in:
\`\`\`
${RESULTS_DIR}
\`\`\`

### Criterion Reports

HTML reports with detailed charts and statistics:
\`\`\`
${BENCHMARK_REPO_DIR}/target/criterion/
\`\`\`

Open \`target/criterion/report/index.html\` in a browser to view interactive results.

## Viewing Results

### Command Line
\`\`\`bash
# List all criterion results
ls -lh ${BENCHMARK_REPO_DIR}/target/criterion/

# View specific benchmark results
cat ${BENCHMARK_REPO_DIR}/target/criterion/<benchmark-name>/base/estimates.json
\`\`\`

### HTML Reports
\`\`\`bash
# Open main report
xdg-open ${BENCHMARK_REPO_DIR}/target/criterion/report/index.html

# Or on macOS
open ${BENCHMARK_REPO_DIR}/target/criterion/report/index.html
\`\`\`

## Notes

- The main bigweaver-agent-canary-hydro-zeta repository no longer contains these benchmarks
- All benchmarks are now maintained in this dedicated repository
- Performance comparisons across time can be done using criterion's baseline features
- To compare with previous runs, use: \`cargo bench --bench <name> --baseline <baseline-name>\`

## Baseline Management

### Save a baseline
\`\`\`bash
cargo bench -- --save-baseline my-baseline
\`\`\`

### Compare with baseline
\`\`\`bash
cargo bench -- --baseline my-baseline
\`\`\`

### List available baselines
\`\`\`bash
ls -1 ${BENCHMARK_REPO_DIR}/target/criterion/*/
\`\`\`

EOF

print_success "Comparison complete!"
echo ""
print_info "Results Summary: ${SUMMARY_FILE}"
print_info "Detailed Report: ${REPORT_FILE}"
print_info "HTML Reports: ${BENCHMARK_REPO_DIR}/target/criterion/report/index.html"
echo ""
print_info "To view HTML reports:"
print_info "  xdg-open ${BENCHMARK_REPO_DIR}/target/criterion/report/index.html"
