#!/bin/bash

# Performance Comparison Script
# This script runs benchmarks in both repositories and provides guidance for comparison

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEPS_REPO="$SCRIPT_DIR"
MAIN_REPO="$(dirname "$SCRIPT_DIR")/bigweaver-agent-canary-hydro-zeta"

echo "=================================================="
echo "Cross-Repository Benchmark Comparison"
echo "=================================================="
echo ""
echo "This script will run benchmarks in both repositories:"
echo "  1. bigweaver-agent-canary-zeta-hydro-deps (timely/differential)"
echo "  2. bigweaver-agent-canary-hydro-zeta (Hydroflow)"
echo ""

# Check if main repo exists
if [ ! -d "$MAIN_REPO" ]; then
    echo "ERROR: Main repository not found at: $MAIN_REPO"
    echo "Please ensure both repositories are in the same parent directory."
    exit 1
fi

echo "Repositories found:"
echo "  - Deps repo: $DEPS_REPO"
echo "  - Main repo: $MAIN_REPO"
echo ""

# Function to run benchmarks
run_benchmarks() {
    local repo=$1
    local name=$2
    
    echo "=================================================="
    echo "Running benchmarks in $name"
    echo "=================================================="
    cd "$repo"
    
    if [ "$name" == "deps repository" ]; then
        cargo bench --no-fail-fast
    else
        cargo bench -p benches --no-fail-fast
    fi
    
    echo ""
    echo "Benchmarks completed for $name"
    echo "Results saved to: $repo/target/criterion/"
    echo ""
}

# Ask user what to do
echo "What would you like to do?"
echo "  1) Run benchmarks in both repositories"
echo "  2) Run benchmarks in deps repository only (timely/differential)"
echo "  3) Run benchmarks in main repository only (Hydroflow)"
echo "  4) Show comparison instructions"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo ""
        echo "Running benchmarks in both repositories..."
        echo ""
        run_benchmarks "$DEPS_REPO" "deps repository"
        run_benchmarks "$MAIN_REPO" "main repository"
        ;;
    2)
        echo ""
        echo "Running benchmarks in deps repository only..."
        echo ""
        run_benchmarks "$DEPS_REPO" "deps repository"
        ;;
    3)
        echo ""
        echo "Running benchmarks in main repository only..."
        echo ""
        run_benchmarks "$MAIN_REPO" "main repository"
        ;;
    4)
        # Just show instructions
        ;;
    *)
        echo "Invalid choice. Showing instructions only."
        ;;
esac

echo "=================================================="
echo "Comparison Instructions"
echo "=================================================="
echo ""
echo "Benchmark results are saved in Criterion format:"
echo ""
echo "  Timely/Differential results:"
echo "    $DEPS_REPO/target/criterion/"
echo ""
echo "  Hydroflow results:"
echo "    $MAIN_REPO/target/criterion/"
echo ""
echo "To compare results:"
echo ""
echo "1. View HTML Reports:"
echo "   Open the HTML files in a browser:"
echo "   - $DEPS_REPO/target/criterion/report/index.html"
echo "   - $MAIN_REPO/target/criterion/report/index.html"
echo ""
echo "2. Compare Specific Benchmarks:"
echo "   Look for matching benchmark names across repositories:"
echo "   - arithmetic/timely (deps) vs arithmetic/dfir_rs/* (main)"
echo "   - reachability/differential (deps) vs reachability/dfir_rs/* (main)"
echo ""
echo "3. Command-line Comparison:"
echo "   Use criterion-table or critcmp tools:"
echo "   cargo install critcmp"
echo "   critcmp --basedir $DEPS_REPO/target/criterion \\"
echo "            --basedir $MAIN_REPO/target/criterion"
echo ""
echo "4. Benchmark Mappings:"
echo "   Deps Repository          | Main Repository"
echo "   -------------------------|------------------------"
echo "   arithmetic/timely        | arithmetic/dfir_rs/*"
echo "   fan_in/timely            | fan_in/dfir_rs/*"
echo "   fan_out/timely           | fan_out/dfir_rs/*"
echo "   fork_join/timely         | fork_join/dfir_rs/*"
echo "   identity/timely          | identity/dfir_rs/*"
echo "   join/timely              | join/dfir_rs/*"
echo "   reachability/timely      | reachability/dfir_rs/*"
echo "   reachability/differential| reachability/dfir_rs/*"
echo "   upcase/timely            | upcase/dfir_rs/*"
echo ""
echo "=================================================="
echo "Done!"
echo "=================================================="
