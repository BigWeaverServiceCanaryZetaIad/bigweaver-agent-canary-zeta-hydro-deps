# Hydro Benchmarks Guide

This guide explains how to use the benchmarks in this repository and what each benchmark measures.

## Overview

This repository contains 12 benchmarks that compare different dataflow processing implementations:
- **dfir_rs** (Hydro's dataflow implementation)
- **timely-dataflow** (established streaming dataflow framework)
- **differential-dataflow** (incremental computation framework)

The benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:
- Reduce build times by 40-60%
- Isolate heavy dependencies (timely and differential-dataflow)
- Enable independent performance testing workflow

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmark

```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

### Run Specific Test Within a Benchmark

```bash
cargo bench --bench arithmetic -- arithmetic/dfir_rs
```

## Benchmark Descriptions

### 1. arithmetic.rs
Tests basic arithmetic operations through a pipeline of operations.
- **Pattern**: Linear pipeline
- **Operations**: Addition operations
- **Purpose**: Baseline performance for simple operations

### 2. fan_in.rs
Tests merging multiple input streams into a single output stream.
- **Pattern**: Multiple sources → single sink
- **Operations**: Stream merging
- **Purpose**: Measures overhead of combining streams

### 3. fan_out.rs
Tests splitting a single input stream to multiple output streams.
- **Pattern**: Single source → multiple sinks
- **Operations**: Stream splitting (broadcast)
- **Purpose**: Measures overhead of stream distribution

### 4. fork_join.rs
Tests fork-join pattern with filtering and merging.
- **Pattern**: Repeated fork and join operations
- **Operations**: Filter, union
- **Purpose**: Complex dataflow graph with branching and merging

### 5. futures.rs
Tests async futures-based processing.
- **Pattern**: Async stream processing
- **Operations**: Async operations
- **Purpose**: Measures async overhead and scheduling

### 6. identity.rs
Tests identity function (no-op) for baseline measurement.
- **Pattern**: Simple passthrough
- **Operations**: Identity transformation
- **Purpose**: Establishes baseline overhead

### 7. join.rs
Tests stream join operations.
- **Pattern**: Two-stream join
- **Operations**: Hash join
- **Purpose**: Measures join operation performance

### 8. micro_ops.rs
Tests various micro-operations in isolation.
- **Pattern**: Individual operator testing
- **Operations**: Map, filter, fold, etc.
- **Purpose**: Isolates performance of specific operators

### 9. reachability.rs
Tests graph reachability algorithm.
- **Pattern**: Iterative graph algorithm
- **Operations**: Graph traversal, iteration
- **Purpose**: Complex algorithm with state and iteration
- **Data**: Uses `reachability_edges.txt` and `reachability_reachable.txt`

### 10. symmetric_hash_join.rs
Tests symmetric hash join implementation.
- **Pattern**: Two-way hash join
- **Operations**: Hash join with symmetry
- **Purpose**: Bidirectional join performance

### 11. upcase.rs
Tests string transformation operations.
- **Pattern**: Map operation on strings
- **Operations**: String uppercase conversion
- **Purpose**: String processing overhead
- **Data**: Uses `words_alpha.txt`

### 12. words_diamond.rs
Tests diamond-shaped dataflow pattern with word processing.
- **Pattern**: Fork and rejoin (diamond)
- **Operations**: String operations, merge
- **Purpose**: Complex dataflow with data-dependent branching
- **Data**: Uses `words_alpha.txt`

## Interpreting Results

Benchmark results show:
- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Comparison**: Relative performance between implementations

Look for:
- Consistent performance across implementations
- Bottlenecks in specific patterns
- Scaling characteristics

## Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/`
2. Use the criterion framework:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_test", |b| {
           b.iter(|| {
               // benchmark code
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```
3. Add the benchmark to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

## Performance Comparison

The benchmarks enable comparing:
- **dfir_rs**: Hydro's implementation optimized for compile-time optimization
- **timely**: Mature runtime with dynamic dataflow
- **differential**: Incremental computation with automatic updates

Each has different strengths:
- dfir_rs: Compile-time optimization, type safety
- timely: Runtime flexibility, mature ecosystem
- differential: Incremental updates, efficient change propagation

## CI/CD Integration

These benchmarks can be integrated into CI/CD pipelines to:
- Track performance regressions
- Compare implementation changes
- Generate performance reports

## Troubleshooting

### Build Failures
- Ensure Rust 1.91.1 or later is installed
- Check that git dependencies are accessible
- Run `cargo clean` and rebuild

### Slow Benchmarks
- Reduce iteration counts in benchmark code
- Use `cargo bench -- --quick` for faster runs
- Focus on specific benchmarks with `cargo bench --bench <name>`

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Main Hydro Repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
