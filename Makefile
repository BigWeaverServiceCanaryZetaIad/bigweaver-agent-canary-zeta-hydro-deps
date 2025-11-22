# Makefile for Hydro Performance Comparison Benchmarks
# Provides convenient shortcuts for common tasks

.PHONY: help setup check bench bench-quick bench-all bench-patterns bench-operations
.PHONY: analyze compare clean view test install-deps

# Default target
.DEFAULT_GOAL := help

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[1;33m
NC := \033[0m # No Color

##@ General

help: ## Display this help message
	@echo "$(BLUE)Hydro Performance Comparison Benchmarks$(NC)"
	@echo ""
	@echo "Available targets:"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf ""} /^[a-zA-Z_-]+:.*?##/ { printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2 } /^##@/ { printf "\n$(YELLOW)%s$(NC)\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""
	@echo "$(BLUE)Quick start: make setup && make bench-quick$(NC)"

##@ Setup

setup: ## Verify repository setup and dependencies
	@echo "$(BLUE)Verifying setup...$(NC)"
	@bash scripts/setup.sh

check: setup ## Check repository configuration (alias for setup)

install-deps: ## Install system dependencies (Rust, etc.)
	@echo "$(BLUE)Checking dependencies...$(NC)"
	@which cargo > /dev/null 2>&1 || (echo "$(YELLOW)Installing Rust...$(NC)" && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh)
	@cargo --version

##@ Benchmarking

bench: bench-quick ## Run quick benchmarks (default, alias for bench-quick)

bench-quick: ## Run quick smoke test benchmarks (~2-3 min)
	@echo "$(BLUE)Running quick benchmarks...$(NC)"
	@bash scripts/run_benchmarks.sh -m quick

bench-all: ## Run all benchmarks (~10-15 min)
	@echo "$(BLUE)Running all benchmarks (this will take 10-15 minutes)...$(NC)"
	@bash scripts/run_benchmarks.sh -m all

bench-patterns: ## Run dataflow pattern benchmarks (fan_in, fan_out, fork_join)
	@echo "$(BLUE)Running pattern benchmarks...$(NC)"
	@bash scripts/run_benchmarks.sh -m patterns

bench-operations: ## Run operation benchmarks (arithmetic, join, identity, upcase)
	@echo "$(BLUE)Running operation benchmarks...$(NC)"
	@bash scripts/run_benchmarks.sh -m operations

bench-iterative: ## Run iterative benchmarks (reachability)
	@echo "$(BLUE)Running iterative benchmarks...$(NC)"
	@bash scripts/run_benchmarks.sh -m iterative

bench-arithmetic: ## Run arithmetic benchmark only
	@bash scripts/run_benchmarks.sh -m specific -b arithmetic

bench-reachability: ## Run reachability benchmark only
	@bash scripts/run_benchmarks.sh -m specific -b reachability

bench-join: ## Run join benchmark only
	@bash scripts/run_benchmarks.sh -m specific -b join

##@ Analysis

analyze: ## Analyze benchmark results and generate report
	@echo "$(BLUE)Analyzing results...$(NC)"
	@python3 scripts/analyze_results.py

compare: ## Compare benchmark results (requires baseline)
	@echo "$(BLUE)Comparing results...$(NC)"
	@bash scripts/compare_results.sh

list-baselines: ## List available saved baselines
	@bash scripts/compare_results.sh -l

view: ## Open HTML benchmark reports in browser
	@echo "$(BLUE)Opening benchmark reports...$(NC)"
	@if [ -f target/criterion/report/index.html ]; then \
		xdg-open target/criterion/report/index.html 2>/dev/null || \
		open target/criterion/report/index.html 2>/dev/null || \
		echo "$(YELLOW)Open: target/criterion/report/index.html$(NC)"; \
	else \
		echo "$(YELLOW)No reports found. Run benchmarks first: make bench$(NC)"; \
	fi

##@ Baselines

save-baseline: ## Save current results as baseline (usage: make save-baseline NAME=my-baseline)
	@if [ -z "$(NAME)" ]; then \
		echo "$(YELLOW)Usage: make save-baseline NAME=baseline-name$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Saving baseline: $(NAME)$(NC)"
	@bash scripts/run_benchmarks.sh -m all -s $(NAME)

compare-baseline: ## Compare against baseline (usage: make compare-baseline NAME=my-baseline)
	@if [ -z "$(NAME)" ]; then \
		echo "$(YELLOW)Usage: make compare-baseline NAME=baseline-name$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Comparing against baseline: $(NAME)$(NC)"
	@bash scripts/run_benchmarks.sh -m all -l $(NAME)

##@ Development

test: ## Run benchmark tests (quick validation)
	@echo "$(BLUE)Running benchmark tests...$(NC)"
	@cargo test -p benches

build: ## Build benchmarks without running
	@echo "$(BLUE)Building benchmarks...$(NC)"
	@cargo build -p benches --benches

clean: ## Clean build artifacts and benchmark results
	@echo "$(BLUE)Cleaning build artifacts...$(NC)"
	@cargo clean
	@rm -rf target/criterion
	@echo "$(GREEN)Clean complete$(NC)"

clean-results: ## Clean only benchmark results (keep build cache)
	@echo "$(BLUE)Cleaning benchmark results...$(NC)"
	@rm -rf target/criterion
	@echo "$(GREEN)Results cleaned$(NC)"

fmt: ## Format code
	@cargo fmt -p benches

clippy: ## Run clippy lints
	@cargo clippy -p benches --benches

##@ Workflows

dev-cycle: ## Development cycle: clean -> build -> test -> quick bench
	@echo "$(BLUE)Running development cycle...$(NC)"
	@$(MAKE) clean-results
	@$(MAKE) build
	@$(MAKE) test
	@$(MAKE) bench-quick

regression-test: ## Regression test: save baseline, test, compare
	@echo "$(BLUE)Running regression test...$(NC)"
	@echo "$(YELLOW)Step 1: Saving current state as baseline$(NC)"
	@$(MAKE) save-baseline NAME=regression-baseline
	@echo ""
	@echo "$(YELLOW)Now make your changes and run: make compare-baseline NAME=regression-baseline$(NC)"

full-comparison: ## Full system comparison: all benchmarks + analysis + view
	@echo "$(BLUE)Running full comparison...$(NC)"
	@$(MAKE) bench-all
	@$(MAKE) analyze
	@$(MAKE) view

##@ Documentation

docs: ## Open documentation in browser
	@echo "$(BLUE)Available documentation:$(NC)"
	@echo "  README.md - Repository overview"
	@echo "  QUICKSTART.md - Quick start guide"
	@echo "  DEVELOPMENT.md - Developer guide"
	@echo "  BENCHMARKS_COMPARISON.md - Benchmark reference"
	@if which mdcat > /dev/null 2>&1; then \
		mdcat README.md; \
	else \
		cat README.md; \
	fi

##@ CI/CD

ci-setup: ## Setup for CI/CD environment
	@echo "$(BLUE)Setting up CI environment...$(NC)"
	@rustup component add rustfmt clippy
	@$(MAKE) setup

ci-test: ## Run CI test suite
	@echo "$(BLUE)Running CI tests...$(NC)"
	@$(MAKE) fmt
	@$(MAKE) clippy
	@$(MAKE) test
	@$(MAKE) bench-quick

##@ Info

info: ## Show repository information
	@echo "$(BLUE)Repository Information$(NC)"
	@echo "$(YELLOW)Location:$(NC) $(shell pwd)"
	@echo "$(YELLOW)Rust version:$(NC) $(shell rustc --version 2>/dev/null || echo 'Not installed')"
	@echo "$(YELLOW)Cargo version:$(NC) $(shell cargo --version 2>/dev/null || echo 'Not installed')"
	@echo ""
	@echo "$(YELLOW)Benchmarks available:$(NC)"
	@ls -1 benches/benches/*.rs 2>/dev/null | wc -l | xargs echo "  " || echo "  0"
	@echo ""
	@echo "$(YELLOW)Main Hydro repository:$(NC)"
	@if [ -d "../bigweaver-agent-canary-hydro-zeta" ]; then \
		echo "  ✓ Found at ../bigweaver-agent-canary-hydro-zeta"; \
	else \
		echo "  ✗ Not found (required for benchmarks)"; \
	fi
	@echo ""
	@echo "$(YELLOW)Recent results:$(NC)"
	@if [ -d "target/criterion" ]; then \
		find target/criterion -name "*.html" -type f | wc -l | xargs echo "  Report files: "; \
		du -sh target/criterion 2>/dev/null | awk '{print "  Total size: " $$1}'; \
	else \
		echo "  No results yet"; \
	fi

status: info ## Show repository status (alias for info)

# Legacy/compatibility targets
all: bench-all ## Run all benchmarks (compatibility alias)

.PHONY: all
