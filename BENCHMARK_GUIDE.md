# Benchmark Guide

This guide provides detailed information about running, interpreting, and extending the benchmarks in this repository.

## Prerequisites

### Required Dependencies

1. **Rust Toolchain**: Ensure you have a recent version of Rust installed
2. **Main Repository**: The bigweaver-agent-canary-hydro-zeta repository must be cloned as a sibling directory, as these benchmarks depend on `dfir_rs` and `sinktools` from that repository

### Directory Structure

Your workspace should look like this:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/     # Main repository
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
```

## Running Benchmarks

### Basic Commands

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench arithmetic

# Run with more detailed output
cargo bench -- --verbose

# Run and save baseline for comparison
cargo bench -- --save-baseline before-changes

# Compare against baseline
cargo bench -- --baseline before-changes
```

### Benchmark-Specific Examples

#### Arithmetic Operations

```bash
cargo bench --bench arithmetic
```

This benchmark compares various implementations of a simple arithmetic pipeline:
- Raw threading with channels
- Iterator-based pipelines
- Timely dataflow
- Hydroflow implementations

#### Graph Reachability

```bash
cargo bench --bench reachability
```

Tests graph reachability algorithms using differential-dataflow, comparing:
- Standard HashSet-based iterative algorithm
- Differential-dataflow implementation
- Hydroflow recursive implementation

#### Fan-In and Fan-Out Patterns

```bash
cargo bench --bench fan_in
cargo bench --bench fan_out
```

These test stream merging and splitting patterns common in dataflow systems.

## Understanding Results

### Criterion Output

Criterion generates detailed HTML reports in `target/criterion/`. Each benchmark produces:

- **Time measurements**: Mean execution time with confidence intervals
- **Throughput**: Operations per second where applicable
- **Regression analysis**: Detects performance regressions across runs
- **Comparison plots**: Visual comparisons between different implementations

### Key Metrics

- **Time**: Lower is better
- **Throughput**: Higher is better
- **Variance**: Lower variance indicates more consistent performance

### Example Output

```
arithmetic/timely       time:   [245.67 ms 247.23 ms 248.91 ms]
                        thrpt:  [4.0170 Melem/s 4.0441 Melem/s 4.0696 Melem/s]
```

This shows:
- Mean time: 247.23 ms (with confidence interval)
- Throughput: ~4 million elements per second

## Benchmark Descriptions

### Arithmetic (`arithmetic.rs`)

Tests a chain of 20 addition operations on 1 million integers. Compares:

1. **pipeline**: Multi-threaded channel-based pipeline
2. **raw**: Simple vector-based processing (theoretical minimum)
3. **iter**: Rust iterator chains
4. **iter-collect**: Iterator with intermediate collections
5. **dfir_rs/compiled**: Compiled Hydroflow pipeline
6. **dfir_rs/surface**: Hydroflow surface syntax
7. **timely**: Timely dataflow implementation

### Fan-In (`fan_in.rs`)

Tests merging multiple input streams into a single output stream. Evaluates:
- Stream synchronization overhead
- Merge performance with different numbers of input streams

### Fan-Out (`fan_out.rs`)

Tests splitting a single stream into multiple output streams. Evaluates:
- Broadcasting efficiency
- Fan-out scaling characteristics

### Fork-Join (`fork_join.rs`)

Tests parallel processing patterns where data is:
1. Split into multiple paths
2. Processed independently
3. Merged back together

### Identity (`identity.rs`)

Minimal overhead benchmark that passes data through the dataflow system with no transformations. Measures:
- Base system overhead
- Data transfer costs
- Pipeline coordination overhead

### Join (`join.rs`)

Tests stream join operations, a fundamental operation in dataflow systems. Compares:
- Hash-based joins
- Nested-loop joins
- Optimized dataflow joins

### Reachability (`reachability.rs`)

Graph algorithm benchmark using differential-dataflow. Tests:
- Iterative computation
- Incremental computation
- Graph traversal performance

Uses real graph data from included text files.

### Upcase (`upcase.rs`)

String transformation benchmark testing:
- String processing in dataflow systems
- Memory allocation patterns
- Transformation pipeline performance

## Performance Comparison Tips

### Establishing Baselines

Before making changes:

```bash
# Save current performance as baseline
cargo bench -- --save-baseline main-branch

# After changes, compare
cargo bench -- --baseline main-branch
```

### Isolating System Noise

For more consistent results:

1. Close unnecessary applications
2. Disable CPU frequency scaling if possible
3. Run multiple times and look at the median results
4. Use `--warm-up-time` and `--measurement-time` flags for longer runs

```bash
cargo bench -- --warm-up-time 10 --measurement-time 30
```

### Comparing Across Machines

When comparing results from different machines, focus on:
- Relative performance between implementations (not absolute times)
- Throughput ratios rather than raw numbers
- Scaling behavior rather than absolute performance

## Adding New Benchmarks

### Structure

Create a new file in `benches/` following this pattern:

```rust
use criterion::{Criterion, criterion_group, criterion_main, black_box};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

fn benchmark_name(c: &mut Criterion) {
    c.bench_function("category/name", |b| {
        b.iter(|| {
            // Benchmark code here
            black_box(result); // Prevent optimization
        });
    });
}

criterion_group!(benches, benchmark_name);
criterion_main!(benches);
```

### Register the Benchmark

Add to `Cargo.toml`:

```toml
[[bench]]
name = "your_benchmark"
harness = false
```

### Best Practices

1. **Use `black_box()`**: Prevents compiler from optimizing away your benchmark
2. **Realistic data sizes**: Use data sizes representative of real workloads
3. **Multiple implementations**: Compare against baseline implementations
4. **Document parameters**: Clearly document any constants or parameters
5. **Include warmup**: Allow for JIT compilation and cache warmup

## Troubleshooting

### Benchmark Fails to Compile

Ensure:
- Main repository is in the correct location (sibling directory)
- All dependencies are up to date: `cargo update`
- Rust toolchain is recent enough

### Inconsistent Results

- Check system load: `top` or `htop`
- Increase sample size: `-- --sample-size 100`
- Increase measurement time: `-- --measurement-time 60`

### Out of Memory

Some benchmarks use large datasets. If you encounter OOM errors:
- Close other applications
- Reduce data size constants in benchmark files
- Run benchmarks individually rather than all at once

## Integration with CI/CD

These benchmarks can be integrated into continuous integration:

```bash
# Quick validation (shorter run)
cargo bench --no-fail-fast -- --quick

# Full benchmark suite with comparison
cargo bench -- --save-baseline $(git rev-parse HEAD)
```

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)
- Main repository: `bigweaver-agent-canary-hydro-zeta`
