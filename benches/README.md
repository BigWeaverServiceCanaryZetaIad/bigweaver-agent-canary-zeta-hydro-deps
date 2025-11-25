# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that compare the performance of Hydro dataflow operations with their equivalents in [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow).

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate the `timely` and `differential-dataflow` dependencies, keeping the main repository lean and focused.

## Benchmarks Included

### Timely Dataflow Benchmarks

1. **arithmetic.rs** - Tests arithmetic operations in a pipeline with multiple map operations
2. **fan_in.rs** - Tests multiple streams merging into one using concatenate operations
3. **fan_out.rs** - Tests splitting data into multiple streams
4. **fork_join.rs** - Tests splitting data, processing in parallel, and rejoining
5. **identity.rs** - Tests basic data passthrough operations
6. **join.rs** - Tests joining two data streams
7. **upcase.rs** - Tests string manipulation operations

### Differential Dataflow Benchmarks

1. **reachability.rs** - Tests graph reachability algorithms using differential dataflow
   - Uses data files: `reachability_edges.txt` and `reachability_reachable.txt`

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p timely-differential-benches
```

### Run Specific Benchmarks

Run a single benchmark:
```bash
cargo bench -p timely-differential-benches --bench arithmetic
```

Run multiple specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench arithmetic --bench join
```

### Filter by Test Name

Run only specific test functions within benchmarks:
```bash
cargo bench -p timely-differential-benches -- timely
```

This will run all benchmark functions containing "timely" in their name.

## Benchmark Output

Benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) which provides:
- Statistical analysis of performance
- HTML reports in `target/criterion/`
- Console output with comparison to previous runs
- Detection of performance regressions

### Viewing HTML Reports

After running benchmarks, open the generated HTML reports:
```bash
# Linux/macOS
open target/criterion/report/index.html

# Or manually navigate to:
# target/criterion/<benchmark_name>/report/index.html
```

## Comparing Performance

### Comparing with Main Repository

To compare performance between this repository and the main `bigweaver-agent-canary-hydro-zeta` repository:

1. **Run benchmarks in the main repository** (if they still exist):
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches --bench arithmetic
   ```

2. **Run benchmarks in this repository**:
   ```bash
   cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p timely-differential-benches --bench arithmetic
   ```

3. **Compare results**: Criterion will automatically save baseline results. You can compare against saved baselines:
   ```bash
   # Save current results as baseline
   cargo bench -p timely-differential-benches --bench arithmetic -- --save-baseline main-repo
   
   # Later, compare against that baseline
   cargo bench -p timely-differential-benches --bench arithmetic -- --baseline main-repo
   ```

### Performance Metrics

Each benchmark typically compares multiple implementations:
- **Raw/Iterator**: Pure Rust implementations for baseline comparison
- **Timely**: Timely Dataflow implementation
- **dfir_rs (Hydro)**: Hydro dataflow implementation
  - Compiled version (optimized)
  - Surface syntax version (using macros)

Look for these patterns in benchmark results:
- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Overhead**: Difference between raw implementation and dataflow framework

## Benchmark Details

### arithmetic.rs
- **NUM_INTS**: 1,000,000 integers
- **NUM_OPS**: 20 operations per integer
- Tests: pipeline, raw copy, iterator, timely, and hydro implementations

### fan_in.rs
- **NUM_STREAMS**: Number of input streams to merge
- **NUM_INTS**: Data size per stream
- Tests: concatenation performance across implementations

### fan_out.rs
- Tests distributing data to multiple downstream operators
- Compares map/broadcast patterns

### fork_join.rs
- **NUM_OPS**: Number of fork-join iterations
- Tests: splitting data based on predicate, parallel processing, and merging
- Auto-generated using build.rs

### identity.rs
- Tests minimal overhead for passing data through the system
- Baseline for understanding framework overhead

### join.rs
- Tests joining two streams of data
- Compares custom operator implementation with timely

### reachability.rs
- **Graph size**: ~10,000 edges
- Tests iterative graph reachability using differential dataflow
- Demonstrates incremental computation capabilities

### upcase.rs
- Tests string operations (uppercase conversion)
- String manipulation benchmarks

## Dependencies

### Core Dependencies
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`

### Benchmark Framework
- `criterion = { version = "0.5.0", features = ["async_tokio", "html_reports"] }`

### Utilities
- `futures = "0.3"` - Async runtime support
- `tokio = { version = "1.29.0", features = ["rt-multi-thread"] }` - Async runtime
- `rand = "0.8.0"`, `rand_distr = "0.4.3"` - Random data generation
- `seq-macro = "0.2.0"` - Compile-time sequence generation
- `static_assertions = "1.0.0"` - Compile-time assertions

## Build Process

The `build.rs` script generates benchmark code at compile time:
- Generates `fork_join_20.hf` - Hydro syntax for fork-join benchmark
- Ensures NUM_OPS matches between Rust code and generated Hydro syntax

## Integration with Main Repository

These benchmarks can be run independently or as part of performance regression testing:

1. **CI/CD Integration**: Add benchmark runs to continuous integration
2. **Performance Tracking**: Track performance trends over time
3. **Regression Detection**: Alert on performance degradations
4. **Cross-Implementation Validation**: Ensure Hydro matches or exceeds timely/differential performance

## Troubleshooting

### Missing Dependencies
If you encounter dependency resolution issues:
```bash
cargo update
cargo clean
cargo build
```

### Build Failures
Ensure you have the correct Rust toolchain:
```bash
rustup show  # Should show 1.91.1
```

### Benchmark Failures
If benchmarks fail to run:
1. Check that data files are present (reachability_edges.txt, etc.)
2. Ensure sufficient system resources (some benchmarks are memory-intensive)
3. Try running with `--` `--test` flag for quick smoke test:
   ```bash
   cargo bench -p timely-differential-benches --bench arithmetic -- --test
   ```

## Contributing

When adding new benchmarks:
1. Follow the existing naming patterns
2. Include comparisons with timely/differential when relevant
3. Add documentation explaining what the benchmark tests
4. Update this README with benchmark details
5. Ensure benchmarks run in reasonable time (< 1 minute preferred)

## References

- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Project](https://github.com/hydro-project/hydro)
