#!/bin/bash

# Performance Regression Check Script
# This script helps detect performance regressions by comparing current benchmarks
# against a saved baseline.

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
BASELINE_NAME="${1:-main}"
THRESHOLD="${PERF_THRESHOLD:-5.0}"  # Default 5% regression threshold

echo -e "${BLUE}=================================================="
echo "Performance Regression Check"
echo -e "==================================================${NC}"
echo ""
echo "Baseline: $BASELINE_NAME"
echo "Threshold: ${THRESHOLD}% regression"
echo ""

# Check if baseline exists
if [ ! -d "target/criterion" ]; then
    echo -e "${YELLOW}No benchmark results found.${NC}"
    echo "Creating initial baseline..."
    cargo bench -- --save-baseline "$BASELINE_NAME"
    echo ""
    echo -e "${GREEN}Baseline '$BASELINE_NAME' created successfully.${NC}"
    echo "Run this script again after making changes to check for regressions."
    exit 0
fi

# Check if specific baseline exists
BASELINE_DIR="target/criterion/*/$BASELINE_NAME"
if ! ls $BASELINE_DIR >/dev/null 2>&1; then
    echo -e "${YELLOW}Baseline '$BASELINE_NAME' not found.${NC}"
    echo "Available baselines:"
    find target/criterion -type d -name "base" -o -name "change" | sed 's|target/criterion/||' | sed 's|/.*||' | sort -u | while read bench; do
        find "target/criterion/$bench" -mindepth 1 -maxdepth 1 -type d | sed 's|.*/||' | grep -v "^base$" | while read baseline; do
            echo "  - $baseline"
        done
    done
    echo ""
    echo "Creating baseline '$BASELINE_NAME'..."
    cargo bench -- --save-baseline "$BASELINE_NAME"
    echo ""
    echo -e "${GREEN}Baseline '$BASELINE_NAME' created.${NC}"
    echo "Run this script again after making changes to check for regressions."
    exit 0
fi

echo "Running benchmarks and comparing against baseline..."
echo ""

# Run benchmarks and save output
BENCH_OUTPUT=$(mktemp)
cargo bench -- --baseline "$BASELINE_NAME" 2>&1 | tee "$BENCH_OUTPUT"

echo ""
echo -e "${BLUE}=================================================="
echo "Analyzing Results"
echo -e "==================================================${NC}"
echo ""

# Parse results for regressions
REGRESSIONS=()
IMPROVEMENTS=()
NO_CHANGE=()

# Function to extract percentage from criterion output
extract_percentage() {
    local line="$1"
    # Extract percentage like "+5.2%" or "-3.4%"
    if echo "$line" | grep -q "change:"; then
        percentage=$(echo "$line" | grep -oP '[\+\-]\d+\.\d+%' | head -1 | tr -d '+%')
        echo "$percentage"
    fi
}

# Parse benchmark results
while IFS= read -r line; do
    if echo "$line" | grep -q "time:"; then
        benchmark_name=$(echo "$line" | awk '{print $1}')
        
        # Get next line which should contain change information
        change_line=$(grep -A 1 "^$benchmark_name" "$BENCH_OUTPUT" | tail -1)
        
        if echo "$change_line" | grep -q "Performance has regressed"; then
            percentage=$(extract_percentage "$change_line")
            if [ ! -z "$percentage" ]; then
                abs_percentage=${percentage#-}
                if (( $(echo "$abs_percentage > $THRESHOLD" | bc -l) )); then
                    REGRESSIONS+=("$benchmark_name: +${abs_percentage}%")
                fi
            fi
        elif echo "$change_line" | grep -q "Performance has improved"; then
            percentage=$(extract_percentage "$change_line")
            if [ ! -z "$percentage" ]; then
                abs_percentage=${percentage#-}
                IMPROVEMENTS+=("$benchmark_name: -${abs_percentage}%")
            fi
        elif echo "$change_line" | grep -q "No change"; then
            NO_CHANGE+=("$benchmark_name")
        fi
    fi
done < "$BENCH_OUTPUT"

# Display results
if [ ${#REGRESSIONS[@]} -gt 0 ]; then
    echo -e "${RED}⚠ Performance Regressions Detected (>${THRESHOLD}%):${NC}"
    for reg in "${REGRESSIONS[@]}"; do
        echo -e "  ${RED}▼${NC} $reg"
    done
    echo ""
fi

if [ ${#IMPROVEMENTS[@]} -gt 0 ]; then
    echo -e "${GREEN}✓ Performance Improvements:${NC}"
    for imp in "${IMPROVEMENTS[@]}"; do
        echo -e "  ${GREEN}▲${NC} $imp"
    done
    echo ""
fi

if [ ${#NO_CHANGE[@]} -gt 0 ]; then
    echo -e "${BLUE}○ No Significant Change:${NC}"
    for nc in "${NO_CHANGE[@]}"; do
        echo -e "  ${BLUE}○${NC} $nc"
    done
    echo ""
fi

# Summary
echo -e "${BLUE}=================================================="
echo "Summary"
echo -e "==================================================${NC}"
echo "Regressions:  ${#REGRESSIONS[@]}"
echo "Improvements: ${#IMPROVEMENTS[@]}"
echo "No change:    ${#NO_CHANGE[@]}"
echo ""

# Generate HTML report link
if [ -f "target/criterion/report/index.html" ]; then
    echo "Detailed HTML report: target/criterion/report/index.html"
    echo ""
fi

# Cleanup
rm -f "$BENCH_OUTPUT"

# Exit with error if regressions found
if [ ${#REGRESSIONS[@]} -gt 0 ]; then
    echo -e "${RED}Performance regression check FAILED!${NC}"
    echo "Regressions exceed ${THRESHOLD}% threshold."
    echo ""
    echo "To update baseline if changes are intentional:"
    echo "  cargo bench -- --save-baseline $BASELINE_NAME"
    exit 1
else
    echo -e "${GREEN}Performance regression check PASSED!${NC}"
    echo "No significant regressions detected."
    exit 0
fi
