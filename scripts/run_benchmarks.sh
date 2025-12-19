#!/bin/bash
# Benchmark Runner Script
# This script runs all benchmarks and organizes results for comparison

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}    Hydro Benchmarks - Performance Testing Suite${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo

# Navigate to benches directory
cd "$(dirname "$0")/../benches"

# Create results directory with timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULTS_DIR="../results/${TIMESTAMP}"
mkdir -p "${RESULTS_DIR}"

echo -e "${GREEN}Running all benchmarks...${NC}"
echo -e "${YELLOW}Results will be saved to: ${RESULTS_DIR}${NC}"
echo

# Run benchmarks
cargo bench --message-format=json > "${RESULTS_DIR}/benchmark_raw.json" 2>&1 || true
cargo bench 2>&1 | tee "${RESULTS_DIR}/benchmark_output.txt"

echo
echo -e "${GREEN}✓ Benchmarks complete!${NC}"
echo -e "${YELLOW}Results saved to:${NC}"
echo -e "  - ${RESULTS_DIR}/benchmark_output.txt"
echo -e "  - ${RESULTS_DIR}/benchmark_raw.json"
echo -e "  - target/criterion/ (detailed HTML reports)"
echo

# Create summary
echo -e "${BLUE}Generating summary...${NC}"
cat > "${RESULTS_DIR}/README.md" << EOF
# Benchmark Results - ${TIMESTAMP}

## Run Information

- **Date**: $(date)
- **Hostname**: $(hostname)
- **Rust Version**: $(rustc --version)
- **Cargo Version**: $(cargo --version)

## Benchmarks Executed

1. **micro_ops** - Micro-operations benchmark
2. **symmetric_hash_join** - Symmetric hash join benchmark
3. **words_diamond** - Word processing diamond pattern
4. **futures** - Futures-based operations

## Results

See the following files for detailed results:
- \`benchmark_output.txt\` - Full benchmark output with timing results
- \`benchmark_raw.json\` - Machine-readable JSON results
- \`../../target/criterion/\` - Detailed HTML reports with graphs

## Viewing Results

To view the detailed HTML reports:
\`\`\`bash
# Open the Criterion reports in a browser
firefox ../target/criterion/report/index.html
# Or with any browser
xdg-open ../target/criterion/report/index.html
\`\`\`

## Comparing Results

To compare with previous runs:
\`\`\`bash
# Criterion automatically compares with previous runs
# Check the HTML reports for comparison charts
\`\`\`
EOF

echo -e "${GREEN}✓ Summary generated!${NC}"
echo
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}All done! View HTML reports with:${NC}"
echo -e "  firefox ../target/criterion/report/index.html"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
