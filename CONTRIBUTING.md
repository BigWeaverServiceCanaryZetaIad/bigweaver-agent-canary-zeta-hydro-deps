# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for comparing DFIR/Hydro with Timely Dataflow and Differential Dataflow.

## Running Benchmarks

To execute the benchmarks, run:

```bash
cargo bench -p benches
```

To run specific benchmark files:

```bash
# Reachability benchmarks (includes timely and differential)
cargo bench -p benches --bench reachability

# Arithmetic benchmarks (includes timely)
cargo bench -p benches --bench arithmetic

# Other DFIR benchmarks
cargo bench -p benches --bench join
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench upcase
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

## Benchmark Categories

### Reachability Benchmarks (`benches/reachability.rs`)
- `benchmark_timely` - Graph reachability using Timely Dataflow
- `benchmark_differential` - Graph reachability using Differential Dataflow
- `benchmark_hydroflow_*` - Various DFIR implementations

### Arithmetic Benchmarks (`benches/arithmetic.rs`)
- `benchmark_timely` - Sequential arithmetic operations using Timely Dataflow
- `benchmark_hydroflow_*` - Various DFIR implementations
- `benchmark_pipeline` - Multi-threaded pipeline implementation
- `benchmark_iter` - Pure Rust iterator implementation

## Dependencies

The benchmarks require access to the main `bigweaver-agent-canary-hydro-zeta` repository for:
- `dfir_rs` - The DFIR runtime
- `sinktools` - Sink utilities

These are referenced via relative paths in `benches/Cargo.toml`.

## Performance Comparison

The primary purpose of these benchmarks is to enable performance comparison between:
1. DFIR/Hydro implementations
2. Timely Dataflow implementations
3. Differential Dataflow implementations
4. Baseline Rust implementations

Results can be used to track performance improvements and identify optimization opportunities.
