# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely-dataflow and differential-dataflow dependencies that were moved from the main bigweaver-agent-canary-hydro-zeta repository.

## Purpose

This repository separates performance benchmarks that depend on `timely` and `differential-dataflow` from the main Hydro repository. This separation:
- Avoids adding these dependencies to the main codebase
- Retains the ability to run performance comparisons
- Allows independent benchmark development and testing

## Structure

- `benches/` - Performance benchmarks comparing Hydro (DFIR) with timely and differential-dataflow implementations

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed.

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run a specific benchmark
cargo bench -p benches --bench identity
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
```

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Futures-based benchmarks
- `identity` - Identity/passthrough benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

## Performance Comparisons

These benchmarks allow for performance comparisons between:
- Hydro (DFIR) implementations
- Timely-dataflow implementations
- Differential-dataflow implementations

Results can be used to track performance improvements and regressions across different approaches.

## Dependencies

This repository depends on:
- `dfir_rs` - From the main Hydro repository (via git)
- `sinktools` - From the main Hydro repository (via git)
- `timely-master` - Timely-dataflow library
- `differential-dataflow-master` - Differential-dataflow library
- `criterion` - For benchmarking framework

## Contributing

When adding new benchmarks:
1. Add the benchmark file to `benches/benches/`
2. Register the benchmark in `benches/Cargo.toml`
3. Follow existing patterns for fair comparisons
4. Document the benchmark purpose in the file header