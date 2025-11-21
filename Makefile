.PHONY: help bench bench-quick bench-timely bench-differential test clean format lint check all

# Default target
help:
	@echo "Available targets:"
	@echo "  make bench              - Run all benchmarks"
	@echo "  make bench-quick        - Run quick benchmarks (for development)"
	@echo "  make bench-timely       - Run only timely benchmarks"
	@echo "  make bench-differential - Run only differential benchmarks"
	@echo "  make test               - Run all tests"
	@echo "  make check              - Run format and lint checks"
	@echo "  make format             - Format all code"
	@echo "  make lint               - Run clippy linter"
	@echo "  make clean              - Clean build artifacts"
	@echo "  make all                - Run tests, checks, and benchmarks"
	@echo ""
	@echo "Environment variables:"
	@echo "  WORKERS=N               - Set number of worker threads (default: 1)"
	@echo "  BASELINE=name           - Compare against saved baseline"
	@echo ""
	@echo "Examples:"
	@echo "  make bench WORKERS=4"
	@echo "  make bench-timely BASELINE=main"
	@echo "  make bench-quick"

# Benchmark targets
bench:
	@echo "Running all benchmarks..."
	cargo bench --all

bench-quick:
	@echo "Running quick benchmarks..."
	cargo bench --all -- --quick

bench-timely:
	@echo "Running timely benchmarks..."
	cargo bench --package timely-benchmarks

bench-differential:
	@echo "Running differential benchmarks..."
	cargo bench --package differential-benchmarks

# Test targets
test:
	@echo "Running all tests..."
	cargo test --all

test-timely:
	@echo "Running timely tests..."
	cargo test --package timely-benchmarks

test-differential:
	@echo "Running differential tests..."
	cargo test --package differential-benchmarks

# Code quality targets
format:
	@echo "Formatting code..."
	cargo fmt --all

format-check:
	@echo "Checking code formatting..."
	cargo fmt --all -- --check

lint:
	@echo "Running clippy..."
	cargo clippy --all-targets --all-features -- -D warnings

check: format-check lint
	@echo "All checks passed!"

# Build targets
build:
	@echo "Building all packages..."
	cargo build --all

build-release:
	@echo "Building release binaries..."
	cargo build --all --release

# Clean target
clean:
	@echo "Cleaning build artifacts..."
	cargo clean
	rm -rf target/criterion

# Utility targets
doc:
	@echo "Building documentation..."
	cargo doc --all --no-deps --open

doc-private:
	@echo "Building documentation (including private items)..."
	cargo doc --all --no-deps --document-private-items --open

# Comprehensive target
all: test check bench-quick
	@echo "All tasks completed successfully!"

# Baseline management
save-baseline:
ifndef NAME
	@echo "Error: NAME is required. Usage: make save-baseline NAME=baseline-name"
	@exit 1
endif
	@echo "Saving baseline as '$(NAME)'..."
	cargo bench --all -- --save-baseline $(NAME)

compare-baseline:
ifndef NAME
	@echo "Error: NAME is required. Usage: make compare-baseline NAME=baseline-name"
	@exit 1
endif
	@echo "Comparing against baseline '$(NAME)'..."
	cargo bench --all -- --baseline $(NAME)

# Multi-worker benchmarks
bench-workers-1:
	@echo "Running benchmarks with 1 worker..."
	TIMELY_WORKER_THREADS=1 cargo bench --all -- --save-baseline workers-1

bench-workers-2:
	@echo "Running benchmarks with 2 workers..."
	TIMELY_WORKER_THREADS=2 cargo bench --all -- --save-baseline workers-2

bench-workers-4:
	@echo "Running benchmarks with 4 workers..."
	TIMELY_WORKER_THREADS=4 cargo bench --all -- --save-baseline workers-4

bench-all-workers: bench-workers-1 bench-workers-2 bench-workers-4
	@echo "Completed benchmarks for all worker configurations!"

# View results
view-results:
	@echo "Opening benchmark results..."
	@if command -v xdg-open > /dev/null; then \
		xdg-open target/criterion/report/index.html; \
	elif command -v open > /dev/null; then \
		open target/criterion/report/index.html; \
	else \
		echo "Please open target/criterion/report/index.html in your browser"; \
	fi

# Installation check
check-deps:
	@echo "Checking dependencies..."
	@cargo --version || (echo "Cargo not found! Install Rust from https://rustup.rs" && exit 1)
	@rustc --version || (echo "Rustc not found! Install Rust from https://rustup.rs" && exit 1)
	@echo "All dependencies OK!"
