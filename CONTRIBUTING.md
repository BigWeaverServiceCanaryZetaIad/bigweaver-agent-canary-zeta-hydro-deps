# Contributing to hydro-deps

This repository contains benchmarks that depend on timely and differential-dataflow packages. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep those dependencies separate.

## Repository Structure

* `benches/` - Contains performance benchmarks comparing Hydro with timely and differential-dataflow implementations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Rust

This repository uses the same Rust toolchain as the main Hydro repository. The version is specified in `rust-toolchain.toml` and is automatically detected by `cargo`.

## Code Style

Code in this repository follows the same style guidelines as the main Hydro repository:
- Run `cargo fmt` to format code
- Run `cargo clippy` to check for common issues

The configuration files `rustfmt.toml` and `clippy.toml` are kept in sync with the main repository.

## Updating Dependencies

The benchmarks depend on the main Hydro repository via git dependencies. When updating:
1. Ensure the git reference points to the correct version/branch
2. Test that benchmarks still compile and run
3. Update documentation if benchmark behavior changes

## Submitting Changes

Follow the same [Conventional Commits](https://www.conventionalcommits.org/) specification as the main Hydro repository for commit messages and pull requests.
