# Contributing to Hydro Dependencies Repository

This repository contains benchmarks and code that require external dependencies like Timely Dataflow and Differential Dataflow.

## Repository Structure

* `benches/` - Performance benchmarks comparing Hydro (dfir_rs) against Timely Dataflow and Differential Dataflow

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fork_join
```

## Rust Version

This repository uses the same Rust version as the main Hydro project. The version is specified in `rust-toolchain.toml` and is automatically detected by `cargo`.

## Code Style

This repository follows the same code style conventions as the main Hydro project:
- Run `cargo fmt` to format code
- Run `cargo clippy` to check for lints

## Related Repository

Main Hydro project: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Updating Benchmarks

When updating benchmarks, ensure that:
1. All benchmark variants (timely, differential, dfir_rs) are kept in sync
2. Performance comparison functionality is maintained
3. Documentation is updated to reflect any changes
