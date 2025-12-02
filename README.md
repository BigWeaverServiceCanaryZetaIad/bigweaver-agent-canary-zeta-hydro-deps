# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external crates like `timely` and `differential-dataflow`.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related crates, including performance comparisons with Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

### Available Benchmarks

- `arithmetic` - Arithmetic operation pipeline benchmarks
- `fan_in` - Fan-in operation benchmarks
- `fan_out` - Fan-out operation benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

## Migration from bigweaver-agent-canary-hydro-zeta

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate dependencies on `timely` and `differential-dataflow` packages. This allows the main repository to maintain a cleaner dependency structure.

### What Was Moved

- All benchmark code from `benches/` directory
- Benchmark configurations and test data files
- GitHub Actions workflow for automated benchmarking
- All dependencies on `timely` and `differential-dataflow` packages

### Benefits

- **Cleaner Dependencies**: The main Hydro repository no longer has dependencies on timely/differential packages
- **Isolated Testing**: Performance benchmarks can be run independently
- **Maintained Functionality**: All benchmark functionality is preserved and can still be executed
- **Better Organization**: Separates core functionality from performance testing infrastructure