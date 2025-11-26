# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains performance benchmarks and dependency tests for timely-dataflow and differential-dataflow packages used in the Hydro ecosystem. These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a cleaner separation of concerns and reduce the dependency footprint of the core repository.

## Purpose

The `bigweaver-agent-canary-zeta-hydro-deps` repository serves the following purposes:

1. **Performance Testing**: Provides benchmarks for measuring and comparing performance of timely-dataflow and differential-dataflow implementations
2. **Dependency Isolation**: Maintains specialized dependencies (timely, differential-dataflow) separate from core functionality
3. **Technical Debt Management**: Reduces build times and complexity in the main repository
4. **Performance Comparison**: Enables performance comparisons between different dataflow implementations

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                         # Benchmark package
│   ├── Cargo.toml                   # Benchmark dependencies and configurations
│   ├── build.rs                     # Build script for code generation
│   ├── README.md                    # Benchmark documentation
│   └── benches/                     # Benchmark implementations
│       ├── arithmetic.rs            # Arithmetic operations benchmark
│       ├── fan_in.rs                # Fan-in pattern benchmark
│       ├── fan_out.rs               # Fan-out pattern benchmark
│       ├── fork_join.rs             # Fork-join pattern benchmark
│       ├── identity.rs              # Identity operation benchmark
│       ├── join.rs                  # Join operation benchmark
│       ├── upcase.rs                # String uppercase benchmark
│       ├── reachability.rs          # Graph reachability benchmark
│       ├── reachability_edges.txt   # Test data for reachability (532KB)
│       └── reachability_reachable.txt # Expected results for reachability (38KB)
├── Cargo.toml                       # Workspace configuration
├── README.md                        # This file
├── QUICKSTART.md                    # Quick setup guide
├── BENCHMARK_DETAILS.md             # Detailed benchmark descriptions
├── INTEGRATION_GUIDE.md             # Integration with main repository
└── CONTRIBUTING.md                  # Contribution guidelines
```

## Benchmarks

This repository includes 8 performance benchmarks:

### Timely-Dataflow Benchmarks
- **arithmetic**: Arithmetic operations through dataflow pipeline
- **fan_in**: Multiple streams converging into one
- **fan_out**: Single stream splitting into multiple streams
- **fork_join**: Fork and join pattern with filtering
- **identity**: Identity transformation (baseline)
- **join**: Two-stream join operation
- **upcase**: String uppercase transformation

### Differential-Dataflow Benchmarks
- **reachability**: Graph reachability computation using differential dataflow

## Quick Start

### Prerequisites

- Rust toolchain (latest stable)
- Cargo

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run specific benchmark:
```bash
cargo bench -p hydro-deps-benches --bench arithmetic
cargo bench -p hydro-deps-benches --bench reachability
```

Run with specific features:
```bash
cargo bench -p hydro-deps-benches --bench arithmetic -- --baseline <baseline>
```

### Building

Build the benchmark package:
```bash
cargo build -p hydro-deps-benches
```

## Integration with Main Repository

To integrate these benchmarks with the main `bigweaver-agent-canary-hydro-zeta` repository, see the [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md) for detailed instructions.

## Documentation

- **[QUICKSTART.md](QUICKSTART.md)**: Quick setup and basic usage
- **[BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md)**: Detailed description of each benchmark
- **[INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md)**: How to integrate with the main repository
- **[CONTRIBUTING.md](CONTRIBUTING.md)**: Guidelines for contributing

## Dependencies

Key dependencies:
- **timely**: Timely-dataflow framework (0.13.0-dev.1)
- **differential-dataflow**: Differential dataflow library (0.13.0-dev.1)
- **criterion**: Benchmarking framework (0.5.0)

Optional dependencies (for integration):
- **dfir_rs**: Hydro dataflow IR (from main repository)
- **sinktools**: Sink utilities (from main repository)

## Performance Testing Team

These benchmarks are maintained for the Performance Testing Team to:
- Track performance changes over time
- Compare different implementation strategies
- Identify performance regressions
- Validate optimization efforts

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)**: Main Hydro repository
- Original benchmark migration documented in the main repository's BENCHMARK_MIGRATION_GUIDE.md

## License

Apache-2.0

## Contact

For questions or issues, please contact the Development Team or Performance Testing Team.

---

**Last Updated**: 2025-11-26  
**Repository**: bigweaver-agent-canary-zeta-hydro-deps  
**Owner**: BigWeaverServiceCanaryZetaIad