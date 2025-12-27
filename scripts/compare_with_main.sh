#!/usr/bin/env bash
#
# compare_with_main.sh
#
# This script runs benchmarks in both the main Hydro repository and this
# comparison repository, then aggregates the results for easy comparison.
#
# Usage:
#   ./scripts/compare_with_main.sh [OPTIONS]
#
# Options:
#   --main-repo PATH     Path to main repository (default: ../bigweaver-agent-canary-hydro-zeta)
#   --baseline NAME      Save results as baseline with given name
#   --compare NAME       Compare results against named baseline
#   --no-main            Skip running benchmarks in main repository
#   --no-deps            Skip running benchmarks in deps repository
#   --bench PATTERN      Run only benchmarks matching pattern
#   --help               Show this help message
#

set -euo pipefail

# Default configuration
MAIN_REPO="../bigweaver-agent-canary-hydro-zeta"
RUN_MAIN=true
RUN_DEPS=true
BASELINE_NAME=""
COMPARE_BASELINE=""
BENCH_PATTERN=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --main-repo)
            MAIN_REPO="$2"
            shift 2
            ;;
        --baseline)
            BASELINE_NAME="$2"
            shift 2
            ;;
        --compare)
            COMPARE_BASELINE="$2"
            shift 2
            ;;
        --no-main)
            RUN_MAIN=false
            shift
            ;;
        --no-deps)
            RUN_DEPS=false
            shift
            ;;
        --bench)
            BENCH_PATTERN="$2"
            shift 2
            ;;
        --help)
            grep "^#" "$0" | grep -v "^#!/" | sed 's/^# \?//'
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_command() {
    if ! command -v "$1" &> /dev/null; then
        log_error "$1 is required but not installed"
        return 1
    fi
    return 0
}

# Verify prerequisites
log_info "Checking prerequisites..."
check_command cargo || exit 1
check_command git || exit 1

# Verify repository paths
if [[ "$RUN_MAIN" == true ]] && [[ ! -d "$MAIN_REPO" ]]; then
    log_error "Main repository not found at: $MAIN_REPO"
    log_info "Use --main-repo to specify correct path or --no-main to skip"
    exit 1
fi

if [[ "$RUN_MAIN" == true ]] && [[ ! -f "$MAIN_REPO/Cargo.toml" ]]; then
    log_error "Invalid main repository (Cargo.toml not found): $MAIN_REPO"
    exit 1
fi

# Build benchmark command options
BENCH_OPTS=()
if [[ -n "$BASELINE_NAME" ]]; then
    BENCH_OPTS+=("--save-baseline" "$BASELINE_NAME")
elif [[ -n "$COMPARE_BASELINE" ]]; then
    BENCH_OPTS+=("--baseline" "$COMPARE_BASELINE")
fi

if [[ -n "$BENCH_PATTERN" ]]; then
    BENCH_OPTS+=("--bench" "$BENCH_PATTERN")
fi

# Run main repository benchmarks
if [[ "$RUN_MAIN" == true ]]; then
    log_info "Running benchmarks in main repository..."
    log_info "Repository: $MAIN_REPO"
    
    cd "$MAIN_REPO"
    
    # Check if benches package exists
    if cargo metadata --no-deps --format-version 1 2>/dev/null | grep -q '"name":"benches"'; then
        log_info "Building and running DFIR-native benchmarks..."
        
        if cargo bench -p benches "${BENCH_OPTS[@]}" 2>&1 | tee "$REPO_ROOT/main_bench.log"; then
            log_success "Main repository benchmarks completed"
        else
            log_error "Main repository benchmarks failed"
            log_info "Check main_bench.log for details"
            exit 1
        fi
    else
        log_warning "No benches package found in main repository"
    fi
    
    cd "$REPO_ROOT"
fi

# Run comparison repository benchmarks
if [[ "$RUN_DEPS" == true ]]; then
    log_info "Running comparison benchmarks in deps repository..."
    log_info "Repository: $REPO_ROOT"
    
    cd "$REPO_ROOT"
    
    # Update dependencies to get latest DFIR
    log_info "Updating dependencies to latest DFIR..."
    if ! cargo update 2>&1 | tee "$REPO_ROOT/deps_update.log"; then
        log_warning "Dependency update had issues (continuing anyway)"
    fi
    
    log_info "Building and running comparison benchmarks..."
    if cargo bench "${BENCH_OPTS[@]}" 2>&1 | tee "$REPO_ROOT/deps_bench.log"; then
        log_success "Comparison benchmarks completed"
    else
        log_error "Comparison benchmarks failed"
        log_info "Check deps_bench.log for details"
        exit 1
    fi
fi

# Generate summary
log_info "Generating benchmark summary..."

SUMMARY_FILE="$REPO_ROOT/benchmark_summary.txt"
{
    echo "Benchmark Comparison Summary"
    echo "============================"
    echo ""
    echo "Date: $(date)"
    echo ""
    
    if [[ "$RUN_MAIN" == true ]]; then
        echo "Main Repository: $MAIN_REPO"
        echo "Main Repository Results: $MAIN_REPO/target/criterion/"
        echo ""
    fi
    
    if [[ "$RUN_DEPS" == true ]]; then
        echo "Deps Repository: $REPO_ROOT"
        echo "Deps Repository Results: $REPO_ROOT/target/criterion/"
        echo ""
    fi
    
    if [[ -n "$BASELINE_NAME" ]]; then
        echo "Results saved as baseline: $BASELINE_NAME"
    elif [[ -n "$COMPARE_BASELINE" ]]; then
        echo "Results compared against baseline: $COMPARE_BASELINE"
    fi
    
    echo ""
    echo "Benchmark Categories Run:"
    echo "------------------------"
    
    if [[ "$RUN_DEPS" == true ]] && [[ -d "$REPO_ROOT/target/criterion" ]]; then
        find "$REPO_ROOT/target/criterion" -name "report" -type d | \
            sed 's|.*/criterion/||' | sed 's|/report||' | sort | \
            while read -r bench; do
                echo "  - $bench"
            done
    fi
    
    echo ""
    echo "To view detailed results:"
    echo "------------------------"
    
    if [[ "$RUN_MAIN" == true ]]; then
        echo "Main repository HTML reports:"
        echo "  open $MAIN_REPO/target/criterion/report/index.html"
        echo ""
    fi
    
    if [[ "$RUN_DEPS" == true ]]; then
        echo "Comparison repository HTML reports:"
        echo "  open $REPO_ROOT/target/criterion/report/index.html"
        echo ""
    fi
    
    echo "For command-line summary:"
    echo "  cat main_bench.log | grep -A 5 'time:'"
    echo "  cat deps_bench.log | grep -A 5 'time:'"
    
} > "$SUMMARY_FILE"

cat "$SUMMARY_FILE"

log_success "Benchmark comparison complete!"
log_info "Summary saved to: $SUMMARY_FILE"

# Try to open HTML reports if on macOS or Linux with GUI
if command -v open &> /dev/null; then
    log_info "Opening HTML reports..."
    if [[ "$RUN_DEPS" == true ]] && [[ -f "$REPO_ROOT/target/criterion/report/index.html" ]]; then
        open "$REPO_ROOT/target/criterion/report/index.html"
    fi
elif command -v xdg-open &> /dev/null; then
    log_info "Opening HTML reports..."
    if [[ "$RUN_DEPS" == true ]] && [[ -f "$REPO_ROOT/target/criterion/report/index.html" ]]; then
        xdg-open "$REPO_ROOT/target/criterion/report/index.html"
    fi
fi

exit 0
