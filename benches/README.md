# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks for comparing Timely Dataflow, Differential Dataflow, and Hydroflow performance across various dataflow patterns.

## Overview

These benchmarks were moved from the main Hydro repository to reduce unnecessary dependencies in the core codebase. They provide comprehensive performance comparisons for various dataflow operations and patterns.

## Benchmark Descriptions

### Arithmetic (`arithmetic.rs`)
Pipeline and dataflow arithmetic operations. Compares performance across different implementations:
- Pipeline (channel-based)
- Raw iteration
- Iterator with collect
- Hydroflow (compiled and surface syntax)
- Timely dataflow

### Fan-In (`fan_in.rs`)
Tests the fan-in dataflow pattern where multiple input streams converge into a single output stream.

### Fan-Out (`fan_out.rs`)
Tests the fan-out dataflow pattern where a single input stream is distributed to multiple output streams.

### Fork-Join (`fork_join.rs`)
Benchmarks the fork-join pattern with alternating filter operations. Uses build-time code generation to create the dataflow graph.

### Identity (`identity.rs`)
Basic identity operations that pass data through with minimal transformation. Useful for measuring framework overhead.

### Join (`join.rs`)
Tests join operations between two streams, comparing different implementations.

### Reachability (`reachability.rs`)
Graph reachability algorithms comparing different dataflow implementations. Uses edge and reachability data files for testing.

### Upcase (`upcase.rs`)
String case conversion benchmarks comparing different implementations.

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed. The benchmarks require:
- Rust edition 2021
- Criterion for benchmarking
- Timely and Differential-Dataflow packages
- Hydroflow dependencies (dfir_rs, sinktools)

### Run All Benchmarks

```bash
cd benches
cargo bench
```

### Run Specific Benchmarks

```bash
# Arithmetic benchmarks
cargo bench --bench arithmetic

# Fan-in pattern
cargo bench --bench fan_in

# Fan-out pattern
cargo bench --bench fan_out

# Fork-join pattern
cargo bench --bench fork_join

# Identity operations
cargo bench --bench identity

# Join operations
cargo bench --bench join

# Graph reachability
cargo bench --bench reachability

# String upcase
cargo bench --bench upcase
```

### Run Specific Test Cases

You can filter benchmarks by name:

```bash
# Run only Timely benchmarks
cargo bench -- timely

# Run only Hydroflow benchmarks
cargo bench -- dfir_rs

# Run only pipeline benchmarks
cargo bench -- pipeline
```

## Performance Comparison

These benchmarks allow you to compare:
- **Timely Dataflow**: Stream processing framework
- **Differential Dataflow**: Incremental computation framework built on Timely
- **Hydroflow**: Modern dataflow framework with compiled and surface syntax
- **Baseline Implementations**: Raw Rust, iterators, channels for comparison

## Data Files

The `benches/` directory includes data files used by benchmarks:
- `reachability_edges.txt` (521KB) - Graph edges for reachability testing
- `reachability_reachable.txt` (38KB) - Expected reachability results

## Build Process

The `build.rs` script generates code for the fork-join benchmark at compile time. This allows testing with different numbers of operations without manually writing repetitive code.

## Configuration

Key constants can be adjusted in individual benchmark files:
- `NUM_OPS`: Number of operations to chain
- `NUM_INTS`: Number of integers to process
- Various data sizes and parameters specific to each benchmark

## Dependencies

The benchmarks depend on:
- `criterion`: Benchmarking framework with statistical analysis
- `timely`: Timely dataflow engine
- `differential-dataflow`: Differential dataflow engine
- `dfir_rs`: Hydroflow core library
- `sinktools`: Hydroflow sink utilities
- `tokio`: Async runtime for async benchmarks
- Various utility crates (rand, seq-macro, static_assertions, etc.)

## Results

Benchmark results are generated in the `target/criterion` directory with:
- HTML reports for visualization
- Statistical analysis
- Performance comparisons across runs
- Regression detection

Open `target/criterion/report/index.html` in a browser to view detailed results.

## Integration with CI/CD

These benchmarks can be integrated into CI/CD pipelines for:
- Performance regression detection
- Comparing different implementations
- Tracking performance over time
- Validating optimization efforts

## Notes

- Benchmarks use `black_box()` to prevent compiler optimizations from eliminating code
- Some benchmarks are hardcoded for specific numbers of operations (marked with assertions)
- Async benchmarks require Tokio runtime
- Results may vary based on hardware, system load, and compiler optimizations

## Troubleshooting

### Build Issues

If you encounter dependency issues:
1. Ensure the dfir_rs and sinktools dependencies point to the correct repository
2. Update git dependencies if using local development versions
3. Check that Timely and Differential versions are compatible

### Performance Variations

If benchmark results seem inconsistent:
1. Close other applications to reduce system load
2. Run benchmarks multiple times for statistical significance
3. Consider using `taskset` or similar tools to pin to specific CPU cores
4. Disable CPU frequency scaling for more consistent results

## Contributing

When adding new benchmarks:
1. Follow the existing naming conventions
2. Include comparisons with baseline implementations
3. Document the benchmark purpose and patterns tested
4. Add appropriate `[[bench]]` entries to `Cargo.toml`
5. Update this README with the new benchmark description

## License

These benchmarks are licensed under Apache-2.0, consistent with the Hydro project.
