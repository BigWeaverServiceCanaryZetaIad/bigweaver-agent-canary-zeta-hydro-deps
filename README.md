# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance comparison benchmarks for Hydro/DFIR against other dataflow systems including Timely Dataflow and Differential Dataflow.

## Structure

- `benches/` - Microbenchmarks comparing Hydro performance against Timely and Differential Dataflow

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
```

## Benchmark Categories

The benchmarks include:
- **arithmetic** - Basic arithmetic operations
- **fan_in** - Fan-in dataflow patterns
- **fan_out** - Fan-out dataflow patterns
- **fork_join** - Fork-join parallelism patterns
- **futures** - Async futures-based operations
- **identity** - Identity/passthrough operations
- **join** - Join operations
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability algorithms
- **symmetric_hash_join** - Symmetric hash join operations
- **upcase** - String transformation operations
- **words_diamond** - Diamond-pattern word processing

## Dependencies

These benchmarks depend on:
- `timely-master` - Timely Dataflow for performance comparisons
- `differential-dataflow-master` - Differential Dataflow for performance comparisons
- `dfir_rs` - The Hydro/DFIR runtime being benchmarked

Note: These dependencies on `timely` and `differential-dataflow` are intentionally kept in this separate repository to avoid adding them as dependencies to the main Hydro repository.