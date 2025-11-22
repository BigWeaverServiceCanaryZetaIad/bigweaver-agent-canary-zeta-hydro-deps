# Getting Started with Timely and Differential-Dataflow Benchmarks

This guide will help you set up and run the Timely and Differential-Dataflow benchmarks.

## Prerequisites

### Required Software

- **Rust**: Version supporting edition 2024 (1.82.0 or later recommended)
- **Cargo**: Latest version
- **Git**: For cloning the repository

### Installation

If you don't have Rust installed:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
```

Update to the latest Rust version:

```bash
rustup update
```

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Build Dependencies

First, ensure all dependencies are downloaded and built:

```bash
cargo check
```

This will:
- Download timely and differential-dataflow packages
- Build all dependencies
- Verify your setup is correct

### 3. Verify Installation

Run a quick benchmark to verify everything works:

```bash
cargo bench --bench identity -- --test
```

This runs the identity benchmark in test mode (faster, less accurate).

## Running Benchmarks

### Basic Usage

#### Run All Benchmarks

```bash
cargo bench
```

This will run all available benchmarks and generate detailed reports.

**Expected time**: 10-30 minutes depending on your hardware.

#### Run Specific Benchmark

```bash
# Run identity benchmark
cargo bench --bench identity

# Run reachability benchmark (includes timely and differential)
cargo bench --bench reachability

# Run arithmetic benchmark
cargo bench --bench arithmetic
```

### Understanding Output

Criterion provides rich output during benchmark execution:

```
identity/timely         time:   [45.234 ms 45.987 ms 46.821 ms]
                        change: [-2.1234% -0.8765% +0.4321%] (p = 0.32 > 0.05)
                        No change in performance detected.
```

Breaking this down:
- **time**: [lower bound, estimate, upper bound] at 95% confidence
- **change**: Performance change from previous run
- **p-value**: Statistical significance (< 0.05 indicates significant change)

### Viewing Results

Criterion generates HTML reports with graphs and detailed statistics:

```bash
# View in default browser (Linux)
xdg-open target/criterion/report/index.html

# View in default browser (macOS)
open target/criterion/report/index.html

# Or manually navigate to:
# target/criterion/report/index.html
```

### Advanced Options

#### Quick Test Run

For faster iteration during development:

```bash
cargo bench --bench identity -- --quick
```

#### Verbose Output

To see more detailed information:

```bash
cargo bench --bench identity -- --verbose
```

#### Sample Size Control

Adjust the number of iterations:

```bash
cargo bench --bench identity -- --sample-size 20
```

#### Specific Test Within Benchmark

```bash
# Run only the timely variant
cargo bench --bench reachability -- timely

# Run only the differential variant
cargo bench --bench reachability -- differential
```

## Benchmark Details

### Identity Benchmark

**What it tests**: Data transformation through a chain of map operations.

```bash
cargo bench --bench identity
```

**Configuration**:
- Items: 1,000,000
- Operations: 20 map operations
- Framework: Timely Dataflow

### Arithmetic Benchmark

**What it tests**: Numerical computation performance.

```bash
cargo bench --bench arithmetic
```

**Configuration**:
- Items: 1,000,000 random integers
- Operations: Arithmetic transformations
- Framework: Timely Dataflow

### Fan-In Benchmark

**What it tests**: Merging multiple streams into one.

```bash
cargo bench --bench fan_in
```

**Configuration**:
- Streams: 20 input streams
- Items per stream: 1,000,000
- Framework: Timely Dataflow

### Fan-Out Benchmark

**What it tests**: Broadcasting one stream to multiple consumers.

```bash
cargo bench --bench fan_out
```

**Configuration**:
- Consumers: 20
- Items: 1,000,000
- Framework: Timely Dataflow

### Fork-Join Benchmark

**What it tests**: Parallel branch and merge pattern.

```bash
cargo bench --bench fork_join
```

**Configuration**:
- Items: 1,000,000
- Branches: 2
- Framework: Timely Dataflow

### Join Benchmark

**What it tests**: Relational join operations.

```bash
cargo bench --bench join
```

**Configuration**:
- Left side: 100,000 items
- Right side: 100,000 items
- Framework: Timely Dataflow

### Upcase Benchmark

**What it tests**: String manipulation performance.

```bash
cargo bench --bench upcase
```

**Configuration**:
- Words: 100,000
- Operation: String uppercasing
- Framework: Timely Dataflow

### Reachability Benchmark

**What it tests**: Graph reachability computation.

```bash
cargo bench --bench reachability
```

**Configuration**:
- Framework: **Both** Timely Dataflow and Differential-Dataflow
- Graph size: ~500KB of edges
- Algorithm: Iterative reachability from source node

**Special note**: This benchmark includes TWO implementations:
1. `reachability/timely` - Using Timely's dataflow operators
2. `reachability/differential` - Using Differential-Dataflow's incremental computation

## Troubleshooting

### Build Errors

**Problem**: Compilation fails with dependency errors

**Solution**: Update and rebuild:
```bash
cargo clean
cargo update
cargo check
```

### Slow Compilation

**Problem**: Initial build takes a long time

**Explanation**: This is normal. Timely and Differential-Dataflow are large frameworks with significant compile times.

**Tip**: Subsequent builds will be much faster due to caching.

### Memory Issues

**Problem**: Benchmarks cause out-of-memory errors

**Solution**: 
- Reduce dataset sizes in benchmark files
- Close other applications
- Run benchmarks individually instead of all at once

### Benchmark Hangs

**Problem**: A benchmark appears to hang or take extremely long

**Solution**:
- Check if it's still running (CPU usage should be high)
- Some benchmarks (especially reachability) can take several minutes
- Try running with `--sample-size 10` for faster completion

## Next Steps

Once you have benchmarks running successfully:

1. **Compare with Hydroflow/DFIR**: See [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md)
2. **Understand repository relationship**: See [RELATIONSHIP_TO_MAIN_REPO.md](RELATIONSHIP_TO_MAIN_REPO.md)
3. **Modify benchmarks**: Edit files in `benches/benches/` and re-run
4. **Add custom benchmarks**: Create new benchmark files following existing patterns

## Tips for Effective Benchmarking

### 1. Consistent Environment

- Close unnecessary applications
- Run on consistent hardware
- Avoid running during system updates or backups

### 2. Baseline Establishment

- Run benchmarks multiple times to establish a baseline
- Save results for comparison: `cargo bench --save-baseline my-baseline`
- Compare against baseline: `cargo bench --baseline my-baseline`

### 3. Statistical Significance

- Don't trust single runs for performance conclusions
- Look for p-values < 0.05 for significant changes
- Consider running with higher sample sizes for critical measurements

### 4. Iteration During Development

Use `--quick` mode for fast feedback:
```bash
cargo bench --bench identity -- --quick
```

Then run full benchmarks before committing changes.

## Getting Help

If you encounter issues:

1. Check this documentation thoroughly
2. Review the [README.md](README.md) for overview information
3. Check Cargo output for specific error messages
4. Consult [Criterion.rs documentation](https://bheisler.github.io/criterion.rs/)
5. Review [Timely Dataflow documentation](https://github.com/TimelyDataflow/timely-dataflow)

## Summary

You should now be able to:
- ✅ Set up the benchmark repository
- ✅ Run individual and all benchmarks
- ✅ View and interpret results
- ✅ Use advanced benchmarking options
- ✅ Troubleshoot common issues

Continue to [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md) to learn how to compare these benchmarks with the main Hydroflow/DFIR implementation.
