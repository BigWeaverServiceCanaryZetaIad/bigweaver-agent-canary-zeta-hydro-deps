# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that depend on `timely` and `differential-dataflow` packages. These benchmarks have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository to prevent unnecessary dependencies from affecting the main codebase.

## Purpose

This dedicated benchmark repository serves several key purposes:

1. **Dependency Isolation**: Keeps `timely` and `differential-dataflow` dependencies separate from the main codebase
2. **Performance Testing**: Maintains comprehensive benchmarks for performance comparisons
3. **Build Optimization**: Reduces build times and complexity in the main repository
4. **Maintainability**: Provides clear separation between core functionality and performance testing infrastructure

## Repository Structure

```
.
├── benches/
│   ├── Cargo.toml          # Benchmark package configuration
│   ├── README.md           # Benchmark documentation
│   ├── build.rs            # Build script for generating benchmarks
│   └── benches/            # Individual benchmark implementations
│       ├── arithmetic.rs
│       ├── fan_in.rs
│       ├── fan_out.rs
│       ├── fork_join.rs
│       ├── identity.rs
│       ├── join.rs
│       ├── reachability.rs
│       ├── symmetric_hash_join.rs
│       ├── upcase.rs
│       ├── futures.rs
│       ├── micro_ops.rs
│       └── words_diamond.rs
├── Cargo.toml              # Workspace configuration
├── rust-toolchain.toml     # Rust toolchain specification
├── rustfmt.toml            # Code formatting configuration
└── clippy.toml             # Linting configuration
```

## Benchmarks

The repository includes benchmarks organized by dataflow patterns and operations:

- **arithmetic**: Basic arithmetic operations through dataflow pipelines
- **fan_in**: Multiple inputs converging to a single output
- **fan_out**: Single input distributing to multiple outputs
- **fork_join**: Parallel processing with join operations
- **identity**: Simple pass-through operations
- **join**: Data joining operations
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join implementations
- **upcase**: String transformation operations
- **futures**: Async futures-based operations
- **micro_ops**: Micro-level operation benchmarks
- **words_diamond**: Diamond-shaped dataflow patterns

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Run Specific Benchmark Functions

```bash
cargo bench -p benches --bench arithmetic -- timely
```

## Dependencies

The benchmarks depend on:

- **timely-master**: Timely dataflow framework
- **differential-dataflow-master**: Differential dataflow framework
- **dfir_rs**: Hydro's dataflow IR (from main repository)
- **criterion**: Benchmarking framework
- **futures**: Async runtime abstractions
- **tokio**: Async runtime

## Development

### Prerequisites

- Rust toolchain (specified in `rust-toolchain.toml`)
- Git access to the main Hydro repository

### Building

```bash
cargo build --release
```

### Testing

```bash
cargo test -p benches
```

## Related Repositories

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)
- **Documentation**: See the main repository for comprehensive documentation

## Contributing

Contributions should follow the guidelines established in the main Hydro repository. Please ensure:

1. New benchmarks follow existing naming conventions
2. Code is formatted with `rustfmt` and passes `clippy` checks
3. Benchmarks are documented with clear explanations
4. Performance comparisons are included where relevant

## License

Apache-2.0 (same as the main Hydro project)