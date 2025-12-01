# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external crates like `timely` and `differential-dataflow`.

## Purpose

These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

- Avoid unnecessary dependencies on heavy packages like `timely` and `differential-dataflow` in the main repository
- Reduce compilation times for the main repository
- Maintain separation of concerns between core functionality and performance benchmarking

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro/DFIR performance against other dataflow systems.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

- `arithmetic` - Arithmetic operation performance
- `fan_in` - Fan-in pattern performance
- `fan_out` - Fan-out pattern performance
- `fork_join` - Fork-join pattern performance
- `futures` - Futures-based performance
- `identity` - Identity operation performance
- `join` - Join operation performance
- `micro_ops` - Micro-operation performance
- `reachability` - Graph reachability performance
- `symmetric_hash_join` - Symmetric hash join performance
- `upcase` - String upper-casing performance
- `words_diamond` - Word processing diamond pattern

## Dependencies

This repository maintains benchmarks that depend on:

- `timely` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)
- `dfir_rs` - The core DFIR runtime from the main Hydro repository

## Contributing

See the [main repository's contributing guide](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md) for information on contributing to the Hydro project.