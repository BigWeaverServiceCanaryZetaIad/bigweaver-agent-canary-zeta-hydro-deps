# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro (dfir_rs) performance with timely and differential-dataflow frameworks. These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain a modular structure with clear separation of concerns.

## Overview

This repository maintains benchmarks that require timely and differential-dataflow dependencies. By isolating these benchmarks here, we keep the main Hydro repository lean and focused on core functionality while preserving the ability to perform cross-framework performance comparisons.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/              # Benchmark implementations
│   │   ├── arithmetic.rs     # Arithmetic operations benchmark
│   │   ├── fan_in.rs         # Fan-in pattern benchmark
│   │   ├── fan_out.rs        # Fan-out pattern benchmark
│   │   ├── fork_join.rs      # Fork-join pattern benchmark
│   │   ├── identity.rs       # Identity operations benchmark
│   │   ├── join.rs           # Join operations benchmark
│   │   ├── reachability.rs   # Graph reachability benchmark
│   │   ├── upcase.rs         # Uppercase operations benchmark
│   │   ├── reachability_edges.txt     # Edge data for reachability
│   │   └── reachability_reachable.txt # Expected reachable nodes
│   ├── src/
│   │   └── lib.rs            # Library crate
│   ├── build.rs              # Build script for code generation
│   └── Cargo.toml            # Package configuration
├── Cargo.toml                # Workspace configuration
└── README.md                 # This file
```

## Benchmarks

### Available Benchmarks

1. **arithmetic.rs** - Compares arithmetic pipeline operations between Hydro and timely
2. **fan_in.rs** - Tests fan-in dataflow patterns with multiple input streams
3. **fan_out.rs** - Tests fan-out dataflow patterns with multiple output streams
4. **fork_join.rs** - Evaluates fork-join patterns for parallel processing
5. **identity.rs** - Measures overhead of identity transformations
6. **join.rs** - Compares join operation implementations
7. **reachability.rs** - Graph reachability using both timely and differential-dataflow
8. **upcase.rs** - String transformation benchmarks

### Running Benchmarks

To run all benchmarks:

```bash
cargo bench -p benches
```

To run a specific benchmark:

```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
```

To run benchmarks with verbose output:

```bash
cargo bench -p benches -- --verbose
```

## Dependencies

This repository includes the following key dependencies:

- **timely** (timely-master 0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - Hydro dataflow framework (from main repository)
- **criterion** - Benchmarking framework with async support
- **tokio** - Async runtime

## Building

To build the benchmarks:

```bash
cargo build -p benches
```

To build with release optimizations:

```bash
cargo build -p benches --release
```

## Development

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Implement benchmark using criterion framework
4. Test with `cargo bench -p benches --bench <name>`

### Updating Dependencies

Dependencies can be updated by modifying `benches/Cargo.toml`. After updating:

```bash
cargo update -p benches
cargo build -p benches
cargo bench -p benches
```

## Motivation

This repository was created to:

- **Reduce Build Dependencies**: Remove timely and differential-dataflow from the main repository
- **Improve Build Times**: Decrease compilation time for the main Hydro repository
- **Maintain Modularity**: Keep clear separation between core functionality and comparative benchmarks
- **Enable Performance Comparisons**: Preserve ability to compare frameworks without cluttering main repo

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main Hydro repository
- [timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow) - Timely dataflow framework
- [differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow) - Differential dataflow framework

## Migration Notes

These benchmarks were migrated from the main repository as part of a modular reorganization effort. For migration details, see the BENCHMARK_REMOVAL_SUMMARY.md in the main repository.

## License

Apache-2.0

## Contributing

See CONTRIBUTING.md for contribution guidelines.