#!/bin/bash
# Cross-repository benchmark comparison script
# This script runs benchmarks in both repositories and compares the results
#
# Prerequisites:
# 1. Both repositories must be cloned side-by-side
# 2. Path dependencies in timely-differential-benches/Cargo.toml must be uncommented
#
# Usage:
#   ./scripts/compare_benchmarks.sh [main_repo_path]
#
# If main_repo_path is not provided, defaults to ../bigweaver-agent-canary-hydro-zeta

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPS_REPO_DIR="$(dirname "$SCRIPT_DIR")"
MAIN_REPO_DIR="${1:-${MAIN_REPO_DIR:-../bigweaver-agent-canary-hydro-zeta}}"

echo "====================================="
echo "Cross-Repository Benchmark Comparison"
echo "====================================="
echo ""
echo "Deps repository: $DEPS_REPO_DIR"
echo "Main repository: $MAIN_REPO_DIR"
echo ""

# Check if main repository exists
if [ ! -d "$MAIN_REPO_DIR" ]; then
    echo "Error: Main repository not found at: $MAIN_REPO_DIR"
    echo ""
    echo "Please provide the path to bigweaver-agent-canary-hydro-zeta:"
    echo "  $0 /path/to/bigweaver-agent-canary-hydro-zeta"
    echo ""
    echo "Or set the MAIN_REPO_DIR environment variable:"
    echo "  export MAIN_REPO_DIR=/path/to/bigweaver-agent-canary-hydro-zeta"
    echo "  $0"
    exit 1
fi

# Check if path dependencies are configured
if ! grep -q "^babyflow = { path" "$DEPS_REPO_DIR/timely-differential-benches/Cargo.toml"; then
    echo "Warning: Path dependencies may not be configured in timely-differential-benches/Cargo.toml"
    echo "Please uncomment the following lines in timely-differential-benches/Cargo.toml:"
    echo "  babyflow = { path = \"../../bigweaver-agent-canary-hydro-zeta/babyflow\" }"
    echo "  hydroflow = { path = \"../../bigweaver-agent-canary-hydro-zeta/hydroflow\" }"
    echo "  spinachflow = { path = \"../../bigweaver-agent-canary-hydro-zeta/spinachflow\" }"
    echo ""
    echo "Continuing anyway, but benchmarks may fail..."
    echo ""
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
