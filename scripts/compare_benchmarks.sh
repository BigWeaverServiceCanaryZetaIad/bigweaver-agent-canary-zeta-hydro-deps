#!/bin/bash
#
# Cross-Repository Benchmark Comparison Script
# ============================================
#
# Purpose:
#   This script automates performance comparison between timely/differential-dataflow
#   benchmarks (in this repository) and hydro-native benchmarks (in the main repository).
#
# Usage:
#   ./scripts/compare_benchmarks.sh
#
#   Or with custom main repository path:
#   MAIN_REPO_DIR=/path/to/main/repo ./scripts/compare_benchmarks.sh
#
# What it does:
#   1. Runs all timely/differential-dataflow benchmarks in this repository
#   2. Checks if the main repository exists and has benchmarks
#   3. Runs benchmarks in the main repository (if available)
#   4. Saves results in target/criterion directories for comparison
#
# Output:
#   - Console output showing benchmark progress and results
#   - HTML reports in target/criterion/report/index.html (each repository)
#   - Raw benchmark data in target/criterion/<benchmark-name>/ directories
#
# Environment Variables:
#   MAIN_REPO_DIR - Path to the main repository (default: ../bigweaver-agent-canary-hydro-zeta)
#
# Exit Codes:
#   0 - Success (all available benchmarks completed)
#   1 - Main repository not found
#   Other - Benchmark execution failure
#

set -e

# Determine repository paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPS_REPO_DIR="$(dirname "$SCRIPT_DIR)"
MAIN_REPO_DIR="${MAIN_REPO_DIR:-../bigweaver-agent-canary-hydro-zeta}"


echo "====================================="
echo "Cross-Repository Benchmark Comparison"
echo "====================================="
echo ""
echo "Repositories:"
echo "  - Deps repo (timely/differential): $DEPS_REPO_DIR"
echo "  - Main repo (hydro):               $MAIN_REPO_DIR"
echo ""

# Check if main repository exists
if [ ! -d "$MAIN_REPO_DIR" ]; then
    echo "Error: Main repository not found at: $MAIN_REPO_DIR"
    echo "Please set MAIN_REPO_DIR environment variable or ensure the repository is at ../bigweaver-agent-canary-hydro-zeta"
    echo ""
    echo "Example: MAIN_REPO_DIR=/path/to/repo ./scripts/compare_benchmarks.sh"
    exit 1
fi

# Step 1: Run timely/differential benchmarks in this repository
echo "Step 1: Running timely/differential-dataflow benchmarks..."
echo "------------------------------------------------------"
cd "$DEPS_REPO_DIR"
echo "Running: cargo bench -p timely-differential-benches --no-fail-fast"
echo ""
cargo bench -p timely-differential-benches --no-fail-fast

echo ""
echo "====================================="
echo "✓ Timely/Differential benchmarks completed"
echo "====================================="
echo "Results saved in: $DEPS_REPO_DIR/target/criterion/"
echo ""

# Step 2: Check if main repository has benchmarks to run
echo "Step 2: Checking main repository for benchmarks..."
echo "------------------------------------------------"
if [ -f "$MAIN_REPO_DIR/Cargo.toml" ]; then
    cd "$MAIN_REPO_DIR"
    
    # Check if there's a benches package
    if cargo metadata --no-deps --format-version 1 2>/dev/null | grep -q '"name":"benches"'; then
        echo "Found benchmark package in main repository"
        echo "Running: cargo bench -p benches --no-fail-fast"
        echo ""
        cargo bench -p benches --no-fail-fast
        echo ""
        echo "====================================="
        echo "✓ Main repository benchmarks completed"
        echo "====================================="
        echo "Results saved in: $MAIN_REPO_DIR/target/criterion/"
    else
        echo "ℹ No benchmark package found in main repository"
        echo "  This is expected if hydro-native benchmarks haven't been added yet"
    fi
else
    echo "ℹ Main repository does not have a Cargo.toml file"
fi

echo ""
echo "====================================="
echo "✓ All benchmarks completed successfully!"
echo "====================================="
echo ""
echo "Next Steps:"
echo "  1. View detailed results:"
echo "     - Timely/Differential: $DEPS_REPO_DIR/target/criterion/report/index.html"
echo "     - Main repository:     $MAIN_REPO_DIR/target/criterion/report/index.html"
echo ""
echo "  2. Compare key metrics:"
echo "     - Throughput (items/sec)"
echo "     - Latency (time/operation)"
echo "     - Scalability characteristics"
echo ""
echo "  3. To run specific benchmarks:"
echo "     cargo bench -p timely-differential-benches --bench <benchmark-name>"
echo ""
