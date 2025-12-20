#!/usr/bin/env bash
#
# verify_benchmarks.sh
#
# This script verifies that all benchmarks are properly configured and can be discovered.
#
# Usage:
#   ./scripts/verify_benchmarks.sh
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

log_header() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

cd "$REPO_ROOT"

ERRORS=0

log_header "Benchmark Verification Report"

# Check directory structure
log_info "Checking directory structure..."

if [[ -d "benches/benches" ]]; then
    log_success "Benchmark directory exists: benches/benches/"
else
    log_error "Benchmark directory missing: benches/benches/"
    ((ERRORS++))
fi

# Check Cargo.toml files
log_info "Checking Cargo.toml configuration..."

if [[ -f "Cargo.toml" ]]; then
    log_success "Root Cargo.toml exists"
else
    log_error "Root Cargo.toml missing"
    ((ERRORS++))
fi

if [[ -f "benches/Cargo.toml" ]]; then
    log_success "Benchmark Cargo.toml exists"
else
    log_error "Benchmark Cargo.toml missing"
    ((ERRORS++))
fi

# Expected benchmark files
EXPECTED_BENCHMARKS=(
    "arithmetic"
    "fan_in"
    "fan_out"
    "fork_join"
    "identity"
    "join"
    "reachability"
    "upcase"
)

log_header "Checking Benchmark Files"

for bench in "${EXPECTED_BENCHMARKS[@]}"; do
    BENCH_FILE="benches/benches/${bench}.rs"
    if [[ -f "$BENCH_FILE" ]]; then
        log_success "Benchmark file exists: $bench.rs"
        
        # Check if it has criterion imports
        if grep -q "criterion" "$BENCH_FILE"; then
            log_success "  └─ Has criterion imports"
        else
            log_error "  └─ Missing criterion imports"
            ((ERRORS++))
        fi
        
        # Check if it has main function
        if grep -q "criterion_main" "$BENCH_FILE"; then
            log_success "  └─ Has criterion_main macro"
        else
            log_error "  └─ Missing criterion_main macro"
            ((ERRORS++))
        fi
    else
        log_error "Benchmark file missing: $bench.rs"
        ((ERRORS++))
    fi
done

# Check data files
log_header "Checking Data Files"

DATA_FILES=(
    "benches/benches/reachability_edges.txt"
    "benches/benches/reachability_reachable.txt"
)

for data_file in "${DATA_FILES[@]}"; do
    if [[ -f "$data_file" ]]; then
        SIZE=$(wc -c < "$data_file" | tr -d ' ')
        log_success "Data file exists: $(basename "$data_file") (${SIZE} bytes)"
    else
        log_error "Data file missing: $(basename "$data_file")"
        ((ERRORS++))
    fi
done

# Check Cargo.toml entries
log_header "Checking Cargo.toml Benchmark Entries"

for bench in "${EXPECTED_BENCHMARKS[@]}"; do
    if grep -q "name = \"$bench\"" benches/Cargo.toml; then
        log_success "Cargo.toml entry exists for: $bench"
    else
        log_error "Cargo.toml entry missing for: $bench"
        ((ERRORS++))
    fi
done

# Check dependencies
log_header "Checking Dependencies"

REQUIRED_DEPS=(
    "criterion"
    "dfir_rs"
    "timely"
    "differential-dataflow"
)

for dep in "${REQUIRED_DEPS[@]}"; do
    if grep -q "\"$dep\"" benches/Cargo.toml || grep -q "$dep =" benches/Cargo.toml; then
        log_success "Dependency configured: $dep"
    else
        log_error "Dependency missing: $dep"
        ((ERRORS++))
    fi
done

# Check for timely and differential specific packages
if grep -q 'package = "timely-master"' benches/Cargo.toml; then
    log_success "Timely package correctly aliased"
else
    log_error "Timely package alias missing"
    ((ERRORS++))
fi

if grep -q 'package = "differential-dataflow-master"' benches/Cargo.toml; then
    log_success "Differential-dataflow package correctly aliased"
else
    log_error "Differential-dataflow package alias missing"
    ((ERRORS++))
fi

# Check documentation
log_header "Checking Documentation"

DOC_FILES=(
    "README.md"
    "MIGRATION.md"
    "benches/README.md"
    "BENCHMARK_USAGE.md"
)

for doc in "${DOC_FILES[@]}"; do
    if [[ -f "$doc" ]]; then
        log_success "Documentation exists: $doc"
    else
        log_error "Documentation missing: $doc"
        ((ERRORS++))
    fi
done

# Check scripts
log_header "Checking Scripts"

SCRIPT_FILES=(
    "scripts/compare_with_main.sh"
    "scripts/verify_benchmarks.sh"
)

for script in "${SCRIPT_FILES[@]}"; do
    if [[ -f "$script" ]]; then
        log_success "Script exists: $script"
    else
        log_error "Script missing: $script"
        ((ERRORS++))
    fi
done

# Summary
log_header "Verification Summary"

if [[ $ERRORS -eq 0 ]]; then
    log_success "All verification checks passed!"
    echo ""
    echo "The benchmark suite is properly configured with:"
    echo "  - ${#EXPECTED_BENCHMARKS[@]} benchmark files"
    echo "  - ${#DATA_FILES[@]} data files"
    echo "  - ${#REQUIRED_DEPS[@]} required dependencies"
    echo "  - ${#DOC_FILES[@]} documentation files"
    echo "  - ${#SCRIPT_FILES[@]} helper scripts"
    echo ""
    echo "You can now run benchmarks with:"
    echo "  cargo bench                    # Run all benchmarks"
    echo "  cargo bench --bench arithmetic # Run specific benchmark"
    echo "  ./scripts/compare_with_main.sh # Compare with main repository"
    exit 0
else
    log_error "Verification failed with $ERRORS error(s)"
    echo ""
    echo "Please fix the errors above before running benchmarks."
    exit 1
fi
