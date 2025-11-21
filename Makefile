# Makefile for bigweaver-agent-canary-zeta-hydro-deps
# Provides convenient commands for building, testing, and benchmarking

.PHONY: help build test bench clean check fmt clippy all compare doc install-tools

# Default target
help:
	@echo "Available targets:"
	@echo "  make build          - Build all packages"
	@echo "  make test           - Run all tests"
	@echo "  make bench          - Run all benchmarks"
	@echo "  make bench-quick    - Run quick benchmark pass"
	@echo "  make bench-save     - Save benchmark baseline"
	@echo "  make check          - Check code without building"
	@echo "  make fmt            - Format code"
	@echo "  make fmt-check      - Check code formatting"
	@echo "  make clippy         - Run clippy lints"
	@echo "  make clean          - Clean build artifacts"
	@echo "  make all            - Format, clippy, test, and build"
	@echo "  make compare        - Run comparison script"
	@echo "  make doc            - Generate documentation"
	@echo "  make install-tools  - Install development tools"
	@echo ""
	@echo "Benchmark-specific targets:"
	@echo "  make bench-arithmetic    - Run arithmetic benchmark"
	@echo "  make bench-fan-in        - Run fan_in benchmark"
	@echo "  make bench-fan-out       - Run fan_out benchmark"
	@echo "  make bench-fork-join     - Run fork_join benchmark"
	@echo "  make bench-identity      - Run identity benchmark"
	@echo "  make bench-join          - Run join benchmark"
	@echo "  make bench-reachability  - Run reachability benchmark"
	@echo "  make bench-upcase        - Run upcase benchmark"

# Build targets
build:
	cargo build --all

build-release:
	cargo build --all --release

# Test targets
test:
	cargo test --all

test-verbose:
	cargo test --all -- --nocapture

# Benchmark targets
bench:
	cargo bench --all

bench-quick:
	CRITERION_SAMPLE_SIZE=10 cargo bench --all

bench-save:
	cargo bench --all -- --save-baseline main

bench-compare:
	cargo bench --all -- --baseline main

# Individual benchmark targets
bench-arithmetic:
	cargo bench --bench arithmetic

bench-fan-in:
	cargo bench --bench fan_in

bench-fan-out:
	cargo bench --bench fan_out

bench-fork-join:
	cargo bench --bench fork_join

bench-identity:
	cargo bench --bench identity

bench-join:
	cargo bench --bench join

bench-reachability:
	cargo bench --bench reachability

bench-upcase:
	cargo bench --bench upcase

# Code quality targets
check:
	cargo check --all

fmt:
	cargo fmt --all

fmt-check:
	cargo fmt --all -- --check

clippy:
	cargo clippy --all -- -D warnings

clippy-fix:
	cargo clippy --all --fix --allow-dirty

# Cleaning
clean:
	cargo clean
	rm -rf target/

clean-bench:
	rm -rf target/criterion/

# Combined targets
all: fmt clippy test build

ci: fmt-check clippy test build

# Comparison with main repository
compare:
	./compare_benchmarks.sh

# Documentation
doc:
	cargo doc --all --no-deps --open

doc-private:
	cargo doc --all --no-deps --document-private-items --open

# Development tools
install-tools:
	cargo install cargo-watch
	cargo install cargo-criterion
	cargo install critcmp
	cargo install flamegraph

# Continuous development
watch:
	cargo watch -x check -x test

watch-bench:
	cargo watch -x 'bench --bench arithmetic'

# Profiling targets
profile-arithmetic:
	cargo bench --bench arithmetic --profile-time 10

profile-reachability:
	cargo bench --bench reachability --profile-time 10

# Report generation
report:
	@echo "Opening benchmark reports..."
	@echo "HTML Report: target/criterion/report/index.html"
	@which xdg-open > /dev/null && xdg-open target/criterion/report/index.html || open target/criterion/report/index.html || echo "Please open target/criterion/report/index.html manually"

# Update dependencies
update:
	cargo update

update-check:
	cargo outdated

# Size analysis
bloat:
	cargo bloat --release --crates

# Security audit
audit:
	cargo audit

# Pre-commit checks
pre-commit: fmt clippy test
	@echo "✓ Pre-commit checks passed"

# Release preparation
prepare-release: clean all bench
	@echo "✓ Release preparation complete"

# Comparison with specific baseline
compare-with-baseline:
	@read -p "Enter baseline name: " baseline; \
	cargo bench -- --baseline $$baseline

# Archive benchmark results
archive-results:
	@mkdir -p benchmark-archive
	@timestamp=$$(date +%Y%m%d-%H%M%S); \
	tar -czf benchmark-archive/results-$$timestamp.tar.gz target/criterion/
	@echo "Results archived to benchmark-archive/results-$$timestamp.tar.gz"

# List available benchmarks
list-benchmarks:
	@echo "Available benchmarks:"
	@grep -E '^\[\[bench\]\]' benches/Cargo.toml -A1 | grep 'name' | sed 's/name = "\(.*\)"/  - \1/'

# Show benchmark status
status:
	@echo "Repository Status:"
	@echo "=================="
	@echo "Git Branch:    $$(git branch --show-current 2>/dev/null || echo 'N/A')"
	@echo "Last Commit:   $$(git log -1 --format='%h - %s' 2>/dev/null || echo 'N/A')"
	@echo ""
	@echo "Build Status:"
	@echo "============="
	@cargo --version
	@rustc --version
	@echo ""
	@echo "Benchmarks:"
	@echo "==========="
	@$(MAKE) list-benchmarks
	@echo ""
	@if [ -d target/criterion ]; then \
		echo "Last benchmark run: $$(find target/criterion -name 'index.html' -type f -printf '%T@ %Tc\n' | sort -n | tail -1 | cut -d' ' -f2-)"; \
	else \
		echo "No benchmark results found. Run 'make bench' first."; \
	fi

# Show disk usage
disk-usage:
	@echo "Disk Usage:"
	@echo "==========="
	@du -sh target/ 2>/dev/null || echo "No target directory"
	@du -sh target/criterion/ 2>/dev/null || echo "No criterion results"
	@du -sh target/debug/ 2>/dev/null || echo "No debug builds"
	@du -sh target/release/ 2>/dev/null || echo "No release builds"

# Dependency tree
deps:
	cargo tree

deps-duplicates:
	cargo tree -d

# Quick verification
verify: fmt-check clippy
	@echo "✓ Code verification passed"

# Performance regression check
regression-check:
	@if [ ! -d target/criterion ]; then \
		echo "No baseline found. Running initial benchmark..."; \
		$(MAKE) bench-save; \
	else \
		echo "Running regression check..."; \
		cargo bench -- --baseline main; \
	fi
