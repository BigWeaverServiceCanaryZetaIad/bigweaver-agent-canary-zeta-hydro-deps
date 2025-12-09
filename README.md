# Hydro Dependencies Repository

This repository contains benchmarks and other components that depend on external frameworks, separate from the main [Hydro repository](https://github.com/hydro-project/hydro). By isolating these dependencies, we reduce the build complexity and dependency footprint of the main Hydro codebase while retaining the ability to run performance comparisons.

## Purpose

This repository serves as a dedicated location for:
- **Performance benchmarks** comparing Hydro with other dataflow frameworks (Timely Dataflow and Differential Dataflow)
- Components that require dependencies not needed in the core Hydro framework
- Tools for measuring and comparing performance characteristics

## Benchmarks

The `benches/` directory contains microbenchmarks that compare Hydro (DFIR) implementations with equivalent Timely Dataflow and Differential Dataflow implementations. These benchmarks help us:
- Track performance improvements and regressions
- Compare Hydro's performance against established dataflow frameworks
- Identify optimization opportunities

### Available Benchmarks

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Multiple inputs converging to single operator
- **fan_out**: Single input distributing to multiple operators
- **fork_join**: Fork-join patterns with filtering
- **futures**: Async/futures-based operations
- **identity**: Simple pass-through operations
- **join**: Join operations between streams
- **micro_ops**: Various micro-operations
- **reachability**: Graph reachability computations (includes test data files)
- **symmetric_hash_join**: Symmetric hash join implementations
- **upcase**: String transformation operations
- **words_diamond**: Diamond-shaped dataflow graphs

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

Run benchmarks for a specific framework within a benchmark file:
```bash
cargo bench -p benches --bench reachability -- timely
cargo bench -p benches --bench reachability -- differential
cargo bench -p benches --bench reachability -- dfir
```

### Benchmark Results

Benchmark results are generated in the `target/criterion/` directory with:
- HTML reports for visualization
- Detailed timing statistics
- Comparison with previous runs (if available)

## Dependencies

This repository includes dependencies on:
- **timely**: Timely Dataflow framework
- **differential-dataflow**: Differential Dataflow framework
- **dfir_rs**: Hydro's DFIR (Dataflow Intermediate Representation)
- **criterion**: Benchmarking framework
- Other supporting libraries

The `dfir_rs` and `sinktools` crates are referenced from the main Hydro repository via git dependencies, ensuring benchmarks always test against the latest Hydro implementation.

## Development

### Prerequisites

- Rust toolchain (see main Hydro repository for version requirements)
- Git access to the main Hydro repository

### Building

```bash
cargo build
```

### Testing

```bash
cargo test -p benches
```

## Architecture

This repository follows the team's practice of separating concerns to improve:
- **Build times**: The main Hydro repository doesn't need to build Timely/Differential dependencies
- **Dependency management**: External framework dependencies are isolated
- **Clarity**: The main repository focuses on core Hydro functionality

## Contributing

When adding new benchmarks:
1. Implement versions for Hydro (DFIR), Timely, and Differential Dataflow where applicable
2. Use the existing benchmarks as templates
3. Include any necessary test data files in the `benches/benches/` directory
4. Update this README with the new benchmark name and description
5. Follow the existing code style and structure

## Related Repositories

- [Main Hydro Repository](https://github.com/hydro-project/hydro): Core Hydro framework and DFIR implementation
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow): Timely Dataflow framework
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow): Differential Dataflow framework