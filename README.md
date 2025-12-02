# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on timely-dataflow and differential-dataflow. These have been separated from the main repository to reduce compilation time and dependency bloat for core development.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks for comparing Hydro with timely-dataflow and differential-dataflow:

- **arithmetic.rs** - Arithmetic operation benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Async/futures benchmarks
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **reachability.rs** - Graph reachability benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String transformation benchmarks
- **words_diamond.rs** - Diamond pattern benchmarks

### Hydro Test Benchmarks (`hydro_test_benches/`)

Reference benchmark implementations from hydro_test:

- **paxos_bench.rs** - Paxos consensus protocol benchmarks
- **two_pc_bench.rs** - Two-phase commit protocol benchmarks

## Prerequisites

1. Clone both repositories as siblings:
   ```bash
   parent-directory/
   ├── bigweaver-agent-canary-hydro-zeta/      # Main Hydro repository
   └── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
   ```

2. Ensure you have the Rust toolchain installed (see `rust-toolchain.toml` in the main repository)

## Running Benchmarks

From this repository directory:

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability

# Run benchmarks with specific features
cargo bench -p benches --features debugging
```

## Performance Comparison

This repository enables systematic performance comparisons between Hydro implementations and timely/differential-dataflow implementations. Follow this workflow:

### Step 1: Establish Baselines in This Repository

Run benchmarks in this repository to capture timely/differential-dataflow performance:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Create a baseline for comparison
cargo bench -p benches -- --save-baseline timely-baseline

# Or run specific benchmarks
cargo bench -p benches --bench arithmetic -- --save-baseline timely-baseline
cargo bench -p benches --bench reachability -- --save-baseline timely-baseline
```

### Step 2: Run Equivalent Hydro Implementations

Switch to the main repository and run equivalent benchmarks:

```bash
cd ../bigweaver-agent-canary-hydro-zeta

# Run Hydro benchmarks (if available in dfir_rs or other packages)
cargo bench --features benchmark

# Or run specific Hydro implementations
cargo bench -p dfir_rs --bench <benchmark-name>
```

### Step 3: Compare Results

Benchmark results are stored in `target/criterion/` directories in each repository. Compare:

- **Execution time**: Check the time measurements in each report
- **Throughput**: Compare operations/second metrics
- **Memory usage**: Review memory allocation patterns
- **Scalability**: Test with different input sizes

### Step 4: Document Findings

Create performance comparison reports documenting:
- Test environment (hardware, OS, Rust version)
- Input parameters and data sizes
- Measured metrics (time, throughput, memory)
- Relative performance differences
- Analysis of performance characteristics

### Example Comparison Workflow

```bash
# In bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches --bench reachability -- --save-baseline timely

# Switch to main repository
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p dfir_rs --bench reachability_hydro

# Compare results
# Open target/criterion/reachability/report/index.html in each repository
# Document the performance differences
```

### Comparing Protocol Benchmarks

The `hydro_test_benches/` directory contains reference implementations that show how distributed protocols (Paxos, Two-PC) are benchmarked. To compare:

1. Use the reference implementations in `hydro_test_benches/` as a guide
2. Run the actual benchmarks in the main repository: `cargo bench -p hydro_test`
3. Compare throughput, latency, and scalability metrics
4. Consider factors like network overhead, consensus rounds, and participant counts

The benchmarks output detailed performance metrics including throughput and latency statistics that can be directly compared.

## Dependencies

This repository depends on:
- **timely-dataflow** (timely-master 0.13.0-dev.1) - Core timely dataflow engine
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1) - Incremental computation framework

And references the following from the main repository via path dependencies:
- **dfir_rs** - Core Hydro dataflow runtime
- **sinktools** - Sink utilities for benchmarking

## Documentation

This repository includes comprehensive documentation:

- **[QUICK_START.md](QUICK_START.md)** - Get started in 5 minutes
- **[BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)** - Detailed benchmark guide with performance comparison methodology
- **[SETUP_VERIFICATION.md](SETUP_VERIFICATION.md)** - Verify your setup and troubleshoot issues
- **[REPOSITORY_STRUCTURE.md](REPOSITORY_STRUCTURE.md)** - Complete repository structure and file organization
- **[benches/README.md](benches/README.md)** - Detailed information about benchmark implementations
- **[hydro_test_benches/README.md](hydro_test_benches/README.md)** - Protocol benchmark reference implementations
- **[hydro_test_examples/README.md](hydro_test_examples/README.md)** - Runnable protocol examples

For information about the main Hydro project and contributing guidelines, see the main repository's README and CONTRIBUTING.md.

## Migration Information

These benchmarks were migrated from the main Hydro repository on 2025-12-01 to:
- Reduce compilation time for contributors not working on performance comparisons
- Separate concerns between core functionality and performance testing
- Maintain a dedicated space for benchmark development and analysis

The migration maintains full functionality for running performance comparisons while keeping the main repository lean.

## Related Repositories

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## License

Apache-2.0