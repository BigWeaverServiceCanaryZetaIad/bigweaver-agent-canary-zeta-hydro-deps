# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on external dataflow libraries (Timely Dataflow and Differential Dataflow). These benchmarks have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency management and avoid adding these dependencies to the core codebase.

## Purpose

The benchmarks in this repository allow performance comparisons between Hydro and other dataflow frameworks:
- **Timely Dataflow**: A low-latency data-parallel dataflow system
- **Differential Dataflow**: An implementation of differential dataflow over timely dataflow

## Structure

```
.
├── benches/               # Benchmark crate
│   ├── benches/          # Individual benchmark files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── upcase.rs
│   │   └── *.txt        # Test data files
│   ├── Cargo.toml       # Benchmark dependencies
│   ├── build.rs         # Build script
│   └── README.md        # Benchmark documentation
├── Cargo.toml           # Workspace configuration
└── README.md            # This file
```

## Dependencies

The benchmarks require the following external dependencies:
- `timely-master` (version 0.13.0-dev.1): Timely dataflow library
- `differential-dataflow-master` (version 0.13.0-dev.1): Differential dataflow library
- `dfir_rs`: Hydro's dataflow implementation (from main repository)
- `sinktools`: Utilities from main repository
- `criterion`: Benchmarking framework

## Building and Running

### Prerequisites

- Rust toolchain 1.91.1 or later
- Access to the main Hydro repository for `dfir_rs` and `sinktools` dependencies

### Build

```bash
cargo build --release
```

### Run Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

See the [benches/README.md](benches/README.md) for detailed information about each benchmark.

## Architecture

This repository follows a modular architecture with clear separation of concerns:
- **Workspace Structure**: Uses Cargo workspace for organization
- **Clean Dependencies**: Keeps external dataflow dependencies isolated
- **Performance Testing**: Dedicated to comparative performance analysis

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro): Main Hydro repository
  - Contains `dfir_rs` and `sinktools` used by these benchmarks

## Contributing

When adding new benchmarks that require Timely or Differential Dataflow dependencies:
1. Add the benchmark file to `benches/benches/`
2. Update `benches/Cargo.toml` to include the new benchmark
3. Add any required test data files
4. Update the benchmark documentation

## License

Apache-2.0

## Maintainers

Part of the BigWeaverServiceCanaryZetaIad project.