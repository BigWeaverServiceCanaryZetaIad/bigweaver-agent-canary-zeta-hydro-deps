# Contributing to Hydro Dependencies

This repository contains benchmarks and dependencies for the Hydro project that have been separated from the main repository.

## Repository Structure

* `benches/` - Benchmarks that depend on timely and differential-dataflow

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Code Style

This repository follows the same code style conventions as the main Hydro repository:
* Use `rustfmt` for formatting (see `rustfmt.toml`)
* Use `clippy` for linting (see `clippy.toml`)
* Follow Rust edition 2021 conventions

To format code:
```bash
cargo fmt
```

To run clippy:
```bash
cargo clippy --all-targets
```

## Adding New Benchmarks

If you want to add new benchmarks that depend on timely or differential-dataflow:

1. Add the benchmark file to `benches/benches/`
2. Add the benchmark entry to `benches/Cargo.toml` under `[[bench]]`
3. Ensure the benchmark follows the Criterion.rs framework conventions
4. Update `benches/README.md` to document the new benchmark

## Relationship to Main Repository

This repository is a companion to [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro). 

Benchmarks were moved here to:
- Keep timely and differential-dataflow dependencies out of the main repository
- Maintain the ability to run performance comparisons
- Improve build times for the main repository
- Simplify dependency management

## Testing

Run tests with:
```bash
cargo test -p benches
```

## Submitting Changes

Follow the same commit message conventions as the main Hydro repository:
* Use [Conventional Commits](https://www.conventionalcommits.org/) format
* Examples: `feat(benches): add new benchmark`, `fix(benches): correct timing logic`
