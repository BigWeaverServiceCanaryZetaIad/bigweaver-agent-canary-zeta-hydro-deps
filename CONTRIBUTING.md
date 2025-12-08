# Contributing to Hydro Dependencies

This repository contains benchmarks and code that depend on external packages like timely-dataflow and differential-dataflow.

## Repository Structure

* `benches/` contains performance benchmarks comparing Hydro (DFIR) with timely-dataflow and differential-dataflow implementations

## Rust

This repository follows the same Rust version and tooling as the main Hydro repository. The Rust toolchain version is specified in `rust-toolchain.toml`.

## Code Style

Code formatting and linting configurations are synchronized with the main Hydro repository:
- `rustfmt.toml` for code formatting (run with `cargo fmt`)
- `clippy.toml` for linting (run with `cargo clippy`)

## Running Benchmarks

To run benchmarks locally:
```bash
cd benches
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

## Updating Dependencies

When updating dependencies, ensure:
1. The benchmarks still compile and run correctly
2. Performance comparisons remain valid
3. The git dependencies to the main Hydro repository remain compatible

## Submitting Changes

Follow the same conventions as the main Hydro repository:
- Use [Conventional Commits](https://www.conventionalcommits.org/) format for commit messages
- Create feature branches for development
- Test benchmarks before submitting changes
