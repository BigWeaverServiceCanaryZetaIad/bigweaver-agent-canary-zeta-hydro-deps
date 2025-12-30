# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and external dependencies for the Hydro project that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Repository Structure

* `benches` - Microbenchmarks for DFIR (Dataflow Intermediate Representation) and other frameworks, including performance comparisons with Timely Dataflow and Differential Dataflow.

## Building and Running Benchmarks

To run the benchmarks:

```bash
cargo bench --workspace
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity transformation benchmark
- `upcase` - Uppercase string transformation benchmark
- `join` - Join operation benchmark
- `reachability` - Graph reachability benchmark (uses differential_dataflow)
- `micro_ops` - Micro-operations benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `words_diamond` - Word processing diamond pattern benchmark
- `futures` - Futures-based operations benchmark

## Dependencies

The benchmarks use:
- `timely` - Timely Dataflow framework
- `differential-dataflow` - Differential Dataflow framework
- `dfir_rs` - DFIR runtime (from main repository)
- `criterion` - Benchmarking framework
