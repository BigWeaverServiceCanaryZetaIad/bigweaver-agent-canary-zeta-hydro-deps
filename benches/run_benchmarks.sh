#!/bin/bash
# Quick benchmark runner script
# 
# Usage:
#   ./run_benchmarks.sh              # Run all benchmarks
#   ./run_benchmarks.sh arithmetic   # Run specific benchmark

cd "$(dirname "$0")"

if [ $# -eq 0 ]; then
    echo "Running all benchmarks..."
    cargo bench
else
    echo "Running benchmark: $1"
    cargo bench --bench "$1"
fi

echo ""
echo "Results saved to: target/criterion/"
echo ""
echo "Available benchmarks:"
echo "  - arithmetic:     Pipeline arithmetic operations"
echo "  - fan_in:         Fan-in pattern"
echo "  - fan_out:        Fan-out pattern"
echo "  - fork_join:      Fork-join pattern"
echo "  - identity:       Identity operations"
echo "  - join:           Join operations"
echo "  - reachability:   Graph reachability"
echo "  - upcase:         String transformation"
