# Quick Start Guide

Get started with Timely and Differential Dataflow benchmarks in 5 minutes.

## Prerequisites

Install Rust if you haven't already:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Quick Start Steps

### 1. Clone and Navigate

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Build Everything

```bash
cargo build --release
```

This compiles both Timely and Differential Dataflow benchmark suites in optimized mode.

### 3. Run Your First Benchmark

Try a simple benchmark to verify everything works:

```bash
cargo bench -p timely-benchmarks --bench identity
```

This runs the identity benchmark for Timely Dataflow, which should complete in under a minute.

### 4. View Results

Criterion automatically generates HTML reports:

```bash
# Reports are saved in target/criterion/
ls target/criterion/

# View the main report (if you have a browser)
open target/criterion/report/index.html
# Or on Linux:
xdg-open target/criterion/report/index.html
```

## Next Steps

### Run All Benchmarks

```bash
# This will take 10-20 minutes depending on your hardware
cargo bench
```

### Run Specific Benchmark Suites

```bash
# Only Timely benchmarks
cargo bench -p timely-benchmarks

# Only Differential benchmarks
cargo bench -p differential-benchmarks
```

### Run Individual Benchmarks

```bash
# Arithmetic operations
cargo bench --bench arithmetic

# Graph reachability (iterative)
cargo bench -p differential-benchmarks --bench reachability

# Micro operations (filter, map, chain)
cargo bench --bench micro_ops
```

## Understanding Output

When you run a benchmark, you'll see output like:

```
timely_identity/100     time:   [45.234 µs 45.891 µs 46.612 µs]
```

This means:
- **Benchmark name**: `timely_identity/100` (identity operation with 100 elements)
- **Timing range**: The benchmark took between 45.2 and 46.6 microseconds (95% confidence interval)
- **Estimate**: Best estimate is 45.9 microseconds

## Common Tasks

### Compare Before/After Changes

```bash
# Run benchmarks and save as baseline
cargo bench -- --save-baseline before

# Make your changes...

# Run benchmarks again and compare
cargo bench -- --baseline before
```

Criterion will show you the performance difference!

### Export Results for Analysis

```bash
# Results are in JSON format in target/criterion/
cat target/criterion/timely_identity/100/base/estimates.json | jq '.mean'
```

### Clean Build Artifacts

```bash
# Remove build artifacts but keep benchmark results
cargo clean

# Remove everything including benchmark results
rm -rf target/
```

## Troubleshooting

### Build Fails

Make sure you have the latest Rust:

```bash
rustup update
```

### Benchmarks Take Too Long

Run specific benchmarks instead of all:

```bash
# Just the fast ones
cargo bench --bench identity
cargo bench --bench arithmetic
```

Or reduce the sample size (Criterion options):

```bash
cargo bench -- --sample-size 10
```

### Permission Denied

If you get permission errors:

```bash
sudo chown -R $USER:$USER .
```

## Available Benchmarks Summary

| Benchmark | Description | Runtime | Difficulty |
|-----------|-------------|---------|------------|
| `identity` | Passthrough operations | ~1 min | Easy |
| `arithmetic` | Basic math operations | ~2 min | Easy |
| `micro_ops` | Filter, map, chain | ~3 min | Easy |
| `fan_in` | Stream merging | ~2 min | Medium |
| `fan_out` | Stream splitting | ~2 min | Medium |
| `reachability` | Graph traversal | ~5 min | Hard |

## Learning More

- **Detailed README**: [README.md](./README.md) - Full documentation
- **Comparison Guide**: [BENCHMARK_COMPARISON.md](./BENCHMARK_COMPARISON.md) - Compare with Hydro
- **Timely Docs**: https://timelydataflow.github.io/timely-dataflow/
- **Differential Docs**: https://timelydataflow.github.io/differential-dataflow/

## Examples of Benchmark Output

### Successful Run

```
timely_arithmetic/1000
                        time:   [123.45 µs 124.67 µs 126.01 µs]
Found 2 outliers among 100 measurements (2.00%)
  1 (1.00%) high mild
  1 (1.00%) high severe
```

✅ This is normal! A few outliers are expected.

### Performance Change Detected

```
timely_arithmetic/1000
                        time:   [110.23 µs 111.45 µs 112.89 µs]
                        change: [-12.345% -10.234% -8.123%] (p = 0.00 < 0.05)
                        Performance has improved.
```

✅ Great! The benchmark is faster than the baseline.

### First Run (No Baseline)

```
timely_arithmetic/1000
                        time:   [123.45 µs 124.67 µs 126.01 µs]
```

ℹ️ No comparison shown - this is your first run!

## Getting Help

If you encounter issues:

1. Check the [README.md](./README.md) for detailed documentation
2. Verify you're using Rust 1.70+: `rustc --version`
3. Make sure you're building in release mode (benchmarks automatically do this)
4. Try cleaning and rebuilding: `cargo clean && cargo build --release`

## Quick Command Reference

```bash
# Build everything
cargo build --release

# Run all benchmarks
cargo bench

# Run Timely benchmarks only
cargo bench -p timely-benchmarks

# Run Differential benchmarks only
cargo bench -p differential-benchmarks

# Run specific benchmark
cargo bench --bench arithmetic

# Run benchmark with baseline comparison
cargo bench -- --baseline my-baseline

# Save current run as baseline
cargo bench -- --save-baseline my-baseline

# View help
cargo bench -- --help
```

Happy benchmarking! 🚀
