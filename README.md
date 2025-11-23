# Hydro Dependencies and Benchmarks Repository

This repository contains the timely and differential-dataflow benchmarks that were separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain cleaner dependency management.

## Overview

This repository provides:
- **Timely and Differential-Dataflow Benchmarks**: Performance comparison benchmarks for DFIR/Hydro vs. Timely Dataflow and Differential Dataflow
- **Required Dependencies**: All necessary dependencies from the main Hydro repository to support the benchmarks

## Repository Structure

```
.
├── benches/                    # Benchmark package
│   ├── benches/               # Individual benchmark implementations
│   ├── Cargo.toml            # Benchmark dependencies and configuration
│   └── README.md             # Benchmark-specific documentation
├── dfir_rs/                   # DFIR runtime
├── dfir_lang/                 # DFIR language support
├── dfir_macro/                # DFIR macro support
├── lattices/                  # Lattice types for CRDTs
├── sinktools/                 # Utilities for sinks
├── variadics/                 # Variadic support
└── [other dependencies]       # Additional required dependencies
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run the reachability benchmark
cargo bench -p benches --bench reachability

# Run the join benchmark
cargo bench -p benches --bench join

# Run the arithmetic benchmark
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

The following benchmarks are available:
- `arithmetic` - Arithmetic operations comparison
- `fan_in` - Fan-in operations
- `fan_out` - Fan-out operations
- `fork_join` - Fork-join patterns
- `futures` - Futures-based operations
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String uppercase operations
- `words_diamond` - Word processing in diamond topology

### Benchmark Output

Benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) for statistical analysis and HTML report generation. After running benchmarks, you can find detailed reports in:
```
target/criterion/
```

## Performance Comparison Capabilities

This repository maintains the ability to perform performance comparisons between:
- **Hydroflow/DFIR**: The primary dataflow framework
- **Timely Dataflow**: A low-latency cyclic dataflow framework
- **Differential Dataflow**: An incremental computation framework built on Timely

Each benchmark typically implements the same algorithm using different frameworks to allow for direct performance comparison.

## Dependencies

### Key Dependencies

- **timely** (timely-master v0.13.0-dev.1): Timely Dataflow framework
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1): Differential Dataflow framework
- **criterion**: Benchmarking framework with statistical analysis
- **dfir_rs**: DFIR runtime and operators

See `benches/Cargo.toml` for the complete list of dependencies.

## Development

### Building the Repository

```bash
# Check all packages compile
cargo check --workspace

# Build all packages
cargo build --workspace

# Run tests
cargo test --workspace
```

### Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`
2. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
3. Implement your benchmark using Criterion
4. Run and validate: `cargo bench -p benches --bench your_benchmark_name`

## Why This Separation?

This repository was created to:
1. **Reduce Dependency Complexity**: The main Hydro repository no longer needs timely/differential-dataflow dependencies
2. **Improve Build Times**: Developers working on core Hydro functionality don't need to compile benchmark-only dependencies
3. **Maintain Performance Testing**: All benchmarking capabilities are preserved and fully functional
4. **Enable Focused Development**: Benchmark development can proceed independently of core features

## Relationship to Main Repository

This repository depends on the main bigweaver-agent-canary-hydro-zeta repository as a library. The dependencies included here are copied to ensure the benchmarks can run standalone without complex path references.

## License

Apache-2.0

See [LICENSE](LICENSE) for details.

## Related Documentation

- Main Repository: bigweaver-agent-canary-hydro-zeta
- For benchmark migration details, see the BENCHMARK_MIGRATION.md in the main repository
- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)

## Contributing

When contributing benchmarks:
1. Follow the existing benchmark structure
2. Include both Hydroflow and comparison framework implementations
3. Document the benchmark purpose and methodology
4. Ensure benchmarks are deterministic and reproducible
5. Add appropriate documentation in the benchmark file

## Questions or Issues?

For questions about:
- **Benchmarks**: Refer to `benches/README.md`
- **Main Hydro Project**: See the main repository documentation
- **Performance Results**: Check the Criterion HTML reports in `target/criterion/`