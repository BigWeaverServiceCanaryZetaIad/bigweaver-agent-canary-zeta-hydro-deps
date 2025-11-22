# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for external Hydro dependencies, specifically timely and differential-dataflow.

## Purpose

This repository was created to maintain a cleaner separation of concerns between the core Hydro functionality
and benchmarks for external dependencies. By separating these benchmarks:

- The main Hydro repository avoids unnecessary dependencies
- Build times are improved for the main repository
- The codebase remains focused and lean
- Benchmarks can be maintained independently

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks for:

- **Timely Dataflow**: Benchmarks for various timely dataflow patterns and operations
- **Differential Dataflow**: Benchmarks for differential dataflow computations

See [benches/README.md](benches/README.md) for detailed information on running benchmarks.

## Quick Start

### Running All Benchmarks

```bash
cargo bench -p timely-differential-benches
```

### Running Specific Benchmarks

```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
```

## Documentation

- **[MIGRATION_NOTES.md](MIGRATION_NOTES.md)** - Detailed migration information and rationale
- **[REMOVAL_SUMMARY.md](REMOVAL_SUMMARY.md)** - Summary of files removed from main repository
- **[CHANGES_README.md](CHANGES_README.md)** - Comprehensive overview of all changes
- **[benches/README.md](benches/README.md)** - Benchmark-specific documentation

## Performance Comparison

These benchmarks support performance comparison with the main Hydro repository benchmarks.
Both repositories use Criterion 0.5.0 with compatible configurations, allowing for
cross-repository performance analysis.

For details on comparing performance, see the [Performance Comparison](MIGRATION_NOTES.md#performance-comparison-functionality)
section in MIGRATION_NOTES.md.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                  # Workspace configuration
├── README.md                   # This file
├── MIGRATION_NOTES.md          # Detailed migration documentation
├── REMOVAL_SUMMARY.md          # Summary of removals from main repo
├── CHANGES_README.md           # Comprehensive changes overview
└── benches/                    # Benchmark package
    ├── Cargo.toml              # Benchmark dependencies and targets
    ├── README.md               # Benchmark usage documentation
    └── benches/                # Benchmark source files
        ├── arithmetic.rs       # Arithmetic operations benchmark
        ├── fan_in.rs           # Fan-in pattern benchmark
        ├── fan_out.rs          # Fan-out pattern benchmark
        ├── fork_join.rs        # Fork-join pattern benchmark
        ├── identity.rs         # Identity transformation benchmark
        ├── join.rs             # Join operations benchmark
        ├── reachability.rs     # Graph reachability benchmark
        ├── upcase.rs           # String uppercase benchmark
        └── *.txt               # Test data files
```

## Contributing

For contribution guidelines, please refer to the main Hydro repository's CONTRIBUTING.md.

## License

Apache-2.0

## Related Repositories

- **Main Hydro Repository**: Contains core Hydro functionality and dfir_rs benchmarks
- **Hydro Project**: https://github.com/hydro-project/hydro