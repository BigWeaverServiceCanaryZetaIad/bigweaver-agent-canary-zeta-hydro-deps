# Timely and Differential-Dataflow Benchmarks

This package contains performance benchmarks that compare Hydro implementations against timely-dataflow and differential-dataflow reference implementations.

## Overview

These benchmarks help measure and compare:
- **Dataflow Performance**: How different dataflow patterns perform
- **Scalability**: Performance characteristics as input size grows
- **Optimization Opportunities**: Where Hydro can be improved
- **Regression Detection**: Ensuring performance doesn't degrade over time

## Benchmark Files

All benchmark implementations are in the `benches/` subdirectory:

- **arithmetic.rs** - Basic arithmetic operations on streams
- **fan_in.rs** - Multiple input streams merging
- **fan_out.rs** - Single input stream splitting to multiple outputs
- **fork_join.rs** - Parallel processing with synchronization
- **futures.rs** - Async/await pattern benchmarks
- **identity.rs** - Pass-through operations (baseline for overhead)
- **join.rs** - Relational join operations
- **micro_ops.rs** - Individual micro-operations
- **reachability.rs** - Graph reachability computation
- **symmetric_hash_join.rs** - Hash-based join optimization
- **upcase.rs** - String transformation operations
- **words_diamond.rs** - Complex diamond-shaped dataflow pattern

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Run with Options

```bash
# Save baseline for future comparison
cargo bench -p benches -- --save-baseline my-baseline

# Compare against saved baseline
cargo bench -p benches -- --baseline my-baseline

# Run with verbose output
cargo bench -p benches -- --verbose

# Filter specific tests within a benchmark
cargo bench -p benches --bench arithmetic -- multiply
```

## Benchmark Data Files

Some benchmarks use external data files:

- **reachability_edges.txt** - Graph edge list for reachability benchmark (532KB)
- **reachability_reachable.txt** - Expected reachable nodes for verification (38KB)
- **words_alpha.txt** - English word list for words_diamond benchmark (3.8MB)

The word list is sourced from: https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Understanding Results

Criterion outputs results in the following format:

```
benchmark_name          time:   [lower_bound estimate upper_bound]
                        thrpt:  [lower_bound estimate upper_bound]
```

- **time**: Execution time (lower is better)
- **thrpt**: Throughput in elements/second (higher is better)
- **Bounds**: 95% confidence intervals

Results are also saved as HTML reports in `target/criterion/<benchmark-name>/report/index.html`.

## Performance Comparison

These benchmarks use timely-dataflow and differential-dataflow implementations. To compare with Hydro:

1. Run these benchmarks to establish timely/differential baselines
2. Run equivalent Hydro benchmarks in the main repository
3. Compare the performance metrics
4. Analyze where optimizations are needed

See the main README.md and BENCHMARK_GUIDE.md for detailed comparison workflows.

## Dependencies

Key dependencies for these benchmarks:

- **criterion** (v0.5.0) - Benchmark harness with statistical analysis
- **timely-master** (v0.13.0-dev.1) - Timely dataflow engine
- **differential-dataflow-master** (v0.13.0-dev.1) - Incremental computation framework
- **dfir_rs** (via path) - Hydro dataflow runtime for comparison
- **tokio** (v1.29.0) - Async runtime for futures benchmarks

## Adding New Benchmarks

To add a new benchmark:

1. Create a new file in `benches/`: `my_benchmark.rs`
2. Implement using Criterion:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_bench(c: &mut Criterion) {
       c.bench_function("my_test", |b| b.iter(|| {
           // benchmark code
       }));
   }
   
   criterion_group!(benches, my_bench);
   criterion_main!(benches);
   ```
3. Add entry to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
4. Run: `cargo bench -p benches --bench my_benchmark`

## Troubleshooting

**Build Errors**: Ensure the main Hydro repository is cloned as a sibling directory
**Inconsistent Results**: Check system load and disable CPU frequency scaling
**Missing Data Files**: Git should track the data files; verify they're present

For more detailed information, see:
- `../BENCHMARK_GUIDE.md` - Comprehensive benchmark guide
- `../README.md` - Repository overview and setup instructions
