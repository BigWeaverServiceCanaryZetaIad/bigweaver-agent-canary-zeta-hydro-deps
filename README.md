# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the bigweaver-agent-canary-hydro-zeta project that require timely and differential-dataflow packages.

## Purpose

The benchmarks in this repository were moved from the main bigweaver-agent-canary-hydro-zeta repository to:
- **Reduce dependency bloat** in the main repository
- **Improve build times** by separating heavy dependencies
- **Maintain performance testing capabilities** with timely and differential-dataflow
- **Enable independent benchmark development** without affecting the core codebase

## Structure

### `benches/`
Contains timely and differential-dataflow benchmarks including:
- Dataflow pattern benchmarks (arithmetic, identity, join, etc.)
- Application benchmarks (reachability, symmetric hash join, etc.)
- Performance comparison benchmarks (fork_join, fan_in, fan_out, etc.)

### `hydro_test_benches/`
A complete library crate containing:
- **Benchmark implementations**: `paxos_bench.rs`, `two_pc_bench.rs`
- **Core protocol modules**: `paxos.rs`, `two_pc.rs`, `compartmentalized_paxos.rs`
- **Supporting modules**: `kv_replica.rs`, `paxos_with_client.rs`
- **Examples**: Standalone examples demonstrating how to run each benchmark

## Running Benchmarks

### Running Criterion Benchmarks

To run the benchmarks in the `benches/` directory:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench <benchmark_name>
```

For example:
```bash
cargo bench --bench reachability
cargo bench --bench micro_ops
```

### Running Hydro Test Benchmarks

The `hydro_test_benches` crate provides standalone examples for each protocol benchmark.

To run the Paxos benchmark example:
```bash
cargo run --package hydro_test_benches --example paxos
```

To run the Two-Phase Commit benchmark example:
```bash
cargo run --package hydro_test_benches --example two_pc
```

To run the Compartmentalized Paxos benchmark example:
```bash
cargo run --package hydro_test_benches --example compartmentalized_paxos
```

## Dependencies

The benchmarks depend on:
- `timely` and `differential-dataflow` for dataflow processing
- `hydro_lang` and `hydro_std` from the main hydro repository (referenced as git dependencies)
- `dfir_rs` and `sinktools` from the main hydro repository (referenced as git dependencies in benches/)
- `criterion` for benchmarking infrastructure
- `hydro_deploy` for deployment and testing (dev dependency)

## Migration from Main Repository

These benchmarks were moved from the bigweaver-agent-canary-hydro-zeta repository as part of a dependency management initiative. The main repository no longer has dependencies on timely and differential-dataflow packages, keeping it lightweight while preserving the ability to run comprehensive performance comparisons.

For more information about running benchmarks or contributing, see the README files in each subdirectory.