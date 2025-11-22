#!/bin/bash
# Script to compare performance between different versions

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

Compare performance between different versions of the main repository.

This script automates the process of:
1. Saving a baseline from one version
2. Switching to another version
3. Running benchmarks and comparing results

OPTIONS:
    -h, --help                  Show this help message
    -b, --baseline NAME         Name for the baseline (default: baseline)
    -m, --main-repo PATH        Path to main repository (default: ../bigweaver-agent-canary-hydro-zeta)
    --baseline-commit HASH      Commit hash for baseline version
    --compare-commit HASH       Commit hash for comparison version
    --baseline-branch NAME      Branch name for baseline version
    --compare-branch NAME       Branch name for comparison version
    --bench NAME                Run specific benchmark only
    --fast                      Run fast benchmarks only
    --no-restore                Don't restore original branch after comparison

EXAMPLES:
    # Compare current branch against main
    $0 --baseline-branch main --compare-branch feature-xyz

    # Compare specific commits
    $0 --baseline-commit abc123 --compare-commit def456

    # Compare specific benchmark only
    $0 --baseline-branch main --compare-branch optimization --bench identity

    # Quick comparison with fast benchmarks
    $0 --baseline-branch main --fast

WORKFLOW:
    1. Script switches main repo to baseline version
    2. Runs benchmarks and saves as baseline
    3. Switches main repo to comparison version
    4. Runs benchmarks comparing against baseline
    5. Displays results
    6. Optionally restores original branch

EOF
    exit 0
}

# Default values
BASELINE_NAME="comparison-baseline"
MAIN_REPO_PATH="../bigweaver-agent-canary-hydro-zeta"
BASELINE_COMMIT=""
COMPARE_COMMIT=""
BASELINE_BRANCH=""
COMPARE_BRANCH=""
BENCH_NAME=""
FAST_MODE=false
RESTORE_BRANCH=true
ORIGINAL_BRANCH=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -b|--baseline)
            BASELINE_NAME="$2"
            shift 2
            ;;
        -m|--main-repo)
            MAIN_REPO_PATH="$2"
            shift 2
            ;;
        --baseline-commit)
            BASELINE_COMMIT="$2"
            shift 2
            ;;
        --compare-commit)
            COMPARE_COMMIT="$2"
            shift 2
            ;;
        --baseline-branch)
            BASELINE_BRANCH="$2"
            shift 2
            ;;
        --compare-branch)
            COMPARE_BRANCH="$2"
            shift 2
            ;;
        --bench)
            BENCH_NAME="$2"
            shift 2
            ;;
        --fast)
            FAST_MODE=true
            shift
            ;;
        --no-restore)
            RESTORE_BRANCH=false
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Validation
if [ -z "$BASELINE_COMMIT" ] && [ -z "$BASELINE_BRANCH" ]; then
    print_error "Must specify either --baseline-commit or --baseline-branch"
    exit 1
fi

if [ -z "$COMPARE_COMMIT" ] && [ -z "$COMPARE_BRANCH" ]; then
    print_warning "No comparison version specified, using current HEAD"
fi

# Verify main repository exists
if [ ! -d "$MAIN_REPO_PATH" ]; then
    print_error "Main repository not found at: $MAIN_REPO_PATH"
    print_error "Please specify correct path with --main-repo"
    exit 1
fi

# Verify we're in the benchmark repository
if [ ! -f "Cargo.toml" ]; then
    print_error "Cargo.toml not found. Please run this script from the benchmark repository root."
    exit 1
fi

# Function to checkout version in main repo
checkout_version() {
    local version=$1
    local type=$2  # "commit" or "branch"
    
    cd "$MAIN_REPO_PATH"
    
    if [ "$type" = "commit" ]; then
        print_info "Checking out commit: $version"
        git checkout "$version"
    else
        print_info "Checking out branch: $version"
        git checkout "$version"
        git pull --ff-only || print_warning "Could not fast-forward branch"
    fi
    
    cd - > /dev/null
}

# Function to run benchmarks
run_benchmarks() {
    local mode=$1  # "baseline" or "compare"
    local extra_args=""
    
    if [ "$mode" = "baseline" ]; then
        extra_args="-- --save-baseline $BASELINE_NAME"
        print_info "Running benchmarks and saving as baseline: $BASELINE_NAME"
    else
        extra_args="-- --baseline $BASELINE_NAME"
        print_info "Running benchmarks and comparing against baseline: $BASELINE_NAME"
    fi
    
    if [ -n "$BENCH_NAME" ]; then
        print_info "Running specific benchmark: $BENCH_NAME"
        cargo bench --bench "$BENCH_NAME" $extra_args
    elif [ "$FAST_MODE" = true ]; then
        print_info "Running fast benchmarks only"
        cargo bench --bench identity $extra_args
        cargo bench --bench arithmetic $extra_args
        cargo bench --bench micro_ops $extra_args
    else
        print_info "Running all benchmarks"
        cargo bench $extra_args
    fi
}

# Main execution
print_info "Starting performance comparison..."
print_info "Baseline name: $BASELINE_NAME"
print_info "Main repository: $MAIN_REPO_PATH"

# Save original branch if we need to restore
if [ "$RESTORE_BRANCH" = true ]; then
    cd "$MAIN_REPO_PATH"
    ORIGINAL_BRANCH=$(git branch --show-current)
    print_info "Current branch: $ORIGINAL_BRANCH (will be restored after comparison)"
    cd - > /dev/null
fi

# Step 1: Checkout baseline version
print_info "=== Step 1: Setting up baseline version ==="
if [ -n "$BASELINE_COMMIT" ]; then
    checkout_version "$BASELINE_COMMIT" "commit"
else
    checkout_version "$BASELINE_BRANCH" "branch"
fi

# Step 2: Run baseline benchmarks
print_info "=== Step 2: Running baseline benchmarks ==="
run_benchmarks "baseline"
print_success "Baseline benchmarks completed"

# Step 3: Checkout comparison version
if [ -n "$COMPARE_COMMIT" ] || [ -n "$COMPARE_BRANCH" ]; then
    print_info "=== Step 3: Setting up comparison version ==="
    if [ -n "$COMPARE_COMMIT" ]; then
        checkout_version "$COMPARE_COMMIT" "commit"
    else
        checkout_version "$COMPARE_BRANCH" "branch"
    fi
else
    print_info "=== Step 3: Using current version for comparison ==="
fi

# Step 4: Run comparison benchmarks
print_info "=== Step 4: Running comparison benchmarks ==="
run_benchmarks "compare"
print_success "Comparison benchmarks completed"

# Step 5: Display results
print_info "=== Step 5: Results ==="
print_success "Performance comparison complete!"
print_info "Detailed results are in the output above and in HTML reports"
print_info "HTML reports: target/criterion/report/index.html"

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

# Step 6: Restore original branch
if [ "$RESTORE_BRANCH" = true ] && [ -n "$ORIGINAL_BRANCH" ]; then
    print_info "=== Step 6: Restoring original branch ==="
    cd "$MAIN_REPO_PATH"
    git checkout "$ORIGINAL_BRANCH"
    cd - > /dev/null
    print_success "Restored to branch: $ORIGINAL_BRANCH"
else
    print_warning "Original branch not restored. Main repository is at comparison version."
fi

print_success "Performance comparison workflow complete!"
