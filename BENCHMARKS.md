# Benchmark Documentation

This document provides detailed information about each benchmark in this repository and how to interpret the results.

## Overview

These benchmarks compare three different implementations for each workload:
1. **DFIR (Dataflow Intermediate Representation)**: The Hydro framework's implementation
2. **Timely Dataflow**: Reference implementation using timely-dataflow
3. **Differential Dataflow**: Reference implementation using differential-dataflow (where applicable)

## Benchmark Descriptions

### arithmetic.rs

**Purpose**: Measures the performance of simple arithmetic operations (map operations) in a pipeline.

**Workload**: Applies 20 consecutive `map(|x| x + 1)` operations to 1,000,000 integers.

**Implementations**:
- Raw Rust (baseline)
- Iterator chains
- Pipeline with channels
- DFIR compiled layer
- DFIR surface syntax
- Timely dataflow

**Key Metrics**: Throughput and latency for chained map operations.

### fan_in.rs

**Purpose**: Tests stream merging/concatenation performance.

**Workload**: Merges multiple input streams into a single output stream.

**Implementations**:
- DFIR scheduled layer
- DFIR surface syntax
- Timely dataflow

**Key Metrics**: Overhead of stream merging operations.

### fan_out.rs

**Purpose**: Tests stream splitting/distribution performance.

**Workload**: Splits a single input stream into multiple output streams.

**Implementations**:
- DFIR scheduled layer
- DFIR surface syntax
- Timely dataflow

**Key Metrics**: Overhead of stream splitting operations.

### fork_join.rs

**Purpose**: Measures fork-join pattern performance.

**Workload**: Forks computation paths and joins them back together.

**Implementations**:
- Raw Rust
- DFIR compiled layer
- DFIR surface syntax
- Timely dataflow

**Key Metrics**: Latency and throughput for fork-join patterns.

### identity.rs

**Purpose**: Baseline benchmark for data passthrough (no operations).

**Workload**: Passes data through the system with minimal transformation.

**Implementations**:
- Raw Rust
- Iterator chains
- DFIR compiled layer
- DFIR surface syntax
- Timely dataflow

**Key Metrics**: System overhead with minimal computation.

### join.rs

**Purpose**: Tests stream join performance.

**Workload**: Joins two streams on a key.

**Implementations**:
- DFIR surface syntax
- Timely dataflow

**Key Metrics**: Join operation throughput and latency.

### micro_ops.rs

**Purpose**: Microbenchmarks for individual operators.

**Workload**: Tests individual operations like filter, map, fold, etc.

**Implementations**:
- DFIR surface syntax
- Timely dataflow

**Key Metrics**: Per-operator overhead.

### reachability.rs

**Purpose**: Graph reachability computation (transitive closure).

**Workload**: Computes all nodes reachable from a starting node in a graph.

**Implementations**:
- DFIR scheduled layer
- DFIR surface syntax
- Timely dataflow
- Differential dataflow

**Key Metrics**: Iterative computation performance and convergence time.

**Note**: This benchmark uses differential-dataflow's incremental computation capabilities.

### symmetric_hash_join.rs

**Purpose**: Tests symmetric hash join implementation.

**Workload**: Performs symmetric hash joins on streams.

**Implementations**:
- DFIR compiled layer
- Timely dataflow

**Key Metrics**: Join throughput for symmetric hash join algorithm.

### upcase.rs

**Purpose**: String transformation benchmark.

**Workload**: Converts strings to uppercase.

**Implementations**:
- Raw Rust
- Iterator chains
- DFIR compiled layer
- DFIR surface syntax
- Timely dataflow

**Key Metrics**: String operation throughput.

## Interpreting Results

### Understanding Criterion Output

Benchmarks use the Criterion framework, which provides:
- **Time**: Mean execution time with confidence intervals
- **Throughput**: Operations per second
- **Comparison**: Performance relative to previous runs

### Expected Performance Characteristics

1. **Raw Rust** implementations typically set the theoretical performance ceiling
2. **DFIR compiled layer** should approach raw Rust performance
3. **DFIR surface syntax** may have additional overhead from the macro layer
4. **Timely/Differential** provide comparison points for mature frameworks

### Performance Factors

Benchmark results are affected by:
- CPU architecture and clock speed
- Memory bandwidth and cache sizes
- System load and background processes
- Compiler optimizations
- Data sizes and operation characteristics

## Running Performance Comparisons

### Compare Specific Implementations

To compare DFIR vs Timely for a specific benchmark:

```bash
cargo bench --bench arithmetic -- "timely|hydroflow"
```

### Save Baseline for Comparison

```bash
cargo bench --save-baseline main-branch
```

Then after making changes:

```bash
cargo bench --baseline main-branch
```

### Generate Detailed Reports

```bash
cargo bench
open target/criterion/report/index.html
```

## Maintenance Notes

### When to Update Benchmarks

Update benchmarks when:
1. DFIR API changes affect benchmark code
2. New operators or patterns are added to DFIR
3. Timely/differential-dataflow dependencies need version updates
4. Performance regressions are detected

### Benchmark Hygiene

- Keep benchmarks focused on specific operations
- Avoid I/O or external dependencies in benchmark loops
- Use consistent data sizes for comparison
- Document any assumptions or limitations

## Troubleshooting

### Compilation Errors

If benchmarks fail to compile:
1. Ensure the main repository is checked out alongside this one
2. Check that `dfir_rs` path in `Cargo.toml` is correct
3. Verify Rust toolchain version matches main repository

### Performance Anomalies

If results seem inconsistent:
1. Close other applications to reduce system noise
2. Run benchmarks multiple times to establish confidence intervals
3. Check CPU governor settings (performance vs powersave)
4. Verify no thermal throttling is occurring

## Additional Resources

- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Documentation](https://hydro.run/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
