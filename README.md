# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro/DFIR performance with other dataflow systems, specifically:

- **timely-dataflow**: A low-latency data-parallel dataflow system
- **differential-dataflow**: An incremental data-parallel dataflow system built on timely

## Benchmarks

The `benches` directory contains microbenchmarks comparing DFIR with timely and differential-dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

### Available Benchmarks

- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Fan-in dataflow patterns
- **fan_out**: Fan-out dataflow patterns  
- **fork_join**: Fork-join patterns
- **identity**: Identity operations (baseline)
- **join**: Join operations
- **reachability**: Graph reachability computations
- **upcase**: String uppercase operations
- **micro_ops**: Microbenchmarks for various operators
- **symmetric_hash_join**: Symmetric hash join operations
- **words_diamond**: Diamond pattern on word processing
- **futures**: Async futures operations

## Purpose

These benchmarks were moved from the main Hydro repository to:
1. Remove timely and differential-dataflow dependencies from the main repository
2. Keep performance comparison capabilities available
3. Separate external dependency benchmarks from core Hydro development

## Relationship to Main Repository

This repository depends on the main [Hydro repository](https://github.com/hydro-project/hydro) for:
- `dfir_rs`: The DFIR runtime
- `sinktools`: Utility crate

The benchmarks in this repository can be run independently to compare Hydro's performance against other dataflow systems.
