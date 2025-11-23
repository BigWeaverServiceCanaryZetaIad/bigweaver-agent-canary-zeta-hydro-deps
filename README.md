# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency management and reduce compilation complexity.

## Purpose

This repository serves as a dedicated location for:
- Performance benchmarks requiring heavy dependencies (timely, differential-dataflow)
- Comparative performance analysis between different dataflow implementations
- Isolated testing environment for dependency-heavy workloads

## Contents

### Timely and Differential-Dataflow Benchmarks

The `timely-benchmarks` package contains comprehensive performance benchmarks comparing:
- Timely dataflow implementations
- Differential-dataflow implementations  
- dfir_rs implementations (from the main repository)

See [`timely-benchmarks/README.md`](timely-benchmarks/README.md) for detailed documentation.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                          # Workspace configuration
├── README.md                           # This file
└── timely-benchmarks/                  # Timely and differential-dataflow benchmarks
    ├── Cargo.toml                      # Benchmark package configuration
    ├── README.md                       # Benchmark documentation
    ├── build.rs                        # Build script for code generation
    └── benches/                        # Benchmark implementations
        ├── arithmetic.rs               # Arithmetic pipeline benchmarks
        ├── fan_in.rs                   # Fan-in pattern benchmarks
        ├── fan_out.rs                  # Fan-out pattern benchmarks
        ├── fork_join.rs                # Fork-join pattern benchmarks
        ├── identity.rs                 # Identity operation benchmarks
        ├── join.rs                     # Join operation benchmarks
        ├── reachability.rs             # Graph reachability benchmarks
        ├── upcase.rs                   # String processing benchmarks
        ├── reachability_edges.txt      # Test data for reachability
        └── reachability_reachable.txt  # Expected results for reachability

```

## Running Benchmarks

From the repository root:

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark package
cargo bench -p timely-benchmarks

# Run specific benchmark
cargo bench -p timely-benchmarks --bench arithmetic
```

## Dependencies

This repository maintains dependencies that were removed from the main repository:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)

It also references components from the main `bigweaver-agent-canary-hydro-zeta` repository for comparison:
- `dfir_rs`
- `sinktools`

## Relationship to Main Repository

This repository works in conjunction with `bigweaver-agent-canary-hydro-zeta`:

- **Main Repository**: Contains core Hydro project functionality, libraries, and lightweight benchmarks
- **This Repository**: Contains benchmarks requiring heavy dependencies that would bloat the main repository

The separation allows:
- Faster compilation times in the main repository
- Cleaner dependency management
- Isolated performance testing environment
- Preserved ability to run performance comparisons

## Migration History

These benchmarks were moved from the main repository as part of a dependency cleanup initiative:
- **Original Location**: `bigweaver-agent-canary-hydro-zeta/benches`
- **Reason**: Reduce dependency complexity and improve compilation times
- **Date**: November 2025

See `TIMELY_REMOVAL_SUMMARY.md` in the main repository for detailed migration documentation.

## Development

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` for specific version)
- Access to the main `bigweaver-agent-canary-hydro-zeta` repository (for cross-repository dependencies)

### Building

```bash
# Check all packages compile
cargo check --workspace

# Build all packages
cargo build --workspace

# Build benchmarks (compile without running)
cargo bench --no-run
```

### Testing

```bash
# Verify benchmarks compile
cargo bench -p timely-benchmarks --no-run

# Run quick benchmark test
cargo bench -p timely-benchmarks --bench arithmetic -- --quick
```

## Contributing

When adding new benchmarks or modifying existing ones:

1. Follow the existing benchmark structure and naming conventions
2. Update the relevant README.md files
3. Ensure benchmarks compile and run successfully
4. Document any new dependencies or requirements
5. Consider the impact on compilation times

## License

Apache-2.0

## Contact

For questions or issues related to these benchmarks, please refer to the main Hydro project repository or team discussions.