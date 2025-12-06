#!/bin/bash
# Performance Comparison Script
# 
# This script helps compare performance between Timely/Differential benchmarks
# in this repository and Hydro implementations in the main repository.
#
# Usage:
#   ./compare_performance.sh [benchmark_name]
#
# Examples:
#   ./compare_performance.sh              # Run all benchmarks
#   ./compare_performance.sh reachability # Run only reachability benchmark

set -e

BENCHMARK=${1:-""}
MAIN_REPO="../bigweaver-agent-canary-hydro-zeta"

echo "==================================="
echo "Hydro Performance Comparison Tool"
echo "==================================="
echo ""

# Check if main repository exists
if [ ! -d "$MAIN_REPO" ]; then
    echo "Warning: Main Hydro repository not found at $MAIN_REPO"
    echo "Clone it with:"
    echo "  git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git $MAIN_REPO"
    echo ""
    echo "Continuing with benchmarks from this repository only..."
    echo ""
fi

# Run benchmarks in this repository
echo "Running Timely/Differential benchmarks..."
echo ""

if [ -z "$BENCHMARK" ]; then
    cargo bench -p benches -- --save-baseline timely-differential
else
    cargo bench -p benches --bench "$BENCHMARK" -- --save-baseline timely-differential
fi

echo ""
echo "==================================="
echo "Benchmarks Complete"
echo "==================================="
echo ""
echo "Results saved to: target/criterion/"
echo ""

# If main repo exists and has benchmarks, offer to run those too
if [ -d "$MAIN_REPO" ] && [ -d "$MAIN_REPO/benches" ]; then
    echo "Main Hydro repository found with benchmarks."
    echo "Would you like to run Hydro benchmarks for comparison? (y/n)"
    read -r response
    
    if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
        echo ""
        echo "Running Hydro benchmarks..."
        cd "$MAIN_REPO"
        
        if [ -z "$BENCHMARK" ]; then
            cargo bench -p benches -- --save-baseline hydro
        else
            cargo bench -p benches --bench "$BENCHMARK" -- --save-baseline hydro
        fi
        
        echo ""
        echo "==================================="
        echo "Comparison Complete"
        echo "==================================="
        echo ""
        echo "View results:"
        echo "  - Timely/Differential: $(pwd)/../target/criterion/"
        echo "  - Hydro: $(pwd)/target/criterion/"
    fi
fi

echo ""
echo "To compare specific benchmarks, use:"
echo "  cargo bench -p benches --bench <name> -- --baseline timely-differential"
