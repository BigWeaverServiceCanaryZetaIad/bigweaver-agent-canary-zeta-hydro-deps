# Usage Guide

This document provides quick reference for common tasks with the benchmark suite.

## Quick Start

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
# Run a single benchmark
cargo bench -p benches --bench arithmetic

# Run multiple benchmarks
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench identity
```

### Running Benchmarks with Filters

```bash
# Run all tests in the arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run specific test within a benchmark
cargo bench -p benches --bench micro_ops -- filter_name
```

## Performance Comparison Workflow

### 1. Create a Baseline

Before making changes to the Hydro framework:

```bash
# Run benchmarks and save results as baseline
cargo bench -p benches -- --save-baseline before-changes
```

### 2. Make Your Changes

Edit code in the main Hydro repository (bigweaver-agent-canary-hydro-zeta).

### 3. Compare Performance

```bash
# Update dependencies to get latest changes
cargo update -p dfir_rs -p sinktools

# Run benchmarks and compare against baseline
cargo bench -p benches -- --baseline before-changes
```

### 4. Review Results

Check the console output for performance differences:
- Green text indicates improvements
- Red text indicates regressions
- White text indicates no significant change

View detailed HTML reports:
```bash
# Open benchmark report in browser
open target/criterion/arithmetic/report/index.html
```

## Common Tasks

### Update Dependencies

```bash
# Update all dependencies
cargo update

# Update specific dependencies from main repo
cargo update -p dfir_rs
cargo update -p sinktools
```

### Test Against Local Changes

To test against uncommitted changes in the main repository:

1. Edit `benches/Cargo.toml`:
```toml
[dev-dependencies]
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

2. Run benchmarks:
```bash
cargo bench -p benches
```

3. **Remember to revert the Cargo.toml changes before committing!**

### Clean Build

If you encounter issues:

```bash
# Clean all build artifacts
cargo clean

# Rebuild everything
cargo build -p benches --release
```

## Understanding Benchmark Output

### Console Output

```
arithmetic/pipeline     time:   [123.45 ms 125.67 ms 128.90 ms]
                        change: [-5.2341% -3.1234% -1.0123%] (p = 0.01 < 0.05)
                        Performance has improved.
```

- **time**: Current benchmark timing (lower, estimate, upper bounds)
- **change**: Percentage change compared to baseline
- **p-value**: Statistical significance (< 0.05 means significant)
- **Performance**: Interpretation (improved/regressed/no change)

### HTML Reports

Located in `target/criterion/<benchmark-name>/report/index.html`:

- **Violin plots**: Distribution of measurement samples
- **Line charts**: Performance over time (if multiple runs)
- **Statistical analysis**: Detailed statistical metrics
- **Regression analysis**: Trend analysis

## Benchmark-Specific Notes

### Reachability Benchmark

Uses large graph data from `reachability_edges.txt`. May take longer to run:

```bash
# Increase measurement time for more stable results
cargo bench -p benches --bench reachability -- --measurement-time 20
```

### Words Diamond Benchmark

Uses large word list from `words_alpha.txt` (3.7MB):

```bash
# Run with verbose output
cargo bench -p benches --bench words_diamond -- --verbose
```

### Micro Operations Benchmark

Tests many small operations. Quick to run:

```bash
cargo bench -p benches --bench micro_ops
```

## Advanced Usage

### Saving Multiple Baselines

```bash
# Create dated baselines
cargo bench -p benches -- --save-baseline 2025-12-01
cargo bench -p benches -- --save-baseline 2025-12-15

# Compare against specific baseline
cargo bench -p benches -- --baseline 2025-12-01
```

### Exporting Results

```bash
# Results are stored in target/criterion/
# Copy for archival or sharing
cp -r target/criterion/ benchmark-results-2025-12-04/
```

### Custom Measurement Time

For more accurate results (longer runtime):

```bash
# Run for 30 seconds instead of default 5
cargo bench -p benches -- --measurement-time 30
```

### Plotting Results

Criterion generates plots automatically in HTML reports. For custom analysis:

```bash
# Raw data is in target/criterion/<benchmark>/base/estimates.json
# Parse and visualize using your preferred tools
```

## Troubleshooting

### "error: could not find `Cargo.toml`"

Make sure you're in the repository root:
```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
```

### "package `dfir_rs` not found"

Update dependencies:
```bash
cargo update
```

### Benchmarks Take Too Long

Run a subset:
```bash
# Run only fast benchmarks
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
cargo bench -p benches --bench fan_in
```

### High Performance Variance

1. Close other applications
2. Disable CPU frequency scaling (if possible)
3. Run multiple times to establish trend
4. Use longer measurement time:
   ```bash
   cargo bench -p benches -- --measurement-time 20
   ```

## Next Steps

- Read [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) for background and rationale
- Read [benches/README.md](benches/README.md) for benchmark descriptions
- Check [Criterion documentation](https://bheisler.github.io/criterion.rs/book/) for advanced features

## Getting Help

- **Issues with benchmarks**: Open an issue in this repository
- **Issues with Hydro**: Open an issue in the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Questions**: Check existing issues or create a new one
