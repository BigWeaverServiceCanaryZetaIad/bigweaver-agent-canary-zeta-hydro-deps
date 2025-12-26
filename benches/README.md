# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that compare the performance of Hydro/DFIR against Timely Dataflow and Differential Dataflow. These benchmarks are essential for retaining the ability to run performance comparisons between different dataflow frameworks.

## Purpose

These benchmarks serve several important purposes:

1. **Performance Comparison**: Compare Hydro/DFIR performance against established dataflow frameworks (Timely and Differential Dataflow)
2. **Regression Detection**: Identify performance regressions in Hydro/DFIR
3. **Optimization Validation**: Verify that optimizations actually improve performance
4. **Framework Selection**: Help users understand the performance characteristics of each framework

## Benchmarks

### fan_in.rs
Tests the performance of fan-in operations (many sources converging to one sink) using:
- **Hydro/DFIR**: Using the surface syntax with union operators
- **Timely Dataflow**: Using Concatenate operators
- **Raw Iterators**: Baseline comparison using Rust iterators
- **Raw Loops**: Baseline comparison using for loops

This benchmark helps understand the overhead of dataflow abstractions for simple union/concatenation operations.

### fork_join.rs
Tests the performance of alternating fork and join operations using:
- **Hydro/DFIR**: Using both the scheduled API and surface syntax
- **Timely Dataflow**: Using Filter and Concatenate operators
- **Raw Implementation**: Using vectors and modulo operations

This benchmark tests the performance of complex dataflow patterns that repeatedly split and merge data streams, which is common in many data processing pipelines.

### reachability.rs
Tests graph reachability algorithms using:
- **Hydro/DFIR**: Multiple implementations (scheduled, surface syntax, and optimized versions)
- **Timely Dataflow**: Using feedback loops and filter operations
- **Differential Dataflow**: Using iterate, semijoin, and distinct operators

This benchmark is particularly important as it tests:
- Iterative/recursive dataflow patterns
- State management (tracking visited nodes)
- Join operations
- The performance characteristics of incremental computation (in Differential Dataflow)

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run a Specific Benchmark

```bash
# Run only the fan_in benchmark
cargo bench -p benches --bench fan_in

# Run only the fork_join benchmark
cargo bench -p benches --bench fork_join

# Run only the reachability benchmark
cargo bench -p benches --bench reachability
```

### Run Specific Test Within a Benchmark

```bash
# Run only Timely Dataflow tests in the reachability benchmark
cargo bench -p benches --bench reachability -- timely

# Run only Differential Dataflow tests
cargo bench -p benches --bench reachability -- differential

# Run only Hydro/DFIR tests
cargo bench -p benches --bench reachability -- dfir_rs
```

## Understanding Results

Criterion will output results showing:
- **Time**: How long each benchmark iteration took
- **Throughput**: Operations per second (if applicable)
- **Comparison**: Performance relative to previous runs (if available)

Results are also saved as HTML reports in `target/criterion/` for detailed analysis including:
- Performance graphs
- Statistical analysis
- Comparison charts between different implementations

## Dependencies

The benchmarks require:
- **criterion**: Statistics-driven benchmarking framework
- **timely**: Timely Dataflow framework (version 0.13.0-dev.1)
- **differential-dataflow**: Differential Dataflow framework (version 0.13.0-dev.1)
- **dfir_rs**: Hydro/DFIR framework (from hydro-project/hydro repository)
- **sinktools**: Utilities for working with Hydro sinks

## Data Files

The `reachability` benchmark uses pre-generated graph data files:
- `reachability_edges.txt`: Graph edges for the reachability test
- `reachability_reachable.txt`: Expected reachable nodes for validation

These files are embedded in the benchmark binary at compile time using `include_bytes!()`.

## Build Configuration

The `build.rs` script generates code for the `fork_join` benchmark, creating a surface syntax version with a configurable number of operations. This allows testing different graph sizes without manual code duplication.

## Performance Considerations

When running benchmarks:
1. **Close other applications** to reduce system noise
2. **Run multiple times** to account for variance
3. **Use release mode** (Criterion does this automatically)
4. **Consider CPU frequency scaling** - disable turbo boost for more consistent results
5. **Watch for thermal throttling** on long benchmark runs

## Interpreting Performance Comparisons

When comparing results:
- **Raw/Iterator baselines**: Show the theoretical minimum overhead
- **Timely vs Hydro**: Compare dataflow framework performance
- **Differential vs Hydro**: Compare incremental vs batch computation
- **Surface vs Scheduled APIs**: Compare high-level vs low-level Hydro APIs

Lower execution time is better, but also consider:
- Code complexity and maintainability
- Feature richness (e.g., incremental computation in Differential)
- Type safety and correctness guarantees

## Contributing

When adding new benchmarks:
1. Follow the existing pattern of comparing multiple implementations
2. Include both raw/baseline and framework implementations
3. Document what the benchmark tests and why it matters
4. Add appropriate `[[bench]]` entries to `Cargo.toml`
5. Update this README with the new benchmark description
