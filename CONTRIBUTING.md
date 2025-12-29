# Contributing to Hydro Dependencies Benchmarks

This repository contains performance comparison benchmarks for Hydro against Timely Dataflow and Differential Dataflow frameworks.

## Repository Purpose

This repository was created to separate heavy dependencies (timely and differential-dataflow) from the main Hydro repository. The benchmarks here enable:
- Performance comparison tracking over time
- Independent execution of framework comparison benchmarks
- Cleaner dependency management in the main Hydro codebase

## Repository Structure

* `benches/` contains all benchmark implementations
  - Benchmarks that compare Hydro/DFIR with Timely Dataflow
  - Benchmarks that compare Hydro/DFIR with Differential Dataflow
  - Supporting data files for benchmarks

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench arithmetic
```

## Dependencies

The benchmarks depend on:
- `dfir_rs` from the main Hydro repository (via git)
- `sinktools` from the main Hydro repository (via git)
- `timely-master` package
- `differential-dataflow-master` package
- `criterion` for benchmarking infrastructure

## Updating Benchmarks

When updating benchmarks:
1. Ensure benchmarks still compile against latest Hydro changes
2. Verify performance comparisons remain valid
3. Update documentation if benchmark behavior changes
4. Run all benchmarks to ensure no regressions

## Code Style

Follow the same code style as the main Hydro repository:
- Use `rustfmt` for formatting
- Use `clippy` for linting
- Follow Rust best practices

## Submitting Changes

Follow the same PR process as the main Hydro repository:
- Use feature branches
- Follow Conventional Commits specification for PR titles
- Include benchmark results in PR descriptions when relevant
