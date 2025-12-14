# Timely Dataflow and Differential Dataflow Benchmarks

This directory contains performance benchmarks comparing Hydro (DFIR) with Timely Dataflow and Differential Dataflow implementations.

## Overview

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies on `timely` and `differential-dataflow` packages. This separation allows the main repository to remain lightweight while still maintaining the ability to run performance comparisons.

## Available Benchmarks

### Primary Benchmarks Migrated from Main Repository

These benchmarks with Timely and Differential Dataflow dependencies were moved from `bigweaver-agent-canary-hydro-zeta`:

- **fan_out**: Fan-out dataflow patterns with Timely comparisons
- **fan_in**: Fan-in dataflow patterns with Timely comparisons
- **fork_join**: Fork-join patterns with Timely comparisons
- **reachability**: Graph reachability with Differential Dataflow comparisons
- **join**: Join operations

### Additional Benchmarks

- **arithmetic**: Arithmetic operations pipeline benchmark
- **identity**: Identity operation benchmark
- **upcase**: String uppercase transformation benchmark

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
# Primary benchmarks moved from main repository
cargo bench --bench fan_out
cargo bench --bench fan_in
cargo bench --bench fork_join
cargo bench --bench reachability
cargo bench --bench join

# Additional benchmarks
cargo bench --bench arithmetic
cargo bench --bench identity
cargo bench --bench upcase
```

## Benchmark Results

Benchmark results are generated in the `target/criterion` directory and include:
- HTML reports with visualizations
- Statistical analysis of performance
- Comparison with previous runs (if available)

## Dependencies

These benchmarks depend on the following packages isolated in this repository's `Cargo.toml`:

- `timely-master` (v0.13.0-dev.1): Timely Dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1): Differential Dataflow framework
- `dfir_rs`: Hydro's DFIR runtime (for comparison)
- `criterion`: Benchmarking framework

The main repository (`bigweaver-agent-canary-hydro-zeta`) no longer has `timely` or `differential-dataflow` dependencies.

## Cross-Repository Performance Comparison

To compare performance between this repository and the main Hydro repository:

1. Run benchmarks in this repository:
   ```bash
   cargo bench --bench <benchmark_name>
   ```

2. Navigate to the main repository and run equivalent benchmarks there

3. Compare the results from both `target/criterion` directories

## Adding New Benchmarks

To add a new benchmark that uses Timely or Differential Dataflow:

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark configuration to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
3. Implement the benchmark using the Criterion framework

## Notes

- These benchmarks are kept separate to avoid introducing Timely and Differential Dataflow dependencies into the main repository
- The main repository contains non-Timely benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond)
- This separation maintains a clean dependency tree while preserving performance comparison capabilities
