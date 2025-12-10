# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on [timely](https://github.com/TimelyDataflow/timely-dataflow) and [differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow) for the Hydro project. These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce dependencies and improve build performance.

## Purpose

This repository serves as a dedicated location for performance benchmarks that compare Hydro (formerly Hydroflow) implementations against timely and differential-dataflow implementations. By separating these benchmarks:

- The main repository avoids heavy dependencies on timely and differential-dataflow
- Build times for the main repository are improved
- Security surface area is reduced
- Performance comparison capabilities are preserved

## Benchmarks

The following benchmarks are included:

- **arithmetic.rs** - Pipeline arithmetic operations benchmark comparing raw Rust, Hydro, and timely implementations
- **fan_in.rs** - Fan-in dataflow pattern benchmark
- **fan_out.rs** - Fan-out dataflow pattern benchmark
- **fork_join.rs** - Fork-join dataflow pattern benchmark
- **identity.rs** - Identity operation benchmark (baseline performance)
- **join.rs** - Join operation benchmark
- **reachability.rs** - Graph reachability algorithm benchmark comparing Hydro, timely, and differential-dataflow
- **upcase.rs** - String uppercase transformation benchmark

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:

```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

## Performance Comparisons

Each benchmark typically includes multiple implementations:

1. **Raw Rust** - Direct implementation without any framework
2. **Hydro** - Implementation using the Hydro dataflow framework
3. **Timely** - Implementation using timely-dataflow
4. **Differential** - Implementation using differential-dataflow (where applicable)

Results are generated using [Criterion.rs](https://github.com/bheisler/criterion.rs) and output to `target/criterion/`.

## Cross-Repository Performance Comparison

To compare performance between the main repository and these benchmarks:

1. **Run benchmarks in this repository:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

2. **View Criterion results:**
   ```bash
   open target/criterion/report/index.html
   ```

3. **Compare with main repository benchmarks** (if any remain in the main repo):
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench
   ```

## Dependencies

This repository depends on:

- **dfir_rs** - The core Hydro dataflow runtime (referenced via Git from main repository)
- **sinktools** - Utilities for Hydro (referenced via Git from main repository)
- **timely** - Timely dataflow framework
- **differential-dataflow** - Differential dataflow framework
- **criterion** - Benchmarking framework

The dfir_rs and sinktools dependencies are pulled from a specific commit in the main repository to ensure consistency.

## Structure

```
.
├── Cargo.toml          # Package configuration with benchmark definitions
├── README.md           # This file
├── build.rs            # Build script for generating benchmark code
└── benches/            # Benchmark source files
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── reachability_edges.txt      # Test data for reachability benchmark
    ├── reachability_reachable.txt  # Expected results for reachability
    └── upcase.rs
```

## Updating Dependencies

To update to a newer version of the main repository:

1. Find the desired commit hash from the main repository
2. Update the `rev` field in `Cargo.toml` for `dfir_rs` and `sinktools` dependencies
3. Run `cargo update` to fetch the new dependencies
4. Test the benchmarks to ensure compatibility

Example:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "NEW_COMMIT_HASH" }
```

## Contributing

When adding new benchmarks that require timely or differential-dataflow:

1. Add the benchmark file to the `benches/` directory
2. Add a `[[bench]]` entry in `Cargo.toml`
3. Update this README with a description of the benchmark
4. Ensure the benchmark includes multiple implementations for comparison
5. Run and verify the benchmark works correctly

## License

Apache-2.0 - See the main repository for full license details.