#!/bin/bash
# Script to run all benchmarks with proper configuration

set -e

echo "=========================================="
echo "Hydro Performance Benchmarks"
echo "=========================================="
echo ""

# Parse command line arguments
BASELINE=""
SAVE_BASELINE=""
QUICK_MODE=false
SPECIFIC_BENCH=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --baseline)
      BASELINE="$2"
      shift 2
      ;;
    --save-baseline)
      SAVE_BASELINE="$2"
      shift 2
      ;;
    --quick)
      QUICK_MODE=true
      shift
      ;;
    --bench)
      SPECIFIC_BENCH="$2"
      shift 2
      ;;
    --help)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --baseline NAME          Compare against baseline NAME"
      echo "  --save-baseline NAME     Save results as baseline NAME"
      echo "  --quick                  Run quick benchmarks (smaller sample size)"
      echo "  --bench NAME             Run specific benchmark only"
      echo "  --help                   Show this help message"
      echo ""
      echo "Examples:"
      echo "  $0                                    # Run all benchmarks"
      echo "  $0 --save-baseline main              # Save baseline"
      echo "  $0 --baseline main                   # Compare to baseline"
      echo "  $0 --bench arithmetic                # Run arithmetic only"
      echo "  $0 --quick --bench reachability      # Quick reachability test"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# Build benchmark arguments
BENCH_ARGS="-p hydro-benchmarks"

if [ -n "$SPECIFIC_BENCH" ]; then
  BENCH_ARGS="$BENCH_ARGS --bench $SPECIFIC_BENCH"
  echo "Running benchmark: $SPECIFIC_BENCH"
else
  echo "Running all benchmarks"
fi

# Add baseline arguments
CRITERION_ARGS=""
if [ -n "$SAVE_BASELINE" ]; then
  CRITERION_ARGS="-- --save-baseline $SAVE_BASELINE"
  echo "Saving baseline as: $SAVE_BASELINE"
elif [ -n "$BASELINE" ]; then
  CRITERION_ARGS="-- --baseline $BASELINE"
  echo "Comparing against baseline: $BASELINE"
fi

echo ""
echo "Configuration:"
echo "  Quick mode: $QUICK_MODE"
echo "  Package: hydro-benchmarks"
if [ -n "$SPECIFIC_BENCH" ]; then
  echo "  Benchmark: $SPECIFIC_BENCH"
fi
echo ""

# Set environment for quick mode
if [ "$QUICK_MODE" = true ]; then
  echo "Running in quick mode (reduced sample size)..."
  export CRITERION_SAMPLE_SIZE=10
fi

# Check if we're using local paths
if grep -q 'path = "' benches/Cargo.toml 2>/dev/null; then
  echo "⚠️  WARNING: Using local path dependencies"
  echo "   Check benches/Cargo.toml to verify paths are correct"
  echo ""
fi

# Run the benchmarks
echo "Starting benchmarks..."
echo "=========================================="
echo ""

cargo bench $BENCH_ARGS $CRITERION_ARGS

echo ""
echo "=========================================="
echo "Benchmarks complete!"
echo ""
echo "View HTML reports:"
echo "  target/criterion/report/index.html"
echo ""

# Check if HTML reports exist
if [ -f "target/criterion/report/index.html" ]; then
  echo "To open reports:"
  echo "  # Linux:"
  echo "  xdg-open target/criterion/report/index.html"
  echo "  # macOS:"
  echo "  open target/criterion/report/index.html"
  echo "  # Windows:"
  echo "  start target/criterion/report/index.html"
fi

echo ""
echo "Done!"
