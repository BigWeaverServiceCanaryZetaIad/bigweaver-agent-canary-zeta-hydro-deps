# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for Timely Dataflow and Differential Dataflow that were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a clean dependency structure.

## Purpose

The main purpose of this repository is to:
1. **Isolate Dependencies**: Keep `timely` and `differential-dataflow` dependencies separate from the main Hydro project
2. **Performance Benchmarking**: Provide comprehensive benchmarks comparing Hydro with Timely and Differential Dataflow
3. **Maintain Clean Architecture**: Allow the main repository to remain focused on core functionality
4. **Enable Performance Tracking**: Facilitate long-term performance comparison and regression detection

## Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                          # Workspace configuration
├── rust-toolchain.toml                 # Rust toolchain specification
├── README.md                           # This file
└── benches/                            # Benchmark package
    ├── Cargo.toml                      # Benchmark dependencies
    ├── README.md                       # Detailed benchmark documentation
    ├── build.rs                        # Build-time code generation
    └── benches/                        # Benchmark implementations
        ├── arithmetic.rs               # Arithmetic pipeline benchmarks
        ├── fan_in.rs                   # Stream merging benchmarks
        ├── fan_out.rs                  # Stream splitting benchmarks
        ├── fork_join.rs                # Fork-join pattern benchmarks
        ├── identity.rs                 # Identity/passthrough benchmarks
        ├── join.rs                     # Stream join benchmarks
        ├── reachability.rs             # Graph reachability benchmarks
        ├── upcase.rs                   # String manipulation benchmarks
        ├── reachability_edges.txt      # Test data for reachability
        └── reachability_reachable.txt  # Test data for reachability
```

## Quick Start

### Prerequisites

- Rust 1.91.1 or later (managed via rust-toolchain.toml)
- Cargo

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

For detailed instructions, see [benches/README.md](benches/README.md).

## Benchmarks Overview

This repository includes benchmarks that compare:
- **Raw Rust** implementations (baseline)
- **Timely Dataflow** implementations
- **Differential Dataflow** implementations (for incremental computation)
- **Hydro (dfir_rs)** implementations

### Benchmark Categories

1. **Basic Operations**: arithmetic, identity, upcase
2. **Stream Patterns**: fan_in, fan_out, fork_join
3. **Data Processing**: join
4. **Advanced Algorithms**: reachability (using differential dataflow)

## Performance Comparison

These benchmarks help answer questions like:
- How does Hydro's performance compare to Timely Dataflow?
- What is the overhead of using a dataflow framework vs raw Rust?
- How do different dataflow patterns perform?
- Where are the optimization opportunities?

### Viewing Results

Benchmark results are generated using Criterion.rs and include:
- Statistical analysis with confidence intervals
- HTML reports with graphs and charts
- Automatic regression detection
- Historical performance tracking

View HTML reports at: `target/criterion/report/index.html`

## Relationship to Main Repository

This repository is complementary to `bigweaver-agent-canary-hydro-zeta`:

- **Main Repository**: Contains the core Hydro implementation, tests, and documentation
- **This Repository (hydro-deps)**: Contains benchmarks requiring external dataflow dependencies

By separating these concerns:
- The main repository stays lean and focused
- Dependency management is simplified
- Benchmarks can evolve independently
- Performance tracking is isolated and clear

## Dependencies

### Main Dependencies
- `timely-master = "0.13.0-dev.1"` - Timely Dataflow framework
- `differential-dataflow-master = "0.13.0-dev.1"` - Differential Dataflow framework

### Benchmark Dependencies
- `criterion = "0.5.0"` - Benchmarking framework
- `tokio = "1.29.0"` - Async runtime
- `futures = "0.3"` - Async utilities

See [benches/Cargo.toml](benches/Cargo.toml) for complete dependency list.

## Development

### Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Update `benches/README.md` with benchmark details
4. Follow existing patterns for comparison benchmarks

### Running in Development

Quick test run (faster, less accurate):
```bash
cargo bench -- --test
```

Full benchmark run:
```bash
cargo bench
```

### Build System

The `build.rs` script generates code at build time:
- Generates Hydro syntax files for complex benchmarks
- Ensures consistency between Rust code and generated code
- Parameterizes benchmark complexity

## CI/CD Integration

These benchmarks can be integrated into CI/CD pipelines:

```bash
# Quick smoke test
cargo bench -- --test

# Full benchmark with baseline comparison
cargo bench -- --save-baseline main

# Compare against baseline
cargo bench -- --baseline main
```

## Contributing

Contributions are welcome! When contributing:

1. Ensure benchmarks run successfully
2. Add documentation for new benchmarks
3. Follow existing code organization patterns
4. Include comparison with timely/differential when relevant
5. Update this README if adding new categories

## License

Apache-2.0 (same as the main Hydro project)

## References

- [Main Hydro Repository](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)

## Questions and Support

For questions or issues:
1. Check the detailed documentation in `benches/README.md`
2. Review benchmark source code for implementation details
3. Open an issue in this repository
4. Refer to the main Hydro project documentation