# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely and differential-dataflow packages that were moved from the main bigweaver-agent-canary-hydro-zeta repository.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related crates, focusing on performance comparisons with timely and differential-dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

### Available Benchmarks

- **arithmetic**: Arithmetic operations benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Async futures benchmarks
- **identity**: Identity/passthrough benchmarks
- **join**: Join operations benchmarks
- **micro_ops**: Micro-operations benchmarks
- **reachability**: Graph reachability benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase benchmarks
- **words_diamond**: Diamond pattern with word processing

## Dependencies

This repository maintains dependencies on:
- **timely**: Timely dataflow framework
- **differential-dataflow**: Differential dataflow framework
- **dfir_rs**: Core Hydro dataflow intermediate representation (from main repository)
- **sinktools**: Sink utilities (from main repository)

## Purpose

This separate repository allows performance testing and benchmarking of timely and differential-dataflow dependent code without including these dependencies in the main Hydro repository.