# bigweaver-agent-canary-zeta-hydro-deps

A dedicated repository for timely and differential-dataflow benchmarks that compare performance with Hydro/dfir_rs.

## Overview

This repository was created to maintain performance comparison benchmarks between Hydro and timely/differential-dataflow while keeping these dependencies separate from the main bigweaver-agent-canary-hydro-zeta repository.

## Purpose

- **Dependency Isolation**: Keeps timely and differential-dataflow dependencies separate from the main codebase
- **Performance Comparison**: Maintains ability to benchmark Hydro against timely and differential-dataflow
- **Clean Architecture**: Follows the team's pattern of separating concerns into dedicated repositories
- **Faster Main Builds**: Reduces build times for the main repository by isolating these dependencies

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark package
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs      # Arithmetic operations
│   │   ├── fan_in.rs          # Fan-in dataflow pattern
│   │   ├── fan_out.rs         # Fan-out dataflow pattern
│   │   ├── fork_join.rs       # Fork-join pattern
│   │   ├── identity.rs        # Identity operations
│   │   ├── join.rs            # Join operations
│   │   ├── reachability.rs    # Graph reachability
│   │   ├── upcase.rs          # String transformations
│   │   ├── reachability_edges.txt        # Graph data
│   │   └── reachability_reachable.txt    # Expected results
│   ├── build.rs               # Build script for code generation
│   ├── Cargo.toml             # Benchmark dependencies
│   └── README.md              # Detailed benchmark documentation
├── Cargo.toml                 # Workspace configuration
├── rust-toolchain.toml        # Rust toolchain specification
├── rustfmt.toml              # Code formatting rules
├── clippy.toml               # Linter configuration
├── .gitignore                # Git ignore rules
├── LICENSE                   # Apache 2.0 License
├── README.md                 # This file
├── QUICK_START.md            # Setup and quick start guide
├── RUNNING_BENCHMARKS.md     # Detailed benchmark instructions
└── MIGRATION.md              # Migration details from main repository
```

## Quick Start

### Prerequisites

- Rust toolchain (1.91.1 or as specified in rust-toolchain.toml)
- Access to bigweaver-agent-canary-hydro-zeta repository (for dfir_rs and sinktools dependencies)

### Setup

1. Clone this repository:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

2. Ensure the main repository is cloned as a sibling directory:
```bash
cd ..
git clone https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

3. Build the benchmarks:
```bash
cargo build --release -p timely-differential-benches
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run a specific benchmark:
```bash
cargo bench -p timely-differential-benches --bench arithmetic
```

For more detailed instructions, see [RUNNING_BENCHMARKS.md](RUNNING_BENCHMARKS.md).

## Available Benchmarks

| Benchmark | Description | Uses Timely | Uses Differential |
|-----------|-------------|-------------|-------------------|
| `arithmetic` | Arithmetic operations | ✅ | ❌ |
| `fan_in` | Fan-in dataflow pattern | ✅ | ❌ |
| `fan_out` | Fan-out dataflow pattern | ✅ | ❌ |
| `fork_join` | Fork-join pattern | ✅ | ❌ |
| `identity` | Identity operations | ✅ | ❌ |
| `join` | Join operations | ✅ | ❌ |
| `reachability` | Graph reachability | ✅ | ✅ |
| `upcase` | String transformations | ✅ | ❌ |

## Dependencies

### External Dependencies
- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **criterion** (v0.5.0) - Benchmarking framework

### Main Repository Dependencies
- **dfir_rs** - Hydro dataflow implementation (from bigweaver-agent-canary-hydro-zeta)
- **sinktools** - Utility crate (from bigweaver-agent-canary-hydro-zeta)

## Documentation

- **[QUICK_START.md](QUICK_START.md)** - Quick setup and usage guide
- **[RUNNING_BENCHMARKS.md](RUNNING_BENCHMARKS.md)** - Comprehensive benchmark running instructions
- **[MIGRATION.md](MIGRATION.md)** - Details about the migration from the main repository
- **[benches/README.md](benches/README.md)** - Detailed benchmark documentation

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository

## Migration Context

These benchmarks were originally part of the main bigweaver-agent-canary-hydro-zeta repository but were moved to this dedicated repository to:
1. Reduce unnecessary dependencies in the main repository
2. Improve build times for the main codebase
3. Maintain clean separation of concerns
4. Follow architectural patterns for dependency management

For details about the migration, see [MIGRATION.md](MIGRATION.md).

## Contributing

When adding new benchmarks:
1. Place benchmark files in `benches/benches/`
2. Add benchmark target in `benches/Cargo.toml`
3. Update documentation in `benches/README.md`
4. Follow existing code style (enforced by rustfmt and clippy)

## License

Apache License 2.0 - See [LICENSE](LICENSE) file for details.

## Contact

For questions or issues, please refer to the main bigweaver-agent-canary-hydro-zeta repository.