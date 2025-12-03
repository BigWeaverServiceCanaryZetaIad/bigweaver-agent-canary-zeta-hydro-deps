# Performance Comparison Guide

This document explains how to use the benchmarks in this repository to compare the performance of Hydro (DFIR) with timely and differential-dataflow.

## 📋 Overview

These benchmarks were designed to provide a fair comparison between different dataflow frameworks:
- **Hydro/DFIR**: The main Hydro dataflow system
- **Timely Dataflow**: A low-latency data-parallel dataflow system
- **Differential Dataflow**: An incremental computation framework built on Timely

## 🚀 Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Multiple inputs merging into one output
- `fan_out` - One input splitting to multiple outputs
- `fork_join` - Fork and join operations
- `futures` - Async futures benchmarks
- `identity` - Pass-through operations (no-op)
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability computation
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String transformation operations
- `words_diamond` - Diamond-shaped dataflow pattern

### Benchmark Options

To save results for comparison:
```bash
cargo bench -p benches -- --save-baseline <name>
```

To compare with a baseline:
```bash
cargo bench -p benches -- --baseline <name>
```

## 📊 Understanding Results

Criterion (the benchmarking framework) will generate:
- Console output with timing statistics
- HTML reports in `target/criterion/`
- Charts showing performance trends

### Key Metrics
- **Time**: Wall-clock time for the benchmark
- **Throughput**: Items processed per second
- **Comparison**: Performance relative to baseline (if provided)

## 🔧 Configuration

### Benchmark Parameters

Many benchmarks have configurable parameters at the top of their source files:
- `NUM_INTS`: Number of integers to process
- `NUM_OPS`: Number of operations to chain

You can modify these to test different scenarios.

### System Requirements

For accurate benchmarking:
- Run on a quiet system (minimal background processes)
- Consider disabling CPU frequency scaling
- Run multiple iterations to account for variance

## 📝 Benchmark Descriptions

### Identity Benchmark
Tests the overhead of passing data through a pipeline without transformation. Compares raw data copying, channel-based pipelines, DFIR, and Timely implementations.

### Reachability Benchmark
Implements graph reachability computation, a classic dataflow problem. Tests both incremental and batch processing modes.

### Join Benchmark
Tests the performance of join operations, a fundamental operation in dataflow systems.

### Arithmetic Benchmark
Measures the overhead of performing simple arithmetic operations in different frameworks.

### Fan In/Out Benchmarks
Test the performance of data distribution patterns:
- **Fan Out**: One source, multiple destinations
- **Fan In**: Multiple sources, one destination

## 🎯 Performance Comparison Tips

1. **Establish Baseline**: Run benchmarks on the main Hydro repository first
2. **Fair Comparison**: Ensure similar workloads across frameworks
3. **Multiple Runs**: Statistical significance requires multiple measurements
4. **Document Changes**: Note any code changes that affect performance
5. **Hardware Specs**: Document CPU, RAM, and other relevant specs

## 🔗 Integration with CI/CD

While these benchmarks are in a separate repository, they can still be integrated into CI/CD pipelines:

1. Clone both repositories
2. Run benchmarks as part of performance testing
3. Track performance trends over time
4. Alert on performance regressions

## 📖 Further Reading

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Documentation](https://hydro.run/)

## 🐛 Troubleshooting

### Build Errors
If you encounter build errors:
1. Ensure you have the latest Rust toolchain
2. Check that git dependencies are accessible
3. Verify network connectivity for crate downloads

### Performance Issues
If benchmarks run slowly:
1. Check system load (`top` or `htop`)
2. Ensure adequate memory
3. Consider reducing `NUM_INTS` or `NUM_OPS` parameters

### Inconsistent Results
If results vary significantly:
1. Run benchmarks multiple times
2. Check for background processes
3. Consider CPU thermal throttling
4. Use Criterion's baseline comparison feature

## 🤝 Contributing

When adding new benchmarks:
1. Add the benchmark to `benches/benches/`
2. Update `Cargo.toml` with a `[[bench]]` entry
3. Follow existing benchmark patterns
4. Document the benchmark purpose
5. Include both DFIR and comparison implementations

## 📊 Example: Comparing Versions

To compare performance between two versions of Hydro:

```bash
# Baseline (older version)
git checkout v0.13.0
cargo bench -p benches -- --save-baseline v0.13.0

# New version
git checkout main
cargo bench -p benches -- --baseline v0.13.0
```

This will show performance improvements or regressions between versions.
