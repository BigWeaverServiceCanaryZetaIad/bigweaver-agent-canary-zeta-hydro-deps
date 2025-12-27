# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the BigWeaver Agent Canary Hydro project that require external dataflow frameworks (Timely Dataflow and Differential Dataflow).

## Contents

- `benches/`: Performance benchmarks comparing Hydro with Timely and Differential Dataflow
  - Includes various benchmark categories: graph reachability, join operations, micro-operations, and more

## Purpose

This repository isolates the dependencies on `timely-master` and `differential-dataflow-master` from the main Hydro codebase, keeping the core repository clean while maintaining comprehensive performance comparison capabilities.

## Running Benchmarks

To run the benchmarks from this repository:

```bash
cargo bench
```

Individual benchmarks can be run with:

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks include:
- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String upper-case benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks
