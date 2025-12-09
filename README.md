# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on the `timely` and `differential-dataflow` packages, which have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain a cleaner dependency structure.

## Benchmarks

The `benches` directory contains microbenchmarks for testing performance of various dataflow operations. These benchmarks use the `timely` and `differential-dataflow` packages to provide performance comparisons.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in dataflow patterns
- `fan_out` - Fan-out dataflow patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity operations
- `upcase` - String uppercase operations
- `join` - Join operations
- `reachability` - Graph reachability benchmarks
- `micro_ops` - Micro-operation benchmarks
- `symmetric_hash_join` - Symmetric hash join operations
- `words_diamond` - Word processing diamond patterns
- `futures` - Future-based operations

### Performance Comparisons

These benchmarks allow for performance comparisons between different implementations and optimizations. The results can be used to validate performance improvements in the main repository while keeping the heavy dependencies isolated.

## Repository Structure

```
.
├── benches/          # Benchmark crate with timely/differential-dataflow dependencies
│   ├── benches/      # Individual benchmark files
│   ├── Cargo.toml    # Benchmark dependencies
│   └── README.md     # Benchmark-specific documentation
└── README.md         # This file
```

## Dependencies

This repository depends on:
- `timely-master` (v0.13.0-dev.1) - Timely dataflow
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential dataflow
- `dfir_rs` - From the main hydro repository (via git dependency)
- `sinktools` - From the main hydro repository (via git dependency)

## Why Separate Repository?

The benchmarks were moved to this separate repository to:
1. Avoid direct dependencies on `timely` and `differential-dataflow` in the main repository
2. Reduce build times for the main repository
3. Maintain cleaner separation of concerns
4. Allow independent versioning of benchmark code
5. Keep the main repository's dependency footprint minimal

The benchmarks can still perform performance comparisons by depending on the main repository's crates via git dependencies.