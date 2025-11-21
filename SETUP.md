# Setup Guide

This guide will help you set up the development environment and run benchmarks for performance comparison between timely/differential-dataflow and Hydroflow.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Running Benchmarks](#running-benchmarks)
- [Performance Comparison](#performance-comparison)
- [Troubleshooting](#troubleshooting)
- [Advanced Configuration](#advanced-configuration)

## Prerequisites

### Required Software

1. **Rust Toolchain** (version 1.70 or later)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   source $HOME/.cargo/env
   ```

2. **Git**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install git
   
   # macOS
   brew install git
   ```

3. **Build Tools**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install build-essential pkg-config
   
   # macOS (Xcode Command Line Tools)
   xcode-select --install
   ```

### Optional Tools

1. **critcmp** - For comparing benchmark results
   ```bash
   cargo install critcmp
   ```

2. **cargo-watch** - For continuous testing
   ```bash
   cargo install cargo-watch
   ```

3. **flamegraph** - For profiling
   ```bash
   cargo install flamegraph
   ```

### System Requirements

- **RAM**: At least 4GB (8GB+ recommended for larger benchmarks)
- **Disk Space**: 2GB for dependencies and build artifacts
- **CPU**: Multi-core processor recommended for parallel benchmarks

## Installation

### 1. Clone the Repository

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Verify Installation

```bash
# Check Rust installation
rustc --version
cargo --version

# Should output something like:
# rustc 1.70.0 (or later)
# cargo 1.70.0 (or later)
```

### 3. Build the Project

```bash
# Build all packages
cargo build

# Or using Make
make build
```

This will download and compile all dependencies. First build may take 5-10 minutes.

### 4. Verify Setup

```bash
# Run a quick test build of benchmarks
cargo build --benches

# Run a single quick benchmark to verify everything works
cargo bench --bench arithmetic -- --quick
```

## Quick Start

### Running Your First Benchmark

1. **Run a single benchmark**:
   ```bash
   cargo bench --bench arithmetic
   ```

2. **View results**:
   ```bash
   # Results are in target/criterion/
   # Open the HTML report
   open target/criterion/report/index.html
   # or on Linux: xdg-open target/criterion/report/index.html
   ```

3. **Run all benchmarks**:
   ```bash
   cargo bench
   # or
   make bench
   ```

### Understanding the Output

When you run a benchmark, you'll see output like:

```
arithmetic/timely       time:   [45.123 ms 45.456 ms 45.789 ms]
                        thrpt:  [21.840 Melem/s 22.003 Melem/s 22.166 Melem/s]
```

This shows:
- **time**: Mean execution time with confidence interval [lower mean upper]
- **thrpt**: Throughput (if applicable)

## Running Benchmarks

### Individual Benchmarks

```bash
# Run specific benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join

# Using Make
make bench-arithmetic
make bench-reachability
make bench-join
```

### All Benchmarks

```bash
# Run all benchmarks (may take 15-30 minutes)
cargo bench

# or using Make
make bench
```

### Quick Benchmarks (For Testing)

```bash
# Faster iteration during development
make bench-quick

# or manually
CRITERION_SAMPLE_SIZE=10 cargo bench
```

### Filtering Benchmarks

```bash
# Run only timely implementations
cargo bench timely

# Run only baseline implementations
cargo bench raw

# Run specific benchmark variant
cargo bench arithmetic/timely
```

### Saving and Comparing Results

```bash
# Save current results as baseline
cargo bench -- --save-baseline my-baseline

# Make changes to code...

# Compare against baseline
cargo bench -- --baseline my-baseline
```

## Performance Comparison

This repository works in conjunction with the main `bigweaver-agent-canary-hydro-zeta` repository to enable performance comparisons between timely/differential-dataflow and Hydroflow.

### Complete Comparison Workflow

#### Method 1: Using the Comparison Script (Recommended)

```bash
# Run the interactive comparison script
./compare_benchmarks.sh

# Follow the prompts:
# 1) Run benchmarks in both repositories
# 2) Run benchmarks in deps repository only (timely/differential)
# 3) Run benchmarks in main repository only (Hydroflow)
# 4) Show comparison instructions
```

#### Method 2: Manual Comparison

1. **Run benchmarks in this repository** (timely/differential):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

2. **Run benchmarks in main repository** (Hydroflow):
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Compare HTML reports**:
   - Timely/Differential: `bigweaver-agent-canary-zeta-hydro-deps/target/criterion/report/index.html`
   - Hydroflow: `bigweaver-agent-canary-hydro-zeta/target/criterion/report/index.html`

4. **Compare specific benchmarks**:
   ```bash
   # Look for matching patterns:
   # - arithmetic/timely vs arithmetic/dfir_rs/compiled
   # - reachability/differential vs reachability/dfir_rs/compiled
   ```

### Using critcmp for Comparison

```bash
# Install critcmp if not already installed
cargo install critcmp

# Compare results from both repositories
critcmp --basedir bigweaver-agent-canary-zeta-hydro-deps/target/criterion \
        --basedir bigweaver-agent-canary-hydro-zeta/target/criterion
```

### Benchmark Mappings

| This Repository (Timely/DD) | Main Repository (Hydroflow) |
|----------------------------|----------------------------|
| arithmetic/timely | arithmetic/dfir_rs/* |
| fan_in/timely | fan_in/dfir_rs/* |
| fan_out/timely | fan_out/dfir_rs/* |
| fork_join/timely | fork_join/dfir_rs/* |
| identity/timely | identity/dfir_rs/* |
| join/timely | join/dfir_rs/* |
| reachability/timely | reachability/dfir_rs/* |
| reachability/differential | reachability/dfir_rs/* |
| upcase/timely | upcase/dfir_rs/* |

## Troubleshooting

### Common Issues

#### 1. Compilation Errors

**Problem**: `error: linking with 'cc' failed`

**Solution**:
```bash
# Ubuntu/Debian
sudo apt-get install build-essential

# macOS
xcode-select --install
```

#### 2. Out of Memory

**Problem**: Compilation runs out of memory

**Solution**:
```bash
# Reduce parallel compilation jobs
cargo build -j 2
```

#### 3. Benchmarks Taking Too Long

**Problem**: Benchmarks take forever to complete

**Solution**:
```bash
# Use quick mode
make bench-quick

# Or run specific benchmarks
cargo bench --bench arithmetic
```

#### 4. Inconsistent Results

**Problem**: Benchmark results vary significantly between runs

**Solution**:
1. Close other applications
2. Disable CPU frequency scaling:
   ```bash
   # Linux (requires sudo)
   sudo cpupower frequency-set --governor performance
   ```
3. Run on dedicated hardware
4. Increase measurement time:
   ```bash
   CRITERION_MEASUREMENT_TIME=10 cargo bench
   ```

#### 5. Missing Main Repository

**Problem**: Comparison script can't find main repository

**Solution**:
```bash
# Ensure both repositories are in the same parent directory
parent-dir/
  ├── bigweaver-agent-canary-zeta-hydro-deps/
  └── bigweaver-agent-canary-hydro-zeta/
```

### Getting Help

If you encounter issues not covered here:

1. Check the [BENCHMARKS.md](BENCHMARKS.md) documentation
2. Look at [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines
3. Open an issue on the repository with:
   - Your OS and version
   - Rust version (`rustc --version`)
   - Complete error message
   - Steps to reproduce

## Advanced Configuration

### Environment Variables

Configure benchmark behavior using environment variables:

```bash
# Measurement time per benchmark (seconds)
CRITERION_MEASUREMENT_TIME=10 cargo bench

# Number of samples
CRITERION_SAMPLE_SIZE=50 cargo bench

# Warm-up time (seconds)
CRITERION_WARM_UP_TIME=5 cargo bench

# Combine multiple settings
CRITERION_MEASUREMENT_TIME=10 \
CRITERION_SAMPLE_SIZE=100 \
CRITERION_WARM_UP_TIME=5 \
cargo bench
```

### Profiling Benchmarks

#### With perf (Linux)

```bash
# Profile a specific benchmark
cargo bench --bench arithmetic --profile-time 10

# Analyze with perf
perf record -g cargo bench --bench arithmetic --profile-time 10
perf report
```

#### With flamegraph

```bash
# Install flamegraph
cargo install flamegraph

# Generate flamegraph
cargo flamegraph --bench arithmetic

# Opens flamegraph.svg in browser
```

#### With Valgrind

```bash
# Profile with callgrind
valgrind --tool=callgrind \
         --dump-instr=yes \
         --collect-jumps=yes \
         target/release/deps/arithmetic-* --profile-time 1

# View with kcachegrind
kcachegrind callgrind.out.*
```

### Custom Data Files

Some benchmarks (like reachability) use data files. To use custom data:

1. Place your data file in `benches/benches/`
2. Update the benchmark to load your file
3. Rebuild and run:
   ```bash
   cargo bench --bench reachability
   ```

### Parallel Execution

```bash
# Control number of parallel benchmark threads
cargo bench -- --test-threads=1

# Run benchmarks in parallel (default)
cargo bench
```

### Continuous Benchmarking

```bash
# Install cargo-watch
cargo install cargo-watch

# Watch for changes and run benchmarks
cargo watch -x 'bench --bench arithmetic'

# or using Make
make watch-bench
```

### CI Integration

For continuous integration, use:

```bash
# Quick CI-friendly benchmark run
CRITERION_SAMPLE_SIZE=10 cargo bench --no-fail-fast

# Save results for comparison
cargo bench -- --save-baseline ci-baseline
```

## Development Workflow

### Recommended Workflow

1. **Make code changes**
2. **Check compilation**:
   ```bash
   make check
   # or
   cargo check --benches
   ```
3. **Run quick benchmark**:
   ```bash
   make bench-quick
   # or
   CRITERION_SAMPLE_SIZE=10 cargo bench --bench <your-bench>
   ```
4. **Full benchmark before commit**:
   ```bash
   make bench
   ```
5. **Run pre-commit checks**:
   ```bash
   make pre-commit
   # Runs: format, clippy, tests
   ```

### Using Make Commands

The Makefile provides convenient shortcuts:

```bash
# See all available commands
make help

# Common commands
make build          # Build project
make test           # Run tests
make bench          # Run all benchmarks
make bench-quick    # Quick benchmark pass
make fmt            # Format code
make clippy         # Run lints
make clean          # Clean build artifacts
make all            # Format, lint, test, build
```

## Next Steps

After setup:

1. **Read the benchmark documentation**: [BENCHMARKS.md](BENCHMARKS.md)
2. **Explore benchmark code**: Look at `benches/benches/*.rs` files
3. **Run comparisons**: Use `./compare_benchmarks.sh` to compare with Hydroflow
4. **Contribute**: See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines

## Performance Tips

### For Accurate Benchmarks

1. **Consistent Environment**:
   - Close other applications
   - Run on AC power (laptops)
   - Disable CPU frequency scaling
   - Use consistent room temperature

2. **Multiple Runs**:
   - Run benchmarks multiple times
   - Check variance/confidence intervals
   - Look for outliers

3. **System Settings**:
   ```bash
   # Linux: Set CPU governor to performance
   sudo cpupower frequency-set --governor performance
   
   # Disable turbo boost for consistency
   echo "1" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
   ```

### For Development

1. **Use quick mode** for rapid iteration
2. **Run specific benchmarks** instead of all
3. **Profile** when optimizing
4. **Compare against baselines** to track progress

## Resources

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow](https://hydro.run/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

## Support

- **Documentation**: Check BENCHMARKS.md and README.md
- **Issues**: Open an issue on the repository
- **Questions**: Use GitHub discussions

---

Happy benchmarking! 🚀
