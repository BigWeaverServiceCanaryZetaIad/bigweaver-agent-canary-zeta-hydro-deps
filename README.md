# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code and other components with dependencies on timely and differential-dataflow packages. These have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain clean dependency management.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related dataflow operations. These benchmarks use the timely and differential-dataflow packages for performance comparisons.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

Available benchmarks:
- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in dataflow patterns
- `fan_out` - Fan-out dataflow patterns
- `fork_join` - Fork-join patterns
- `futures` - Async futures operations
- `identity` - Identity transformations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String uppercase operations
- `words_diamond` - Diamond pattern word processing

## Dependencies

This repository depends on:
- `timely-master` (0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow framework
- `dfir_rs` - From the main Hydro repository (via git)
- `sinktools` - From the main Hydro repository (via git)

## Migration Notes

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate dependencies on timely and differential-dataflow packages. This separation allows the main repository to avoid these dependencies while preserving the ability to run performance comparisons.

For the main Hydro project documentation, please visit the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).