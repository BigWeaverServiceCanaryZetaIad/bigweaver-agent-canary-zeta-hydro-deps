# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external packages like `timely` and `differential-dataflow`. These have been separated from the main repository to keep the main codebase lean and free from unnecessary dependencies.

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and related crates that use timely-dataflow and differential-dataflow.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
```

### Available Benchmarks

- **arithmetic**: Arithmetic operation benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Async futures benchmarks
- **identity**: Identity operation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase benchmarks
- **words_diamond**: Word processing diamond pattern benchmarks

## Repository Structure

This repository references the main `bigweaver-agent-canary-hydro-zeta` repository for core dependencies like `dfir_rs` and `sinktools`. Ensure both repositories are cloned in the same parent directory for the relative paths to work correctly.

```
projects/
├── bigweaver-agent-canary-hydro-zeta/    # Main repository
└── bigweaver-agent-canary-zeta-hydro-deps/    # This repository
    └── benches/                               # Benchmarks with timely/differential-dataflow
```