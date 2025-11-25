# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and tests for external dependencies used by the Hydro project, specifically Timely Dataflow and Differential Dataflow.

## Purpose

This repository maintains a clean separation between:
- Core Hydro functionality (in `bigweaver-agent-canary-hydro-zeta`)
- Dependency-specific benchmarks and tests (in this repository)

This separation allows for:
- Independent versioning and development of dependency benchmarks
- Reduced build times for the main repository
- Better organization of performance testing infrastructure
- Easier maintenance and updates of dependency-related code

## Contents

### timely-benchmarks

Microbenchmarks comparing Timely Dataflow, Differential Dataflow, and Hydro implementations.

See [timely-benchmarks/README.md](./timely-benchmarks/README.md) for details.

## Quick Start

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark suite
cargo bench -p timely-benchmarks

# Run individual benchmark
cargo bench -p timely-benchmarks --bench reachability
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # This file
├── MIGRATION.md                  # Migration documentation
└── timely-benchmarks/           # Timely/Differential benchmarks
    ├── Cargo.toml
    ├── README.md
    ├── build.rs
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── upcase.rs
```

## Development

### Adding New Benchmarks

1. Add benchmark file to `timely-benchmarks/benches/`
2. Add corresponding `[[bench]]` entry in `timely-benchmarks/Cargo.toml`
3. Update documentation

### Dependencies

Benchmarks depend on:
- `dfir_rs` from the main Hydro repository
- `timely` and `differential-dataflow` from their respective repositories
- `criterion` for benchmarking infrastructure

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main Hydro repository

## License

Apache-2.0

## Migration History

- **2024-11-25**: Initial repository setup with timely and differential-dataflow benchmarks migrated from main repository