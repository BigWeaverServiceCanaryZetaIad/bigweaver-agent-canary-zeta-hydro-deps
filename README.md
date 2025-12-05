# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance testing code for the Hydro distributed programming framework, specifically focused on consensus and transaction protocols.

## Overview

This repository was created to separate benchmark code and its dependencies from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation provides:

- **Clean Code Organization**: Benchmark code isolated from production code
- **Independent Evolution**: Benchmarks can be updated without affecting the main codebase
- **Performance Tracking**: Dedicated space for performance testing and comparison
- **Reduced Dependencies**: Benchmark-specific dependencies don't clutter the main repository

## Contents

### Benchmarks (`hydro_benchmarks/`)

Performance benchmarks for distributed protocols:

- **Paxos Consensus**: Multi-replica consensus protocol with key-value store
- **Two-Phase Commit**: Distributed transaction coordination protocol
- **Benchmark Framework**: Reusable infrastructure for creating new benchmarks

For detailed information on available benchmarks and how to run them, see [BENCHMARKS.md](BENCHMARKS.md).

## Quick Start

### Building

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Build all crates
cargo build --release
```

### Running Benchmarks

```bash
# Run all benchmark tests
cargo test --package hydro_benchmarks

# Run specific benchmark
cargo test --package hydro_benchmarks paxos_bench

# Run with output (to see performance metrics)
cargo test --release --package hydro_benchmarks -- --nocapture
```

## Documentation

- **[BENCHMARKS.md](BENCHMARKS.md)**: Detailed guide to available benchmarks and usage
- **[BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md)**: Migration details and repository structure

## Dependencies

The benchmarks require the following Hydro framework components:

- `hydro_lang` (^0.14.0): Core language features
- `hydro_std` (^0.14.0): Standard utilities
- `hydro_deploy` (^0.14.0): Deployment framework

See individual `Cargo.toml` files for complete dependency lists.

## Performance Comparison

This repository maintains the ability to run performance comparisons across different versions of the Hydro framework. See the [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md) guide for instructions on running cross-version comparisons.

## Contributing

Contributions are welcome! When adding new benchmarks:

1. Follow the existing code structure in `hydro_benchmarks/src/cluster/`
2. Use the benchmark client framework for consistency
3. Include tests to verify correctness
4. Update documentation in `BENCHMARKS.md`

## License

Apache-2.0

## Related Projects

- [Hydro Framework](https://hydro.run) - Main project website
- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main Hydro repository
