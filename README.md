# bigweaver-agent-canary-zeta-hydro-deps

This repository contains the timely and differential-dataflow benchmarks that were previously part of the main bigweaver-agent-canary-hydro-zeta repository. These benchmarks have been migrated here to maintain clean dependency isolation and enable independent performance testing.

## Overview

This repository houses performance benchmarks comparing Hydro (dfir_rs) implementations against timely-dataflow and differential-dataflow. The benchmarks help track performance characteristics and ensure that Hydro maintains competitive performance with established dataflow systems.

## Repository Structure

```
.
├── benches/                    # Benchmark workspace
│   ├── benches/               # Individual benchmark implementations
│   │   ├── arithmetic.rs      # Arithmetic operations benchmark
│   │   ├── fan_in.rs          # Fan-in pattern benchmark
│   │   ├── fan_out.rs         # Fan-out pattern benchmark
│   │   ├── fork_join.rs       # Fork-join pattern benchmark
│   │   ├── futures.rs         # Futures-based benchmark
│   │   ├── identity.rs        # Identity transformation benchmark
│   │   ├── join.rs            # Join operations benchmark
│   │   ├── micro_ops.rs       # Micro-operations benchmark
│   │   ├── reachability.rs    # Graph reachability benchmark
│   │   ├── symmetric_hash_join.rs  # Symmetric hash join benchmark
│   │   ├── upcase.rs          # String uppercase benchmark
│   │   ├── words_diamond.rs   # Word processing diamond pattern
│   │   ├── reachability_*.txt # Test data for reachability benchmark
│   │   └── words_alpha.txt    # Word list for word benchmarks
│   ├── Cargo.toml             # Benchmark dependencies
│   ├── README.md              # Benchmark documentation
│   └── build.rs               # Build-time code generation
├── Cargo.toml                  # Workspace configuration
├── rust-toolchain.toml         # Rust toolchain specification
├── rustfmt.toml               # Code formatting rules
├── clippy.toml                # Linting configuration
├── BENCHMARK_MIGRATION.md      # Migration documentation
└── README.md                  # This file
```

## Getting Started

### Prerequisites

- Rust toolchain (automatically configured via `rust-toolchain.toml` to version 1.91.1)
- Git access to the bigweaver-agent-canary-hydro-zeta repository (for dfir_rs and sinktools dependencies)

### Building

To build the benchmarks:

```bash
cargo build --workspace
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

Run a quick subset of benchmarks (if available):
```bash
cargo bench -p benches -- --quick
```

## Benchmarks

### Available Benchmarks

1. **arithmetic** - Tests basic arithmetic operations in dataflow graphs
2. **fan_in** - Tests fan-in patterns where multiple streams merge
3. **fan_out** - Tests fan-out patterns where streams split
4. **fork_join** - Tests fork-join parallel patterns
5. **futures** - Tests asynchronous future-based operations
6. **identity** - Tests identity transformations (baseline)
7. **join** - Tests join operations between streams
8. **micro_ops** - Tests individual micro-operations
9. **reachability** - Tests graph reachability algorithms
10. **symmetric_hash_join** - Tests symmetric hash join implementation
11. **upcase** - Tests string transformation operations
12. **words_diamond** - Tests diamond-pattern word processing

### Benchmark Data

- `reachability_edges.txt` - Graph edges for reachability tests
- `reachability_reachable.txt` - Expected reachability results
- `words_alpha.txt` - English word list (from https://github.com/dwyl/english-words)

## Performance Comparison

These benchmarks compare three implementations:
- **Timely Dataflow** - The original timely-dataflow system
- **Differential Dataflow** - Incremental computation on top of timely
- **Hydro (dfir_rs)** - The Hydro implementation

Results are typically displayed showing relative performance across all three systems, allowing for direct performance comparisons.

## Dependencies

This repository depends on:
- **criterion** - Benchmarking framework
- **timely-dataflow** - From https://github.com/TimelyDataflow/timely-dataflow
- **differential-dataflow** - From https://github.com/TimelyDataflow/differential-dataflow
- **dfir_rs** - From bigweaver-agent-canary-hydro-zeta repository
- **sinktools** - From bigweaver-agent-canary-hydro-zeta repository

All external dependencies (timely, differential-dataflow, dfir_rs, sinktools) are referenced via Git repositories to ensure independent execution.

## Migration History

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to maintain cleaner dependency separation. For detailed migration information, see [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md).

## Development

### Code Quality

This repository follows the same code quality standards as the main Hydro project:

- **Formatting**: Enforced via `rustfmt.toml`
- **Linting**: Enforced via `clippy.toml`
- **Toolchain**: Locked to Rust 1.91.1

Run formatting:
```bash
cargo fmt --all
```

Run linting:
```bash
cargo clippy --all
```

### Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Implement the benchmark following the existing patterns
4. Document the benchmark in this README

## Contributing

For contribution guidelines, please refer to the main Hydro repository's CONTRIBUTING.md.

## License

Apache-2.0

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository

## Questions or Issues

For questions about benchmarks or to report issues, please open an issue in this repository or refer to the main Hydro project.