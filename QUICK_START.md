# Quick Start Guide

This guide will help you get started with running the timely and differential-dataflow benchmarks.

## Prerequisites

Ensure you have Rust installed. The repository will automatically use the version specified in `rust-toolchain.toml` (1.91.1).

```bash
# Check if Rust is installed
rustc --version

# If not installed, get it from https://rustup.rs/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Quick Run

### 1. Clone and Navigate

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Run All Benchmarks

```bash
cargo bench
```

This will:
- Download and compile dependencies (first run may take a while)
- Run all 8 benchmarks
- Generate HTML reports in `target/criterion/`

### 3. Run a Specific Benchmark

```bash
# Run arithmetic benchmark
cargo bench --bench arithmetic

# Run graph reachability benchmark
cargo bench --bench reachability
```

### 4. View Results

Benchmark results are automatically saved with:
- Console output showing timing results
- HTML reports in `target/criterion/` directory
- Statistical analysis and comparisons

```bash
# Open HTML reports (example)
open target/criterion/report/index.html
```

## Common Commands

### Run benchmarks matching a pattern

```bash
# All timely-related benchmarks
cargo bench timely

# All Hydroflow benchmarks
cargo bench dfir_rs

# Specific operation
cargo bench arithmetic
```

### Save baseline for comparison

```bash
# Create baseline
cargo bench -- --save-baseline my_baseline

# Compare against baseline later
cargo bench -- --baseline my_baseline
```

### Build without running

```bash
cargo build --release
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Arithmetic operations across frameworks |
| `identity` | Pass-through benchmark (measures overhead) |
| `fan_in` | Multiple streams merging |
| `fan_out` | Stream splitting into multiple outputs |
| `fork_join` | Fork-join parallelism |
| `join` | Stream join operations |
| `reachability` | Graph reachability computation |
| `upcase` | String transformation |

## Understanding Results

Each benchmark compares multiple implementations:

- **Raw/Baseline**: Pure Rust without frameworks
- **Iterator**: Standard Rust iterator chains
- **Timely**: Using timely-dataflow
- **Differential**: Using differential-dataflow (where applicable)
- **Hydroflow**: Using dfir_rs (compiled and surface syntax)

Criterion provides:
- **Time**: Mean execution time with confidence intervals
- **Throughput**: Operations per second (where applicable)
- **Comparison**: Performance relative to previous runs
- **Change**: Statistical significance of performance changes

## Troubleshooting

### Build Issues

If you encounter build errors:

```bash
# Clean build
cargo clean

# Update dependencies
cargo update

# Try building again
cargo build
```

### Network Issues

The benchmarks use git dependencies, so you need internet access for the first build:

- `dfir_rs` from hydro-project/hydro
- `sinktools` from hydro-project/hydro

### Long Build Times

First build will take longer because:
- Git dependencies need to be fetched
- Multiple frameworks need compilation
- Release profile uses optimizations

Subsequent builds will be much faster.

## Next Steps

- **Explore Results**: Check the HTML reports in `target/criterion/`
- **Add Benchmarks**: See `README.md` for adding new benchmarks
- **Modify Tests**: Edit benchmark files in `benches/benches/`
- **Compare Performance**: Use baseline features to track changes

## Getting Help

- **Documentation**: See `README.md` for comprehensive documentation
- **Migration Details**: See `MIGRATION_SUMMARY.md` for setup details
- **Issues**: File issues in the repository
- **Upstream Projects**:
  - Hydroflow: https://github.com/hydro-project/hydro
  - Timely: https://github.com/TimelyDataflow/timely-dataflow
  - Differential: https://github.com/TimelyDataflow/differential-dataflow

## Performance Tips

### For Development

```bash
# Faster builds during development
cargo build
cargo test
```

### For Accurate Benchmarks

```bash
# Use release mode (done automatically by cargo bench)
cargo bench

# Close other applications
# Ensure consistent system state
# Run multiple times for statistical significance
```

## Example Session

```bash
# Navigate to repository
cd bigweaver-agent-canary-zeta-hydro-deps

# Run a quick benchmark
cargo bench --bench identity

# Output will show:
# identity/pipeline    time: [...]
# identity/timely      time: [...]
# identity/dfir_rs     time: [...]
# ...

# View detailed results
ls target/criterion/identity/
# You'll see directories for each benchmark variant

# Run all benchmarks and compare
cargo bench

# Check the summary report
open target/criterion/report/index.html
```

That's it! You're ready to run and analyze the benchmarks. 🚀
