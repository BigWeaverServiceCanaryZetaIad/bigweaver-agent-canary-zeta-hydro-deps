# Benchmark Guide

## Overview

This guide explains how to run and interpret the benchmarks in this repository, which compare Hydro (DFIR) implementations with timely-dataflow and differential-dataflow.

## Quick Start

### Running All Benchmarks

```bash
cargo bench -p benches
```

This will run all benchmarks and generate HTML reports in `target/criterion/`.

### Running Individual Benchmarks

```bash
# Identity benchmark
cargo bench -p benches --bench identity

# Reachability benchmark
cargo bench -p benches --bench reachability

# Micro-operations benchmark
cargo bench -p benches --bench micro_ops
```

## Benchmark Categories

### Stream Processing Benchmarks

These benchmarks test basic stream processing patterns:

- **identity** - Measures overhead of passing data through operators
- **arithmetic** - Tests arithmetic operations on streams
- **upcase** - String transformation benchmarks

### Join Benchmarks

Benchmarks focusing on join operations:

- **join** - Basic join operations
- **symmetric_hash_join** - Symmetric hash join implementations
- **fork_join** - Fork-join pattern performance

### Graph Benchmarks

Graph processing benchmarks:

- **reachability** - Graph reachability algorithms
- Uses test data from `reachability_edges.txt` and `reachability_reachable.txt`

### Pattern Benchmarks

Common dataflow patterns:

- **fan_in** - Multiple inputs to single operator
- **fan_out** - Single input to multiple operators
- **words_diamond** - Diamond-shaped dataflow pattern

### Micro-benchmarks

- **micro_ops** - Fine-grained operation benchmarks
- **futures** - Async/futures integration benchmarks

## Interpreting Results

### Criterion Output

Criterion provides detailed statistics for each benchmark:

- **time** - Mean execution time with confidence intervals
- **change** - Performance change compared to previous runs
- **R²** - Goodness of fit for the linear regression model

### HTML Reports

After running benchmarks, view detailed reports:

```bash
# Open in browser
open target/criterion/report/index.html
```

Reports include:
- Execution time distributions
- Historical performance trends
- Statistical analysis
- Comparison between runs

## Performance Comparison

### Comparing Implementations

Each benchmark typically includes multiple implementations:

1. **DFIR (Hydro)** - Main Hydro implementation
2. **Timely** - Timely-dataflow implementation  
3. **Differential** - Differential-dataflow implementation (where applicable)
4. **Raw/Baseline** - Minimal overhead baseline (some benchmarks)

Use these to:
- Validate Hydro performance
- Identify optimization opportunities
- Track performance regressions

### Baseline Comparisons

Some benchmarks include "raw" implementations that represent theoretical minimum overhead:

- Compare against these to understand framework overhead
- Use for setting performance goals

## Adding New Benchmarks

### 1. Create Benchmark File

Create a new file in `benches/benches/`:

```rust
use criterion::{criterion_group, criterion_main, Criterion};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_benchmark", |b| {
        b.iter(|| {
            // Benchmark code here
        });
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

### 2. Register in Cargo.toml

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### 3. Run and Validate

```bash
cargo bench -p benches --bench my_benchmark
```

## Best Practices

### Writing Benchmarks

1. **Use black_box** - Prevent compiler optimizations:
   ```rust
   use criterion::black_box;
   black_box(result);
   ```

2. **Consistent Setup** - Use consistent input sizes and patterns

3. **Multiple Runs** - Let Criterion run multiple iterations for accuracy

4. **Fair Comparisons** - Ensure implementations solve the same problem

### Running Benchmarks

1. **Stable Environment** - Run on a quiet system
2. **Consistent Conditions** - Same hardware, similar load
3. **Multiple Runs** - Run multiple times to confirm results
4. **Baseline First** - Establish baseline before changes

## Troubleshooting

### Long Build Times

Benchmarks depend on large crates (timely, differential). First build may take several minutes.

### Memory Usage

Some benchmarks (especially `reachability`) use significant memory. Ensure adequate RAM.

### Timeout Issues

Large benchmarks may timeout. Adjust in benchmark code:

```rust
c.bench_function("name", |b| {
    b.iter(|| { /* ... */ });
}).sample_size(10); // Reduce sample size
```

## CI/CD Integration

### GitHub Actions

The repository includes a benchmark workflow (`.github/workflows/benchmark.yml`):

- Runs on performance-critical changes
- Archives results for historical comparison
- Can be triggered manually

### Local CI Simulation

```bash
# Run the same checks as CI
cargo check --all-targets
cargo test -p benches
cargo bench -p benches --no-run
```

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Documentation](https://hydro.run)

## Contact

For questions or issues with benchmarks, please open an issue in the repository.
