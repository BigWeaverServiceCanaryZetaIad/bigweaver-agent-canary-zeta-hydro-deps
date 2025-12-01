# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance tests for the Hydro project that depend on `timely` and `differential-dataflow` packages.

## Purpose

This repository was created to separate performance benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Reduce compilation time for the main repository
- Avoid unnecessary dependencies on heavy packages like `timely` and `differential-dataflow` in the core codebase
- Maintain clean separation between core functionality and performance testing
- Allow independent evolution of benchmarks and performance testing infrastructure

## Structure

```
benches/
├── Cargo.toml              # Benchmark dependencies and configuration
├── README.md              # Benchmark-specific documentation
├── build.rs               # Build script
└── benches/               # Benchmark implementations
    ├── arithmetic.rs      # Arithmetic operation benchmarks
    ├── fan_in.rs         # Fan-in pattern benchmarks
    ├── fan_out.rs        # Fan-out pattern benchmarks
    ├── fork_join.rs      # Fork-join pattern benchmarks
    ├── futures.rs        # Futures-based benchmarks
    ├── identity.rs       # Identity operation benchmarks
    ├── join.rs           # Join operation benchmarks
    ├── micro_ops.rs      # Micro-operation benchmarks
    ├── reachability.rs   # Graph reachability benchmarks
    ├── symmetric_hash_join.rs  # Hash join benchmarks
    ├── upcase.rs         # String transformation benchmarks
    ├── words_diamond.rs  # Word processing benchmarks
    └── *.txt             # Test data files
```

## Dependencies

The benchmarks depend on packages from the main repository via git dependencies:
- `dfir_rs` - Core dataflow library from bigweaver-agent-canary-hydro-zeta
- `sinktools` - Utility crate from bigweaver-agent-canary-hydro-zeta

External dependencies:
- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow framework
- `criterion` - Benchmarking framework

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

## Development

When making changes to this repository, ensure:
1. Benchmarks retain the ability to run performance comparisons
2. Dependencies are kept in sync with the main repository requirements
3. CI/CD pipelines are updated to reflect any structural changes

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository