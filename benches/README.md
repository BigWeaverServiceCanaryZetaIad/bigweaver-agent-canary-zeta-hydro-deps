# Timely and Differential-Dataflow Benchmarks

This directory contains performance benchmarks that compare Hydro (dfir_rs/Hydroflow) implementations with timely-dataflow and differential-dataflow implementations. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain separation of concerns and reduce dependency complexity in the core repository.

## Overview

These benchmarks provide comparative performance analysis between:
- **Hydroflow/dfir_rs**: The core dataflow library
- **Timely Dataflow**: A low-latency cyclic dataflow computational model
- **Differential Dataflow**: An implementation of differential computation on timely dataflow

## Prerequisites

Before running these benchmarks, ensure you have:
- Rust toolchain installed (compatible with the version specified in rust-toolchain.toml of the main repository)
- Git access to the bigweaver-agent-canary-hydro-zeta repository (for dfir_rs and sinktools dependencies)

## Running Benchmarks

### Run All Benchmarks

To run all benchmarks in this package:

```bash
cargo bench -p hydro-deps-benches
```

### Run Specific Benchmarks

To run a specific benchmark:

```bash
cargo bench -p hydro-deps-benches --bench <benchmark_name>
```

For example:
```bash
cargo bench -p hydro-deps-benches --bench arithmetic
cargo bench -p hydro-deps-benches --bench reachability
```

### Run Quick Benchmarks

For faster iteration during development, you can run benchmarks with reduced sample sizes:

```bash
cargo bench -p hydro-deps-benches -- --quick
```

## Available Benchmarks

### 1. Arithmetic Operations (`arithmetic.rs`)
Compares arithmetic pipeline operations between Hydroflow, timely, and differential-dataflow.

**What it tests:**
- Pipeline of arithmetic operations (add, multiply, modulo)
- Data transformation through multiple stages
- Operator composition efficiency

**Run with:**
```bash
cargo bench -p hydro-deps-benches --bench arithmetic
```

### 2. Fan-In Pattern (`fan_in.rs`)
Tests the fan-in pattern where multiple data sources are merged into a single stream.

**What it tests:**
- Multiple input streams converging to one output
- Union operations efficiency
- Data merging performance

**Run with:**
```bash
cargo bench -p hydro-deps-benches --bench fan_in
```

### 3. Fan-Out Pattern (`fan_out.rs`)
Tests the fan-out pattern where a single data source is distributed to multiple consumers.

**What it tests:**
- Data broadcast to multiple downstream operators
- Tee/split operations efficiency
- Parallel processing capabilities

**Run with:**
```bash
cargo bench -p hydro-deps-benches --bench fan_out
```

### 4. Fork-Join Pattern (`fork_join.rs`)
Tests the fork-join computational pattern with alternating splits and merges.

**What it tests:**
- Splitting data streams based on conditions
- Rejoining split streams
- Complex dataflow graph execution
- Dynamic code generation via build.rs

**Run with:**
```bash
cargo bench -p hydro-deps-benches --bench fork_join
```

**Note:** This benchmark uses code generation in `build.rs` to create the fork-join graph with a configurable number of operations.

### 5. Identity Operations (`identity.rs`)
Tests simple identity operations where data passes through without transformation.

**What it tests:**
- Baseline dataflow overhead
- Minimal operator latency
- Framework efficiency with no-op transformations

**Run with:**
```bash
cargo bench -p hydro-deps-benches --bench identity
```

### 6. Join Operations (`join.rs`)
Compares join operations between the different dataflow systems.

**What it tests:**
- Hash join implementations
- Key-value pair matching
- Join state management
- Memory efficiency during joins

**Run with:**
```bash
cargo bench -p hydro-deps-benches --bench join
```

### 7. Graph Reachability (`reachability.rs`)
Tests graph reachability algorithms using iterative dataflow computation.

**What it tests:**
- Iterative/recursive dataflow patterns
- Fixed-point computation
- Graph algorithms performance
- Large-scale data processing

**Data files:**
- `reachability_edges.txt` - Graph edge definitions
- `reachability_reachable.txt` - Expected reachable nodes

**Run with:**
```bash
cargo bench -p hydro-deps-benches --bench reachability
```

### 8. String Uppercase (`upcase.rs`)
Tests string transformation operations.

**What it tests:**
- String processing operations
- Data transformation overhead
- Memory allocation patterns

**Run with:**
```bash
cargo bench -p hydro-deps-benches --bench upcase
```

## Benchmark Output

Benchmarks use the [Criterion.rs](https://github.com/bheisler/criterion.rs) framework, which provides:

- **Statistical analysis** of benchmark results
- **HTML reports** with graphs and detailed statistics
- **Comparison between runs** to detect performance regressions
- **Outlier detection** for more reliable measurements

After running benchmarks, you can find detailed reports in:
```
target/criterion/<benchmark_name>/report/index.html
```

## Performance Comparison

The benchmarks allow you to compare:

1. **Throughput**: Operations per second for each implementation
2. **Latency**: Time taken for individual operations
3. **Memory usage**: Resource consumption patterns
4. **Scalability**: Performance with different data sizes

## Understanding Results

When comparing results between Hydroflow/dfir_rs, timely, and differential-dataflow:

- **Lower execution times are better** (faster processing)
- **Higher throughput is better** (more operations per second)
- Look for **consistent performance** across multiple runs
- Pay attention to **variance** and **confidence intervals**

## Data Files

Some benchmarks require data files:

- **reachability_edges.txt**: Graph edges for reachability testing (524KB)
- **reachability_reachable.txt**: Expected reachable nodes (40KB)
- **words_alpha.txt**: Word list for string processing tests (3.7MB)

These files are included in the `benches/` directory and are automatically used by the relevant benchmarks.

## Build Configuration

The `build.rs` script generates code for certain benchmarks (notably `fork_join`) at compile time. This allows for flexible benchmark configuration without manual code duplication.

### Customizing Fork-Join Benchmark

To change the number of operations in the fork-join benchmark, edit `build.rs`:

```rust
const NUM_OPS: usize = 20; // Change this value
```

Then rebuild:
```bash
cargo clean -p hydro-deps-benches
cargo bench -p hydro-deps-benches --bench fork_join
```

## Continuous Performance Testing

To track performance over time:

1. Run benchmarks on a consistent machine configuration
2. Save Criterion.rs output for comparison
3. Use `cargo bench -- --save-baseline <name>` to create named baselines
4. Compare against baselines with `cargo bench -- --baseline <name>`

Example:
```bash
# Create baseline
cargo bench -p hydro-deps-benches -- --save-baseline main

# After changes, compare against baseline
cargo bench -p hydro-deps-benches -- --baseline main
```

## Troubleshooting

### Build Errors

If you encounter build errors related to missing dependencies:

1. Ensure you have network access to clone the main repository
2. Check that the git URLs in `Cargo.toml` are correct
3. Verify your Rust toolchain version matches the project requirements

### Performance Variance

If benchmark results show high variance:

1. Close unnecessary applications to reduce system load
2. Run benchmarks multiple times for statistical significance
3. Use a dedicated benchmark machine if available
4. Consider disabling CPU frequency scaling

### Missing Data Files

If benchmarks fail due to missing data files, ensure you're running from the repository root or the files are in the correct location relative to the benchmark binary.

## Contributing

When adding new benchmarks:

1. Follow the existing naming conventions
2. Add comprehensive documentation in this README
3. Include both Hydroflow and comparison implementations
4. Add appropriate `[[bench]]` entries to `Cargo.toml`
5. Ensure benchmarks are reproducible and statistically sound

## Migration Notes

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to:

1. **Reduce dependency complexity** in the main repository
2. **Improve separation of concerns** between core library and external dependency benchmarks
3. **Maintain performance comparison capabilities** while keeping the main repository lean
4. **Enable independent benchmarking** without requiring the full main repository build

The benchmarks maintain full functionality and can be run independently from this repository.

## References

- [Hydroflow Documentation](https://hydro.run/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydroflow repository
