# Timely and Differential Dataflow Benchmarks

This repository contains performance benchmarks for [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow).

## Overview

These benchmarks were originally part of the Hydro project's benchmark suite but have been extracted into a standalone repository to:
- Reduce dependency overhead in the main Hydro repository
- Provide a dedicated space for Timely/Differential performance testing
- Enable independent performance comparisons and tracking

## Benchmarks

The following benchmarks are included:

### 1. **arithmetic** - Chain of Arithmetic Operations
Tests performance of sequential arithmetic operations (addition) through a dataflow pipeline.
- **Operations**: 20 sequential map operations
- **Data size**: 1,000,000 integers
- **Measures**: Pipeline throughput for simple transformations

### 2. **fan_in** - Multiple Stream Concatenation
Tests the performance of merging multiple streams into one.
- **Operations**: 20 separate streams concatenated into one
- **Data size**: 1,000,000 integers per stream
- **Measures**: Stream merging efficiency

### 3. **fan_out** - Single Stream Splitting
Tests the performance of splitting one stream into multiple consumers.
- **Operations**: 20 independent consumers of one stream
- **Data size**: 1,000,000 integers
- **Measures**: Stream broadcasting efficiency

### 4. **fork_join** - Stream Splitting and Rejoining
Tests iterative fork-join patterns where streams are repeatedly split and merged.
- **Operations**: 20 iterations of split-by-filter and merge
- **Branch factor**: 2
- **Data size**: 100,000 integers
- **Measures**: Complex dataflow pattern performance

### 5. **identity** - Pass-through Operations
Tests the overhead of dataflow operators with minimal computation.
- **Operations**: 20 identity map operations
- **Data size**: 1,000,000 integers
- **Measures**: Baseline operator overhead

### 6. **join** - Hash Join Operations
Tests hash join performance for both primitive and complex types.
- **Variants**: usize×usize and String×String joins
- **Data size**: 100,000 tuples per input
- **Measures**: Join operator efficiency

### 7. **reachability** - Graph Reachability
Tests iterative graph algorithms with feedback loops.
- **Implementations**: 
  - Timely Dataflow with feedback loops
  - Differential Dataflow with incremental computation
- **Data**: Real graph data (55,008 edges, 7,855 reachable nodes)
- **Measures**: Iterative computation and convergence performance

### 8. **upcase** - String Transformation
Tests string manipulation operations through dataflow.
- **Variants**: 
  - In-place uppercase transformation
  - Allocating uppercase transformation
  - String concatenation
- **Operations**: 20 sequential transformations
- **Data size**: 100,000 strings
- **Measures**: String processing throughput

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
# ... etc
```

### Run Specific Benchmark Function
```bash
cargo bench --bench reachability -- "reachability/timely"
cargo bench --bench reachability -- "reachability/differential"
```

### Generate HTML Reports
Criterion automatically generates HTML reports in `target/criterion/`. Open `target/criterion/report/index.html` in a browser to view detailed results.

## Dependencies

This benchmark suite uses:
- **timely-master** (0.13.0-dev.1): Development version of Timely Dataflow
- **differential-dataflow-master** (0.13.0-dev.1): Development version of Differential Dataflow
- **criterion** (0.5.0): Statistical benchmarking framework

## Benchmark Data Files

Some benchmarks include test data files:
- `reachability_edges.txt`: Graph edges for reachability testing (55,008 edges)
- `reachability_reachable.txt`: Expected reachable nodes (7,855 nodes)
- `words_alpha.txt`: Dictionary of words for string processing tests

## Performance Comparison

These benchmarks can be used to:
1. **Track Timely/Differential performance over time**: Run benchmarks across different versions
2. **Compare with other dataflow systems**: Use as reference implementations
3. **Optimize Timely/Differential implementations**: Identify performance bottlenecks
4. **Validate Hydro performance**: Compare against Hydro's equivalent implementations

## Historical Context

These benchmarks were extracted from the [Hydro project](https://github.com/hydro-project/hydro) repository. The original implementations included:
- Side-by-side Hydro and Timely/Differential comparisons
- Multiple variants for each benchmark (raw iteration, pipeline, Hydro compiled/surface syntax)

This extraction focuses solely on the Timely and Differential Dataflow implementations to:
- Reduce compilation overhead in the Hydro repository
- Maintain clear separation of concerns
- Preserve the ability to run performance comparisons externally

## Methodology

When using these benchmarks:

1. **Warm-up runs**: Criterion automatically handles warm-up iterations
2. **Statistical analysis**: Results include confidence intervals and outlier detection
3. **Fair comparisons**: Ensure consistent:
   - Input data sizes
   - Number of operations
   - Hardware resources
   - Compilation settings (release mode recommended)

## Build Configuration

Recommended cargo configuration for accurate benchmarking:

```toml
[profile.release]
opt-level = 3
lto = true
codegen-units = 1
```

Or use:
```bash
RUSTFLAGS="-C target-cpu=native" cargo bench
```

## Contributing

When adding new benchmarks:
1. Follow the existing naming conventions
2. Include clear documentation of what is being measured
3. Use realistic data sizes
4. Add appropriate assertions to validate correctness
5. Update this README with benchmark descriptions

## License

This benchmark suite inherits the license from the original Hydro project.

## References

- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://github.com/hydro-project/hydro)
- [Criterion Benchmarking](https://github.com/bheisler/criterion.rs)
