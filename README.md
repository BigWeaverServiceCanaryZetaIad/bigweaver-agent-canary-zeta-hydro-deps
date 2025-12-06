# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and other code that depend on timely and differential-dataflow packages, which have been moved from the main hydro repository to reduce its dependency footprint.

## Benchmarks

Microbenchmarks for Hydro and other crates, including benchmarks that use timely and differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

The following benchmarks are available:
- `arithmetic` - Arithmetic operation benchmarks comparing different implementations
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks  
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercasing benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

## Dependencies

This repository includes benchmarks that depend on:
- `timely-master` - Timely dataflow
- `differential-dataflow-master` - Differential dataflow
- `dfir_rs` - From the main hydro repository
- `sinktools` - From the main hydro repository

The `dfir_rs` and `sinktools` dependencies are pulled from the main hydro repository via git.