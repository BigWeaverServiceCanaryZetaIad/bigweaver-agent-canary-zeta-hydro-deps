# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and components that depend on external dataflow systems, specifically [timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow). These benchmarks compare the performance of Hydroflow/dfir_rs implementations against these established dataflow systems.

## Purpose

This repository was created to maintain separation of concerns between:
- The core Hydroflow library (in [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta))
- Performance comparison benchmarks that require external dependencies

By separating these benchmarks, we achieve:
1. **Reduced dependency complexity** in the main Hydroflow repository
2. **Faster build times** for the core library
3. **Cleaner dependency tree** for projects using Hydroflow
4. **Maintained performance comparison capabilities** for development and research

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Workspace configuration
├── README.md               # This file
└── benches/                # Benchmark package
    ├── Cargo.toml          # Benchmark dependencies and configuration
    ├── README.md           # Detailed benchmark documentation
    ├── build.rs            # Build-time code generation
    └── benches/            # Benchmark implementations
        ├── arithmetic.rs           # Arithmetic operations comparison
        ├── fan_in.rs               # Fan-in pattern comparison
        ├── fan_out.rs              # Fan-out pattern comparison
        ├── fork_join.rs            # Fork-join pattern comparison
        ├── identity.rs             # Identity operations comparison
        ├── join.rs                 # Join operations comparison
        ├── reachability.rs         # Graph reachability comparison
        ├── upcase.rs               # String uppercase comparison
        ├── reachability_edges.txt  # Test data for reachability
        ├── reachability_reachable.txt  # Expected results
        └── words_alpha.txt         # Word list test data
```

## Quick Start

### Prerequisites

- Rust toolchain (edition 2021 or later)
- Git access to the main Hydroflow repository
- Network access for dependency resolution

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run a specific benchmark:
```bash
cargo bench -p hydro-deps-benches --bench arithmetic
```

For detailed instructions and benchmark descriptions, see [benches/README.md](benches/README.md).

## Available Benchmarks

This repository contains the following performance benchmarks:

| Benchmark | Description | Tests |
|-----------|-------------|-------|
| **arithmetic** | Arithmetic pipeline operations | Data transformation through multiple stages |
| **fan_in** | Multiple streams merging to one | Union operations and data merging |
| **fan_out** | Single stream to multiple consumers | Broadcast and parallel processing |
| **fork_join** | Alternating splits and merges | Complex dataflow graphs |
| **identity** | Pass-through operations | Framework overhead baseline |
| **join** | Hash join operations | Key-value matching and state management |
| **reachability** | Graph reachability algorithms | Iterative/recursive dataflow patterns |
| **upcase** | String transformations | String processing performance |

Each benchmark compares implementations across:
- **Hydroflow/dfir_rs**: The Hydro dataflow library
- **Timely Dataflow**: Low-latency cyclic dataflow
- **Differential Dataflow**: Differential computation on timely

## Dependencies

This repository depends on:

### External Dataflow Systems
- `timely-dataflow` (version 0.13.0-dev.1) - Core timely dataflow library
- `differential-dataflow` (version 0.13.0-dev.1) - Differential computation library

### Hydroflow Components
- `dfir_rs` - Core Hydroflow dataflow library
- `sinktools` - Utility tools for dataflow sinks

### Benchmark Framework
- `criterion` - Statistical benchmarking framework with HTML reports

### Supporting Libraries
- `tokio` - Async runtime
- `futures` - Async primitives
- `rand`, `rand_distr` - Random number generation
- Other utility crates (see `benches/Cargo.toml`)

## Performance Comparison

These benchmarks enable performance analysis across multiple dimensions:

1. **Throughput**: Operations per second
2. **Latency**: End-to-end processing time
3. **Memory efficiency**: Resource consumption patterns
4. **Scalability**: Performance with varying data sizes

Results are generated using Criterion.rs, providing statistical analysis, HTML reports, and regression detection.

## Documentation

- **[benches/README.md](benches/README.md)** - Comprehensive benchmark documentation including:
  - Detailed descriptions of each benchmark
  - Instructions for running and interpreting results
  - Performance comparison guidelines
  - Troubleshooting tips
  - Contributing guidelines

## Development Workflow

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Implement benchmarks for Hydroflow, timely, and differential-dataflow
3. Add a `[[bench]]` entry in `benches/Cargo.toml`
4. Update documentation in `benches/README.md`
5. Test the benchmark thoroughly

### Running Tests

Check that benchmarks compile:
```bash
cargo check -p hydro-deps-benches
```

Run a quick test:
```bash
cargo bench -p hydro-deps-benches -- --quick
```

### Updating Dependencies

To update the main Hydroflow dependencies:
```bash
cargo update -p dfir_rs
cargo update -p sinktools
```

To update external dataflow libraries:
```bash
cargo update -p timely-master
cargo update -p differential-dataflow-master
```

## Continuous Integration

When setting up CI for this repository:

1. Use a consistent benchmark environment
2. Consider running benchmarks on dedicated hardware
3. Store baseline results for regression detection
4. Use `cargo bench -- --save-baseline <name>` for reproducible comparisons

## Migration History

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository as part of a strategic refactoring initiative to:

- Reduce dependency complexity in the core library
- Improve build times for most users
- Maintain clean separation between core functionality and external comparisons
- Enable independent performance testing without full repository builds

For migration details, see `BENCHMARK_REMOVAL_SUMMARY.md` in the main repository.

## Related Projects

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydroflow repository
- **[Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)** - Timely dataflow computational model
- **[Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)** - Differential computation framework

## Contributing

Contributions are welcome! Please:

1. Follow the existing code style and conventions
2. Add tests and benchmarks for new functionality
3. Update documentation accordingly
4. Ensure all benchmarks compile and run successfully
5. Provide statistical significance in performance claims

## License

This project is licensed under the Apache License 2.0 - see the LICENSE file for details.

## Support

For questions or issues:
- Open an issue in this repository for benchmark-specific questions
- Refer to the main Hydroflow repository for general Hydroflow questions
- See the detailed documentation in [benches/README.md](benches/README.md)

## Acknowledgments

These benchmarks enable comparative performance analysis with:
- The Timely Dataflow team for their excellent dataflow system
- The Differential Dataflow team for differential computation implementations
- The Criterion.rs team for the robust benchmarking framework