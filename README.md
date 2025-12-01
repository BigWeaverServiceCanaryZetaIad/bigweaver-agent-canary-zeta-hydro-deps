# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark utilities and performance tests for dependencies used by the Hydro project, specifically `timely` and `differential-dataflow`. By separating these benchmarks into a dedicated repository, the main Hydro repository avoids direct dependencies on these packages, reducing dependency bloat and improving compilation times.

## Purpose

The purpose of this repository is to:
- Maintain benchmark code that depends on `timely` and `differential-dataflow` packages
- Enable performance comparisons between different implementations
- Keep the main `bigweaver-agent-canary-hydro-zeta` repository free from heavy dependencies
- Provide a dedicated space for performance testing and optimization work

## Repository Structure

```
.
├── timely_benchmarks/              # Benchmarks for timely dataflow
│   ├── src/
│   │   └── lib.rs                  # Utility functions and examples
│   └── benches/
│       └── timely_bench.rs         # Criterion-based benchmarks
│
├── differential_dataflow_benchmarks/  # Benchmarks for differential dataflow
│   ├── src/
│   │   └── lib.rs                  # Utility functions and examples
│   └── benches/
│       └── differential_bench.rs   # Criterion-based benchmarks
│
└── Cargo.toml                      # Workspace configuration
```

## Running Benchmarks

### Prerequisites

Ensure you have Rust installed with the version specified in `rust-toolchain.toml`.

### Running All Benchmarks

To run all benchmarks in the workspace:

```bash
cargo bench
```

### Running Specific Benchmarks

To run benchmarks for a specific crate:

```bash
# Run timely benchmarks only
cargo bench -p timely_benchmarks

# Run differential-dataflow benchmarks only
cargo bench -p differential_dataflow_benchmarks
```

### Running Tests

To verify that the benchmark code compiles and runs correctly:

```bash
cargo test
```

## Dependencies

This repository includes the following primary dependencies:

- **timely**: Version 0.12 - A low-latency cyclic dataflow computational model
- **differential-dataflow**: Version 0.12 - An implementation of differential dataflow over timely dataflow
- **criterion**: Version 0.5 - A statistics-driven benchmarking framework (dev dependency)

## Adding New Benchmarks

To add new benchmarks:

1. For timely benchmarks:
   - Add utility functions to `timely_benchmarks/src/lib.rs`
   - Add benchmark functions to `timely_benchmarks/benches/timely_bench.rs`

2. For differential-dataflow benchmarks:
   - Add utility functions to `differential_dataflow_benchmarks/src/lib.rs`
   - Add benchmark functions to `differential_dataflow_benchmarks/benches/differential_bench.rs`

3. Follow the existing patterns using the Criterion benchmarking framework

## Performance Comparisons

This repository enables performance comparisons by:
- Providing a consistent benchmarking environment
- Using Criterion for statistical analysis of results
- Supporting historical performance tracking
- Allowing comparison between different implementation approaches

## Contributing

For contributing guidelines, please refer to the main repository's [CONTRIBUTING.md](https://github.com/hydro-project/hydro/blob/main/CONTRIBUTING.md).

## License

This repository is licensed under Apache-2.0, consistent with the main Hydro project.