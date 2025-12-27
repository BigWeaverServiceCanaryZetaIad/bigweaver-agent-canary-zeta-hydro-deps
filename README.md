# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for performance comparison testing of the Hydro project with timely-dataflow and differential-dataflow.

## Purpose

This repository isolates benchmarking dependencies (timely-dataflow and differential-dataflow) from the main Hydro repository to maintain cleaner dependency management. The benchmarks allow performance comparisons between Hydro and other dataflow frameworks.

## Structure

- `benches/` - Microbenchmarks comparing Hydro with timely-dataflow and differential-dataflow
  - `benches/benches/` - Benchmark source files
  - `benches/Cargo.toml` - Benchmark dependencies and configuration
  - `benches/README.md` - Detailed benchmark documentation

## Quick Start

### Running All Benchmarks

From this repository root, run all benchmarks:
```bash
cargo bench -p benches
```

This will execute all benchmark suites and generate HTML reports in `target/criterion/`.

### Running Specific Benchmarks

Run a single benchmark suite:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

Run specific test cases within a benchmark:
```bash
# Run only timely-dataflow reachability tests
cargo bench -p benches --bench reachability -- timely

# Run only Hydro arithmetic tests
cargo bench -p benches --bench arithmetic -- dfir_rs
```

### Viewing Results

Benchmark results are saved in `target/criterion/`:
- Open `target/criterion/report/index.html` in a browser for a comprehensive report
- Individual benchmark reports are in `target/criterion/<benchmark_name>/report/index.html`
- Results include statistical analysis, plots, and historical comparisons

## Available Benchmarks

| Benchmark | Description | Frameworks Compared |
|-----------|-------------|---------------------|
| `arithmetic` | Chain of arithmetic operations (20 sequential add operations) | Raw, Iterator, Timely, Hydro |
| `fan_in` | Multiple inputs merging into a single output | Timely, Hydro |
| `fan_out` | Single input splitting to multiple outputs | Timely, Hydro |
| `fork_join` | Fork-join pattern with filtering | Timely, Hydro |
| `futures` | Async future handling and waker behavior | Hydro |
| `identity` | Simple pass-through operation | Raw, Pipeline, Iterator, Timely, Hydro |
| `join` | Hash join operation with different data types | Timely, Raw (usize and String) |
| `micro_ops` | Individual dataflow operations (map, filter, join, etc.) | Hydro |
| `reachability` | Graph reachability algorithm | Raw, Timely, Differential, Hydro |
| `symmetric_hash_join` | Symmetric hash join with various selectivity | Hydro |
| `upcase` | String transformation operations | Raw, Timely, Differential, Hydro |
| `words_diamond` | Diamond-shaped dataflow pattern on word processing | Raw, Timely, Hydro |

## Dependencies

The benchmarks reference the main Hydro repository for:
- `dfir_rs` - The core Hydro dataflow implementation
- `sinktools` - Utilities for building dataflow sinks

External dependencies:
- `timely` (timely-master v0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1) - Differential dataflow framework
- `criterion` (v0.5.0) - Benchmarking framework with statistical analysis

These are referenced via relative paths to the main repository for Hydro components.

## Performance Comparison

### Implementation Types

The benchmarks include comparisons across multiple implementations:

1. **Raw Rust** - Baseline implementations using standard Rust collections and iterators
   - Provides lower bound on achievable performance
   - No framework overhead

2. **Iterator-based** - Using Rust's iterator combinators
   - Demonstrates zero-cost abstractions
   - Shows compiler optimization capabilities

3. **Timely-dataflow** - Using the Timely dataflow framework
   - Established dataflow framework for comparison
   - Production-tested implementation

4. **Differential-dataflow** - Using incremental computation
   - For benchmarks that benefit from incremental updates
   - Shows performance characteristics for streaming/incremental scenarios

5. **Hydro (dfir_rs)** - The Hydro dataflow implementation
   - **Compiled**: Low-level compiled dataflow graphs
   - **Surface syntax**: High-level declarative syntax (via `dfir_syntax!` macro)

### Interpreting Results

When comparing results:

- **Throughput**: Higher is better - measured in elements/second
- **Latency**: Lower is better - time per operation
- **Relative Performance**: Compare Hydro against Raw (best case) and Timely/Differential (production frameworks)
- **Variance**: Lower variance indicates more consistent performance

#### What to Look For

1. **Overhead Analysis**: Compare Raw → Iterator → Timely → Hydro
   - Shows framework overhead at each abstraction level
   - Hydro should be competitive with Timely

2. **Abstraction Cost**: Compare Hydro compiled vs. surface syntax
   - Surface syntax should have minimal overhead
   - Demonstrates macro efficiency

3. **Scalability**: Run benchmarks with varying data sizes
   - Use `BENCH_NUM_INTS` environment variable if supported
   - Observe how performance scales

### Performance Testing Best Practices

1. **Minimize Background Load**
   ```bash
   # Close unnecessary applications
   # Disable CPU frequency scaling if possible
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```

2. **Run Multiple Times**
   ```bash
   # Criterion automatically runs multiple iterations
   # For custom sample size:
   cargo bench -p benches -- --sample-size 100
   ```

3. **Warm-up Runs**
   ```bash
   # Criterion includes warm-up by default
   # To adjust warm-up time:
   cargo bench -p benches -- --warm-up-time 5
   ```

4. **Compare Against Baseline**
   ```bash
   # Save baseline results
   cargo bench -p benches -- --save-baseline main
   
   # After changes, compare
   cargo bench -p benches -- --baseline main
   ```

5. **Filter by Pattern**
   ```bash
   # Run only reachability benchmarks
   cargo bench -p benches -- reachability
   
   # Run all Hydro-specific benchmarks
   cargo bench -p benches -- dfir_rs
   ```

### Regression Testing

To detect performance regressions:

```bash
# 1. Establish baseline on main branch
git checkout main
cargo bench -p benches -- --save-baseline main

# 2. Switch to feature branch
git checkout feature-branch

# 3. Run benchmarks and compare
cargo bench -p benches -- --baseline main
```

Criterion will flag significant performance changes (default: 5% threshold).

## Advanced Usage

### Profiling

Generate flamegraphs for specific benchmarks:

```bash
# Install flamegraph
cargo install flamegraph

# Profile a specific benchmark
cargo bench -p benches --bench reachability -- --profile-time=5
```

### Custom Criterion Configuration

Edit `benches/Cargo.toml` to modify Criterion features:
- `html_reports` - Generate HTML reports (enabled by default)
- `async_tokio` - Support for async benchmarks (enabled by default)

### Environment Variables

Some benchmarks support configuration via environment variables:
- Check individual benchmark source files for supported variables
- Common pattern: `NUM_INTS`, `NUM_OPS` for adjusting workload size

## Troubleshooting

### Build Errors

If you encounter build errors:

1. Ensure the main Hydro repository is checked out at the correct relative path:
   ```bash
   ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
   ```

2. Update dependencies:
   ```bash
   cargo update -p benches
   ```

3. Clean build artifacts:
   ```bash
   cargo clean
   cargo bench -p benches
   ```

### Performance Issues

If benchmarks run slowly:

1. Use release mode (enabled by default with `cargo bench`)
2. Check CPU governor settings
3. Disable debug features in dfir_rs if enabled
4. Reduce sample size for quick iteration:
   ```bash
   cargo bench -p benches -- --sample-size 10
   ```

### Missing Data Files

Some benchmarks require data files:
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - Word list for word processing benchmarks

These files are included in the repository and embedded at compile time using `include_bytes!`.

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Follow the existing pattern:
   - Use Criterion for benchmarking framework
   - Include multiple implementations (raw, timely, hydro)
   - Use meaningful test data sizes
   - Document the benchmark purpose
4. Update this README with benchmark description

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://hydro.run/)
