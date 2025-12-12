# Microbenchmarks

Comprehensive benchmarks comparing Hydro/DFIR performance with timely-dataflow and differential-dataflow.

## Quick Start

### Run All Benchmarks

```bash
cargo bench -p hydro-timely-benchmarks
```

### Run Specific Benchmarks

```bash
# Individual benchmark suites
cargo bench -p hydro-timely-benchmarks --bench reachability
cargo bench -p hydro-timely-benchmarks --bench arithmetic
cargo bench -p hydro-timely-benchmarks --bench join
```

## Benchmark Suites

### Performance Comparison Benchmarks

#### arithmetic.rs
Tests numerical computation performance including:
- Basic arithmetic operations (add, multiply, etc.)
- Aggregations (sum, count, average)
- Comparison operations

**Frameworks tested**: DFIR, Timely, Differential

**Key metrics**: Operations per second, latency

#### identity.rs
Baseline benchmark measuring framework overhead:
- Pass-through operations (input → output without transformation)
- Minimal computational work
- Framework dispatch overhead

**Use case**: Establishing baseline performance for other benchmarks

#### upcase.rs
String transformation benchmark:
- Uppercase conversion operations
- String processing pipeline
- Memory allocation patterns

**Data source**: English word list (words_alpha.txt)

### Data Flow Pattern Benchmarks

#### fan_in.rs
Multiple input sources converging to single output:
- N input streams → 1 output stream
- Synchronization overhead
- Merge operation performance

**Pattern**:
```
Input 1 ──┐
Input 2 ──┼──> Output
Input 3 ──┘
```

#### fan_out.rs
Single input distributed to multiple outputs:
- 1 input stream → N output streams
- Broadcasting overhead
- Parallel output performance

**Pattern**:
```
           ┌──> Output 1
Input ─────┼──> Output 2
           └──> Output 3
```

#### fork_join.rs
Parallel processing with synchronization:
- Split work across parallel branches
- Process independently
- Join results together

**Pattern**:
```
       ┌──> Process A ──┐
Input ─┤               ├──> Output
       └──> Process B ──┘
```

### Join Operation Benchmarks

#### join.rs
Standard equi-join operations:
- Hash-based joins
- Memory usage patterns
- Scaling with input size

**Join types**: Inner join, left join variations

**Metrics**: Join throughput, memory consumption

#### symmetric_hash_join.rs
Specialized symmetric hash join implementation:
- Both inputs treated symmetrically
- Optimized for streaming data
- State management comparison

**Use case**: Real-time stream joining

### Graph Algorithm Benchmarks

#### reachability.rs
Graph traversal and reachability analysis:
- Transitive closure computation
- Iterative dataflow
- Fixed-point computation

**Input data**:
- `reachability_edges.txt`: Graph edge list
- `reachability_reachable.txt`: Expected reachable nodes

**Algorithm**: Iteratively compute nodes reachable from source nodes

**Metrics**: Iterations to convergence, total computation time

### Complex Workflow Benchmarks

#### words_diamond.rs
Diamond-shaped dataflow pattern with text processing:
- Multiple transformation paths
- Path convergence
- String manipulation at scale

**Data source**: `words_alpha.txt` (English word dictionary)

**Pattern**: 
```
       ┌──> Transform A ──┐
Input ─┤                  ├──> Output
       └──> Transform B ──┘
```

#### futures.rs
Asynchronous operation handling:
- Future/Promise patterns
- Async execution overhead
- Tokio runtime integration

**Frameworks tested**: DFIR with async, Timely async patterns

#### micro_ops.rs
Fine-grained micro-operation benchmarks:
- Individual operator performance
- Minimal data processing
- Operator dispatch overhead

**Operations tested**: Map, filter, flat_map, fold, etc.

## Data Files

### words_alpha.txt
English word dictionary for text processing benchmarks.

**Source**: https://github.com/dwyl/english-words/blob/master/words_alpha.txt

**Size**: ~370,000 words

**Usage**: 
- `upcase.rs`: String transformation
- `words_diamond.rs`: Complex text workflows

### reachability_edges.txt
Graph edge list for reachability benchmarks.

**Format**: Space-separated pairs representing directed edges
```
node1 node2
node3 node4
```

### reachability_reachable.txt
Expected reachable nodes for validation.

**Format**: List of node IDs
```
node1
node2
```

## Understanding Results

### Criterion.rs Output

Benchmarks use [Criterion.rs](https://bheisler.github.io/criterion.rs/book/) which provides:

1. **Statistical Analysis**
   - Mean execution time
   - Standard deviation
   - Outlier detection
   - Confidence intervals

2. **Comparison Across Runs**
   - Performance changes from previous runs
   - Regression detection
   - Visual plots

3. **HTML Reports**
   - Generated in `target/criterion/`
   - Interactive plots
   - Detailed statistics

### Interpreting Comparisons

**Relative Performance**:
- 1.00x = Equal performance
- 0.50x = 2x faster
- 2.00x = 2x slower

**Statistical Significance**:
- Look for non-overlapping confidence intervals
- Higher sample sizes = more reliable results
- Watch for high standard deviations (unstable results)

## Customizing Benchmarks

### Adjusting Input Sizes

Most benchmarks accept input size parameters. Edit the benchmark source:

```rust
// Example from arithmetic.rs
fn bench_addition(c: &mut Criterion) {
    let input_size = 10_000; // Adjust this
    // ... benchmark code
}
```

### Adding New Frameworks

To add a new framework comparison:

1. Add dependency to `Cargo.toml`
2. Implement the benchmark operation in the new framework
3. Add to the benchmark group:
   ```rust
   group.bench_function("new_framework", |b| {
       // benchmark implementation
   });
   ```

### Tuning Measurement Parameters

Criterion allows customization:

```rust
let mut group = c.benchmark_group("my_benchmark");
group.sample_size(100);           // Number of iterations
group.measurement_time(Duration::from_secs(10)); // Time per benchmark
group.warm_up_time(Duration::from_secs(3));      // Warm-up duration
```

## Performance Tips

### For Accurate Measurements

1. **System Preparation**
   - Close unnecessary applications
   - Disable CPU frequency scaling
   - Run on consistent hardware

2. **Multiple Runs**
   ```bash
   # Run benchmarks multiple times
   for i in {1..5}; do
       cargo bench -p hydro-timely-benchmarks
   done
   ```

3. **Baseline Establishment**
   ```bash
   # Save baseline for comparison
   cargo bench -p hydro-timely-benchmarks -- --save-baseline baseline-name
   
   # Compare against baseline
   cargo bench -p hydro-timely-benchmarks -- --baseline baseline-name
   ```

### Understanding Variance

**High variance causes**:
- Background processes
- Thermal throttling
- Memory pressure
- Non-deterministic algorithms

**Mitigation strategies**:
- Increase sample size
- Run benchmarks overnight (quieter system)
- Use dedicated benchmark machines
- Check system monitoring during runs

## Continuous Integration

### Running in CI

Example CI configuration:

```yaml
- name: Run benchmarks
  run: |
    cargo bench -p hydro-timely-benchmarks --no-fail-fast
    
- name: Archive benchmark results
  uses: actions/upload-artifact@v2
  with:
    name: criterion-results
    path: target/criterion/
```

### Benchmark Regression Detection

Compare against baseline:

```bash
# In CI or locally
cargo bench -p hydro-timely-benchmarks -- --baseline main
```

If performance regresses significantly, CI can fail the build.

## Troubleshooting

### Common Issues

**Issue**: "Benchmark functions must accept a `&mut Criterion`"

**Solution**: Ensure benchmark functions have correct signature:
```rust
fn my_bench(c: &mut Criterion) {
    // ...
}
```

---

**Issue**: "Could not find file: words_alpha.txt"

**Solution**: Ensure data files are in `benches/benches/` directory alongside source files.

---

**Issue**: Benchmarks take extremely long

**Solution**: Reduce input sizes or sample counts in the source code.

---

**Issue**: Memory errors during benchmarks

**Solution**: 
- Reduce input sizes
- Check for memory leaks in benchmark code
- Increase system swap space

### Debug Mode

Run benchmarks with debug output:

```bash
RUST_LOG=debug cargo bench -p hydro-timely-benchmarks --bench reachability
```

### Profiling Benchmarks

For deeper analysis:

```bash
# With perf (Linux)
cargo bench -p hydro-timely-benchmarks --bench reachability -- --profile-time=5

# With flamegraph
cargo flamegraph --bench reachability -p hydro-timely-benchmarks
```

## Contributing New Benchmarks

When adding benchmarks:

1. **Name clearly**: Use descriptive names indicating what's measured
2. **Document inputs**: Specify input data sources and sizes
3. **Test all frameworks**: Ensure DFIR, Timely, and Differential variants
4. **Validate correctness**: Assert outputs match across frameworks
5. **Choose appropriate sizes**: Balance between accuracy and runtime
6. **Add to this README**: Document the new benchmark

## Further Reading

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)

## Questions?

For questions about benchmarks or results, open an issue in this repository.
