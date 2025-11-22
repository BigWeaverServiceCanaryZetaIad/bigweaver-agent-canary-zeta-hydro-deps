# Hydro Microbenchmarks

Comparative performance benchmarks for Hydro, Timely Dataflow, and Differential Dataflow.

## Overview

These benchmarks provide performance comparisons between:
- **Hydro** (dfir_rs): The Hydro dataflow system
- **Timely Dataflow**: A low-latency cyclic dataflow system
- **Differential Dataflow**: An incremental data-parallel programming framework

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will run all benchmark suites and generate HTML reports in `target/criterion/`.

### Run Specific Benchmarks

```bash
# Run reachability benchmark only
cargo bench -p benches --bench reachability

# Run arithmetic operations benchmark
cargo bench -p benches --bench arithmetic

# Run with specific number of iterations
cargo bench -p benches --bench identity -- --sample-size 100
```

## Benchmark Descriptions

### arithmetic.rs
Compares arithmetic operations between Hydro and Timely:
- Basic arithmetic computations
- Multiple operation chaining
- Data transformation pipelines

### fan_in.rs
Tests fan-in patterns where multiple streams merge:
- Multiple input streams converging to one
- Union operations
- Data aggregation patterns

### fan_out.rs
Tests fan-out patterns where one stream splits into multiple:
- Stream splitting
- Multiple output destinations
- Broadcast patterns

### fork_join.rs
Tests fork-join parallelism patterns:
- Parallel processing with rejoining
- Work distribution and collection
- Pipeline parallelism

### futures.rs
Benchmarks futures-based asynchronous operations:
- Async/await patterns
- Future composition
- Asynchronous data processing

### identity.rs
Tests the baseline overhead of identity operations:
- Pass-through operations
- Minimal transformation
- Framework overhead measurement

### join.rs
Compares join operation implementations:
- Two-way joins
- Key-based joining
- Join performance characteristics

### micro_ops.rs
Fine-grained micro-operations benchmarks:
- Individual operator performance
- Small-scale operations
- Operator composition overhead

### reachability.rs
Graph reachability algorithm comparison (Hydro vs Timely vs Differential):
- Transitive closure computation
- Iterative graph algorithms
- Fixed-point computation

**Data files:**
- `reachability_edges.txt`: Edge list for the graph
- `reachability_reachable.txt`: Expected reachability results

### symmetric_hash_join.rs
Tests symmetric hash join implementations:
- Dynamic join operations
- Incremental join updates
- Hash-based join strategies

### upcase.rs
String processing benchmark:
- String transformations
- Map operations
- UTF-8 handling performance

### words_diamond.rs
Word processing with diamond dataflow patterns:
- Complex dataflow topologies
- Multiple paths through the graph
- Path convergence

**Data file:**
- `words_alpha.txt`: English word list from https://github.com/dwyl/english-words

## Understanding Results

### Criterion Output

Criterion produces detailed statistical analysis including:

- **Mean execution time**: Average time per iteration
- **Standard deviation**: Variation in execution time
- **Median**: Middle value of execution times
- **MAD (Median Absolute Deviation)**: Robust measure of variability

### HTML Reports

After running benchmarks, view detailed reports at:
```
target/criterion/report/index.html
```

Reports include:
- Performance comparison charts
- Statistical confidence intervals
- Historical performance trends
- Detailed per-benchmark analysis

### Interpreting Comparisons

When comparing frameworks:
- **Lower is better** for execution time
- Look for consistent trends across multiple runs
- Consider whether differences are statistically significant
- Account for different optimization strategies

## Performance Tuning

### Release Mode

Always run benchmarks in release mode (this is automatic with `cargo bench`):
```bash
cargo bench -p benches
```

### CPU Affinity

For more consistent results, pin to specific CPU cores:
```bash
taskset -c 0-3 cargo bench -p benches
```

### Sample Size

Adjust the number of samples for more accurate results:
```bash
cargo bench -p benches -- --sample-size 200
```

### Warm-up

Criterion automatically performs warm-up iterations, but you can adjust:
```bash
cargo bench -p benches -- --warm-up-time 5
```

## Adding New Benchmarks

To add a new benchmark:

1. **Create the benchmark file** in `benches/`:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_test", |b| {
           b.iter(|| {
               // Your benchmark code here
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

2. **Register in Cargo.toml**:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. **Follow existing patterns**:
   - Compare multiple implementations when relevant
   - Include setup and teardown properly
   - Use meaningful test data sizes
   - Document what is being measured

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Check paths**: Ensure `dfir_rs` and `sinktools` paths are correct
2. **Update dependencies**: Run `cargo update`
3. **Clean build**: Try `cargo clean && cargo build`

### Performance Anomalies

If results seem unexpected:

1. **System load**: Ensure system isn't under heavy load
2. **Power settings**: Use high-performance power mode
3. **Background processes**: Close unnecessary applications
4. **Thermal throttling**: Check CPU temperatures

### Missing Data Files

Some benchmarks require data files:
- `reachability_edges.txt`
- `reachability_reachable.txt`
- `words_alpha.txt`

These should be present in the `benches/` directory.

## Best Practices

1. **Consistent Environment**: Run benchmarks on the same machine with similar load
2. **Multiple Runs**: Run benchmarks several times to verify consistency
3. **Version Control**: Track benchmark results over time
4. **Document Changes**: Note any significant performance changes
5. **Compare Fairly**: Ensure implementations are comparable in functionality

## CI/CD Integration

These benchmarks can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions snippet
- name: Run benchmarks
  run: cargo bench -p benches --no-fail-fast
```

Consider:
- Running on dedicated benchmark infrastructure
- Storing historical results for trend analysis
- Setting performance regression thresholds
- Generating comparison reports

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://hydro-project.github.io/)
