# Benchmark Implementations

This directory contains the actual benchmark implementations comparing DFIR/Hydro with Timely and Differential Dataflow.

## Benchmark Files

### Stream Processing

- **`arithmetic.rs`**: Pipeline of arithmetic operations (20 sequential +1 operations)
  - Tests: Operator fusion and pipeline efficiency
  - Compares: Timely, DFIR, raw iterators, channels

- **`identity.rs`**: Passthrough operations with no transformation
  - Tests: Minimum framework overhead
  - Compares: Timely, DFIR, raw copy operations

- **`upcase.rs`**: String uppercase transformation
  - Tests: Non-numeric data processing
  - Compares: Timely, DFIR, string operations

### Communication Patterns

- **`fan_in.rs`**: Multiple input streams merging into one
  - Tests: Merge/union efficiency
  - Compares: Timely, DFIR

- **`fan_out.rs`**: Broadcasting one stream to multiple outputs
  - Tests: Tee/broadcast efficiency
  - Compares: Timely, DFIR

- **`fork_join.rs`**: Split computation and rejoin pattern
  - Tests: Parallelism and synchronization
  - Compares: Timely, DFIR

### Stateful Operations

- **`join.rs`**: Stream join operations
  - Tests: State management and join performance
  - Compares: Timely, DFIR
  - Variations: Different join cardinalities

- **`symmetric_hash_join.rs`**: Hash-based symmetric join
  - Tests: Alternative join implementation
  - Compares: Different join strategies

### Incremental Computation

- **`reachability.rs`**: Graph reachability computation
  - Tests: Incremental computation capabilities
  - Compares: Differential Dataflow, DFIR
  - Data: 14,855 edges from real graph
  - **Key benchmark**: Shows incremental vs. batch trade-offs

### Complex Patterns

- **`words_diamond.rs`**: Diamond-shaped dataflow pattern
  - Tests: Complex dataflow with multiple paths
  - Data: 370K word dictionary
  - Compares: Pattern composition efficiency

### Micro-benchmarks

- **`micro_ops.rs`**: Micro-benchmark of basic operations
  - Tests: Individual operator performance
  - Purpose: Detailed performance profiling

- **`futures.rs`**: Async/futures-based operations
  - Tests: Async runtime integration
  - Compares: Futures performance

## Test Data Files

- **`words_alpha.txt`**: 370,103 English words
  - Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
  - Used by: `words_diamond.rs`, `upcase.rs`

- **`reachability_edges.txt`**: Graph edge list (14,855 edges)
  - Format: `source target` pairs
  - Used by: `reachability.rs`

- **`reachability_reachable.txt`**: Expected reachable nodes
  - Format: Node IDs, one per line
  - Used by: `reachability.rs` for validation

## Running Benchmarks

### Individual Benchmarks

```bash
# Run specific benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
```

### Quick Mode

For faster iteration during development:
```bash
cargo bench --bench arithmetic -- --quick
```

### Filtering

Run subsets of benchmarks:
```bash
# Only timely benchmarks in a file
cargo bench --bench arithmetic -- timely

# Only differential benchmarks
cargo bench --bench reachability -- differential

# Only DFIR benchmarks
cargo bench --bench join -- dfir
```

## Implementation Notes

### Commented Out Code

Some benchmarks have commented-out sections marked with:
```rust
// NOTE: This benchmark uses pusherator which was removed from the main repo.
```

These used an internal API (`pusherator`) that was later replaced with `sinktools` in the main repository. They're preserved for reference but not actively maintained in this benchmark repository, which focuses on external framework comparisons.

### Framework Versions

The benchmarks use:
- **Timely**: `timely-master` 0.13.0-dev.1
- **Differential**: `differential-dataflow-master` 0.13.0-dev.1
- **DFIR/Hydro**: Latest from main repository via git dependency

### Benchmark Structure

Each benchmark typically includes:

1. **Baseline implementations**: Raw Rust, iterators, channels
2. **Framework implementations**: Timely, Differential, DFIR
3. **Variations**: Different sizes, patterns, optimizations
4. **Criterion groups**: Organized by test category

Example structure:
```rust
fn benchmark_baseline(c: &mut Criterion) { /* ... */ }
fn benchmark_timely(c: &mut Criterion) { /* ... */ }
fn benchmark_dfir(c: &mut Criterion) { /* ... */ }

criterion_group!(
    my_benchmark,
    benchmark_baseline,
    benchmark_timely,
    benchmark_dfir,
);
criterion_main!(my_benchmark);
```

## Adding New Benchmarks

When adding a new benchmark to this directory:

1. **Follow the naming convention**: `descriptive_name.rs`
2. **Include multiple frameworks**: At least Timely or Differential + DFIR
3. **Add baselines**: Raw Rust for context
4. **Document in this README**: Add to the appropriate section above
5. **Register in Cargo.toml**: Add `[[bench]]` section
6. **Update main README**: Add high-level description

See [../CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines.

## Troubleshooting

### Compilation Issues

If a benchmark fails to compile:
1. Check that dependencies are up to date: `cargo update`
2. Verify git dependencies are accessible
3. Check for API changes in DFIR/Hydro

### Inconsistent Results

If results vary significantly:
1. Close other applications
2. Run multiple times (Criterion averages)
3. Check for thermal throttling
4. Consider CPU frequency scaling settings

### Missing Data Files

If benchmarks fail due to missing data:
1. Ensure data files are present in `benches/` directory
2. Check file permissions
3. Verify working directory is repository root

## Performance Tips

### For Accurate Measurements

- **Use release mode**: `cargo bench` uses release profile automatically
- **Disable frequency scaling**: Prevents CPU throttling
- **Close applications**: Reduce system noise
- **Run multiple times**: Establish consistency
- **Use `black_box()`**: Prevent unwanted optimizations

### For Faster Iteration

- **Quick mode**: `cargo bench -- --quick`
- **Filter tests**: `cargo bench -- pattern`
- **Single benchmark**: `cargo bench --bench name`
- **Build only**: `cargo build --benches --release`

## References

- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Timely Documentation](https://docs.rs/timely/)
- [Differential Dataflow Documentation](https://docs.rs/differential-dataflow/)
- [DFIR/Hydro Documentation](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Questions?

For benchmark-specific questions, see:
- [../PERFORMANCE_COMPARISON.md](../PERFORMANCE_COMPARISON.md) - Methodology
- [../README.md](../README.md) - General documentation
- [../CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines
