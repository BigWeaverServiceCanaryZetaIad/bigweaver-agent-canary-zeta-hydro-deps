# Timely and Differential Dataflow Benchmarks

This package contains benchmarks that compare the performance of different dataflow implementations:
- **timely-dataflow**: Low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation based on timely-dataflow
- **dfir_rs**: DFIR (Dataflow IR) implementation from the main Hydro repository

## Migrated Benchmarks

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
1. Reduce dependencies in the main codebase
2. Improve build times by avoiding timely/differential compilation in the main repo
3. Maintain the ability to run performance comparisons

### Available Benchmarks

#### Timely-Dataflow Benchmarks
- **arithmetic.rs** - Pipeline arithmetic operations benchmark
  - Compares channel-based pipeline, raw vector operations, timely dataflow, and DFIR implementations
  - Tests performance of simple arithmetic operations across a pipeline of transformations

- **fan_in.rs** - Fan-in operation benchmark
  - Tests merging multiple input streams into a single output stream
  - Compares timely and DFIR implementations

- **fan_out.rs** - Fan-out operation benchmark
  - Tests broadcasting data to multiple consumers
  - Compares timely and DFIR implementations

- **fork_join.rs** - Fork-join pattern benchmark
  - Tests splitting computation paths and rejoining results
  - DFIR-focused benchmark

- **identity.rs** - Identity operation pipeline benchmark
  - Tests pure data movement without transformation
  - Compares timely and DFIR implementations

- **upcase.rs** - String uppercase operation benchmark
  - Tests string transformation operations
  - Timely-focused benchmark

- **join.rs** - Join operation benchmark
  - Tests relational join operations
  - Timely-focused benchmark

#### Differential-Dataflow Benchmarks
- **reachability.rs** - Graph reachability benchmark
  - Tests iterative graph algorithms
  - Compares differential-dataflow and DFIR implementations
  - Uses data files: `reachability_edges.txt`, `reachability_reachable.txt`

## Setup

### Prerequisites
- Rust (see `rust-toolchain.toml` in the main Hydro repository)
- Cargo

### Configuration

The benchmarks depend on `dfir_rs` and `sinktools` from the main Hydro repository. You can configure this in two ways:

#### Option 1: Local Path Dependencies (Recommended for Development)

If you have both repositories cloned side-by-side:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

Edit `Cargo.toml` and uncomment the path dependencies:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

And comment out the git dependencies:
```toml
# dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
# sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

#### Option 2: Git Dependencies (Default)

The default configuration uses git dependencies, which works out of the box but may be slower for iterative development.

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmarks
```bash
# Timely benchmarks
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench upcase
cargo bench --bench join

# Differential benchmark
cargo bench --bench reachability
```

### Run a Specific Benchmark Function
```bash
cargo bench --bench arithmetic -- "arithmetic/pipeline"
cargo bench --bench reachability -- "reachability/differential"
```

## Benchmark Results

Results are saved to `target/criterion/` with HTML reports that can be viewed in a browser.

## Understanding the Benchmarks

Each benchmark typically includes multiple implementations:
1. **Baseline**: Raw Rust implementation using channels, threads, or basic data structures
2. **Timely**: Implementation using timely-dataflow operators
3. **Differential**: Implementation using differential-dataflow operators (for iterative algorithms)
4. **DFIR**: Implementation using the DFIR system from the main repository

The benchmarks measure:
- Throughput (operations per second)
- Latency (time per operation)
- Memory usage patterns
- Scaling behavior with data size

## Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in the `benches/` directory
2. Add the benchmark to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
3. Use the criterion framework for benchmark harness
4. Follow the existing patterns for fair comparisons

## Performance Tips

- Run benchmarks in release mode (cargo does this by default for `cargo bench`)
- Ensure your system is not under heavy load during benchmarking
- Run multiple iterations to account for variance
- Use `criterion`'s statistical analysis to interpret results

## Troubleshooting

### Compilation Errors with dfir_rs

If you encounter compilation errors related to `dfir_rs` or `sinktools`:
1. Ensure the main Hydro repository is at a compatible version
2. Try using path dependencies instead of git dependencies
3. Check that the feature flags are correct

### Benchmark Takes Too Long

Some benchmarks process large amounts of data. You can:
1. Reduce the dataset size (edit constants in the benchmark file)
2. Run specific benchmark functions instead of all benchmarks
3. Use `--sample-size` flag to reduce the number of iterations

## License

Apache-2.0 (same as the main Hydro repository)

## Related Documentation

- [Main Hydro Repository](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion Benchmark Framework](https://github.com/bheisler/criterion.rs)
