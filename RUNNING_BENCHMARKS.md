# Running Benchmarks Guide

This guide provides detailed instructions for running the benchmarks in this repository and interpreting the results.

## Quick Start

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# View results
open target/criterion/report/index.html
```

## Prerequisites

### System Requirements

- **Rust**: Version 1.75+ (edition 2024 support)
- **Memory**: At least 4GB RAM recommended
- **Disk**: ~2GB for build artifacts and results
- **CPU**: Multi-core processor recommended for parallel benchmarks

### Installation

1. Install Rust and Cargo:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

2. Verify installation:
```bash
rustc --version
cargo --version
```

3. Clone this repository:
```bash
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps
```

## Running Benchmarks

### All Benchmarks

Run the complete benchmark suite:

```bash
cargo bench
```

This will:
- Compile all benchmarks in release mode
- Execute each benchmark with multiple iterations
- Generate statistical analysis
- Create HTML reports

Expected time: 10-30 minutes depending on your system.

### Individual Benchmarks

Run specific benchmarks to save time:

```bash
# Identity transformation benchmarks
cargo bench --bench identity

# Fork-join pattern benchmarks
cargo bench --bench fork_join

# Join operation benchmarks
cargo bench --bench join

# String uppercase benchmarks
cargo bench --bench upcase

# Fan-in pattern benchmarks
cargo bench --bench fan_in

# Fan-out pattern benchmarks
cargo bench --bench fan_out

# Arithmetic operations benchmarks
cargo bench --bench arithmetic

# Graph reachability benchmarks (slowest)
cargo bench --bench reachability
```

### Benchmark Groups

Run multiple related benchmarks:

```bash
# All fan-pattern benchmarks
cargo bench --bench fan_in --bench fan_out

# All timely comparison benchmarks
cargo bench --bench identity --bench fork_join --bench join
```

### Quick Benchmarks (Development Mode)

For faster iteration during development:

```bash
# Shorter measurement time (less accurate)
cargo bench -- --quick

# Compile without running
cargo bench --no-run

# Just verify benchmarks build
cargo build --benches
```

## Understanding Benchmark Output

### Console Output

Each benchmark produces output like:

```
identity/pipeline       time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-2.5% -1.2% +0.3%] (p = 0.15 > 0.05)
                        No change in performance detected.

identity/raw            time:   [12.345 ms 12.456 ms 12.567 ms]
                        thrpt:  [79.567 Kelem/s 80.234 Kelem/s 81.012 Kelem/s]
```

**Interpreting the output:**

- **time**: [lower_bound estimate upper_bound] - The measured execution time with confidence intervals
- **change**: Performance change compared to previous run (if available)
- **p-value**: Statistical significance (p < 0.05 indicates significant change)
- **thrpt**: Throughput measurements (elements processed per second)

### HTML Reports

Detailed reports are generated in `target/criterion/`:

```bash
# Main report index
open target/criterion/report/index.html

# Individual benchmark reports
open target/criterion/identity/report/index.html
open target/criterion/fork_join/report/index.html
```

**Report contents:**

- **Summary**: Quick overview of all measurements
- **Plots**: Visual representation of performance
- **Statistics**: Mean, median, standard deviation, outliers
- **Comparisons**: Performance changes over time
- **Raw Data**: Detailed sample measurements

### Comparison Features

Criterion automatically compares results with previous runs:

- **Improved**: Performance is better (lower time)
- **Regressed**: Performance is worse (higher time)
- **No change**: Performance is within noise threshold

## Benchmark Details

### Identity Benchmark

Tests simple data transformation patterns:

```bash
cargo bench --bench identity
```

**Variants:**
- `identity/pipeline` - Multi-threaded pipeline
- `identity/raw` - Direct vector operations
- `identity/iter` - Iterator-based processing
- `identity/iter-collect` - Iterator with collections
- `identity/timely` - Timely dataflow
- `identity/dfir` - Hydro dataflow

**Use case:** Baseline overhead comparison

### Fork-Join Benchmark

Tests parallel split-merge patterns:

```bash
cargo bench --bench fork_join
```

**What it tests:**
- Data partitioning overhead
- Join/merge performance
- Memory allocation patterns

**Configuration:**
- `NUM_OPS`: Number of fork-join stages (default: 20)
- `NUM_INTS`: Input data size (default: 1,000,000)

### Join Benchmark

Tests relational join operations:

```bash
cargo bench --bench join
```

**Variants:**
- Different join strategies
- Various input sizes
- Memory vs. CPU tradeoffs

### Fan-In/Fan-Out Benchmarks

Tests data distribution patterns:

```bash
cargo bench --bench fan_in
cargo bench --bench fan_out
```

**Fan-in:** Multiple sources → Single sink
**Fan-out:** Single source → Multiple sinks

### Arithmetic Benchmark

Tests computational dataflow patterns:

```bash
cargo bench --bench arithmetic
```

**Operations tested:**
- Addition, subtraction, multiplication
- Pipeline overhead
- Computational intensity

### Upcase Benchmark

Tests string processing:

```bash
cargo bench --bench upcase
```

**What it tests:**
- String transformation overhead
- Memory allocation for strings
- Character-level processing

### Reachability Benchmark

Tests graph algorithms with differential dataflow:

```bash
cargo bench --bench reachability
```

**What it tests:**
- Iterative computation
- Fixed-point algorithms
- Differential dataflow performance

**Note:** This is typically the slowest benchmark due to graph complexity.

## Customizing Benchmarks

### Adjusting Parameters

Edit benchmark files to change parameters:

```rust
// In benches/identity.rs (or other benchmark files)
const NUM_OPS: usize = 20;        // Change to 10 for faster runs
const NUM_INTS: usize = 1_000_000; // Change to 100_000 for quick tests
```

After editing:
```bash
cargo bench --bench identity
```

### Filtering Specific Tests

Run only specific test functions within a benchmark:

```bash
# Run only the "pipeline" variant of identity
cargo bench --bench identity -- pipeline

# Run only "timely" variants across all benchmarks
cargo bench -- timely
```

### Configuring Criterion

Modify criterion settings in benchmark files:

```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn custom_criterion() -> Criterion {
    Criterion::default()
        .sample_size(50)              // Fewer samples for faster runs
        .measurement_time(std::time::Duration::from_secs(5))  // Shorter measurement
        .warm_up_time(std::time::Duration::from_secs(2))      // Less warmup
}

criterion_group! {
    name = benches;
    config = custom_criterion();
    targets = benchmark_function
}
```

## Performance Analysis

### Comparing Implementations

The benchmarks compare different implementation strategies:

1. **Raw/Baseline**: Direct implementation without frameworks
2. **Iterator**: Using Rust's standard library
3. **Timely**: Using timely dataflow
4. **Hydro**: Using Hydro's dfir_rs
5. **Differential**: Using differential-dataflow

**Key metrics to compare:**

- **Absolute performance**: Which is fastest?
- **Overhead**: How much slower than raw implementation?
- **Scalability**: How does it perform with different data sizes?
- **Consistency**: How much variance in measurements?

### Tracking Performance Over Time

To track performance across code changes:

```bash
# Baseline run
cargo bench --bench identity -- --save-baseline before

# Make code changes...

# Compare with baseline
cargo bench --bench identity -- --baseline before
```

Criterion will show detailed comparisons.

### Identifying Bottlenecks

Use these techniques:

1. **Compare variants**: See which implementation pattern is fastest
2. **Profile**: Use profiling tools for detailed analysis
3. **Adjust parameters**: Test different scales to find non-linearities
4. **Isolate components**: Create micro-benchmarks for specific operations

### Statistical Significance

Criterion uses statistical analysis to determine if changes are significant:

- **p < 0.05**: Change is statistically significant
- **p > 0.05**: Change might be noise

Consider:
- Run on dedicated hardware (no background tasks)
- Multiple runs for consistency
- Control for temperature and frequency scaling

## Troubleshooting

### Benchmark Failures

**Compilation errors:**
```bash
# Clean and rebuild
cargo clean
cargo build --benches
```

**Runtime errors:**
- Check data files exist (reachability_*.txt, words_alpha.txt)
- Ensure sufficient memory
- Verify disk space for results

### Inconsistent Results

If results vary significantly:

1. **Close background applications**
2. **Disable CPU frequency scaling:**
   ```bash
   # Linux
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```
3. **Run more iterations:**
   ```bash
   cargo bench -- --sample-size 200
   ```
4. **Use dedicated benchmarking hardware**

### Slow Benchmarks

To speed up benchmarking:

1. **Run specific benchmarks:**
   ```bash
   cargo bench --bench identity
   ```

2. **Reduce parameters:**
   - Edit NUM_OPS and NUM_INTS in benchmark files
   - Use smaller test datasets

3. **Quick mode:**
   ```bash
   cargo bench -- --quick
   ```

4. **Skip slowest benchmarks:**
   ```bash
   cargo bench --bench identity --bench fork_join --bench join
   # (skip reachability)
   ```

### Memory Issues

If benchmarks run out of memory:

1. Reduce NUM_INTS in benchmark files
2. Close other applications
3. Increase swap space
4. Run benchmarks individually

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Benchmarks

on:
  push:
    branches: [main]
  pull_request:

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      - name: Run benchmarks
        run: cargo bench --no-fail-fast
      - name: Archive results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion/
```

### Performance Tracking

For continuous performance monitoring:

1. **Store baseline results** in version control or artifact storage
2. **Compare each run** against the baseline
3. **Alert on regressions** beyond acceptable thresholds
4. **Generate trend reports** over time

## Best Practices

1. **Consistent Environment**: Run on the same hardware for comparisons
2. **Multiple Runs**: Run several times to ensure consistency
3. **Document Changes**: Note code changes when performance shifts
4. **Baseline Management**: Keep baselines for major versions
5. **Realistic Workloads**: Use representative data sizes
6. **Isolate Tests**: Run one benchmark at a time for accuracy
7. **Review Statistics**: Look beyond mean; check variance and outliers

## Advanced Usage

### Custom Benchmarks

Add new benchmarks by:

1. Create `benches/my_benchmark.rs`
2. Add to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Run:
   ```bash
   cargo bench --bench my_benchmark
   ```

### Profiling Integration

Combine with profilers for deeper analysis:

```bash
# With perf on Linux
perf record -g cargo bench --bench identity -- --profile-time=60

# With flamegraph
cargo install flamegraph
cargo flamegraph --bench identity
```

### Exporting Data

Export results for analysis:

```bash
# Criterion saves results in JSON format
ls target/criterion/*/new/

# Process with scripts
python analyze_results.py target/criterion/
```

## Support

For issues or questions:
1. Check the main README.md
2. Review benchmark source code
3. Consult Criterion.rs documentation
4. Refer to the main Hydro repository

## Further Reading

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Benchmarking in Rust](https://doc.rust-lang.org/cargo/commands/cargo-bench.html)
- [Statistical Analysis in Criterion](https://bheisler.github.io/criterion.rs/book/analysis.html)
- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
