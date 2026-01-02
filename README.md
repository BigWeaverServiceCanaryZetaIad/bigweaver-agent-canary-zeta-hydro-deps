# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that have been separated from the main codebase. This includes performance comparison benchmarks for DFIR/Hydro against Timely Dataflow and Differential Dataflow frameworks.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and other dataflow frameworks, including comparisons with Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

Available benchmarks include:
- `arithmetic` - Arithmetic operations comparison
- `fan_in` - Fan-in pattern performance
- `fan_out` - Fan-out pattern performance
- `fork_join` - Fork-join pattern performance
- `futures` - Futures-based operations
- `identity` - Identity operation performance
- `join` - Join operations comparison
- `micro_ops` - Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String transformation operations
- `words_diamond` - Diamond pattern with word processing

### Dependencies

This repository includes the following external dependencies that are used for performance comparisons:
- `timely` - Timely Dataflow framework
- `differential-dataflow` - Differential Dataflow framework

These dependencies have been moved here to keep the main Hydro repository focused on the core implementation.