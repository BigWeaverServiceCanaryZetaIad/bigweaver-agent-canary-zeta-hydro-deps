#!/bin/bash
# Performance comparison script
# Runs benchmarks and generates comparison reports

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "================================================"
echo "Hydro Framework Comparison Benchmark Runner"
echo "================================================"
echo ""

# Parse arguments
QUICK_MODE=false
SPECIFIC_BENCH=""
SAVE_BASELINE=false
BASELINE_NAME="baseline"

while [[ $# -gt 0 ]]; do
    case $1 in
        --quick)
            QUICK_MODE=true
            shift
            ;;
        --bench)
            SPECIFIC_BENCH="$2"
            shift 2
            ;;
        --save-baseline)
            SAVE_BASELINE=true
            shift
            ;;
        --baseline-name)
            BASELINE_NAME="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --quick              Run benchmarks in quick mode (reduced samples)"
            echo "  --bench NAME         Run only specified benchmark"
            echo "  --save-baseline      Save results as baseline for future comparisons"
            echo "  --baseline-name NAME Name for saved baseline (default: 'baseline')"
            echo "  --help               Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                              # Run all benchmarks"
            echo "  $0 --quick                      # Quick run of all benchmarks"
            echo "  $0 --bench arithmetic           # Run only arithmetic benchmark"
            echo "  $0 --save-baseline              # Run all and save as baseline"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Print configuration
echo -e "${BLUE}Configuration:${NC}"
echo "  Quick mode: $QUICK_MODE"
if [ -n "$SPECIFIC_BENCH" ]; then
    echo "  Specific benchmark: $SPECIFIC_BENCH"
else
    echo "  Running: All benchmarks"
fi
if [ "$SAVE_BASELINE" = true ]; then
    echo "  Saving baseline: $BASELINE_NAME"
fi
echo ""

# Build benchmarks
echo -e "${BLUE}Step 1: Building benchmarks...${NC}"
cargo build --benches --release
echo -e "${GREEN}✓ Build complete${NC}"
echo ""

# Prepare benchmark command
BENCH_CMD="cargo bench"

if [ -n "$SPECIFIC_BENCH" ]; then
    BENCH_CMD="$BENCH_CMD --bench $SPECIFIC_BENCH"
fi

if [ "$QUICK_MODE" = true ]; then
    BENCH_CMD="$BENCH_CMD -- --quick"
fi

if [ "$SAVE_BASELINE" = true ]; then
    BENCH_CMD="$BENCH_CMD --save-baseline $BASELINE_NAME"
fi

# Run benchmarks
echo -e "${BLUE}Step 2: Running benchmarks...${NC}"
echo "Command: $BENCH_CMD"
echo ""

$BENCH_CMD

# Generate summary
echo ""
echo -e "${BLUE}Step 3: Generating summary...${NC}"
echo ""

# Check if criterion report exists
REPORT_DIR="target/criterion"
if [ -d "$REPORT_DIR" ]; then
    echo -e "${GREEN}✓ Benchmark results saved${NC}"
    echo ""
    echo "Results location:"
    echo "  - HTML report: $REPORT_DIR/report/index.html"
    echo "  - Raw data: $REPORT_DIR/"
    echo ""
    
    # Count benchmarks
    if command -v find &> /dev/null; then
        NUM_BENCHMARKS=$(find "$REPORT_DIR" -name "base" -type d | wc -l)
        echo "  Total benchmarks run: $NUM_BENCHMARKS"
    fi
    
    echo ""
    echo "To view results:"
    echo "  - Open HTML report in browser"
    echo "  - Or run: open $REPORT_DIR/report/index.html"
else
    echo -e "${YELLOW}⚠ Benchmark results directory not found${NC}"
fi

# Save metadata if saving baseline
if [ "$SAVE_BASELINE" = true ]; then
    METADATA_FILE="$REPORT_DIR/$BASELINE_NAME.metadata.txt"
    echo "Saving baseline metadata to: $METADATA_FILE"
    {
        echo "Baseline: $BASELINE_NAME"
        echo "Date: $(date)"
        echo "Git commit: $(git rev-parse HEAD 2>/dev/null || echo 'unknown')"
        echo "Git branch: $(git branch --show-current 2>/dev/null || echo 'unknown')"
        echo "Rust version: $(rustc --version)"
        echo "Quick mode: $QUICK_MODE"
    } > "$METADATA_FILE"
    echo -e "${GREEN}✓ Baseline saved${NC}"
fi

echo ""
echo "================================================"
echo "Benchmark run complete!"
echo "================================================"
echo ""

# List available benchmarks if none was specified
if [ -z "$SPECIFIC_BENCH" ]; then
    echo "Available benchmarks for individual runs:"
    echo "  - arithmetic"
    echo "  - fan_in"
    echo "  - fan_out"
    echo "  - fork_join"
    echo "  - identity"
    echo "  - join"
    echo "  - reachability"
    echo "  - upcase"
    echo ""
    echo "Run specific benchmark: $0 --bench <name>"
fi

# Tips
echo "Tips:"
echo "  - Compare with baseline: cargo bench --baseline $BASELINE_NAME"
echo "  - Save new baseline: $0 --save-baseline --baseline-name my-baseline"
echo "  - Quick iteration: $0 --quick --bench <benchmark-name>"
echo ""

exit 0
