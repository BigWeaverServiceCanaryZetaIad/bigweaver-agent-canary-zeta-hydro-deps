#!/bin/bash
# Cross-repository benchmark comparison script
# This script runs benchmarks in both repositories and compares the results

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPS_REPO_DIR="$(dirname "$SCRIPT_DIR")"
MAIN_REPO_DIR="${MAIN_REPO_DIR:-../bigweaver-agent-canary-hydro-zeta}"

echo "====================================="
echo "Cross-Repository Benchmark Comparison"
echo "====================================="
echo ""

# Check if main repository exists
if [ ! -d "$MAIN_REPO_DIR" ]; then
    echo "Error: Main repository not found at: $MAIN_REPO_DIR"
    echo "Please set MAIN_REPO_DIR environment variable or ensure the repository is at ../bigweaver-agent-canary-hydro-zeta"
    exit 1
fi

# Run benchmarks in the deps repository (timely/differential benchmarks)
echo "Running timely/differential-dataflow benchmarks in deps repository..."
cd "$DEPS_REPO_DIR"
cargo bench -p timely-differential-benches --no-fail-fast

echo ""
echo "====================================="
echo "Timely/Differential benchmarks completed"
echo "====================================="
echo ""

# Check if main repository has benchmarks to run
if [ -f "$MAIN_REPO_DIR/Cargo.toml" ]; then
    echo "Running benchmarks in main repository..."
    cd "$MAIN_REPO_DIR"
    
    # Check if there's a benches package
    if cargo metadata --no-deps --format-version 1 2>/dev/null | grep -q '"name":"benches"'; then
        cargo bench -p benches --no-fail-fast
        echo ""
        echo "====================================="
        echo "Main repository benchmarks completed"
        echo "====================================="
    else
        echo "No benchmark package found in main repository"
    fi
else
    echo "Main repository does not have a Cargo.toml file"
fi

echo ""
echo "====================================="
echo "All benchmarks completed!"
echo "====================================="
echo ""
echo "Results are saved in target/criterion directories of each repository"
echo "To view detailed results, open target/criterion/report/index.html in each repository"
