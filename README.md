# bigweaver-agent-canary-zeta-hydro-deps

This repository contains Hydro benchmarks and code that depends on Timely Dataflow and Differential Dataflow. These components have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid polluting the main codebase with unnecessary dependencies.

## Contents

### Benchmarks

The `benches` directory contains performance comparison benchmarks that compare Hydro implementations against Timely Dataflow and Differential Dataflow equivalents.

See [benches/README.md](benches/README.md) for details on running the benchmarks.

## Why this repository exists

The main Hydro repository should remain lean and focused on its core functionality. By moving benchmarks that require `timely` and `differential-dataflow` dependencies to this separate repository, we:

1. Keep the main repository's dependency tree clean
2. Reduce compilation time for developers who don't need these comparison benchmarks
3. Maintain the ability to run performance comparisons when needed
4. Separate concerns between production code and comparative analysis

## Relationship to main repository

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository for the `dfir_rs` and `sinktools` crates. These dependencies are specified using Git URLs in the `Cargo.toml` files.

## Development

To build and test:

```bash
# Build all components
cargo build

# Run benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability
```