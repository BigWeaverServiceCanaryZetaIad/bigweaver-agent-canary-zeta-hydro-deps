# Benchmarking Guide

This document explains how to run performance benchmarks and compare Hydro with other dataflow frameworks.

## Overview

The benchmarks in this repository compare Hydro's performance with implementations using `timely` and `differential-dataflow`. Each benchmark typically includes multiple implementations to facilitate direct performance comparisons.

## Prerequisites

1. Rust toolchain (see `rust-toolchain.toml` for the required version)
2. Sufficient disk space for criterion output (~100MB for full benchmark suite)
3. A quiet system environment for accurate benchmarking (minimal background processes)

## Running Benchmarks

### Run All Benchmarks

To run the complete benchmark suite:

```bash
cargo bench -p benches
```

This will execute all benchmarks and generate detailed reports in `target/criterion/`.

### Run Specific Benchmarks

To run individual benchmarks:

```bash
# Run the reachability benchmark
cargo bench -p benches --bench reachability

# Run the identity benchmark
cargo bench -p benches --bench identity

# Run the join benchmark
cargo bench -p benches --bench join
```

### Run a Specific Test Within a Benchmark

```bash
# Run only dfir_rs tests in the identity benchmark
cargo bench -p benches --bench identity dfir_rs
```

## Understanding Benchmark Results

Criterion generates comprehensive reports including:

- **Statistical Analysis**: Mean, standard deviation, and confidence intervals
- **Comparison Data**: Performance differences between runs (if previous data exists)
- **HTML Reports**: Located in `target/criterion/<benchmark_name>/report/index.html`
- **Plots**: Visualization of performance distributions

### Viewing Results

After running benchmarks, open the HTML reports in your browser:

```bash
# Example for the identity benchmark
open target/criterion/identity/report/index.html
```

## Available Benchmarks

| Benchmark | Description | Frameworks Compared |
|-----------|-------------|-------------------|
| `arithmetic` | Basic arithmetic operations over streams | dfir_rs, timely |
| `fan_in` | Multiple input streams merging into one | dfir_rs, timely |
| `fan_out` | Single stream splitting to multiple outputs | dfir_rs, timely |
| `fork_join` | Parallel processing with fork-join pattern | dfir_rs, timely |
| `futures` | Async futures and stream processing | dfir_rs, tokio |
| `identity` | Passthrough/identity operation overhead | dfir_rs, timely, differential |
| `join` | Stream join operations | dfir_rs, timely |
| `micro_ops` | Microbenchmarks of individual operations | dfir_rs |
| `reachability` | Graph reachability computation | dfir_rs, timely, differential |
| `symmetric_hash_join` | Symmetric hash join implementation | dfir_rs, timely |
| `upcase` | String uppercase transformation | dfir_rs, timely |
| `words_diamond` | Diamond-pattern word processing | dfir_rs, timely, differential |

## Performance Comparison Workflow

To compare Hydro performance across different versions or configurations:

1. **Baseline Run**: Run benchmarks on the baseline version
   ```bash
   cargo bench -p benches
   ```

2. **Save Baseline**: Criterion automatically saves results. You can manually save with:
   ```bash
   cargo bench -p benches -- --save-baseline <name>
   ```

3. **Make Changes**: Apply your changes to Hydro or update dependencies

4. **Comparison Run**: Run benchmarks again
   ```bash
   cargo bench -p benches
   ```

5. **View Comparisons**: Criterion will automatically compare with previous runs

### Comparing with Specific Baseline

```bash
# Run and compare with a named baseline
cargo bench -p benches -- --baseline <name>
```

## Best Practices

1. **System Preparation**:
   - Close unnecessary applications
   - Disable CPU frequency scaling if possible
   - Use a power source (not battery) for laptops
   - Allow the system to warm up

2. **Multiple Runs**:
   - Run benchmarks multiple times to ensure consistency
   - Look for performance regressions across multiple runs

3. **Interpreting Results**:
   - Focus on statistical significance, not just raw numbers
   - Look for consistent patterns across multiple benchmarks
   - Consider both absolute performance and scaling characteristics

4. **Reporting**:
   - Include system specifications in performance reports
   - Note any configuration changes or optimizations
   - Document the Rust version and dependency versions used

## Troubleshooting

### Benchmark Takes Too Long

Some benchmarks (especially `reachability` and `words_diamond`) can take several minutes. You can:

- Run specific benchmarks instead of the full suite
- Adjust the sample size (see Criterion documentation)
- Use `--profile-time` to see time spent in each benchmark

### Out of Memory

The `reachability` benchmark uses large datasets. If you encounter OOM errors:

- Close other applications
- Increase system swap space
- Run benchmarks individually rather than all at once

### Inconsistent Results

If results vary significantly between runs:

- Check for background processes consuming CPU
- Verify CPU thermal throttling isn't occurring
- Ensure power management isn't affecting performance
- Run more samples per benchmark

## Adding New Benchmarks

To add a new benchmark:

1. Create a new file in `benches/benches/<name>.rs`
2. Implement benchmark using Criterion
3. Add benchmark declaration in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
4. Include implementations for dfir_rs and comparison frameworks
5. Document the benchmark in this guide

## Dependencies and Updates

The benchmarks depend on:
- `dfir_rs` and `sinktools` from the main Hydro repository (git dependencies)
- `timely` and `differential-dataflow` from crates.io
- `criterion` for the benchmarking framework

To update dependencies:
```bash
cargo update
```

Note: Updates to the Hydro dependencies will automatically pull the latest from the main repository.

## CI/CD Integration

While this repository is separate from the main Hydro repository, you can integrate benchmark runs into CI/CD pipelines. Consider:

- Running benchmarks on release branches
- Comparing performance against stable baselines
- Alerting on significant performance regressions
- Archiving benchmark results for trend analysis

## Further Reading

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Documentation](https://hydro.run/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
