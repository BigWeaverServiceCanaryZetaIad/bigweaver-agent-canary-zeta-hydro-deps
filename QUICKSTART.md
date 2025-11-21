# Quick Start Guide

Get started with Timely and Differential Dataflow benchmarks in minutes.

## Prerequisites

- Rust toolchain (1.70+)
- Cargo

## Quick Run

### Run All Benchmarks
```bash
./run_benchmarks.sh
```

### Run Specific Benchmark Suites

```bash
# Timely benchmarks only
cargo bench -p timely-differential-benches --bench timely_basic_ops
cargo bench -p timely-differential-benches --bench timely_reachability

# Differential benchmarks only
cargo bench -p timely-differential-benches --bench differential_basic_ops
cargo bench -p timely-differential-benches --bench differential_reachability

# Performance comparison
cargo bench -p timely-differential-benches --bench comparison
```

### Run with Filters

```bash
# Run only map operations
cargo bench -p timely-differential-benches -- map

# Run only large workloads (100000 elements)
cargo bench -p timely-differential-benches -- 100000

# Run only Timely framework benchmarks
cargo bench -p timely-differential-benches -- timely/

# Run only Differential framework benchmarks
cargo bench -p timely-differential-benches -- differential/
```

## Understanding Results

After running benchmarks, view the HTML reports:
```bash
# The reports are in target/criterion/
open target/criterion/report/index.html

# Or on Linux
xdg-open target/criterion/report/index.html
```

### Key Metrics

- **Time**: How long the operation took
- **Throughput**: Items processed per second
- **Comparison**: Performance difference vs. baseline

## Performance Comparison Highlights

The comparison suite directly compares Timely and Differential Dataflow:

```bash
cargo bench -p timely-differential-benches --bench comparison
```

This shows:
- **Map/Filter operations**: Both frameworks
- **Aggregations**: Count, reduce operations
- **Incremental updates**: Where Differential excels
- **Reachability**: Graph algorithm comparison

## Benchmark Categories

| Category | Focus | Best For |
|----------|-------|----------|
| Timely Basic Ops | Core streaming operations | Understanding Timely performance |
| Timely Reachability | Graph algorithms | Iterative computation patterns |
| Differential Basic Ops | Collection operations | Understanding Differential performance |
| Differential Reachability | Incremental graphs | Incremental computation |
| Comparison | Side-by-side tests | Choosing the right framework |

## Common Use Cases

### 1. Test a New Change
```bash
# Save baseline before changes
cargo bench -p timely-differential-benches -- --save-baseline before

# Make your changes...

# Compare against baseline
cargo bench -p timely-differential-benches -- --baseline before
```

### 2. Focus on Specific Operations
```bash
# Only test map operations
./run_benchmarks.sh map

# Only test with 10k elements
./run_benchmarks.sh 10000
```

### 3. Quick Smoke Test
```bash
# Run a subset of benchmarks quickly
cargo bench -p timely-differential-benches --bench timely_basic_ops -- --quick
```

## Troubleshooting

### Benchmarks Taking Too Long?
```bash
# Set smaller sample size
export CRITERION_SAMPLE_SIZE=10
cargo bench -p timely-differential-benches
```

### Out of Memory?
Edit the benchmark files to reduce test sizes:
```rust
// Change from [1_000, 10_000, 100_000]
// to [1_000, 10_000]
for size in [1_000, 10_000].iter() {
    // ...
}
```

### Build Errors?
```bash
# Clean and rebuild
cargo clean
cargo build --release -p timely-differential-benches
```

## Next Steps

- Read the full [README.md](README.md) for detailed information
- Check [benches/README.md](benches/README.md) for benchmark documentation
- Explore individual benchmark files in `benches/benches/`
- Customize benchmarks for your use case

## Examples

### Example 1: Compare Map Performance
```bash
cargo bench -p timely-differential-benches --bench comparison -- "comparison/map"
```

### Example 2: Test Incremental Updates
```bash
cargo bench -p timely-differential-benches --bench differential_basic_ops -- incremental
```

### Example 3: Graph Reachability Comparison
```bash
cargo bench -p timely-differential-benches --bench comparison -- reachability
```

## Tips

1. **Use filters**: Narrow down to specific benchmarks to save time
2. **Save baselines**: Track performance over time
3. **Check HTML reports**: Much easier to understand than console output
4. **Run in release mode**: Criterion does this automatically
5. **Warm up your system**: First run may be slower

## Need Help?

- Check the full documentation in `README.md`
- Review benchmark source code in `benches/benches/`
- Consult Criterion.rs documentation for advanced features
