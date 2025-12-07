# Setup and Usage Guide

This repository contains timely and differential-dataflow benchmarks for performance comparison with Hydro/dfir_rs.

## Prerequisites

- Rust toolchain (see rust-toolchain.toml in the main repository for version requirements)
- Git

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Run benchmarks:
   ```bash
   cd benches
   cargo bench
   ```

## Running Specific Benchmarks

Run individual benchmarks:

```bash
# Arithmetic operations benchmark
cargo bench --bench arithmetic

# Graph reachability benchmark
cargo bench --bench reachability

# Identity operations benchmark
cargo bench --bench identity

# Join operations benchmark
cargo bench --bench join

# Fan-in pattern benchmark
cargo bench --bench fan_in

# Fan-out pattern benchmark
cargo bench --bench fan_out

# Fork-join pattern benchmark
cargo bench --bench fork_join

# Upcase transformation benchmark
cargo bench --bench upcase
```

## Understanding the Benchmarks

Each benchmark compares the performance of:
1. **Hydro/dfir_rs implementation**: The Hydro dataflow implementation
2. **Timely/Differential-Dataflow implementation**: Reference implementations using timely and differential-dataflow

The benchmarks measure throughput, latency, and resource usage across different workload patterns.

## Dependencies

The benchmarks depend on:

### External Packages
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `criterion` (v0.5.0) - for benchmarking framework

### Main Repository Dependencies (via Git)
- `dfir_rs` - Core Hydro dataflow runtime
- `sinktools` - Sink utilities for dataflow processing

These are automatically fetched from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Benchmark Results

By default, benchmark results are stored in `target/criterion/`. You can view detailed reports by opening `target/criterion/report/index.html` in a web browser.

## Updating Dependencies

To use the latest version of dfir_rs and sinktools from the main repository:

```bash
cargo update
```

To specify a particular commit or branch from the main repository, edit `benches/Cargo.toml`:

```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", branch = "main", features = [ "debugging" ] }
```

## Data Files

Some benchmarks require data files located in `benches/benches/`:

- `words_alpha.txt` - English word list for word processing benchmarks
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachability results for validation

## Contributing

When contributing new benchmarks:

1. Add the benchmark implementation to `benches/benches/`
2. Update `benches/Cargo.toml` to include the new benchmark
3. Add documentation to `benches/README.md`
4. Ensure the benchmark includes both Hydro and timely/differential implementations for comparison
5. Submit a pull request with clear description of what is being benchmarked

## Troubleshooting

### Compilation Errors

If you encounter compilation errors:

1. Ensure Rust toolchain is up to date: `rustup update`
2. Clean build artifacts: `cargo clean`
3. Update dependencies: `cargo update`

### Git Dependency Issues

If git dependencies fail to resolve:

1. Check network connectivity to GitHub
2. Verify you have access to the main repository
3. Try clearing cargo's git cache: `rm -rf ~/.cargo/git`

### Benchmark Failures

If benchmarks produce unexpected results:

1. Verify data files are present in `benches/benches/`
2. Check that you're running in release mode (benchmarks automatically use release)
3. Ensure sufficient system resources (some benchmarks are memory-intensive)

## Performance Tips

For more accurate benchmark results:

1. Close unnecessary applications
2. Disable CPU frequency scaling if possible
3. Run benchmarks multiple times and average results
4. Use a dedicated benchmark machine for production performance testing

## Links

- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Hydro Documentation](https://hydro.run)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
