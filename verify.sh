#!/bin/bash
# Verification script for migrated timely and differential-dataflow benchmarks

set -e

REPO_ROOT="/projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps"
cd "$REPO_ROOT"

echo "================================================"
echo "Timely Benchmarks Migration Verification Script"
echo "================================================"
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_section() {
    echo ""
    echo "=== $1 ==="
}

# Check if cargo is available
check_cargo() {
    print_section "Checking for Rust toolchain"
    if command -v cargo &> /dev/null; then
        print_success "Cargo found: $(cargo --version)"
        return 0
    else
        print_warning "Cargo not found - skipping build and benchmark tests"
        print_warning "Install Rust from https://rustup.rs/ to run full verification"
        return 1
    fi
}

# Check file structure
check_files() {
    print_section "Checking File Structure"
    
    local missing_files=0
    
    # Check benchmark files
    for file in arithmetic.rs fan_in.rs fan_out.rs fork_join.rs identity.rs join.rs reachability.rs upcase.rs; do
        if [ -f "timely-benchmarks/benches/$file" ]; then
            print_success "Found benchmark: $file"
        else
            print_error "Missing benchmark: $file"
            ((missing_files++))
        fi
    done
    
    # Check data files
    for file in reachability_edges.txt reachability_reachable.txt words_alpha.txt; do
        if [ -f "timely-benchmarks/benches/$file" ]; then
            size=$(du -h "timely-benchmarks/benches/$file" | cut -f1)
            print_success "Found data file: $file ($size)"
        else
            print_error "Missing data file: $file"
            ((missing_files++))
        fi
    done
    
    # Check config files
    for file in Cargo.toml timely-benchmarks/Cargo.toml timely-benchmarks/build.rs; do
        if [ -f "$file" ]; then
            print_success "Found config: $file"
        else
            print_error "Missing config: $file"
            ((missing_files++))
        fi
    done
    
    # Check documentation
    for file in README.md MIGRATION.md VERIFICATION_CHECKLIST.md timely-benchmarks/README.md; do
        if [ -f "$file" ]; then
            print_success "Found documentation: $file"
        else
            print_warning "Missing documentation: $file"
        fi
    done
    
    if [ $missing_files -eq 0 ]; then
        print_success "All required files present"
        return 0
    else
        print_error "$missing_files required file(s) missing"
        return 1
    fi
}

# Check for unwanted dependencies
check_dependencies() {
    print_section "Checking Dependencies"
    
    local has_issues=0
    
    # Check that dfir_rs is not imported
    echo "Checking for removed dfir_rs imports..."
    if grep -r "use dfir_rs::" timely-benchmarks/benches/*.rs &> /dev/null; then
        print_error "Found dfir_rs imports - these should be removed"
        grep -n "use dfir_rs::" timely-benchmarks/benches/*.rs
        ((has_issues++))
    else
        print_success "No dfir_rs imports found (correct)"
    fi
    
    # Check that sinktools is not imported
    if grep -r "use.*sinktools" timely-benchmarks/benches/*.rs &> /dev/null; then
        print_error "Found sinktools imports - these should be removed"
        grep -n "sinktools" timely-benchmarks/benches/*.rs
        ((has_issues++))
    else
        print_success "No sinktools imports found (correct)"
    fi
    
    # Check that dfir_syntax is not used
    if grep -r "dfir_syntax!" timely-benchmarks/benches/*.rs &> /dev/null; then
        print_error "Found dfir_syntax! macro usage - this should be removed"
        grep -n "dfir_syntax!" timely-benchmarks/benches/*.rs
        ((has_issues++))
    else
        print_success "No dfir_syntax! macros found (correct)"
    fi
    
    # Check for timely imports (should exist)
    if grep -r "use timely::" timely-benchmarks/benches/*.rs &> /dev/null; then
        print_success "Found timely imports (correct)"
    else
        print_warning "No timely imports found - expected at least some"
    fi
    
    # Check for differential imports (should exist in at least one file)
    if grep -r "use differential_dataflow::" timely-benchmarks/benches/*.rs &> /dev/null; then
        print_success "Found differential-dataflow imports (correct)"
    else
        print_warning "No differential-dataflow imports found"
    fi
    
    if [ $has_issues -eq 0 ]; then
        print_success "Dependencies check passed"
        return 0
    else
        print_error "Found $has_issues dependency issue(s)"
        return 1
    fi
}

# Check data file integrity
check_data_files() {
    print_section "Checking Data File Integrity"
    
    local has_issues=0
    
    # Check reachability_edges.txt
    if [ -f "timely-benchmarks/benches/reachability_edges.txt" ]; then
        lines=$(wc -l < timely-benchmarks/benches/reachability_edges.txt)
        print_success "reachability_edges.txt has $lines lines"
    else
        print_error "reachability_edges.txt not found"
        ((has_issues++))
    fi
    
    # Check reachability_reachable.txt
    if [ -f "timely-benchmarks/benches/reachability_reachable.txt" ]; then
        lines=$(wc -l < timely-benchmarks/benches/reachability_reachable.txt)
        print_success "reachability_reachable.txt has $lines lines"
    else
        print_error "reachability_reachable.txt not found"
        ((has_issues++))
    fi
    
    # Check words_alpha.txt
    if [ -f "timely-benchmarks/benches/words_alpha.txt" ]; then
        lines=$(wc -l < timely-benchmarks/benches/words_alpha.txt)
        print_success "words_alpha.txt has $lines lines"
    else
        print_error "words_alpha.txt not found"
        ((has_issues++))
    fi
    
    if [ $has_issues -eq 0 ]; then
        print_success "Data files integrity check passed"
        return 0
    else
        print_error "Found $has_issues data file issue(s)"
        return 1
    fi
}

# Main execution
main() {
    local total_checks=0
    local passed_checks=0
    local cargo_available=0
    
    # Run file checks
    ((total_checks++))
    if check_files; then
        ((passed_checks++))
    fi
    
    # Run dependency checks
    ((total_checks++))
    if check_dependencies; then
        ((passed_checks++))
    fi
    
    # Run data file checks
    ((total_checks++))
    if check_data_files; then
        ((passed_checks++))
    fi
    
    # Check for cargo
    if check_cargo; then
        cargo_available=1
        
        print_section "Running Cargo Checks"
        
        # Cargo check
        ((total_checks++))
        if cargo check --workspace 2>&1 | grep -q "Finished"; then
            print_success "Cargo check passed"
            ((passed_checks++))
        else
            print_error "Cargo check failed"
        fi
    fi
    
    # Summary
    print_section "Verification Summary"
    echo ""
    echo "Checks passed: $passed_checks / $total_checks"
    echo ""
    
    if [ $passed_checks -eq $total_checks ]; then
        print_success "All verification checks passed! ✅"
        echo ""
        if [ $cargo_available -eq 1 ]; then
            echo "Next steps:"
            echo "  • Run full benchmark suite: cargo bench --workspace"
            echo "  • Run specific benchmark: cargo bench -p timely-benchmarks --bench arithmetic"
            echo "  • View results in: target/criterion/"
        else
            echo "Install Rust to run benchmarks:"
            echo "  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
        fi
        return 0
    else
        print_error "Some verification checks failed ❌"
        echo ""
        echo "Please review the errors above and fix before proceeding."
        return 1
    fi
}

# Run main
main
exit $?
