#!/bin/bash

# Script to run all benchmarks and save results
# Usage: ./run_benchmarks.sh [output_dir]

set -e

OUTPUT_DIR="${1:-./results}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "Running benchmarks and saving results to ${OUTPUT_DIR}/${TIMESTAMP}/"
mkdir -p "${OUTPUT_DIR}/${TIMESTAMP}"

echo "Running timely reachability benchmark..."
cargo bench --bench timely_reachability | tee "${OUTPUT_DIR}/${TIMESTAMP}/timely_reachability.txt"

echo "Running differential dataflow operations benchmark..."
cargo bench --bench differential_dataflow_ops | tee "${OUTPUT_DIR}/${TIMESTAMP}/differential_dataflow_ops.txt"

echo ""
echo "Benchmark results saved to:"
echo "  - ${OUTPUT_DIR}/${TIMESTAMP}/timely_reachability.txt"
echo "  - ${OUTPUT_DIR}/${TIMESTAMP}/differential_dataflow_ops.txt"
echo ""
echo "To compare with Hydro benchmarks, run the equivalent benchmarks in the main repository."
