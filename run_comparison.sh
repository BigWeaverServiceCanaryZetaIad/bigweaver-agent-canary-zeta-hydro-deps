#!/bin/bash

# Performance comparison script
# Runs benchmarks from both repositories and generates comparison reports

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPS_REPO="$SCRIPT_DIR"
MAIN_REPO="$SCRIPT_DIR/../bigweaver-agent-canary-hydro-zeta"
COMPARISON_DIR="$SCRIPT_DIR/comparison_results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Performance Comparison Tool${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Create comparison results directory
mkdir -p "$COMPARISON_DIR"

# Function to print section headers
print_section() {
    echo ""
    echo -e "${BLUE}=== $1 ===${NC}"
    echo ""
}

# Function to print status
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

# Check if main repository exists
print_section "Checking Repository Setup"

if [ ! -d "$MAIN_REPO" ]; then
    echo -e "${RED}Error: Main repository not found at $MAIN_REPO${NC}"
    echo "Please ensure bigweaver-agent-canary-hydro-zeta is cloned at the same level."
    exit 1
fi
print_status "Main repository found"

if [ ! -d "$MAIN_REPO/benches" ]; then
    echo -e "${YELLOW}Warning: Main repository doesn't have benches directory${NC}"
    echo "Skipping dfir_rs benchmark comparison"
    RUN_MAIN_BENCHES=false
else
    print_status "Main repository benchmarks found"
    RUN_MAIN_BENCHES=true
fi

print_status "Dependencies repository found"

# Run main repository benchmarks
if [ "$RUN_MAIN_BENCHES" = true ]; then
    print_section "Running dfir_rs Benchmarks (Main Repository)"
    
    cd "$MAIN_REPO/benches"
    echo "Running benchmarks in: $(pwd)"
    echo "This may take several minutes..."
    
    if cargo bench --no-fail-fast -- --save-baseline dfir_rs_$TIMESTAMP 2>&1 | tee "$COMPARISON_DIR/dfir_rs_output_$TIMESTAMP.log"; then
        print_status "dfir_rs benchmarks completed"
    else
        echo -e "${YELLOW}Warning: Some dfir_rs benchmarks may have failed${NC}"
    fi
    
    # Copy criterion results
    if [ -d "target/criterion" ]; then
        cp -r target/criterion "$COMPARISON_DIR/dfir_rs_criterion_$TIMESTAMP"
        print_status "dfir_rs results saved to comparison_results/"
    fi
fi

# Run dependencies repository benchmarks
print_section "Running External Framework Benchmarks (Dependencies Repository)"

cd "$DEPS_REPO/benches"
echo "Running benchmarks in: $(pwd)"
echo "This may take several minutes..."

if cargo bench --no-fail-fast -- --save-baseline external_$TIMESTAMP 2>&1 | tee "$COMPARISON_DIR/external_output_$TIMESTAMP.log"; then
    print_status "External framework benchmarks completed"
else
    echo -e "${YELLOW}Warning: Some external benchmarks may have failed${NC}"
fi

# Copy criterion results
if [ -d "target/criterion" ]; then
    cp -r target/criterion "$COMPARISON_DIR/external_criterion_$TIMESTAMP"
    print_status "External framework results saved to comparison_results/"
fi

# Generate comparison report
print_section "Generating Comparison Report"

REPORT_FILE="$COMPARISON_DIR/comparison_report_$TIMESTAMP.md"

cat > "$REPORT_FILE" << EOF
# Performance Comparison Report

**Date**: $(date)
**Main Repository**: bigweaver-agent-canary-hydro-zeta
**Dependencies Repository**: bigweaver-agent-canary-zeta-hydro-deps

## Overview

This report compares performance between:
- **dfir_rs benchmarks** - Core implementation from main repository
- **External framework benchmarks** - Timely and differential-dataflow implementations

## Methodology

- Both benchmark suites run with Criterion default settings
- Results include mean, standard deviation, and confidence intervals
- Multiple iterations performed for statistical significance
- System: $(uname -a)

## Benchmark Results

### dfir_rs Benchmarks (Main Repository)

EOF

if [ "$RUN_MAIN_BENCHES" = true ] && [ -f "$COMPARISON_DIR/dfir_rs_output_$TIMESTAMP.log" ]; then
    echo "Results from main repository benchmarks:" >> "$REPORT_FILE"
    echo '```' >> "$REPORT_FILE"
    grep "time:" "$COMPARISON_DIR/dfir_rs_output_$TIMESTAMP.log" | head -20 >> "$REPORT_FILE" || echo "No timing results found" >> "$REPORT_FILE"
    echo '```' >> "$REPORT_FILE"
else
    echo "Main repository benchmarks were not run." >> "$REPORT_FILE"
fi

cat >> "$REPORT_FILE" << EOF

### External Framework Benchmarks (Dependencies Repository)

Results from external framework benchmarks:
\`\`\`
EOF

if [ -f "$COMPARISON_DIR/external_output_$TIMESTAMP.log" ]; then
    grep "time:" "$COMPARISON_DIR/external_output_$TIMESTAMP.log" | head -20 >> "$REPORT_FILE" || echo "No timing results found" >> "$REPORT_FILE"
fi

cat >> "$REPORT_FILE" << EOF
\`\`\`

## Analysis

### Key Observations

1. **Performance Characteristics**
   - Review relative performance between implementations
   - Consider different optimization trade-offs
   - Note scalability characteristics

2. **Resource Usage**
   - Memory allocation patterns
   - CPU utilization
   - Throughput vs. latency trade-offs

3. **Use Case Suitability**
   - When to use dfir_rs
   - When to use external frameworks
   - Performance/complexity trade-offs

## Detailed Results

Detailed HTML reports with charts and statistics are available in:

- **dfir_rs**: \`comparison_results/dfir_rs_criterion_$TIMESTAMP/\`
- **External**: \`comparison_results/external_criterion_$TIMESTAMP/\`

Open \`report/index.html\` in each directory to view interactive charts.

## Recommendations

Based on these results:

1. **For similar operations**, compare:
   - Execution time (mean and variance)
   - Memory usage patterns
   - Scalability with data size

2. **For different patterns**, consider:
   - Framework strengths and weaknesses
   - Code complexity and maintainability
   - Integration requirements

3. **For production use**, evaluate:
   - Performance requirements
   - Operational complexity
   - Maintenance burden
   - Team expertise

## Files Generated

- \`dfir_rs_output_$TIMESTAMP.log\` - Console output from dfir_rs benchmarks
- \`external_output_$TIMESTAMP.log\` - Console output from external benchmarks
- \`dfir_rs_criterion_$TIMESTAMP/\` - Criterion results for dfir_rs
- \`external_criterion_$TIMESTAMP/\` - Criterion results for external frameworks
- \`comparison_report_$TIMESTAMP.md\` - This report

## Next Steps

1. Review HTML reports for detailed analysis
2. Identify performance bottlenecks
3. Consider optimization opportunities
4. Document findings and decisions

---
Generated by run_comparison.sh on $(date)
EOF

print_status "Comparison report generated: $REPORT_FILE"

# Print summary
print_section "Comparison Complete"

echo "Results saved to: $COMPARISON_DIR"
echo ""
echo "Generated files:"
echo "  - Comparison report: comparison_report_$TIMESTAMP.md"
if [ "$RUN_MAIN_BENCHES" = true ]; then
    echo "  - dfir_rs output: dfir_rs_output_$TIMESTAMP.log"
    echo "  - dfir_rs results: dfir_rs_criterion_$TIMESTAMP/"
fi
echo "  - External output: external_output_$TIMESTAMP.log"
echo "  - External results: external_criterion_$TIMESTAMP/"
echo ""
echo "To view detailed HTML reports:"
if [ "$RUN_MAIN_BENCHES" = true ]; then
    echo "  open $COMPARISON_DIR/dfir_rs_criterion_$TIMESTAMP/report/index.html"
fi
echo "  open $COMPARISON_DIR/external_criterion_$TIMESTAMP/report/index.html"
echo ""
echo "To read the comparison report:"
echo "  cat $REPORT_FILE"
echo ""
echo -e "${GREEN}✓ Performance comparison complete!${NC}"
