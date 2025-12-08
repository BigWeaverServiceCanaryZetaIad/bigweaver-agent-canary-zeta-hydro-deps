# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow packages. These benchmarks were migrated from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid adding these dependencies to the main codebase.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related crates, including performance comparisons with timely and differential-dataflow.

### Running Benchmarks

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

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `futures` - Futures-based operations benchmark
- `identity` - Identity operation benchmark
- `join` - Join operation benchmark
- `micro_ops` - Micro-operations benchmark
- `reachability` - Graph reachability benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `upcase` - Uppercase transformation benchmark
- `words_diamond` - Word processing diamond pattern benchmark

## Dependencies

This repository depends on:
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow computation
- `dfir_rs` - From the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - From the main bigweaver-agent-canary-hydro-zeta repository

## Migration Notes

These benchmarks were removed from the main repository in commit `b161bc10` to eliminate timely and differential-dataflow dependencies from the main codebase while retaining the ability to run performance comparisons.