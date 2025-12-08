# Contributing to Hydro Dependencies Repository

This repository contains benchmarks and dependencies for the Hydro project that rely on external libraries like timely-dataflow and differential-dataflow.

## Repository Structure

* `benches/` - Microbenchmarks comparing DFIR/Hydro with timely-dataflow and differential-dataflow

## Running Benchmarks

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
- `fan_in` - Fan-in data patterns
- `fan_out` - Fan-out data patterns
- `fork_join` - Fork-join patterns
- `futures` - Futures-based async patterns
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability (uses differential-dataflow)
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String uppercase operations
- `words_diamond` - Diamond pattern on word data

## Code Style

This repository follows the same code style guidelines as the main [Hydro repository](https://github.com/hydro-project/hydro). See [rustfmt.toml](rustfmt.toml) and [clippy.toml](clippy.toml) for specific settings.

## Dependencies

The benchmarks depend on:
- `dfir_rs` and `sinktools` from the main Hydro repository (via git)
- `timely-dataflow` and `differential-dataflow` (external dependencies)
- Various utility crates (`criterion`, `rand`, etc.)

## Updating Benchmarks

When updating benchmarks:
1. Ensure they still compile and run successfully
2. Run `cargo fmt` to format code
3. Run `cargo clippy` to check for common issues
4. Update this README if adding new benchmarks

## Related Repositories

- [Main Hydro Repository](https://github.com/hydro-project/hydro) - The main Hydro/DFIR codebase
