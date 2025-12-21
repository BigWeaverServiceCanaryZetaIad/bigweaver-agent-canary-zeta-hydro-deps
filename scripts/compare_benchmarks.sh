#!/bin/bash
# Cross-repository benchmark comparison script
# This script runs benchmarks in both repositories and generates a comparison report

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Timestamp for results
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULTS_DIR="benchmark_results_${TIMESTAMP}"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPS_REPO_DIR="$(dirname "$SCRIPT_DIR")"
MAIN_REPO_DIR="$(dirname "$DEPS_REPO_DIR")/bigweaver-agent-canary-hydro-zeta"

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}Cross-Repository Benchmark Comparison${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# Check if main repository exists
if [ ! -d "$MAIN_REPO_DIR" ]; then
    echo -e "${RED}Error: Main repository not found at $MAIN_REPO_DIR${NC}"
    echo "Please ensure both repositories are checked out in the same parent directory."
    exit 1
fi

# Create results directory
mkdir -p "$RESULTS_DIR"

echo -e "${YELLOW}Results will be saved to: $RESULTS_DIR${NC}"
echo ""

# Function to run benchmarks in a repository
run_benchmarks() {
    local repo_name=$1
    local repo_dir=$2
    local bench_dir=$3
    local output_file=$4

    echo -e "${GREEN}Running benchmarks in $repo_name...${NC}"
    cd "$repo_dir/$bench_dir"
    
    # Run benchmarks and capture output
    if cargo bench --no-fail-fast 2>&1 | tee "$output_file"; then
        echo -e "${GREEN}✓ Benchmarks completed for $repo_name${NC}"
    else
        echo -e "${RED}✗ Some benchmarks failed in $repo_name${NC}"
        echo -e "${YELLOW}  (This is not necessarily an error - some benchmarks may be expected to fail)${NC}"
    fi
    echo ""
}

# Run benchmarks in main repository
echo -e "${BLUE}Step 1: Running Hydroflow/Babyflow/Spinachflow benchmarks${NC}"
run_benchmarks \
    "bigweaver-agent-canary-hydro-zeta" \
    "$MAIN_REPO_DIR" \
    "benches" \
    "$DEPS_REPO_DIR/$RESULTS_DIR/hydro_benchmarks.txt"

# Run benchmarks in deps repository
echo -e "${BLUE}Step 2: Running Timely/Differential benchmarks${NC}"
run_benchmarks \
    "bigweaver-agent-canary-zeta-hydro-deps" \
    "$DEPS_REPO_DIR" \
    "timely-differential-benches" \
    "$DEPS_REPO_DIR/$RESULTS_DIR/timely_benchmarks.txt"

# Generate comparison report
echo -e "${BLUE}Step 3: Generating comparison report${NC}"
REPORT_FILE="$DEPS_REPO_DIR/$RESULTS_DIR/COMPARISON_REPORT.md"

cat > "$REPORT_FILE" << 'EOF'
# Benchmark Comparison Report

## Execution Details

EOF

echo "- **Date**: $(date)" >> "$REPORT_FILE"
echo "- **Hostname**: $(hostname)" >> "$REPORT_FILE"
echo "- **OS**: $(uname -s)" >> "$REPORT_FILE"
echo "- **Architecture**: $(uname -m)" >> "$REPORT_FILE"
echo "- **Rust Version**: $(rustc --version)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

cat >> "$REPORT_FILE" << 'EOF'
## Repositories

- **Main Repository**: bigweaver-agent-canary-hydro-zeta
  - Implementations: Hydroflow, Babyflow, Spinachflow, baselines
- **Deps Repository**: bigweaver-agent-canary-zeta-hydro-deps
  - Implementations: Timely, Differential-Dataflow

## Benchmark Results

### How to Read This Report

Each benchmark section below shows:
- The benchmark name and what it tests
- Raw timing results from criterion
- A brief analysis comparing implementations

For detailed results including confidence intervals, standard deviations, and plots,
see the criterion HTML reports in each repository's `target/criterion/` directory.

### Results Summary

EOF

# Extract key results from both files
echo "#### Main Repository Results (Hydroflow, Babyflow, Spinachflow)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"
grep -A 2 "time:" "$DEPS_REPO_DIR/$RESULTS_DIR/hydro_benchmarks.txt" | head -50 >> "$REPORT_FILE" || echo "No timing results found" >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "#### Deps Repository Results (Timely, Differential)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"
grep -A 2 "time:" "$DEPS_REPO_DIR/$RESULTS_DIR/timely_benchmarks.txt" | head -50 >> "$REPORT_FILE" || echo "No timing results found" >> "$REPORT_FILE"
echo '```' >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

cat >> "$REPORT_FILE" << 'EOF'
## Analysis

### Performance Characteristics

Compare the results above to understand relative performance of different implementations:

1. **Hydroflow** - Modern dataflow framework with scheduling and compilation modes
2. **Babyflow** - Simplified dataflow implementation for comparison
3. **Spinachflow** - Async-based stream processing framework
4. **Timely** - Industry-standard dataflow system for comparison
5. **Differential** - Incremental computation framework

### Recommendations

- Review the detailed criterion reports for statistical analysis
- Pay attention to standard deviations - high variance may indicate unstable performance
- Consider the trade-offs: some frameworks may have higher throughput but more overhead for small data
- For graph algorithms (like reachability), differential's incremental computation may show different characteristics

## Next Steps

1. Open the HTML reports for visual analysis:
   - Main repo: `bigweaver-agent-canary-hydro-zeta/benches/target/criterion/report/index.html`
   - Deps repo: `bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches/target/criterion/report/index.html`

2. For more detailed comparison methodology, see:
   - `docs/BENCHMARK_COMPARISON.md`

3. To re-run specific benchmarks:
   ```bash
   # In main repository
   cd bigweaver-agent-canary-hydro-zeta/benches
   cargo bench --bench <benchmark_name>
   
   # In deps repository
   cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
   cargo bench --bench <benchmark_name>_timely
   ```

## Files Generated

- `hydro_benchmarks.txt` - Full output from main repository benchmarks
- `timely_benchmarks.txt` - Full output from deps repository benchmarks
- `COMPARISON_REPORT.md` - This summary report
EOF

echo -e "${GREEN}✓ Comparison report generated: $REPORT_FILE${NC}"
echo ""

# Print summary
echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}Benchmark Comparison Complete!${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""
echo -e "${YELLOW}Results saved in:${NC} $RESULTS_DIR/"
echo ""
echo -e "${YELLOW}View the comparison report:${NC}"
echo -e "  cat $REPORT_FILE"
echo ""
echo -e "${YELLOW}View detailed HTML reports:${NC}"
echo -e "  Main repo: $MAIN_REPO_DIR/benches/target/criterion/report/index.html"
echo -e "  Deps repo: $DEPS_REPO_DIR/timely-differential-benches/target/criterion/report/index.html"
echo ""

# Offer to open the report
if command -v cat &> /dev/null; then
    echo -e "${GREEN}Would you like to view the comparison report now? (y/n)${NC}"
    read -r -n 1 response
    echo ""
    if [[ "$response" =~ ^[Yy]$ ]]; then
        cat "$REPORT_FILE" | less
    fi
fi

echo -e "${GREEN}Done!${NC}"
