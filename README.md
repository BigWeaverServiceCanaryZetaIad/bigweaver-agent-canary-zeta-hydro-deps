# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow implementations, providing performance comparison capabilities against the main Hydro implementations.

## Overview

This repository was created to separate timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation helps avoid dependencies in the main repository while maintaining the ability to run performance comparisons.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/               # Benchmark suite
│   ├── benches/          # Individual benchmark implementations
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── upcase.rs
│   │   ├── reachability_edges.txt
│   │   └── reachability_reachable.txt
│   ├── build.rs          # Build script for generating benchmark code
│   └── Cargo.toml        # Dependencies and benchmark configuration
├── Cargo.toml            # Workspace configuration
├── rust-toolchain.toml   # Rust toolchain specification
├── rustfmt.toml          # Code formatting configuration
└── clippy.toml           # Linting configuration
```

## Benchmarks

This repository includes the following benchmarks:

### Timely Dataflow Benchmarks

- **arithmetic**: Tests arithmetic operations through dataflow pipelines
- **fan_in**: Tests fan-in patterns (multiple inputs to single output)
- **fan_out**: Tests fan-out patterns (single input to multiple outputs)
- **fork_join**: Tests fork-join patterns with filtering
- **identity**: Tests identity operations (pass-through)
- **join**: Tests join operations between two streams
- **upcase**: Tests string transformation operations

### Differential Dataflow Benchmarks

- **reachability**: Tests graph reachability computation using differential dataflow

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p timely-differential-benchmarks
```

### Run Specific Benchmarks

```bash
# Run a single benchmark
cargo bench -p timely-differential-benchmarks --bench arithmetic

# Run reachability benchmark
cargo bench -p timely-differential-benchmarks --bench reachability
```

### Benchmark Results

Benchmark results are generated in HTML format and can be found in:
```
target/criterion/
```

Open `target/criterion/report/index.html` in a browser to view detailed results.

## Performance Comparisons

These benchmarks can be used to compare performance between:
- Timely dataflow implementations
- Differential dataflow implementations  
- Hydro implementations in the main repository

To compare with Hydro benchmarks, run the corresponding benchmarks in both repositories and compare the results in their respective `target/criterion/` directories.

## Dependencies

This repository depends on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `dfir_rs` (from hydro-project/hydro)
- `criterion` (v0.5.0) for benchmarking infrastructure

## Development

### Prerequisites

- Rust toolchain (version specified in `rust-toolchain.toml`)
- Cargo

### Building

```bash
cargo build --release
```

### Code Quality

Run formatting and linting:

```bash
# Format code
cargo fmt

# Run linter
cargo clippy --all-targets
```

## Migration Notes

These benchmarks were moved from the `bigweaver-agent-canary-hydro-zeta` repository to maintain cleaner separation of concerns and avoid unnecessary dependencies in the main repository.

For detailed migration information, see [MIGRATION.md](MIGRATION.md).

## License

Apache-2.0

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main Hydro repository