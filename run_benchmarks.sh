#!/bin/bash
# Cross-repository benchmark comparison script
# This script runs benchmarks from both repositories and helps compare results

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}Hydro Benchmark Comparison Runner${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEPS_REPO="$SCRIPT_DIR"
MAIN_REPO="$(dirname "$SCRIPT_DIR")/bigweaver-agent-canary-hydro-zeta"

# Check if main repository exists
if [ ! -d "$MAIN_REPO" ]; then
    echo -e "${RED}Error: Main repository not found at $MAIN_REPO${NC}"
    echo -e "${YELLOW}Please ensure both repositories are cloned in the same parent directory${NC}"
    exit 1
fi

echo -e "${GREEN}Found repositories:${NC}"
echo -e "  Reference benchmarks: $DEPS_REPO"
echo -e "  DFIR benchmarks: $MAIN_REPO"
echo ""

# Parse command line arguments
RUN_DFIR=1
RUN_REFERENCE=1
BENCHMARK_NAME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --dfir-only)
            RUN_REFERENCE=0
            shift
            ;;
        --reference-only)
            RUN_DFIR=0
            shift
            ;;
        --bench)
            BENCHMARK_NAME="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --dfir-only         Run only DFIR benchmarks"
            echo "  --reference-only    Run only reference benchmarks"
            echo "  --bench NAME        Run specific benchmark by name"
            echo "  --help              Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                              # Run all benchmarks"
            echo "  $0 --dfir-only                  # Run only DFIR benchmarks"
            echo "  $0 --bench reachability         # Run reachability benchmark only"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Run '$0 --help' for usage information"
            exit 1
            ;;
    esac
done

# Run reference benchmarks
if [ $RUN_REFERENCE -eq 1 ]; then
    echo -e "${YELLOW}Running reference benchmarks (timely/differential)...${NC}"
    cd "$DEPS_REPO"
    
    if [ -n "$BENCHMARK_NAME" ]; then
        echo -e "${BLUE}Building and running: $BENCHMARK_NAME${NC}"
        cargo bench -p hydro-zeta-reference-benches --bench "$BENCHMARK_NAME"
    else
        echo -e "${BLUE}Building and running all reference benchmarks${NC}"
        cargo bench -p hydro-zeta-reference-benches
    fi
    
    echo -e "${GREEN}✓ Reference benchmarks completed${NC}"
    echo ""
fi

# Run DFIR benchmarks
if [ $RUN_DFIR -eq 1 ]; then
    echo -e "${YELLOW}Running DFIR-native benchmarks...${NC}"
    cd "$MAIN_REPO"
    
    if [ -n "$BENCHMARK_NAME" ]; then
        echo -e "${BLUE}Building and running: $BENCHMARK_NAME${NC}"
        cargo bench -p benches --bench "$BENCHMARK_NAME"
    else
        echo -e "${BLUE}Building and running all DFIR benchmarks${NC}"
        cargo bench -p benches
    fi
    
    echo -e "${GREEN}✓ DFIR benchmarks completed${NC}"
    echo ""
fi

echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}Benchmark execution complete!${NC}"
echo -e "${GREEN}=====================================${NC}"
echo ""
echo -e "${YELLOW}Results locations:${NC}"
if [ $RUN_REFERENCE -eq 1 ]; then
    echo -e "  Reference: $DEPS_REPO/target/criterion/"
fi
if [ $RUN_DFIR -eq 1 ]; then
    echo -e "  DFIR: $MAIN_REPO/target/criterion/"
fi
echo ""
echo -e "${BLUE}To compare results, examine the criterion HTML reports or use criterion's comparison tools.${NC}"
