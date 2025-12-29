#!/bin/bash
# Helper script to run benchmarks in this repository
# Usage: ./run_benchmarks.bash [options] [benchmark-name]
#        ./run_benchmarks.bash                    # Run all comparison benchmarks
#        ./run_benchmarks.bash --all              # Run all benchmarks (comparison + pure timely/differential)
#        ./run_benchmarks.bash --timely-only      # Run only pure timely/differential benchmarks
#        ./run_benchmarks.bash reachability       # Run specific comparison benchmark
#        ./run_benchmarks.bash --timely-only join # Run specific pure timely/differential benchmark

set -e

RUN_MODE="comparison"
BENCHMARK_NAME=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --all)
            RUN_MODE="all"
            shift
            ;;
        --timely-only)
            RUN_MODE="timely-only"
            shift
            ;;
        *)
            BENCHMARK_NAME="$1"
            shift
            ;;
    esac
done

echo "=== Hydro Timely/Differential Dataflow Benchmarks ==="
echo ""

run_comparison_benchmarks() {
    if [ -z "$BENCHMARK_NAME" ]; then
        echo "Running all comparison benchmarks (Hydro vs Timely/Differential)..."
        echo "This may take several minutes..."
        echo ""
        cargo bench -p benches
    else
        echo "Running comparison benchmark: $BENCHMARK_NAME"
        echo ""
        cargo bench -p benches --bench "$BENCHMARK_NAME"
    fi
}

run_timely_benchmarks() {
    if [ -z "$BENCHMARK_NAME" ]; then
        echo "Running all pure Timely/Differential benchmarks..."
        echo "This may take several minutes..."
        echo ""
        cargo bench -p timely-differential-benches
    else
        echo "Running pure Timely/Differential benchmark: $BENCHMARK_NAME"
        echo ""
        cargo bench -p timely-differential-benches --bench "$BENCHMARK_NAME"
    fi
}

case $RUN_MODE in
    all)
        run_comparison_benchmarks
        echo ""
        echo "---"
        echo ""
        run_timely_benchmarks
        ;;
    timely-only)
        run_timely_benchmarks
        ;;
    comparison)
        run_comparison_benchmarks
        ;;
esac

echo ""
echo "=== Benchmark Complete ==="
echo ""
echo "Results are available in:"
echo "  - target/criterion/ (HTML reports)"
echo "  - Console output above"
echo ""
echo "To view HTML reports:"
echo "  Open target/criterion/report/index.html in a web browser"
