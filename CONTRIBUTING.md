# Contributing to bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks that compare Hydro (dfir_rs) performance with Timely Dataflow and Differential Dataflow. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the dependency footprint of the main repository minimal.

## Repository Structure

```
.
├── Cargo.toml                 # Workspace manifest
├── README.md                  # Repository documentation
├── MIGRATION.md               # Migration guide explaining the move
├── CONTRIBUTING.md            # This file
└── benches/                   # Benchmarks package
    ├── Cargo.toml            # Benchmark dependencies
    ├── README.md             # Benchmark usage guide
    ├── build.rs              # Build script for generating benchmark code
    └── benches/              # Benchmark source files
        ├── *.rs              # Individual benchmark files
        └── *.txt             # Test data files
```

## Building and Testing

### Prerequisites

- Rust (stable channel, 2024 edition)
- Network access to fetch git dependencies from the main repository

### Building

```bash
cargo build -p benches
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench arithmetic
```

View benchmark results:
```bash
open target/criterion/report/index.html
```

## Adding New Benchmarks

To add a new benchmark that compares Hydro with Timely/Differential:

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
3. Follow the existing benchmark patterns for consistency
4. Run the benchmark to verify it works

## Benchmark Guidelines

- Use the Criterion framework for all benchmarks
- Include comparisons with both Hydro and Timely/Differential where applicable
- Document what each benchmark is measuring
- Use realistic data sizes that reflect actual use cases
- Include both warm-up iterations and measurement iterations

## Dependencies

The benchmarks depend on:

- **dfir_rs**: Referenced via git from the main repository
- **sinktools**: Referenced via git from the main repository  
- **timely-master**: Timely Dataflow framework
- **differential-dataflow-master**: Differential Dataflow framework
- **criterion**: Benchmarking framework

When the main repository updates these dependencies, this repository will automatically use the updated versions on the next build.

## Continuous Integration

Currently, benchmarks are run manually. If you'd like to set up CI for this repository:

1. Consider the runtime of benchmarks (they can be slow)
2. Decide whether to run on every commit or periodically
3. Set up result tracking to monitor performance over time

## Questions or Issues

For questions about:
- **Benchmark results or methodology**: Open an issue in this repository
- **Hydro/dfir_rs functionality**: Open an issue in the main bigweaver-agent-canary-hydro-zeta repository
- **Timely/Differential functionality**: Refer to the respective upstream projects

## Code Style

Follow the Rust community style guidelines:
- Run `cargo fmt` before committing
- Run `cargo clippy` and address warnings
- Use meaningful variable names
- Document complex benchmark logic