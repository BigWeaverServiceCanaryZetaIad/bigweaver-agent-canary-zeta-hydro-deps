# Performance Comparison Guide

## Overview

This guide provides comprehensive instructions for running performance benchmarks and comparing Hydro's performance with timely-dataflow and differential-dataflow frameworks.

## Quick Start

### Basic Benchmark Execution

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench identity

# Quick run (fewer samples, faster)
cargo bench -p benches -- --quick
```

### Viewing Results

Results are generated in HTML format at `target/criterion/`. Open `target/criterion/report/index.html` in your browser for an overview of all benchmark results.

## Detailed Usage

### Running Individual Benchmarks

Each benchmark can be run independently:

```bash
# Arithmetic operations
cargo bench -p benches --bench arithmetic

# Fan-in pattern (includes Timely comparison)
cargo bench -p benches --bench fan_in

# Fan-out pattern (includes Timely comparison)
cargo bench -p benches --bench fan_out

# Fork-join pattern
cargo bench -p benches --bench fork_join

# Futures-based operations
cargo bench -p benches --bench futures

# Identity transformation (includes Timely comparison)
cargo bench -p benches --bench identity

# Join operations
cargo bench -p benches --bench join

# Micro operations
cargo bench -p benches --bench micro_ops

# Graph reachability (includes Differential-Dataflow comparison)
cargo bench -p benches --bench reachability

# Symmetric hash join
cargo bench -p benches --bench symmetric_hash_join

# String uppercase transformation
cargo bench -p benches --bench upcase

# Words diamond pattern
cargo bench -p benches --bench words_diamond
```

### Filtering Benchmarks

Run benchmarks matching a specific pattern:

```bash
# Run all benchmarks containing "join"
cargo bench -p benches -- join

# Run all benchmarks containing "fan"
cargo bench -p benches -- fan

# Run specific size variants
cargo bench -p benches -- "1000"
```

### Baseline Comparisons

Compare performance across code changes:

#### Step 1: Establish Baseline

Before making changes, save a baseline:

```bash
cargo bench -p benches -- --save-baseline before
```

#### Step 2: Make Changes

Make your changes to Hydro (if using local path dependencies) or update the git dependency.

#### Step 3: Compare Against Baseline

```bash
cargo bench -p benches -- --baseline before
```

Criterion will display:
- Percentage change in performance
- Statistical significance
- Whether the change is an improvement or regression

#### Multiple Baselines

You can maintain multiple named baselines:

```bash
# Save different baselines
cargo bench -p benches -- --save-baseline feature-a
cargo bench -p benches -- --save-baseline feature-b
cargo bench -p benches -- --save-baseline production

# Compare against specific baseline
cargo bench -p benches -- --baseline feature-a
```

## Comparative Benchmarks

### Hydro vs Timely Dataflow

The following benchmarks compare Hydro with Timely:

- **fan_in**: Tests fan-in dataflow patterns
- **fan_out**: Tests fan-out dataflow patterns  
- **identity**: Tests simple identity transformations

These benchmarks run both implementations and report comparative metrics.

**Example output:**
```
identity/hydro/1000    time: [1.23 ms 1.25 ms 1.27 ms]
identity/timely/1000   time: [1.45 ms 1.47 ms 1.49 ms]
```

### Hydro vs Differential-Dataflow

The **reachability** benchmark compares graph computation:

- Tests incremental graph reachability
- Compares both initial computation and updates
- Measures throughput and latency

**Example output:**
```
reachability/hydro     time: [45.2 ms 45.8 ms 46.4 ms]
reachability/dd        time: [52.1 ms 52.7 ms 53.3 ms]
```

## Advanced Usage

### Configuring Sample Size

Control the number of samples and iterations:

```bash
# Fewer samples (faster, less precise)
cargo bench -p benches -- --sample-size 10

# More samples (slower, more precise)
cargo bench -p benches -- --sample-size 100
```

### Warm-up Configuration

Adjust warm-up time:

```bash
# Shorter warm-up (faster)
cargo bench -p benches -- --warm-up-time 1

# Longer warm-up (more stable)
cargo bench -p benches -- --warm-up-time 10
```

### Measurement Time

Control measurement duration:

```bash
# Shorter measurement (faster)
cargo bench -p benches -- --measurement-time 5

# Longer measurement (more accurate)
cargo bench -p benches -- --measurement-time 15
```

### Profiling Mode

Run benchmarks with profiling enabled:

```bash
# Build with profiling symbols
cargo bench -p benches --profile profile

# Or use flamegraph for visualization
cargo flamegraph --bench identity -p benches
```

## Local Development Workflow

### Setup for Local Hydro Development

1. Clone both repositories:
```bash
cd /path/to/projects
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

2. Update `benches/Cargo.toml` to use local paths:
```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

3. Make changes to Hydro code in the main repository.

4. Run benchmarks to see the impact:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Iterative Development

For rapid iteration during development:

1. Save baseline before changes:
```bash
cargo bench -p benches -- --save-baseline main
```

2. Make incremental changes.

3. Run quick benchmarks:
```bash
cargo bench -p benches -- --quick --baseline main
```

4. When satisfied, run full benchmarks:
```bash
cargo bench -p benches -- --baseline main
```

## Understanding Results

### Criterion Output

Criterion provides several metrics:

```
identity/hydro/1000     time:   [1.2345 ms 1.2456 ms 1.2567 ms]
                        change: [-5.2345% -3.4567% -1.2345%] (p = 0.00 < 0.05)
                        Performance has improved.
```

**Interpretation:**
- **time**: [lower bound, estimate, upper bound] with 95% confidence
- **change**: Performance change vs baseline (if available)
- **p-value**: Statistical significance (< 0.05 is significant)
- **verdict**: Improvement, regression, or no change

### Statistical Significance

- **p < 0.05**: Change is statistically significant
- **p ≥ 0.05**: Change may be due to noise
- Consider both statistical and practical significance

### Performance Plots

HTML reports include:
- **Violin plots**: Distribution of measurements
- **Line plots**: Performance over time
- **Comparison plots**: Before/after comparisons

## Benchmark Configuration

### Input Sizes

Many benchmarks test multiple input sizes:

```rust
// Typical size progression
[10, 100, 1000, 10000]
```

Helps identify:
- Constant overhead
- Scaling characteristics
- Performance crossover points

### Iterations

Benchmarks automatically adjust iterations to reach stable measurements.

### Workload Characteristics

Different benchmarks stress different aspects:

- **Arithmetic**: Computation-heavy
- **Join**: Memory and computation
- **Reachability**: Graph traversal and incremental updates
- **Fan in/out**: Dataflow routing

## Troubleshooting

### Unstable Results

If results are unstable (large confidence intervals):

1. Close background applications
2. Increase sample size: `--sample-size 50`
3. Increase measurement time: `--measurement-time 10`
4. Check system load: `htop` or `top`
5. Disable CPU frequency scaling (Linux):
```bash
sudo cpupower frequency-set --governor performance
```

### Out of Memory

For large benchmarks:

1. Reduce input sizes in benchmark code
2. Run benchmarks individually
3. Increase system swap space

### Compilation Errors

If dependencies fail to compile:

1. Update Rust: `rustup update`
2. Clean build: `cargo clean`
3. Check dependency versions in `Cargo.toml`
4. Ensure git dependencies are accessible

### Slow Benchmark Execution

To speed up benchmarks:

1. Use `--quick` flag for development
2. Run specific benchmarks instead of all
3. Use `--sample-size 10` for quick feedback
4. Build in release mode: `cargo build --release`

## Best Practices

### Before Benchmarking

1. **Clean state**: Close unnecessary applications
2. **Stable system**: Avoid system updates during benchmarking
3. **Consistent environment**: Use same machine for comparisons
4. **Power connected**: Ensure laptop is plugged in

### During Benchmarking

1. **Avoid interference**: Don't use the computer during benchmark runs
2. **Monitor progress**: Watch for anomalies in output
3. **Save baselines**: Always save baselines before major changes

### After Benchmarking

1. **Review results**: Check HTML reports thoroughly
2. **Validate significance**: Ensure changes are statistically significant
3. **Document findings**: Record important observations
4. **Share results**: Commit baseline data if relevant

## Continuous Integration

### Automated Benchmarking

Set up CI to run benchmarks automatically:

```yaml
- name: Run benchmarks
  run: cargo bench -p benches --no-fail-fast
  
- name: Upload results
  uses: actions/upload-artifact@v3
  with:
    name: benchmark-results
    path: target/criterion/
```

### Performance Regression Detection

Compare against baseline in CI:

```yaml
- name: Download baseline
  run: |
    gh release download baseline -p criterion-baseline.tar.gz
    tar xzf criterion-baseline.tar.gz -C target/
    
- name: Run benchmarks with baseline
  run: cargo bench -p benches -- --baseline baseline
```

### Tracking Performance Over Time

Use tools like:
- **Criterion dashboard**: Track metrics across commits
- **GitHub Actions artifacts**: Store historical results
- **Custom dashboards**: Visualize performance trends

## Additional Resources

### Documentation

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/) - Complete Criterion guide
- [Benchmark Design](https://bheisler.github.io/criterion.rs/book/user_guide/benchmarking_with_inputs.html) - Best practices

### Tools

- **cargo-criterion**: Alternative criterion runner
- **flamegraph**: CPU profiling visualization
- **perf**: Linux performance analysis
- **valgrind**: Memory profiling

### Related

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Support

For help with benchmarks:

- Open an issue in this repository
- Check existing issues for similar problems
- Consult Criterion.rs documentation
- Ask in project discussions

## Contributing

When contributing benchmark improvements:

1. Document benchmark methodology
2. Include baseline comparisons
3. Explain what the benchmark measures
4. Add comments for complex setups
5. Update this guide if adding new techniques

## Conclusion

This benchmark suite provides comprehensive tools for:
- Measuring Hydro performance
- Comparing with established frameworks
- Detecting performance regressions
- Guiding optimization efforts

Use these tools to ensure Hydro maintains excellent performance characteristics as it evolves.
