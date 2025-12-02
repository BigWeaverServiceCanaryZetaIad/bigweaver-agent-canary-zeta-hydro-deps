# Microbenchmarks

Performance benchmarks comparing Hydro/DFIR implementations with timely and differential-dataflow.

## Overview

This benchmark suite provides performance comparisons across multiple dataflow implementations:
- **Hydro/DFIR**: The main Hydro dataflow implementation
- **Timely**: Direct timely-dataflow implementations
- **Differential**: Differential-dataflow implementations

Each benchmark typically includes multiple implementations to allow for direct performance comparisons.

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench reachability
```

### Run Multiple Benchmarks Matching a Pattern
```bash
cargo bench -p benches --bench join
```

### Generate HTML Reports
Criterion automatically generates HTML reports in `target/criterion/`. Open `target/criterion/report/index.html` in a browser to view detailed results, including:
- Performance graphs
- Statistical analysis
- Historical comparisons (if run multiple times)

## Available Benchmarks

### Dataflow Patterns

1. **fan_in** - Tests fan-in dataflow patterns where multiple streams merge
2. **fan_out** - Tests fan-out patterns where one stream splits into multiple
3. **fork_join** - Tests fork-join patterns combining splitting and merging

### Operations

4. **arithmetic** - Arithmetic operations across pipeline stages
5. **identity** - Identity operations (no-op transformations)
6. **join** - Join operations between two streams
7. **symmetric_hash_join** - Symmetric hash join implementation comparisons
8. **micro_ops** - Fine-grained micro-operations benchmarks

### Applications

9. **reachability** - Graph reachability computation (uses `reachability_edges.txt` and `reachability_reachable.txt`)
10. **upcase** - String uppercase transformation
11. **words_diamond** - Word processing with diamond pattern (uses `words_alpha.txt`)
12. **futures** - Async futures and stream processing

## Understanding Results

### Criterion Output

Criterion provides detailed statistical analysis:
```
arithmetic/hydro      time:   [123.45 ms 125.67 ms 128.90 ms]
                      change: [-5.2345% -2.1234% +1.2345%] (p = 0.23 > 0.05)
```

- **time**: Lower, estimate, upper bounds of execution time
- **change**: Performance change from previous run (if available)
- **p-value**: Statistical significance (< 0.05 indicates significant change)

### Comparing Implementations

To compare different implementations:

1. Run the full benchmark suite:
   ```bash
   cargo bench -p benches
   ```

2. Check the generated report at `target/criterion/report/index.html`

3. Look for benchmark variants (e.g., `arithmetic/hydro`, `arithmetic/timely`, `arithmetic/pipeline`)

4. Compare execution times and throughput across implementations

### Performance Tracking

Criterion maintains historical data in `target/criterion/*/base/`. To track performance over time:

1. Run benchmarks regularly on the same machine
2. Review the "change" percentages to spot regressions
3. Use `cargo bench --save-baseline <name>` to save specific baselines
4. Compare against baselines with `cargo bench --baseline <name>`

## Benchmark Data Files

Some benchmarks require data files:
- **reachability_edges.txt** - Graph edges for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes
- **words_alpha.txt** - English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)

These files are automatically included in the repository and loaded during benchmark execution.

## Development

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Implement benchmark using Criterion:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_benchmark", |b| {
           b.iter(|| {
               // benchmark code
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

### Build Configuration

The `build.rs` script generates code for some benchmarks (e.g., fork_join) at build time. This allows parametric generation of benchmark variants.

## Dependencies

Key dependencies used in these benchmarks:

- **criterion** - Benchmarking framework with statistical analysis
- **dfir_rs** - Main Hydro DFIR implementation
- **timely** (timely-master) - Timely-dataflow for comparison
- **differential-dataflow** (differential-dataflow-master) - Differential-dataflow for comparison
- **tokio** - Async runtime for futures benchmarks

## Performance Comparison Philosophy

These benchmarks maintain the team's philosophy of:
1. Comparing multiple implementation approaches
2. Using standardized datasets for reproducibility
3. Generating statistical confidence in results
4. Tracking performance over time
5. Keeping heavyweight dependencies isolated from the main codebase
