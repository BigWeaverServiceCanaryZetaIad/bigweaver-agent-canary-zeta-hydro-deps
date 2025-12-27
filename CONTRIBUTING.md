# Contributing to Hydro-Deps

This repository contains benchmarks comparing DFIR/Hydro performance against Timely Dataflow and Differential Dataflow frameworks. It was separated from the main [Hydro repository](https://github.com/hydro-project/hydro) to isolate dependencies on external dataflow frameworks.

## Repository Structure

* `benches` contains microbenchmarks comparing DFIR/Hydro against Timely Dataflow and Differential Dataflow.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

To run specific benchmarks:
```bash
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench join
```

## Dependencies

This repository depends on:
- **dfir_rs** and **sinktools** from the main [Hydro repository](https://github.com/hydro-project/hydro)
- **timely-master** - Timely Dataflow framework
- **differential-dataflow-master** - Differential Dataflow framework

The dependencies on `dfir_rs` and `sinktools` are pulled from the main Hydro repository via git.

## Submitting Changes

### Commit Messages

Pull request titles and bodies should follow the [Conventional Commits specification](https://www.conventionalcommits.org/).

### Pull Requests

Please ensure that:
1. All benchmarks compile and run successfully
2. Any new benchmarks are documented in the README
3. Changes maintain compatibility with the latest version of DFIR/Hydro

## Coordinating with Main Hydro Repository

Since this repository depends on the main Hydro repository, changes to DFIR/Hydro APIs may require corresponding updates here. When making breaking changes to DFIR/Hydro:

1. Create a feature branch in both repositories
2. Update benchmarks in hydro-deps to work with the new APIs
3. Submit coordinated PRs with clear dependency information

## Rust Toolchain

This repository should build on the latest stable version of Rust. No specific nightly features are required for the benchmarks themselves.
