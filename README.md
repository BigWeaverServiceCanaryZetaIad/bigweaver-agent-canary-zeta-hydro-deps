# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and comparative benchmarks for the Hydro project that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain cleaner dependency management and separation of concerns.

## Contents

### Benchmarks (`benches/`)

Comparative microbenchmarks for Hydro with timely and differential-dataflow implementations. These benchmarks enable performance comparison studies between different dataflow frameworks.

**Key Features:**
- Comparative benchmarks with timely and differential-dataflow
- Multiple benchmark patterns (joins, fan-in/out, graph algorithms, etc.)
- Performance measurement and historical tracking via Criterion
- Separate from main repository to avoid unnecessary dependencies

See [benches/README.md](benches/README.md) for detailed benchmark documentation.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                          # Comparative benchmarks
│   ├── benches/                      # Benchmark implementations
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── futures.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   └── words_diamond.rs
│   ├── Cargo.toml                    # Benchmark dependencies
│   ├── README.md                     # Benchmark documentation
│   └── build.rs                      # Build scripts
├── Cargo.toml                        # Workspace configuration
└── README.md                         # This file
```

## Prerequisites

This repository requires access to the main Hydro repository for shared dependencies. Clone both repositories as siblings:

```bash
cd /projects/
git clone <hydro-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps
```

## Quick Start

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench identity

# View benchmark reports
open target/criterion/report/index.html
```

## Architecture

This repository is part of a microservice architecture that separates concerns:

- **Main Repository** (`bigweaver-agent-canary-hydro-zeta`): Core Hydro implementation
- **Deps Repository** (this repo): Comparative benchmarks and external dependencies

This separation provides:
- ✅ Cleaner dependency graphs in the main repository
- ✅ Reduced build times for core development
- ✅ Focused repositories with clear purposes
- ✅ Independent evolution of benchmark suites
- ✅ Easier maintenance and updates

## Migration History

The benchmarks in this repository were migrated from `bigweaver-agent-canary-hydro-zeta` as part of a dependency management initiative. The migration:

- Removed timely/differential-dataflow dependencies from the main repository
- Preserved all benchmark functionality and historical data
- Maintained performance comparison capabilities
- Improved build times and repository focus

For detailed migration information, see the MIGRATION_NOTES.md in the main repository.

## Development

### Building

```bash
# Build workspace
cargo build --workspace

# Build benchmarks (release mode recommended)
cargo build --release -p benches
```

### Testing

```bash
# Run tests
cargo test --workspace

# Verify benchmark compilation
cargo check -p benches
```

### Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/`
2. Add benchmark entry to `benches/Cargo.toml`
3. Update `benches/README.md` with benchmark description
4. Test the benchmark: `cargo bench -p benches --bench <name>`

## Performance Comparison

This repository enables systematic performance comparison between:

- **Hydro (dfir_rs)**: Modern dataflow framework
- **Timely Dataflow**: High-performance dataflow system
- **Differential Dataflow**: Incremental computation framework
- **Baseline**: Raw Rust implementations (iterators, channels, etc.)

Results help guide optimization efforts and validate design decisions.

## Contributing

When contributing benchmarks or updates:

1. Ensure benchmarks are fair and representative
2. Document benchmark methodology and assumptions
3. Test across different workload sizes
4. Coordinate changes with the main Hydro repository
5. Update documentation appropriately

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main Hydro implementation
- **hydro-project/hydro**: Upstream Hydro project

## License

Apache-2.0

## Contact

For questions about benchmarks or this repository:
- Check the main Hydro repository documentation
- Review git history for implementation details
- Coordinate with Hydro project maintainers