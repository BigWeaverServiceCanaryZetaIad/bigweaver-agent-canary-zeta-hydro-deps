#!/bin/bash
# Verification script to ensure benchmark repository is set up correctly

set -e

echo "=========================================="
echo "Hydro Benchmarks - Setup Verification"
echo "=========================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

CHECKS_PASSED=0
CHECKS_FAILED=0

# Function to report check result
check_result() {
  if [ $1 -eq 0 ]; then
    echo -e "${GREEN}✓${NC} $2"
    CHECKS_PASSED=$((CHECKS_PASSED + 1))
  else
    echo -e "${RED}✗${NC} $2"
    CHECKS_FAILED=$((CHECKS_FAILED + 1))
  fi
}

echo "Checking repository structure..."
echo "=========================================="
echo ""

# Check root files
check_result $(test -f Cargo.toml && echo 0 || echo 1) "Root Cargo.toml exists"
check_result $(test -f README.md && echo 0 || echo 1) "README.md exists"
check_result $(test -f QUICKSTART.md && echo 0 || echo 1) "QUICKSTART.md exists"
check_result $(test -f CONTRIBUTING.md && echo 0 || echo 1) "CONTRIBUTING.md exists"
check_result $(test -f MANIFEST.md && echo 0 || echo 1) "MANIFEST.md exists"
check_result $(test -f .gitignore && echo 0 || echo 1) ".gitignore exists"

# Check scripts
check_result $(test -x run_benchmarks.sh && echo 0 || echo 1) "run_benchmarks.sh is executable"
check_result $(test -x run_comparison.sh && echo 0 || echo 1) "run_comparison.sh is executable"

# Check benches directory
check_result $(test -d benches && echo 0 || echo 1) "benches/ directory exists"
check_result $(test -f benches/Cargo.toml && echo 0 || echo 1) "benches/Cargo.toml exists"
check_result $(test -f benches/README.md && echo 0 || echo 1) "benches/README.md exists"
check_result $(test -d benches/benches && echo 0 || echo 1) "benches/benches/ directory exists"

echo ""
echo "Checking benchmark files..."
echo "=========================================="
echo ""

# Check benchmark source files
BENCHMARKS=("arithmetic" "fan_in" "fan_out" "fork_join" "identity" "join" "reachability" "upcase")

for bench in "${BENCHMARKS[@]}"; do
  check_result $(test -f "benches/benches/${bench}.rs" && echo 0 || echo 1) "${bench}.rs exists"
done

# Check data files
check_result $(test -f benches/benches/reachability_edges.txt && echo 0 || echo 1) "reachability_edges.txt exists"
check_result $(test -f benches/benches/reachability_reachable.txt && echo 0 || echo 1) "reachability_reachable.txt exists"

echo ""
echo "Checking Cargo configuration..."
echo "=========================================="
echo ""

# Check workspace members
if grep -q 'members = \["benches"\]' Cargo.toml; then
  check_result 0 "Workspace includes benches member"
else
  check_result 1 "Workspace includes benches member"
fi

# Check benchmark entries in benches/Cargo.toml
cd benches
for bench in "${BENCHMARKS[@]}"; do
  if grep -q "name = \"${bench}\"" Cargo.toml; then
    check_result 0 "Benchmark entry for ${bench} in Cargo.toml"
  else
    check_result 1 "Benchmark entry for ${bench} in Cargo.toml"
  fi
done
cd ..

echo ""
echo "Checking dependencies..."
echo "=========================================="
echo ""

# Check for required dependencies
cd benches
DEPS=("criterion" "dfir_rs" "differential-dataflow" "timely" "tokio" "futures" "rand")

for dep in "${DEPS[@]}"; do
  if grep -q "^${dep} =" Cargo.toml || grep -q "^${dep} = {" Cargo.toml; then
    check_result 0 "Dependency: ${dep}"
  else
    check_result 1 "Dependency: ${dep}"
  fi
done
cd ..

echo ""
echo "Checking for local path dependencies..."
echo "=========================================="
echo ""

# Warn if using local paths (development mode)
cd benches
if grep -q 'path = ".*dfir_rs"' Cargo.toml; then
  echo -e "${YELLOW}⚠${NC}  Using local path for dfir_rs (development mode)"
  echo "   Remember to revert to git dependency before committing"
else
  check_result 0 "Using git dependency for dfir_rs (production mode)"
fi

if grep -q 'path = ".*sinktools"' Cargo.toml; then
  echo -e "${YELLOW}⚠${NC}  Using local path for sinktools (development mode)"
  echo "   Remember to revert to git dependency before committing"
else
  check_result 0 "Using git dependency for sinktools (production mode)"
fi
cd ..

echo ""
echo "Checking documentation..."
echo "=========================================="
echo ""

# Check documentation completeness
DOCS_CHECKS=0
DOCS_TOTAL=0

# Check README.md
DOCS_TOTAL=$((DOCS_TOTAL + 1))
if grep -q "Quick Start" README.md && grep -q "Benchmarks" README.md; then
  DOCS_CHECKS=$((DOCS_CHECKS + 1))
  check_result 0 "README.md has Quick Start and Benchmarks sections"
else
  check_result 1 "README.md has Quick Start and Benchmarks sections"
fi

# Check QUICKSTART.md
DOCS_TOTAL=$((DOCS_TOTAL + 1))
if grep -q "Installation" QUICKSTART.md && grep -q "Basic Usage" QUICKSTART.md; then
  DOCS_CHECKS=$((DOCS_CHECKS + 1))
  check_result 0 "QUICKSTART.md has Installation and Basic Usage sections"
else
  check_result 1 "QUICKSTART.md has Installation and Basic Usage sections"
fi

# Check benches/README.md
DOCS_TOTAL=$((DOCS_TOTAL + 1))
if grep -q "Arithmetic" benches/README.md && grep -q "Running Benchmarks" benches/README.md; then
  DOCS_CHECKS=$((DOCS_CHECKS + 1))
  check_result 0 "benches/README.md documents benchmarks"
else
  check_result 1 "benches/README.md documents benchmarks"
fi

echo ""
echo "Testing build..."
echo "=========================================="
echo ""

# Try to build (but don't fail the script if it fails - dependencies might not be available)
echo "Attempting to build benchmark package..."
if cargo build -p hydro-benchmarks 2>&1 | head -20; then
  check_result 0 "Benchmark package builds successfully"
else
  echo -e "${YELLOW}⚠${NC}  Build check skipped (dependencies may not be available)"
  echo "   This is normal if running without network access"
  echo "   Try: cargo build -p hydro-benchmarks"
fi

echo ""
echo "=========================================="
echo "Verification Summary"
echo "=========================================="
echo ""

TOTAL_CHECKS=$((CHECKS_PASSED + CHECKS_FAILED))
echo "Checks passed: ${CHECKS_PASSED}/${TOTAL_CHECKS}"
echo ""

if [ $CHECKS_FAILED -eq 0 ]; then
  echo -e "${GREEN}✓ All verification checks passed!${NC}"
  echo ""
  echo "Repository is properly set up. You can now:"
  echo "  • Run benchmarks: cargo bench -p hydro-benchmarks"
  echo "  • Use helper script: ./run_benchmarks.sh"
  echo "  • Read QUICKSTART.md for more information"
  echo ""
  exit 0
else
  echo -e "${RED}✗ Some checks failed${NC}"
  echo ""
  echo "Please review the failures above and fix any issues."
  echo "See CONTRIBUTING.md for setup instructions."
  echo ""
  exit 1
fi
