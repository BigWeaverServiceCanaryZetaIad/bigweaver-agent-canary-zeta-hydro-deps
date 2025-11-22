# Hydro Dependencies - Timely and Differential-Dataflow Benchmarks

This repository contains timely-dataflow and differential-dataflow benchmarks for the Hydro project. These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

- Reduce dependency complexity in the main repository
- Improve build times and maintenance overhead  
- Focus the main repository on core Hydro functionality
- Allow independent benchmark development and versioning
- Enable optional performance testing (clone only when needed)

## Overview

This repository provides comprehensive performance benchmarks comparing Hydro's DFIR and Hydroflow implementations with timely-dataflow and differential-dataflow frameworks. The benchmarks cover various dataflow patterns, operations, and algorithms to enable data-driven performance evaluation.

## Quick Start

### Prerequisites

- Rust 1.91.1 or later (specified in `rust-toolchain.toml`)
- Cargo

### Clone and Setup

```bash
# Clone this repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench identity
```

### For Local Development with Main Repository

If you're developing alongside the main Hydro repository, update `benches/Cargo.toml` to use local paths:

```toml
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                  # Workspace configuration
├── clippy.toml                 # Clippy linting configuration
├── rustfmt.toml                # Code formatting configuration
├── rust-toolchain.toml         # Rust toolchain specification
├── README.md                   # This file
├── MIGRATION_NOTES.md          # Migration documentation
├── QUICK_START.md              # Quick start guide
├── BENCHMARKING.md             # Detailed benchmarking guide
├── CHANGES.md                  # Changelog
└── benches/                    # Benchmark package
    ├── Cargo.toml              # Benchmark dependencies
    ├── README.md               # Benchmark documentation
    ├── build.rs                # Build script
    └── benches/                # Benchmark implementations
        ├── arithmetic.rs       # Arithmetic operations
        ├── fan_in.rs           # Fan-in pattern
        ├── fan_out.rs          # Fan-out pattern
        ├── fork_join.rs        # Fork-join pattern
        ├── futures.rs          # Async operations
        ├── identity.rs         # Identity operations
        ├── join.rs             # Join operations
        ├── micro_ops.rs        # Micro-operations
        ├── reachability.rs     # Graph reachability
        ├── symmetric_hash_join.rs  # Symmetric hash join
        ├── upcase.rs           # String operations
        ├── words_diamond.rs    # Word processing diamond
        ├── reachability_edges.txt      # Test data (521KB)
        ├── reachability_reachable.txt  # Test data (38KB)
        └── words_alpha.txt             # Test data (3.7MB)
```

## Available Benchmarks

### Basic Operations
- **arithmetic**: Basic arithmetic operations
- **identity**: Identity/pass-through operations
- **upcase**: String uppercase transformations
- **micro_ops**: Micro-level operation performance

### Dataflow Patterns
- **fan_in**: Multiple inputs to single output
- **fan_out**: Single input to multiple outputs
- **fork_join**: Fork-join parallelism patterns

### Join Operations
- **join**: Basic join operations
- **symmetric_hash_join**: Symmetric hash join performance

### Complex Algorithms
- **reachability**: Graph reachability algorithms
- **words_diamond**: Diamond pattern with word processing

### Async Operations
- **futures**: Futures and async operation benchmarks

## Performance Comparison

Each benchmark compares implementations across:
- **dfir_rs**: DFIR framework implementation
- **hydroflow**: Hydroflow implementation
- **timely**: Timely-dataflow implementation
- **differential**: Differential-dataflow implementation

Results include mean execution time, standard deviation, throughput measurements, and HTML reports.

## Documentation

- **[MIGRATION_NOTES.md](MIGRATION_NOTES.md)**: Complete migration details from main repository
- **[QUICK_START.md](QUICK_START.md)**: Getting started guide
- **[BENCHMARKING.md](BENCHMARKING.md)**: Detailed benchmarking procedures
- **[CHANGES.md](CHANGES.md)**: Changelog and version history
- **[benches/README.md](benches/README.md)**: Benchmark-specific documentation

## Related Repositories

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Core Hydro implementation

## Dependencies

### Core Dependencies
- `timely-master` (0.13.0-dev.1): Timely-dataflow framework
- `differential-dataflow-master` (0.13.0-dev.1): Differential-dataflow framework
- `criterion` (0.5.0): Benchmarking framework
- `dfir_rs`: DFIR implementation (from main Hydro repository)
- `sinktools`: Supporting utilities (from main Hydro repository)

### Supporting Dependencies
- `futures` (0.3): Async operations
- `tokio` (1.29.0): Async runtime
- `rand` (0.8.0), `rand_distr` (0.4.3): Random data generation

## Contributing

This repository follows the same contribution guidelines as the main Hydro project. Please ensure:
- Code passes `cargo clippy` with no warnings
- Code is formatted with `cargo fmt`
- All benchmarks compile and run successfully
- Documentation is updated for any changes

## License

Apache-2.0

## Questions or Support

For questions about these benchmarks or the migration, please:
1. Check the [MIGRATION_NOTES.md](MIGRATION_NOTES.md) for detailed information
2. Review the [BENCHMARKING.md](BENCHMARKING.md) for usage guidance
3. Refer to the main Hydro repository for core Hydro questions
4. Contact the Hydro development team