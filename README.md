# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external dataflow frameworks (timely and differential-dataflow).

## Benchmarks

The benchmarks compare Hydro/DFIR performance against established dataflow frameworks like Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench fan_out
```

### Available Benchmarks

- **reachability**: Graph reachability algorithms comparing Hydro, Timely, and Differential implementations
- **join**: Join operations with different data types (usize, String)
- **fan_out**: Fan-out pattern benchmarks
- **micro_ops**: Micro-operations including map, flat_map, union, tee, fold, sort
- **arithmetic**: Arithmetic operations
- **fan_in**: Fan-in pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Futures-based operations
- **identity**: Identity operations
- **symmetric_hash_join**: Symmetric hash join operations
- **upcase**: String uppercase operations
- **words_diamond**: Diamond pattern with word processing

### Dependencies

This repository maintains separate benchmarks that depend on:
- `timely` (timely-master)
- `differential-dataflow` (differential-dataflow-master)

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the main repository clean and focused, while preserving the ability to run performance comparisons against established dataflow frameworks.
