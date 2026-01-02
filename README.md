# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro and other dataflow frameworks including Timely Dataflow and Differential Dataflow.

## Benchmarks

The `benches` directory contains microbenchmarks comparing DFIR/Hydro with other frameworks.

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

Available benchmarks include:
- `identity` - Identity operations with Timely Dataflow
- `fan_in` - Fan-in operations with Timely Dataflow  
- `fan_out` - Fan-out operations
- `reachability` - Graph reachability using Differential Dataflow
- `join` - Join operations
- `arithmetic` - Arithmetic operations
- `fork_join` - Fork-join patterns
- `micro_ops` - Micro-operations benchmarks
- `symmetric_hash_join` - Symmetric hash join operations
- `words_diamond` - Word processing diamond pattern
- `upcase` - Uppercase string operations
- `futures` - Futures-based operations

## Dependencies

These benchmarks depend on the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) for the `dfir_rs` and `sinktools` crates.
