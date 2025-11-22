# bigweaver-agent-canary-zeta-hydro-deps

A dedicated repository for timely and differential-dataflow benchmarks and dependencies, separated from the main Hydro repository for improved modularity and maintainability.

## Overview

This repository contains comparative performance benchmarks for dataflow frameworks, specifically timely and differential-dataflow. These benchmarks were previously part of the main bigweaver-agent-canary-hydro-zeta repository but have been moved here to:

- **Reduce dependency complexity** in the main Hydro repository
- **Improve build times** by isolating heavy dependencies
- **Enable independent execution** of comparative benchmarks
- **Maintain performance comparison capability** between different dataflow implementations
- **Follow modular architecture** principles with clear separation of concerns

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark package
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── upcase.rs
│   │   ├── reachability_edges.txt      # Test data (533KB)
│   │   └── reachability_reachable.txt  # Expected results (38KB)
│   ├── Cargo.toml             # Benchmark package configuration
│   ├── build.rs               # Build script for code generation
│   └── README.md              # Detailed benchmark documentation
├── Cargo.toml                 # Workspace configuration
├── README.md                  # This file
├── QUICK_START.md            # Quick setup and usage guide
└── MIGRATION_NOTES.md        # Details about the benchmark migration
```

## Quick Start

### Prerequisites

- Rust (stable toolchain recommended)
- Cargo

### Clone and Build

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build the benchmarks
cargo build --release

# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability
```

For more detailed instructions, see [QUICK_START.md](QUICK_START.md).

## Benchmarks

This repository includes 8 comparative benchmarks:

| Benchmark | Description | Use Case |
|-----------|-------------|----------|
| **arithmetic** | Arithmetic operations | Basic computation performance |
| **fan_in** | Fan-in patterns | Data convergence from multiple sources |
| **fan_out** | Fan-out patterns | Data distribution to multiple consumers |
| **fork_join** | Fork-join patterns | Parallel execution and merging |
| **identity** | Identity operations | Baseline overhead measurement |
| **join** | Join operations | Data joining performance |
| **reachability** | Graph reachability | Complex graph algorithm performance |
| **upcase** | String transformations | String processing performance |

For detailed benchmark documentation, see [benches/README.md](benches/README.md).

## Performance Comparison

These benchmarks enable performance comparison between dataflow frameworks:

1. **Run benchmarks in this repository** for timely/differential-dataflow implementations:
   ```bash
   cargo bench > timely_results.txt
   ```

2. **Run equivalent DFIR benchmarks** in the main Hydro repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches > dfir_results.txt
   ```

3. **Compare results** using criterion's HTML reports or manual analysis

All benchmarks use consistent input sizes and methodology for fair comparison.

## Key Dependencies

- **timely** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (v0.13.0-dev.1) - Differential dataflow framework  
- **criterion** (v0.5.0) - Statistical benchmarking framework

## Relationship to Main Hydro Repository

This repository complements the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository:

- **Main Repository**: Contains DFIR implementation and DFIR-specific benchmarks
- **This Repository**: Contains comparative benchmarks with timely/differential-dataflow
- **Benefits**: Clean separation of dependencies, faster builds, independent execution

## Migration Information

These benchmarks were migrated from the main Hydro repository in November 2024. For complete migration details, see [MIGRATION_NOTES.md](MIGRATION_NOTES.md).

## Documentation

- **[QUICK_START.md](QUICK_START.md)** - Quick setup and usage instructions
- **[MIGRATION_NOTES.md](MIGRATION_NOTES.md)** - Detailed migration information
- **[benches/README.md](benches/README.md)** - Comprehensive benchmark documentation

## Contributing

When adding new benchmarks:

1. Follow the existing benchmark structure using criterion
2. Update `benches/Cargo.toml` with a new `[[bench]]` section
3. Include appropriate test data if needed
4. Document the benchmark purpose and usage in `benches/README.md`
5. Ensure benchmarks run independently and produce reproducible results

## Testing

```bash
# Verify builds correctly
cargo check --workspace

# Run benchmarks
cargo bench

# Generate and view HTML reports
cargo bench
# Open target/criterion/report/index.html
```

## License

Apache-2.0

## Related Links

- Main Hydro Repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Timely Dataflow: [TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- Differential Dataflow: [TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Questions or Issues?

If you encounter problems:

1. Check [QUICK_START.md](QUICK_START.md) for setup instructions
2. Review [benches/README.md](benches/README.md) for benchmark-specific help
3. Verify dependencies with `cargo tree`
4. Open an issue in this repository with details about the problem