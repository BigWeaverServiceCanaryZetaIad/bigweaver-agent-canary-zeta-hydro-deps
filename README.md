# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid introducing timely and differential-dataflow dependencies into the main codebase.

## Contents

### Benchmarks

The `benches` directory contains microbenchmarks for Hydro and comparison benchmarks with timely and differential-dataflow frameworks.

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in operations
- `fan_out` - Fan-out operations
- `fork_join` - Fork-join patterns
- `futures` - Async futures benchmarks
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercase operations
- `words_diamond` - Diamond pattern with word processing

## Dependencies

The benchmarks depend on:
- `dfir_rs` - From the main Hydro repository
- `sinktools` - From the main Hydro repository  
- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow framework
- `criterion` - For benchmarking

These dependencies are referenced via git from the main repository to keep benchmark functionality intact while maintaining separation of concerns.