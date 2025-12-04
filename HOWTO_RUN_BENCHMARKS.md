# How to Run Performance Benchmarks

This guide explains how to run performance benchmarks for Hydro and compare against timely-dataflow and differential-dataflow implementations.

## Prerequisites

1. **Rust Toolchain**: Install Rust using [rustup](https://rustup.rs/)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Clone Repository**:
   ```bash
   git clone https://github.com/hydro-project/hydro-deps bigweaver-agent-canary-zeta-hydro-deps
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

## Quick Start

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will:
- Compile all benchmark code
- Run each benchmark multiple times for statistical accuracy
- Generate HTML reports in `target/criterion/`
- Print summary results to the terminal

### Run Specific Benchmark

```bash
cargo bench -p benches --bench arithmetic
```

Replace `arithmetic` with any benchmark name from the list below.

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Basic arithmetic operations pipeline |
| `fan_in` | Multiple inputs merging to single output |
| `fan_out` | Single input broadcasting to multiple outputs |
| `fork_join` | Fork-join parallelism patterns |
| `futures` | Futures-based async operations |
| `identity` | Identity operations (baseline performance) |
| `join` | Join operations between streams |
| `micro_ops` | Micro-benchmarks of individual operations |
| `reachability` | Graph reachability computation |
| `symmetric_hash_join` | Symmetric hash join implementation |
| `upcase` | String uppercase transformation |
| `words_diamond` | Diamond-shaped word processing pipeline |

## Understanding Results

### Terminal Output

After running benchmarks, you'll see output like:

```
arithmetic/pipeline     time:   [123.45 ms 125.67 ms 127.89 ms]
                        change: [-2.3456% -1.2345% +0.1234%] (p = 0.12 > 0.05)
                        No change in performance detected.
```

This shows:
- **time**: Current performance measurement with confidence interval
- **change**: Performance change compared to previous run
- **p-value**: Statistical significance (< 0.05 indicates significant change)

### HTML Reports

Open `target/criterion/report/index.html` in a web browser to see:

- **Performance Plots**: Visual charts of execution time
- **Statistical Analysis**: Detailed statistical breakdown
- **Historical Data**: Performance trends over time
- **Comparison Charts**: Side-by-side comparisons

## Running Specific Benchmark Variants

Some benchmarks include multiple implementations. To run a specific variant:

```bash
# Run all variants of arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run only the Hydro variant (if available)
cargo bench -p benches --bench arithmetic -- hydro

# Run only the timely variant (if available)
cargo bench -p benches --bench arithmetic -- timely
```

## Performance Comparison Workflow

To compare Hydro against timely/differential-dataflow:

1. **Baseline Run**: Run benchmarks to establish baseline
   ```bash
   cargo bench -p benches
   ```

2. **Make Changes**: Update Hydro code in the main repository

3. **Update Dependency**: Pull latest Hydro changes
   ```bash
   cargo update -p dfir_rs
   ```

4. **Re-run Benchmarks**: Compare against baseline
   ```bash
   cargo bench -p benches
   ```

5. **Review Results**: Check `target/criterion/report/index.html`

## Benchmark Configuration

### Adjusting Sample Size

Edit the benchmark file to change sample size:

```rust
c.bench_function("my_benchmark", |b| {
    b.iter(|| {
        // benchmark code
    });
});
```

Add configuration:

```rust
let mut group = c.benchmark_group("my_group");
group.sample_size(100);  // Increase for more accuracy
group.bench_function("my_benchmark", |b| {
    // ...
});
group.finish();
```

### Warm-up and Measurement Time

```rust
let mut group = c.benchmark_group("my_group");
group.warm_up_time(Duration::from_secs(5));
group.measurement_time(Duration::from_secs(10));
```

## Troubleshooting

### Compilation Errors

If you encounter compilation errors:

```bash
# Update dependencies
cargo update

# Clean build artifacts
cargo clean

# Rebuild
cargo bench -p benches --no-run
```

### Out of Memory

For large benchmarks (like reachability):

```bash
# Reduce input size in the benchmark code
# Or increase system memory/swap
```

### Inconsistent Results

For more stable results:

1. Close other applications
2. Disable CPU frequency scaling (Linux):
   ```bash
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```
3. Increase sample size in benchmark configuration

## Advanced Usage

### Custom Benchmark Targets

Create a new benchmark in `benches/benches/my_benchmark.rs`:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_test", |b| {
        b.iter(|| {
            // Your benchmark code here
            black_box(42)
        });
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

Run it:

```bash
cargo bench -p benches --bench my_benchmark
```

### Exporting Results

Criterion automatically saves results in `target/criterion/`. To export:

```bash
# Copy HTML reports
cp -r target/criterion/report /path/to/export/

# Save raw data (JSON format)
# Results are in target/criterion/*/base/estimates.json
```

## Continuous Benchmarking

To track performance over time:

1. Run benchmarks regularly (e.g., before each release)
2. Archive HTML reports: `cp -r target/criterion/report archive/$(date +%Y%m%d)/`
3. Compare reports across versions
4. Watch for performance regressions

## Getting Help

- **Benchmark Issues**: Check this repository's README.md
- **Criterion Documentation**: https://bheisler.github.io/criterion.rs/book/
- **Hydro Development**: See main repository's CONTRIBUTING.md
- **Performance Questions**: Review the MIGRATION.md guide
