# Usage Guide for bigweaver-agent-canary-zeta-hydro-deps

This guide provides comprehensive instructions for running benchmarks and using the components in this repository.

## Overview

This repository contains two main components:

1. **benches/** - Criterion-based benchmarks for timely and differential-dataflow
2. **hydro_test_benches/** - A self-contained library crate with Hydro protocol benchmarks

## Prerequisites

Ensure you have Rust installed:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Running Criterion Benchmarks (benches/)

### Run All Benchmarks

```bash
cargo bench
```

This will run all benchmarks and generate HTML reports in `target/criterion/`.

### Run Specific Benchmarks

```bash
# Run a single benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench micro_ops

# Run benchmarks matching a pattern
cargo bench micro
cargo bench join
```

### Available Benchmarks

- **arithmetic.rs** - Basic arithmetic operations
- **fan_in.rs** - Fan-in dataflow pattern
- **fan_out.rs** - Fan-out dataflow pattern
- **fork_join.rs** - Fork-join pattern
- **futures.rs** - Async futures benchmarks
- **identity.rs** - Identity transformation
- **join.rs** - Join operations
- **micro_ops.rs** - Micro-operation benchmarks
- **reachability.rs** - Graph reachability
- **symmetric_hash_join.rs** - Symmetric hash join
- **upcase.rs** - String uppercase transformation
- **words_diamond.rs** - Diamond pattern with word processing

### Benchmark Results

After running benchmarks, view the results:
- HTML reports: `target/criterion/<benchmark_name>/report/index.html`
- Terminal output shows performance metrics and comparisons

## Running Hydro Test Benchmarks (hydro_test_benches/)

### Run Examples

The `hydro_test_benches` crate provides three example programs:

```bash
# Run Paxos consensus benchmark
cargo run --package hydro_test_benches --example paxos

# Run Two-Phase Commit benchmark
cargo run --package hydro_test_benches --example two_pc

# Run Compartmentalized Paxos benchmark
cargo run --package hydro_test_benches --example compartmentalized_paxos
```

### Run Tests

```bash
# Run all tests in hydro_test_benches
cargo test --package hydro_test_benches

# Run tests with output
cargo test --package hydro_test_benches -- --nocapture
```

### Using as a Library

You can use the hydro_test_benches as a library in your own projects:

```rust
use hydro_test_benches::paxos::{CorePaxos, PaxosConfig, Proposer, Acceptor};
use hydro_test_benches::paxos_bench::{paxos_bench, Client, Aggregator};
use hydro_test_benches::kv_replica::Replica;

// Set up your clusters and run benchmarks
```

Add to your `Cargo.toml`:
```toml
[dependencies]
hydro_test_benches = { path = "path/to/hydro_test_benches" }
```

## Building the Workspace

### Build Everything

```bash
# Build all crates in the workspace
cargo build

# Build in release mode
cargo build --release
```

### Build Specific Crates

```bash
# Build only benches
cargo build --package benches

# Build only hydro_test_benches
cargo build --package hydro_test_benches
```

## Checking for Issues

```bash
# Check for compilation errors without building
cargo check

# Run clippy for linting
cargo clippy

# Format code
cargo fmt
```

## Understanding the Benchmarks

### Criterion Benchmarks (benches/)

These benchmarks compare the performance of different implementations:
- **Hydro/DFIR implementations** - Using the dfir_rs framework
- **Timely implementations** - Using raw timely-dataflow
- **Differential implementations** - Using differential-dataflow

Each benchmark typically runs multiple configurations and reports:
- Throughput (operations/second)
- Latency percentiles
- Comparative performance between implementations

### Protocol Benchmarks (hydro_test_benches/)

These benchmarks measure distributed consensus protocols:

1. **Paxos Benchmark** (`paxos_bench.rs`)
   - Tests basic Paxos consensus
   - Measures throughput for key-value operations
   - Configurable number of clients, replicas, and fault tolerance

2. **Two-Phase Commit Benchmark** (`two_pc_bench.rs`)
   - Tests 2PC protocol performance
   - Measures commit throughput
   - Configurable participants and clients

3. **Compartmentalized Paxos Benchmark** (via `compartmentalized_paxos.rs`)
   - Tests scalable Paxos variant
   - Uses grid-based acceptor architecture
   - Improved scalability for large deployments

## Configuration

### Benchmark Configuration

Criterion benchmarks can be configured by modifying the benchmark files in `benches/benches/`.

Common configuration options:
- Sample size
- Measurement time
- Warm-up time
- Input data size

### Protocol Benchmark Configuration

Hydro protocol benchmarks can be configured through:
- Constants in example files (NUM_CLIENTS_PER_NODE, CHECKPOINT_FREQUENCY, etc.)
- PaxosConfig and CompartmentalizedPaxosConfig parameters
- Cluster sizes and topology

## Performance Tips

1. **Use Release Mode** - Always run benchmarks in release mode for accurate results:
   ```bash
   cargo bench  # Already uses release profile
   cargo run --release --example paxos
   ```

2. **Isolate System** - For accurate benchmarks:
   - Close unnecessary applications
   - Disable CPU frequency scaling if possible
   - Run multiple iterations to account for variance

3. **Review Reports** - Criterion generates detailed HTML reports with visualizations

## Troubleshooting

### Build Errors

If you encounter build errors:
1. Ensure Rust is up to date: `rustup update`
2. Clean build artifacts: `cargo clean`
3. Check that all git dependencies are accessible

### Runtime Errors

For runtime issues:
1. Check that required ports are available
2. Ensure sufficient system resources
3. Review log output for specific error messages

## Additional Resources

- See `README.md` for overview and migration information
- See `benches/README.md` for details on criterion benchmarks
- See `hydro_test_benches/README.md` for protocol benchmark details
- Review example files in `hydro_test_benches/examples/` for usage patterns

## Contributing

When adding new benchmarks:
1. Follow the existing code structure and patterns
2. Add appropriate documentation
3. Update relevant README files
4. Ensure benchmarks run successfully with `cargo bench` or `cargo test`
5. Include example usage if adding new protocol benchmarks
