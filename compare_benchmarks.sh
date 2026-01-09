#!/bin/bash
# Cross-repository benchmark comparison script

set -e

DEPS_REPO_PATH="${DEPS_REPO_PATH:-$(pwd)}"
HYDRO_REPO_PATH="${HYDRO_REPO_PATH:-../bigweaver-agent-canary-hydro-zeta}"
OUTPUT_DIR="${OUTPUT_DIR:-./benchmark_results}"

echo "=== Cross-Repository Benchmark Comparison ==="
echo "Deps Repository: $DEPS_REPO_PATH"
echo "Hydro Repository: $HYDRO_REPO_PATH"
echo "Output Directory: $OUTPUT_DIR"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Run benchmarks in deps repository
echo "Running benchmarks in deps repository..."
cd "$DEPS_REPO_PATH"
cargo bench --bench reachability -- --save-baseline deps-baseline 2>&1 | tee "$OUTPUT_DIR/deps-reachability.log"
cargo bench --bench arithmetic -- --save-baseline deps-baseline 2>&1 | tee "$OUTPUT_DIR/deps-arithmetic.log"
cargo bench --bench join -- --save-baseline deps-baseline 2>&1 | tee "$OUTPUT_DIR/deps-join.log"

echo ""
echo "=== Benchmark Results ==="
echo "Results saved to: $OUTPUT_DIR"
echo ""
echo "To view detailed HTML reports, open:"
echo "  $DEPS_REPO_PATH/target/criterion/*/report/index.html"
echo ""
echo "To compare with hydro-native implementations (if available):"
echo "  1. Run equivalent benchmarks in $HYDRO_REPO_PATH"
echo "  2. Compare criterion baseline reports"
echo "  3. Use: cargo bench -- --baseline deps-baseline"
