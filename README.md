# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing performance between different dataflow implementations:
- **Timely Dataflow**: Low-latency streaming dataflow system
- **Differential Dataflow**: Incremental computation framework built on Timely
- **Hydroflow/dfir_rs**: The Hydro project's dataflow implementation

## Purpose

This repository was created to:
1. Isolate timely and differential-dataflow dependencies from the main Hydro repository
2. Maintain performance comparison capabilities across different dataflow implementations
3. Enable independent execution and monitoring of benchmarks
4. Reduce dependency complexity in the main codebase

## Repository Structure

```
.
├── benches/              # Benchmark implementations
│   ├── benches/          # Individual benchmark files
│   ├── Cargo.toml        # Package configuration with dependencies
│   ├── README.md         # Benchmark-specific documentation
│   └── build.rs          # Build script for generated benchmarks
├── Cargo.toml            # Workspace configuration
└── README.md             # This file
```

## Quick Start

### Prerequisites

- Rust toolchain (2024 edition)
- Git

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

To run only dfir (Hydroflow) benchmarks:
```bash
cargo bench -p benches -- dfir
```

To run micro-operation benchmarks:
```bash
cargo bench -p benches -- micro/ops/
```

### Available Benchmarks

The following benchmarks are available for performance comparison:

- **arithmetic**: Arithmetic operations and computations
- **fan_in**: Multiple inputs converging to single output
- **fan_out**: Single input branching to multiple outputs
- **fork_join**: Parallel execution with synchronization
- **identity**: Pass-through operations (baseline performance)
- **join**: Data joining operations
- **micro_ops**: Micro-benchmarks for individual operations
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join implementations
- **upcase**: String transformation operations
- **words_diamond**: Diamond-shaped dataflow pattern
- **futures**: Async/future-based operations

Each benchmark typically includes implementations for:
- Timely Dataflow
- Differential Dataflow
- Hydroflow/dfir_rs (referred to as "dfir" or "spinachflow" in some benchmarks)

## Performance Comparison

The benchmarks are designed to provide fair comparisons between different dataflow implementations. Results are generated using the [Criterion](https://github.com/bheisler/criterion.rs) benchmarking framework, which provides:

- Statistical analysis of performance
- HTML reports with visualizations
- Detection of performance regressions
- Comparison between different implementations

### Viewing Results

After running benchmarks, HTML reports are generated in:
```
target/criterion/
```

Open `target/criterion/report/index.html` in your browser to view detailed performance analysis.

## CI/CD Integration

This repository includes GitHub Actions workflows for:
- Automated benchmark execution on schedule
- Performance tracking over time
- Publishing results to GitHub Pages

See `.github/workflows/benchmark.yml` for workflow configuration.

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main Hydro project repository
  - Repository: https://github.com/hydro-project/hydro
  - Contains core Hydroflow/dfir_rs implementation

## Documentation

For more detailed information, see:
- [Benchmark Documentation](benches/README.md) - Detailed benchmark usage
- [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) - Migration history and rationale
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines

## Dependencies

### External Dependencies

- **timely-master**: Timely Dataflow (v0.13.0-dev.1)
- **differential-dataflow-master**: Differential Dataflow (v0.13.0-dev.1)
- **criterion**: Benchmarking framework (v0.5.0)

### Internal Dependencies (from main Hydro repository)

- **dfir_rs**: Hydroflow runtime
- **sinktools**: Utility tools for dataflow sinks

These are pulled from the main Hydro repository via git dependencies.

## Development

### Building

```bash
cargo build
```

### Running Tests

```bash
cargo test -p benches
```

### Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`
2. Add the benchmark configuration to `benches/Cargo.toml`
3. Implement comparisons for relevant dataflow systems
4. Update documentation

## License

Apache-2.0

## Contact

For questions or issues related to these benchmarks, please refer to the main Hydro project repository.