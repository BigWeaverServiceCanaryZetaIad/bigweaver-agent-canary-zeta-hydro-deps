# Quick Start Guide

## Prerequisites

- Rust toolchain (1.75 or later recommended)
- Cargo package manager

## Installation

```bash
# Clone the repository
git clone <repository-url> bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will run all benchmarks and generate HTML reports in `target/criterion/`.

### Run Specific Benchmark

```bash
# Run arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run join benchmark
cargo bench -p benches --bench join
```

### Run Specific Test Within a Benchmark

```bash
# Run only timely implementation of reachability
cargo bench -p benches --bench reachability -- timely

# Run only differential implementation of reachability
cargo bench -p benches --bench reachability -- differential

# Run arithmetic with timely
cargo bench -p benches --bench arithmetic -- arithmetic/timely
```

## Viewing Results

After running benchmarks, view the HTML reports:

```bash
# Results are in target/criterion/
open target/criterion/report/index.html
```

## Quick Validation

To ensure everything compiles correctly:

```bash
# Check that all benchmarks compile
cargo check --benches

# Build benchmarks without running
cargo build --benches --release
```

## Common Commands

```bash
# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Show dependency tree
cargo tree

# Run benchmarks with increased sample size
cargo bench -p benches -- --sample-size 1000

# Save baseline for comparison
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline
```

## Benchmark List

| Benchmark | Focus | Key Metrics |
|-----------|-------|-------------|
| arithmetic | Basic operations | Throughput of map operations |
| fan_in | Stream concatenation | Union/merge performance |
| upcase | String transforms | Map overhead with allocations |
| join | Hash joins | Join performance with different types |
| reachability | Graph algorithms | Iterative/incremental computation |

## Troubleshooting

### Build Errors

If you encounter build errors:

```bash
# Clean and rebuild
cargo clean
cargo check --benches
```

### Slow Benchmarks

If benchmarks are taking too long:

```bash
# Reduce sample size or measurement time
cargo bench -p benches -- --sample-size 10 --measurement-time 5
```

### Missing Rust Toolchain

Install Rust if not already installed:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Next Steps

- Read the full [README.md](README.md) for detailed information
- Check [MIGRATION.md](MIGRATION.md) to understand the migration context
- Review [CHANGELOG.md](CHANGELOG.md) for version history
- Explore benchmark source code in `benches/benches/` directory

## Getting Help

- Review benchmark source code for implementation details
- Check [timely-dataflow documentation](https://github.com/TimelyDataflow/timely-dataflow)
- Check [differential-dataflow documentation](https://github.com/TimelyDataflow/differential-dataflow)
- Open an issue in the repository for bugs or questions
