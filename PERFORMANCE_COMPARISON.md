# Performance Comparison Guide

This repository contains benchmarks for comparing Hydro performance with Timely and Differential Dataflow implementations.

## Repository Structure

This repository now contains two separate benchmark suites:

### 1. Comparison Benchmarks (`benches/`)
Complete implementations comparing all three frameworks:
- Hydro (DFIR) implementations
- Timely Dataflow implementations
- Differential Dataflow implementations
- Baseline implementations (raw iterators, pipelines, etc.)

### 2. Pure Timely/Differential Benchmarks (`timely-differential-benches/`)
Isolated implementations using only Timely and Differential Dataflow:
- Serves as baseline performance measurements
- Enables focused testing of timely/differential frameworks
- Reference implementations without Hydro dependencies

## Purpose

These benchmarks were separated from the main Hydro repository to:
1. Remove heavy dependencies (`timely` and `differential-dataflow`) from the core Hydro codebase
2. Enable independent performance testing and comparison
3. Reduce build times and dependency bloat in the main repository
4. Maintain clean separation of concerns
5. Provide baseline measurements through isolated benchmarks

## Running Benchmarks

### Comparison Benchmarks (All Frameworks)

Run benchmarks that compare Hydro with Timely/Differential implementations:

```bash
# All comparison benchmarks
cargo bench -p benches

# Specific comparison benchmark
cargo bench -p benches --bench reachability
```

### Pure Timely/Differential Benchmarks

Run isolated benchmarks with only Timely/Differential implementations:

```bash
# All pure timely/differential benchmarks
cargo bench -p timely-differential-benches

# Specific pure benchmark
cargo bench -p timely-differential-benches --bench join
```

### Using the Helper Script

```bash
# Run comparison benchmarks only (default)
./run_benchmarks.bash

# Run pure timely/differential benchmarks only
./run_benchmarks.bash --timely-only

# Run all benchmarks (comparison + pure)
./run_benchmarks.bash --all

# Run specific benchmark
./run_benchmarks.bash reachability
./run_benchmarks.bash --timely-only arithmetic
```

### Individual Benchmarks
```bash
# Arithmetic operations benchmark
cargo bench -p benches --bench arithmetic

# Graph reachability benchmark
cargo bench -p benches --bench reachability

# Join operations benchmark
cargo bench -p benches --bench join
```

## Benchmark Descriptions

### arithmetic
Compares different implementations of arithmetic pipelines:
- Pipeline (channel-based)
- Raw copy operations
- Iterator-based
- Hydroflow compiled
- Hydroflow surface syntax
- Timely dataflow

### fan_in / fan_out
Tests fan-in and fan-out patterns across different frameworks.

### fork_join
Evaluates fork-join patterns with multiple branches.

### identity
Tests identity dataflow operations (data passthrough with minimal processing).

### join
Compares join operation implementations.

### reachability
Graph reachability computation benchmark using different approaches.

### upcase
String transformation (uppercase) operations benchmark.

## Interpreting Results

Benchmark results are generated using [Criterion.rs](https://github.com/bheisler/criterion.rs) and include:
- Execution time statistics (mean, median, std deviation)
- Performance comparison between implementations
- HTML reports in `target/criterion/`

## Dependencies

The benchmarks depend on:
- **dfir_rs**: The main Hydro DFIR runtime (from main repository) - used in comparison benchmarks
- **sinktools**: Sink utilities (from main repository) - used in comparison benchmarks
- **timely**: Timely dataflow framework - used in both benchmark suites
- **differential-dataflow**: Differential dataflow framework - used in both benchmark suites
- **criterion**: Benchmarking framework

The `timely-differential-benches` package only depends on timely, differential-dataflow, and criterion, making it lightweight and fast to build.

## Contributing

When adding new benchmarks:
1. Add the benchmark source file to `benches/benches/`
2. Register it in `benches/Cargo.toml` with `[[bench]]` section
3. Update this documentation with benchmark description
4. Ensure comparison implementations are fair and equivalent

## Related Documentation

- Main Hydro repository: [hydro-project/hydro](https://github.com/hydro-project/hydro)
- Timely Dataflow: [TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- Differential Dataflow: [TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)
