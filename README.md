# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for timely and differential-dataflow that were separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency separation.

## Overview

This repository hosts benchmarks that compare the performance of various dataflow processing approaches, including:
- **Timely Dataflow**: Benchmarks using the timely-dataflow framework
- **Differential Dataflow**: Benchmarks using differential-dataflow for incremental computation
- **Hydroflow (dfir_rs)**: Comparative benchmarks against Hydroflow for performance analysis

## Repository Structure

```
.
├── benches/                    # Benchmark package
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs      # Arithmetic operations benchmark
│   │   ├── fan_in.rs         # Fan-in pattern benchmark
│   │   ├── fan_out.rs        # Fan-out pattern benchmark
│   │   ├── fork_join.rs      # Fork-join pattern benchmark
│   │   ├── identity.rs       # Identity operation benchmark
│   │   ├── join.rs           # Join operation benchmark
│   │   ├── reachability.rs   # Graph reachability benchmark
│   │   ├── upcase.rs         # String uppercase benchmark
│   │   ├── reachability_edges.txt        # Test data
│   │   └── reachability_reachable.txt    # Test data
│   ├── Cargo.toml            # Benchmark package configuration
│   └── build.rs              # Build script
├── Cargo.toml                # Workspace configuration
├── README.md                 # This file
├── rust-toolchain.toml       # Rust toolchain specification
├── rustfmt.toml              # Code formatting configuration
├── clippy.toml               # Linting configuration
└── .gitignore                # Git ignore rules
```

## Benchmarks

### Dataflow Pattern Benchmarks

- **arithmetic.rs**: Tests arithmetic operations across different dataflow frameworks
- **identity.rs**: Measures the overhead of passing data through the system unchanged
- **fan_in.rs**: Tests the performance of merging multiple streams
- **fan_out.rs**: Tests the performance of splitting a stream into multiple outputs
- **fork_join.rs**: Benchmarks fork-join parallelism patterns
- **join.rs**: Measures the performance of stream join operations
- **upcase.rs**: Benchmarks simple string transformation operations

### Graph Processing Benchmarks

- **reachability.rs**: Tests graph reachability computation using both timely and differential-dataflow

## Prerequisites

- Rust toolchain (version specified in `rust-toolchain.toml`)
- Cargo package manager

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmark

```bash
# Run arithmetic benchmark
cargo bench --bench arithmetic

# Run reachability benchmark
cargo bench --bench reachability

# Run join benchmark
cargo bench --bench join
```

### Run Benchmarks with Filters

```bash
# Run only timely-related benchmarks
cargo bench timely

# Run only hydroflow-related benchmarks
cargo bench dfir_rs
```

## Benchmark Output

Benchmarks are run using the [Criterion.rs](https://github.com/bheisler/criterion.rs) framework, which provides:
- Statistical analysis of performance
- HTML reports with graphs (in `target/criterion/`)
- Comparison with previous runs to detect performance regressions

## Dependencies

### Core Dependencies

- **timely-dataflow**: Streaming dataflow framework
  - Package: `timely-master`
  - Version: `0.13.0-dev.1`

- **differential-dataflow**: Incremental computation framework built on timely
  - Package: `differential-dataflow-master`
  - Version: `0.13.0-dev.1`

### Comparison Dependencies

- **dfir_rs (Hydroflow)**: For performance comparison benchmarks
  - Source: Git repository (hydro-project/hydro)
  
- **sinktools**: Utility library for Hydroflow benchmarks
  - Source: Git repository (hydro-project/hydro)

### Testing & Utilities

- **criterion**: Benchmarking framework with statistical analysis
- **tokio**: Async runtime for async benchmarks
- **futures**: Async utilities
- **rand**: Random number generation for test data
- **rand_distr**: Random distributions
- **seq-macro**: Macro utilities
- **static_assertions**: Compile-time assertions
- **nameof**: Name reflection utilities

## Performance Comparison

These benchmarks enable performance comparison between:

1. **Raw/Baseline**: Pure Rust implementations without dataflow frameworks
2. **Iterator-based**: Standard Rust iterator chains
3. **Timely Dataflow**: Using the timely-dataflow framework
4. **Differential Dataflow**: Using differential-dataflow for incremental computation
5. **Hydroflow (dfir_rs)**: Both compiled and surface syntax variants

This comprehensive comparison helps identify the performance characteristics and overhead of each approach.

## Development

### Code Formatting

```bash
cargo fmt
```

### Linting

```bash
cargo clippy
```

### Building

```bash
cargo build --release
```

## Migration History

This repository was created to separate timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository. This separation provides:

- **Cleaner Dependencies**: Isolates timely/differential-dataflow dependencies from the main codebase
- **Focused Testing**: Dedicated environment for dataflow framework performance testing
- **Better Organization**: Maintains separation of concerns between core functionality and external framework comparisons

For details on the migration, see the `BENCHMARK_REMOVAL_SUMMARY.md` in the bigweaver-agent-canary-hydro-zeta repository.

## License

Apache-2.0

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main Hydroflow implementation
- [hydro-project/hydro](https://github.com/hydro-project/hydro): Upstream Hydroflow project

## Contributing

When adding new benchmarks:

1. Add the benchmark file to `benches/benches/`
2. Update `benches/Cargo.toml` to include the new `[[bench]]` entry
3. Ensure the benchmark follows the existing patterns and uses criterion
4. Update this README to document the new benchmark
5. Run the benchmark locally to verify it works correctly

## Support

For issues related to:
- Benchmark functionality: File an issue in this repository
- Hydroflow (dfir_rs) implementation: See the [hydro-project/hydro](https://github.com/hydro-project/hydro) repository
- Timely/Differential Dataflow: See the [TimelyDataflow](https://github.com/TimelyDataflow) organization