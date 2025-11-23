#!/bin/bash
# Script to run performance comparison between implementations

set -e

echo "=========================================="
echo "Hydro Performance Comparison"
echo "=========================================="
echo ""

# Default configuration
BASELINE_NAME="baseline"
COMPARISON_NAME="current"
BENCHMARKS=("arithmetic" "fan_in" "fan_out" "fork_join" "identity" "join" "reachability" "upcase")

# Parse arguments
SPECIFIC_BENCH=""
SKIP_BASELINE=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --baseline-name)
      BASELINE_NAME="$2"
      shift 2
      ;;
    --comparison-name)
      COMPARISON_NAME="$2"
      shift 2
      ;;
    --bench)
      SPECIFIC_BENCH="$2"
      BENCHMARKS=("$2")
      shift 2
      ;;
    --skip-baseline)
      SKIP_BASELINE=true
      shift
      ;;
    --help)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "This script helps compare performance between different versions."
      echo ""
      echo "Options:"
      echo "  --baseline-name NAME     Name for baseline measurements (default: baseline)"
      echo "  --comparison-name NAME   Name for comparison measurements (default: current)"
      echo "  --bench NAME             Run comparison for specific benchmark only"
      echo "  --skip-baseline          Skip baseline measurement (use existing)"
      echo "  --help                   Show this help message"
      echo ""
      echo "Workflow:"
      echo "  1. Saves baseline measurements"
      echo "  2. Prompts you to make changes"
      echo "  3. Runs comparison measurements"
      echo "  4. Shows performance differences"
      echo ""
      echo "Examples:"
      echo "  $0                                          # Full comparison"
      echo "  $0 --bench arithmetic                       # Compare arithmetic only"
      echo "  $0 --baseline-name v1.0 --comparison-name v1.1"
      echo "  $0 --skip-baseline --comparison-name v2.0   # Use existing baseline"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# Function to run benchmarks for a specific set
run_benchmark_set() {
  local name=$1
  local save_flag=$2
  
  echo "Running benchmarks for: $name"
  
  if [ -n "$SPECIFIC_BENCH" ]; then
    cargo bench -p hydro-benchmarks --bench "$SPECIFIC_BENCH" -- $save_flag
  else
    cargo bench -p hydro-benchmarks -- $save_flag
  fi
  
  echo ""
}

# Step 1: Run baseline (unless skipped)
if [ "$SKIP_BASELINE" = false ]; then
  echo "Step 1: Creating baseline measurements"
  echo "========================================"
  echo ""
  echo "This will measure current performance and save as baseline: $BASELINE_NAME"
  echo ""
  read -p "Press Enter to start baseline measurements..."
  echo ""
  
  run_benchmark_set "$BASELINE_NAME" "--save-baseline $BASELINE_NAME"
  
  echo "✓ Baseline measurements saved as: $BASELINE_NAME"
  echo ""
else
  echo "Skipping baseline measurement (using existing baseline: $BASELINE_NAME)"
  echo ""
fi

# Step 2: Prompt for changes
echo "Step 2: Make your changes"
echo "========================================"
echo ""
echo "Now is the time to:"
echo "  1. Modify the dfir_rs implementation in the main repository"
echo "  2. Update dependencies if needed"
echo "  3. Make any other changes you want to test"
echo ""
echo "If using local paths in benches/Cargo.toml:"
echo "  - Ensure paths point to the modified code"
echo "  - Run 'cargo clean' in both repositories if needed"
echo ""
read -p "Press Enter when you're ready to run comparison measurements..."
echo ""

# Step 3: Run comparison
echo "Step 3: Running comparison measurements"
echo "========================================"
echo ""
echo "This will measure performance with your changes and compare to baseline."
echo ""

run_benchmark_set "$COMPARISON_NAME" "--baseline $BASELINE_NAME"

# Step 4: Summary
echo ""
echo "=========================================="
echo "Comparison Complete!"
echo "=========================================="
echo ""
echo "Results:"
echo "  Baseline: $BASELINE_NAME"
echo "  Comparison: $COMPARISON_NAME"
echo ""

if [ -n "$SPECIFIC_BENCH" ]; then
  echo "  Benchmark: $SPECIFIC_BENCH"
else
  echo "  Benchmarks: all"
fi

echo ""
echo "The output above shows:"
echo "  - Performance changes (faster/slower)"
echo "  - Statistical significance (p-values)"
echo "  - Confidence intervals"
echo ""
echo "View detailed HTML reports:"
echo "  target/criterion/report/index.html"
echo ""
echo "Interpreting results:"
echo "  • Negative change % = Performance IMPROVED (faster)"
echo "  • Positive change % = Performance REGRESSED (slower)"
echo "  • p < 0.05 = Statistically significant change"
echo "  • Look for consistent patterns across benchmarks"
echo ""
echo "Next steps:"
echo "  • Review HTML reports for detailed analysis"
echo "  • If performance regressed, investigate the changes"
echo "  • If improved, document the optimization"
echo "  • Run again with different configurations to verify"
echo ""
echo "Done!"
