# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that are separated from the main repository to maintain a cleaner codebase structure.

## Repository Contents

### Benches

The `benches` directory contains microbenchmarks for DFIR and other frameworks including:

- Performance comparison tests between DFIR, Timely Dataflow, and Differential Dataflow
- Various microbenchmarks for operations like identity, join, reachability, and more
- Test data files for benchmarking scenarios

## Running Benchmarks

To run the benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operation benchmarks
- `fan_in` - Fan-in operation benchmarks
- `fan_out` - Fan-out operation benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `reachability` - Graph reachability benchmarks
- `micro_ops` - Micro-operation benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String upper-casing benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks
- `futures` - Futures-based benchmarks

## Dependencies

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository for:
- `dfir_rs` - The main DFIR runtime
- `sinktools` - Sink utilities

It also includes dependencies on:
- `timely` - Timely Dataflow framework
- `differential-dataflow` - Differential Dataflow framework