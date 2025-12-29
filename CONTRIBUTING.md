# Contributing to Hydro Performance Comparison Benchmarks

This repository contains performance comparison benchmarks between Hydro and Timely/Differential Dataflow frameworks.

## Repository Structure

* `benches/` - Contains benchmark implementations comparing Hydro against Timely and Differential Dataflow

## Adding New Benchmarks

When adding new performance comparison benchmarks:

1. Add the benchmark file to `benches/benches/`
2. Update `benches/Cargo.toml` to register the new benchmark
3. Ensure the benchmark includes implementations for both Hydro and the comparison framework
4. Update `benches/README.md` to document the new benchmark

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability
```

## Code Style

This repository follows the same code style as the main Hydro project. Use:

```bash
cargo fmt --all
cargo clippy --workspace -- -D warnings
```

## Rust Version

This repository uses the same Rust toolchain as specified in `rust-toolchain.toml`.
