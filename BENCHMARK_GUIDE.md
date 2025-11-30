# Benchmark Guide

This guide explains how to run performance comparison benchmarks between Hydro/DFIR and other dataflow systems (Timely Dataflow and Differential Dataflow).

## Overview

The benchmarks in this repository were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid introducing `timely` and `differential-dataflow` as dependencies in the main codebase. This separation allows for performance comparisons while keeping the main repository's dependency tree clean.

## Prerequisites

- Rust toolchain (stable or nightly as required)
- Cargo

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will run all benchmark suites and generate HTML reports in `target/criterion/`.

### Run Specific Benchmark Suite

```bash
cargo bench -p benches --bench fork_join
```

Available benchmark suites:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join parallelism benchmark
- `futures` - Futures-based async operations
- `identity` - Identity/passthrough benchmark
- `join` - Join operations benchmark
- `micro_ops` - Micro-operations benchmark
- `reachability` - Graph reachability benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `upcase` - String transformation benchmark
- `words_diamond` - Diamond-pattern word processing

### Viewing Results

Benchmark results are saved as HTML reports in:
```
target/criterion/<benchmark_name>/report/index.html
```

Open these files in a web browser to view detailed performance comparisons with charts and statistics.

## Benchmark Structure

Each benchmark typically compares multiple implementations:
- **dfir_rs** - The Hydro/DFIR implementation
- **dfir_rs/surface** - Hydro using surface syntax (when applicable)
- **timely** - Timely Dataflow implementation
- **differential** - Differential Dataflow implementation (for certain benchmarks)
- **raw** - Raw Rust implementation for baseline comparison

## Understanding Results

Criterion provides:
- **Throughput measurements** - Operations per second
- **Latency measurements** - Time per operation
- **Statistical analysis** - Mean, median, standard deviation
- **Comparison with previous runs** - Performance regression detection
- **Outlier detection** - Identifies and highlights outliers

## Customizing Benchmarks

To modify benchmark parameters (e.g., data size, number of operations), edit the constants at the top of each benchmark file in `benches/benches/*.rs`.

For example, in `fork_join.rs`:
```rust
const NUM_OPS: usize = 20;
const NUM_INTS: usize = 100_000;
const BRANCH_FACTOR: usize = 2;
```

## Continuous Integration

These benchmarks can be integrated into CI/CD pipelines to track performance over time. Consider:
- Running benchmarks on dedicated hardware for consistency
- Storing historical results for trend analysis
- Setting performance regression thresholds

## Troubleshooting

### Build Errors

If you encounter build errors, ensure:
1. Your Rust toolchain is up to date: `rustup update`
2. All dependencies are available: `cargo fetch`
3. The build script runs successfully: `cargo build --release -p benches`

### Performance Variability

For consistent results:
1. Close unnecessary applications
2. Run on a machine with minimal background activity
3. Consider running multiple iterations: `cargo bench -p benches -- --sample-size 100`
4. Use a dedicated benchmarking machine if possible

## Contributing

When adding new benchmarks:
1. Follow the existing structure in `benches/benches/`
2. Include comparisons with baseline implementations
3. Document any special requirements or data files
4. Update this guide with the new benchmark information
