# Timely and Differential-Dataflow Benchmarks

This directory contains performance benchmarks that compare DFIR/Hydro implementations with timely-dataflow and differential-dataflow. These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid adding timely and differential-dataflow as dependencies to the core codebase.

## Purpose

These benchmarks enable performance comparisons between:
- **DFIR/Hydro**: The core dataflow runtime in the main repository
- **Timely Dataflow**: A low-latency data-parallel dataflow system
- **Differential Dataflow**: An incremental data-parallel dataflow system built on Timely

## Available Benchmarks

### Arithmetic Operations (`arithmetic.rs`)
Compares arithmetic operation performance across different implementations:
- Pipeline-based implementation
- Raw copy implementation (baseline)
- DFIR implementation
- Timely dataflow implementation

### Fan-In Pattern (`fan_in.rs`)
Tests the performance of fan-in patterns where multiple data streams are merged into one.

### Fan-Out Pattern (`fan_out.rs`)
Tests the performance of fan-out patterns where a single data stream is split into multiple outputs.

### Fork-Join Pattern (`fork_join.rs`)
Evaluates fork-join patterns commonly used in parallel processing:
- Data is split (forked) into multiple processing paths
- Results are recombined (joined) at the end

### Identity/Passthrough (`identity.rs`)
Baseline benchmarks for data passthrough with minimal transformations. Useful for measuring framework overhead.

### Join Operations (`join.rs`)
Compares the performance of join operations across different implementations.

### Graph Reachability (`reachability.rs`)
Tests graph reachability algorithms using:
- `reachability_edges.txt`: Graph edge data (521KB)
- `reachability_reachable.txt`: Expected reachability results (38KB)

### String Uppercase (`upcase.rs`)
Benchmarks string transformation operations (uppercase conversion) across different frameworks.

## Running the Benchmarks

### Prerequisites

1. Ensure you have Rust installed (the version specified in `rust-toolchain.toml`)
2. The benchmarks will automatically fetch the required dependencies

### Run All Benchmarks

```bash
cargo bench
```

### Run a Specific Benchmark

```bash
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

### Run with Specific Filters

To run only certain tests within a benchmark:

```bash
cargo bench --bench arithmetic -- <filter>
```

For example, to run only DFIR-related tests in arithmetic:

```bash
cargo bench --bench arithmetic -- dfir
```

## Understanding Results

Benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) which provides:
- **Statistical analysis**: Mean, median, standard deviation
- **Outlier detection**: Identifies anomalous measurements
- **Regression detection**: Warns if performance degrades
- **HTML reports**: Located in `target/criterion/`

After running benchmarks, open `target/criterion/report/index.html` in a browser to view detailed results.

## Performance Comparison Workflow

To compare DFIR/Hydro performance with Timely/Differential:

1. **Run benchmarks in this repository** to get timely/differential metrics:
   ```bash
   cargo bench
   ```

2. **Run benchmarks in the main repository** for DFIR-only tests:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Compare results** by examining the Criterion reports in both repositories

4. **Analyze differences**:
   - Look for performance gaps between implementations
   - Identify which patterns favor which framework
   - Understand overhead differences

## Benchmark Configuration

### Constants
Most benchmarks define constants that can be adjusted:
- `NUM_OPS`: Number of operations in a pipeline
- `NUM_INTS`: Number of integers processed

### Build Configuration
The `build.rs` script generates code for certain benchmarks (e.g., `fork_join`) to avoid repetitive manual coding.

## Adding New Benchmarks

To add a new benchmark:

1. Create a new file in `benches/` (e.g., `my_benchmark.rs`)
2. Implement using the Criterion framework:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_test", |b| {
           b.iter(|| {
               // Your benchmark code
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```
3. Add a `[[bench]]` entry to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
4. Update this README with documentation for the new benchmark

## Dependencies

This benchmark suite includes:
- **timely**: Low-latency dataflow system
- **differential-dataflow**: Incremental dataflow computations
- **dfir_rs**: DFIR runtime for comparison
- **criterion**: Benchmarking framework with statistical analysis
- **tokio**: Async runtime for async benchmarks

## Relationship with Main Repository

These benchmarks were moved from `bigweaver-agent-canary-hydro-zeta` to maintain clean separation:
- **Main repository**: Core DFIR/Hydro functionality without timely/differential dependencies
- **This repository**: Performance comparison tools with full dependency set

This separation:
- ✅ Reduces main repository build times
- ✅ Prevents dependency conflicts
- ✅ Keeps the main codebase focused on core functionality
- ✅ Enables independent benchmark development

## CI/CD Integration

To integrate these benchmarks into CI/CD:

```yaml
- name: Run Performance Benchmarks
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench --no-fail-fast
```

Results can be archived and tracked over time to detect performance regressions.

## Troubleshooting

### Compilation Errors
If you encounter compilation errors:
1. Ensure `rust-toolchain.toml` specifies the correct Rust version
2. Update dependencies: `cargo update`
3. Clean and rebuild: `cargo clean && cargo build`

### Long Benchmark Times
Some benchmarks process large datasets and may take several minutes. To run faster tests during development:
- Reduce `NUM_INTS` or `NUM_OPS` constants
- Use `--sample-size` flag: `cargo bench -- --sample-size 10`

### Missing Data Files
The `reachability` benchmark requires data files. Ensure:
- `reachability_edges.txt` exists in `benches/`
- `reachability_reachable.txt` exists in `benches/`

## References

- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://github.com/hydro-project/hydro)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
