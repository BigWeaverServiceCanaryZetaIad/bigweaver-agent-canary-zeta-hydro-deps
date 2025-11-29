# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro with timely and differential-dataflow dependencies.

## Overview

This repository was created to maintain the timely and differential-dataflow benchmarks that were removed from the main Hydro repository. The benchmarks enable performance comparisons and testing of Hydro against these streaming dataflow systems.

## Repository Structure

```
.
├── benches/                # Benchmark package
│   ├── benches/           # Individual benchmark files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── futures.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   └── words_diamond.rs
│   ├── Cargo.toml         # Benchmark dependencies
│   ├── README.md          # Benchmark-specific documentation
│   └── build.rs           # Build script for generated benchmarks
├── Cargo.toml             # Workspace configuration
└── README.md              # This file
```

## Prerequisites

- Rust toolchain (version specified in `rust-toolchain.toml`)
- Cargo (comes with Rust)

## Running Benchmarks

### Run All Benchmarks

To run all benchmarks in the workspace:

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

To run a specific benchmark:

```bash
cargo bench -p benches --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `futures` - Futures-based async operations benchmark
- `identity` - Identity transformation benchmark
- `join` - Join operations benchmark
- `micro_ops` - Micro-operations benchmark
- `reachability` - Graph reachability benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `upcase` - String uppercase transformation benchmark
- `words_diamond` - Diamond pattern with word processing benchmark

### Examples

Run the reachability benchmark:
```bash
cargo bench -p benches --bench reachability
```

Run the join benchmark:
```bash
cargo bench -p benches --bench join
```

Run benchmarks matching a pattern:
```bash
cargo bench -p benches fan
```
This will run both `fan_in` and `fan_out` benchmarks.

## Benchmark Results

Benchmark results are generated using [Criterion.rs](https://github.com/bheisler/criterion.rs) and include:
- HTML reports in `target/criterion/`
- Statistical analysis of performance
- Comparison with previous runs (when available)

To view the HTML reports, open `target/criterion/report/index.html` in your web browser after running benchmarks.

## Performance Comparisons

These benchmarks enable performance comparisons between:
- Hydro (using dfir_rs)
- Timely Dataflow
- Differential Dataflow

Each benchmark typically includes implementations for different systems to facilitate direct performance comparisons.

## Dependencies

### Main Dependencies

- **timely**: Version 0.13.0-dev.1 (package: timely-master)
- **differential-dataflow**: Version 0.13.0-dev.1 (package: differential-dataflow-master)
- **dfir_rs**: From hydro-project/hydro repository (with debugging features)
- **sinktools**: From hydro-project/hydro repository
- **criterion**: Version 0.5.0 (benchmarking framework)

### Additional Dependencies

- futures, tokio: Async runtime support
- rand, rand_distr: Random data generation
- seq-macro: Macro utilities
- static_assertions: Compile-time assertions
- nameof: Name-of utilities

## Development

### Building

To build the benchmarks without running them:

```bash
cargo build --package benches --benches
```

### Formatting

Code formatting is enforced using rustfmt:

```bash
cargo fmt --all
```

### Linting

Code quality is checked using clippy:

```bash
cargo clippy --all-targets --all-features
```

## Notes

- The wordlist used in benchmarks is from [english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
- Some benchmarks use generated code (see `build.rs`)
- Benchmarks include data files (e.g., `reachability_edges.txt`, `words_alpha.txt`)

## Related Repositories

- [hydro-project/hydro](https://github.com/hydro-project/hydro) - Main Hydro repository

## Migration History

These benchmarks were moved from the main Hydro repository in commit `b161bc10` to maintain a clean separation between core Hydro functionality and timely/differential-dataflow dependencies. This separation allows the main repository to avoid these dependencies while retaining the ability to run performance comparisons.