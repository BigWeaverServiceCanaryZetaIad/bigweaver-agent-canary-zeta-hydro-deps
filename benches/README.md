# Benchmarks: Comparing Timely, Differential, and Hydroflow

This directory contains microbenchmarks for comparing performance across different dataflow implementations:
- **Timely Dataflow**: Low-latency streaming dataflow
- **Differential Dataflow**: Incremental computation on Timely
- **Hydroflow/dfir_rs**: Hydro project's dataflow runtime

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmarks
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
cargo bench -p benches --bench fork_join
```

### Filter by Implementation
```bash
# Run only Hydroflow (dfir) benchmarks
cargo bench -p benches -- dfir

# Run only Timely benchmarks
cargo bench -p benches -- timely

# Run only Differential benchmarks
cargo bench -p benches -- differential

# Run micro-operation benchmarks
cargo bench -p benches -- micro/ops/
```

### Quick vs Full Benchmarks

Some benchmarks support both quick and full modes:
```bash
# Quick mode (faster, less comprehensive)
cargo bench -p benches --bench identity -- --quick

# Full mode (comprehensive, slower)
cargo bench -p benches --bench identity
```

## Benchmark Descriptions

### Core Dataflow Patterns

#### **arithmetic.rs**
Tests arithmetic operations and computations across dataflow systems.
- Addition, multiplication, and other numeric operations
- Data transformation pipelines
- Useful for understanding computational overhead

#### **identity.rs**
Pass-through operations that measure baseline performance.
- Minimal transformation overhead
- Baseline for comparing other benchmarks
- Tests raw throughput capabilities

#### **fan_in.rs**
Multiple data sources converging to a single output.
- Union operations
- Multiple input streams merging
- Tests multiplexing performance

#### **fan_out.rs**
Single data source splitting to multiple outputs.
- Tee operations
- Broadcasting data
- Tests demultiplexing and cloning performance

#### **fork_join.rs**
Parallel execution patterns with synchronization.
- Parallel branches that rejoin
- Tests parallelism and synchronization overhead
- Generated code (see `build.rs`)

### Data Operations

#### **join.rs**
Join operations on data streams.
- Inner joins
- Stream joining patterns
- Tests state management and lookup performance

#### **symmetric_hash_join.rs**
Specialized symmetric hash join implementations.
- Hash-based joining
- Bidirectional join operations
- Compares different join strategies

#### **reachability.rs**
Graph reachability algorithms.
- Transitive closure computations
- Iterative graph algorithms
- Uses real graph data (`reachability_edges.txt`, `reachability_reachable.txt`)
- Tests iterative and incremental computation

### String Processing

#### **upcase.rs**
String transformation operations.
- Case conversion (uppercase)
- String manipulation overhead
- Tests data transformation performance

#### **words_diamond.rs**
Diamond-shaped dataflow pattern on word processing.
- Complex dataflow topology
- Multiple paths that reconverge
- Uses word list from `words_alpha.txt`
- Tests complex routing and synchronization

### Async Operations

#### **futures.rs**
Asynchronous operations and futures.
- Async/await patterns in dataflows
- Integration with Tokio runtime
- Tests async overhead

### Micro-benchmarks

#### **micro_ops.rs**
Fine-grained operation benchmarks.
- Individual operation performance
- Low-level primitives
- Useful for identifying bottlenecks

## Benchmark Data Files

The benchmark directory includes several data files:

- **`words_alpha.txt`**: 370K+ English words for string processing benchmarks
  - Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
  
- **`reachability_edges.txt`**: Graph edge data for reachability benchmarks
  - Real-world graph structure
  
- **`reachability_reachable.txt`**: Expected reachability results
  - Used for verification

- **`.gitignore`**: Excludes generated files from version control

## Understanding Results

### Criterion Output

Benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) which provides:

- **Statistical analysis**: Mean, median, standard deviation
- **Regression detection**: Warns about performance degradation
- **Comparison**: Compares implementations against each other
- **HTML reports**: Visual performance analysis

### Result Location

After running benchmarks, results are available in:
```
target/criterion/
```

View the report:
```bash
# Open in browser
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

### Interpreting Comparisons

When comparing implementations, look for:
- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Scalability**: Performance with increasing data sizes
- **Memory usage**: Criterion doesn't measure this directly, but can be profiled separately

## Performance Tips

### For Accurate Results

1. **Close unnecessary applications** to reduce system noise
2. **Run multiple times** to account for variance
3. **Use release builds** (benchmarks automatically use release mode)
4. **Avoid running on battery** (laptop performance varies)
5. **Check for thermal throttling** during long benchmark runs

### Profiling

For deeper analysis:
```bash
# Run with profiling
cargo bench -p benches --bench identity -- --profile-time=5

# Use perf (Linux)
cargo bench -p benches --no-run
perf record target/release/deps/identity-*
perf report
```

## Generated Code

Some benchmarks use code generation:

- **fork_join**: Generated by `build.rs`
  - Creates `fork_join_20.hf` with 20 operations
  - Customizable via `NUM_OPS` constant
  - Demonstrates scaling with complexity

## Implementation Notes

### Benchmark Structure

Each benchmark typically includes:
1. **Setup**: Data generation and configuration
2. **Implementations**: Code for each dataflow system
3. **Criterion groups**: Organized comparisons
4. **Assertions**: Verify correctness

### Naming Conventions

- **dfir/spinachflow**: Refers to Hydroflow/dfir_rs
- **timely**: Timely Dataflow implementation
- **differential**: Differential Dataflow implementation
- **SOL (Speed of Light)**: Theoretical optimal performance baseline

### Dependencies

Benchmarks depend on:
- `criterion`: Benchmarking framework
- `dfir_rs`: Hydroflow runtime (via git)
- `timely-master`: Timely Dataflow
- `differential-dataflow-master`: Differential Dataflow
- `sinktools`: Utilities (via git)
- `tokio`: Async runtime
- `rand`: Random data generation

## Adding New Benchmarks

To add a new benchmark:

1. **Create the benchmark file**:
   ```bash
   touch benches/my_benchmark.rs
   ```

2. **Add to Cargo.toml**:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. **Implement comparisons**:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn bench_my_feature(c: &mut Criterion) {
       // Timely implementation
       c.bench_function("timely/my_feature", |b| {
           // ...
       });
       
       // Differential implementation
       c.bench_function("differential/my_feature", |b| {
           // ...
       });
       
       // Hydroflow implementation
       c.bench_function("dfir/my_feature", |b| {
           // ...
       });
   }
   
   criterion_group!(benches, bench_my_feature);
   criterion_main!(benches);
   ```

4. **Document the benchmark** in this README

5. **Test it**:
   ```bash
   cargo bench -p benches --bench my_benchmark
   ```

## Troubleshooting

### Common Issues

**Issue**: Benchmark takes too long
- **Solution**: Use `--quick` flag or reduce iteration counts

**Issue**: Results are noisy/inconsistent
- **Solution**: Close other applications, run multiple times, check system load

**Issue**: Compilation errors
- **Solution**: Ensure dependencies are available, check `Cargo.lock`

**Issue**: Git dependency failures
- **Solution**: Check network connection, verify repository URLs

## CI/CD Integration

These benchmarks are integrated with CI/CD:
- Automatic execution on schedule
- Performance tracking over time
- Results published to GitHub Pages
- Alerts on performance regressions

See `.github/workflows/benchmark.yml` for configuration.

## Contributing

When contributing benchmarks:
1. Ensure all implementations produce equivalent results
2. Add assertions to verify correctness
3. Document what the benchmark measures
4. Include both quick and comprehensive modes where appropriate
5. Update this README with your benchmark description

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow Documentation](https://hydro.run/)

## License

Apache-2.0
