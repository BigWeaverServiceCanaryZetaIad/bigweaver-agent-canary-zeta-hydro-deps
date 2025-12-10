#!/bin/bash

# Script to run Hydro benchmarks
# This script helps run performance benchmarks against the separated benchmark implementations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_REPO="${MAIN_REPO:-../bigweaver-agent-canary-hydro-zeta}"

echo "Hydro Benchmarks Runner"
echo "======================="
echo ""

# Check if main repository exists
if [ ! -d "$MAIN_REPO" ]; then
    echo "Error: Main repository not found at $MAIN_REPO"
    echo "Please set MAIN_REPO environment variable or ensure the main repo is in the parent directory"
    exit 1
fi

# Parse arguments
BENCHMARK_TYPE="${1:-all}"

case "$BENCHMARK_TYPE" in
    paxos)
        echo "Running Paxos benchmark..."
        cd "$MAIN_REPO"
        cargo run --example paxos --features "deploy" -- "${@:2}"
        ;;
    compartmentalized-paxos)
        echo "Running Compartmentalized Paxos benchmark..."
        cd "$MAIN_REPO"
        cargo run --example compartmentalized_paxos --features "deploy" -- "${@:2}"
        ;;
    two-pc|2pc)
        echo "Running Two-Phase Commit benchmark..."
        cd "$MAIN_REPO"
        cargo run --example two_pc --features "deploy" -- "${@:2}"
        ;;
    all)
        echo "Running all benchmarks..."
        echo ""
        echo "1. Paxos Benchmark"
        echo "=================="
        cd "$MAIN_REPO"
        cargo run --example paxos --features "deploy" -- "${@:2}" || true
        echo ""
        echo "2. Two-Phase Commit Benchmark"
        echo "============================="
        cargo run --example two_pc --features "deploy" -- "${@:2}" || true
        ;;
    test)
        echo "Running benchmark tests..."
        cd "$SCRIPT_DIR"
        cargo test
        ;;
    help|--help|-h)
        echo "Usage: $0 [BENCHMARK_TYPE] [OPTIONS]"
        echo ""
        echo "BENCHMARK_TYPE can be:"
        echo "  paxos                  - Run Paxos consensus benchmark"
        echo "  compartmentalized-paxos - Run Compartmentalized Paxos benchmark"
        echo "  two-pc or 2pc         - Run Two-Phase Commit benchmark"
        echo "  all                   - Run all benchmarks (default)"
        echo "  test                  - Run benchmark unit tests"
        echo "  help                  - Show this help message"
        echo ""
        echo "OPTIONS are passed through to the benchmark executable"
        echo ""
        echo "Examples:"
        echo "  $0 paxos --gcp my-project    # Run Paxos on GCP"
        echo "  $0 two-pc                     # Run 2PC on localhost"
        echo "  $0 test                       # Run unit tests"
        echo ""
        echo "Environment Variables:"
        echo "  MAIN_REPO - Path to main Hydro repository (default: ../bigweaver-agent-canary-hydro-zeta)"
        ;;
    *)
        echo "Error: Unknown benchmark type '$BENCHMARK_TYPE'"
        echo "Run '$0 help' for usage information"
        exit 1
        ;;
esac

echo ""
echo "Benchmark execution complete!"
