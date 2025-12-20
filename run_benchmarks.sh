#!/bin/bash
# Convenience script to run all benchmarks in this repository

set -e

echo "Running Hydro/DFIR vs Timely/Differential Dataflow comparison benchmarks..."
echo "=========================================================================="
echo ""

cargo bench -p hydro-benches-comparison

echo ""
echo "=========================================================================="
echo "Benchmarks complete!"
echo ""
echo "Results are saved in target/criterion/"
echo "Open target/criterion/report/index.html in a browser to view detailed results."
