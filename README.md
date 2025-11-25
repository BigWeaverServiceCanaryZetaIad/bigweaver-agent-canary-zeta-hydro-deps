# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for Hydroflow that require external packages like `timely` and `differential-dataflow`. These components have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a cleaner dependency structure in the core codebase.

## Purpose

The separation of benchmarks achieves several key objectives:

1. **Dependency Management**: Isolates `timely` and `differential-dataflow` dependencies from the main repository
2. **Build Optimization**: Reduces build times for the core Hydroflow codebase
3. **Separation of Concerns**: Maintains clear boundaries between core functionality and performance testing
4. **Flexibility**: Allows independent evolution of benchmarking infrastructure

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                   # Workspace configuration
├── README.md                    # This file
├── BENCHMARK_DETAILS.md         # Detailed benchmark descriptions
└── benches/                     # Benchmark package
    ├── Cargo.toml              # Benchmark dependencies and configuration
    └── benches/                # Individual benchmark files
        ├── arithmetic.rs       # Arithmetic operation benchmarks
        ├── fan_in.rs          # Fan-in pattern benchmarks
        ├── fan_out.rs         # Fan-out pattern benchmarks
        ├── fork_join.rs       # Fork-join pattern benchmarks
        ├── identity.rs        # Identity operation benchmarks
        ├── join.rs            # Join operation benchmarks
        ├── micro_ops.rs       # Micro-operation benchmarks
        ├── reachability.rs    # Graph reachability benchmarks
        ├── symmetric_hash_join.rs  # Hash join benchmarks
        ├── upcase.rs          # String transformation benchmarks
        ├── reachability_edges.txt  # Test data for reachability
        └── reachability_reachable.txt  # Expected results for reachability
```

## Getting Started

### Prerequisites

- Rust (latest stable version recommended)
- Cargo (comes with Rust)

### Building

To build the benchmarks:

```bash
cargo build --release
```

### Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
```

To run benchmarks with specific filtering:

```bash
cargo bench -- <filter_pattern>
```

## Benchmark Descriptions

### Core Benchmarks

- **arithmetic**: Tests arithmetic operations across dataflow pipelines
- **fan_in**: Measures performance of multiple inputs converging to a single output
- **fan_out**: Measures performance of single input splitting to multiple outputs
- **fork_join**: Tests fork-join parallelism patterns
- **identity**: Baseline benchmarks for data passing without transformation
- **join**: Tests various join operations between data streams
- **micro_ops**: Fine-grained benchmarks for individual operations
- **reachability**: Graph reachability using differential dataflow
- **symmetric_hash_join**: Specialized hash join implementations
- **upcase**: String transformation benchmarks

For detailed descriptions of each benchmark, see [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md).

## Comparison with Main Repository

These benchmarks provide performance comparisons between:

- **Hydroflow**: Modern dataflow runtime from the main repository
- **Timely Dataflow**: Industry-standard dataflow system
- **Differential Dataflow**: Incremental computation framework

The benchmarks help:
- Validate Hydroflow performance characteristics
- Identify optimization opportunities
- Ensure competitive performance with established frameworks

## Dependencies

Key dependencies include:

- **timely-master**: Timely dataflow framework (v0.13.0-dev.1)
- **differential-dataflow-master**: Differential dataflow library (v0.13.0-dev.1)
- **criterion**: Benchmarking framework with statistical analysis
- **hydroflow**: The main Hydroflow library (from git main branch)

See `benches/Cargo.toml` for the complete dependency list.

## Integration with Main Repository

This repository complements the main `bigweaver-agent-canary-hydro-zeta` repository by:

1. **Maintaining Benchmark Continuity**: Preserves all benchmark functionality previously in the main repo
2. **Enabling Performance Tracking**: Allows ongoing performance comparison and regression detection
3. **Supporting Development**: Provides tools for validating performance improvements

## Contributing

When adding new benchmarks:

1. Place benchmark files in `benches/benches/`
2. Add corresponding `[[bench]]` entry in `benches/Cargo.toml`
3. Follow the existing benchmark structure and naming conventions
4. Include documentation in `BENCHMARK_DETAILS.md`
5. Ensure benchmarks run successfully with `cargo bench`

## CI/CD Integration

To integrate these benchmarks into your CI/CD pipeline:

```bash
# Run benchmarks and save results
cargo bench -- --save-baseline main

# Compare against baseline
cargo bench -- --baseline main
```

## Related Documentation

- Main Repository: `bigweaver-agent-canary-hydro-zeta`
- See main repo's `BENCHMARK_REMOVAL.md` for migration context
- See main repo's `CHANGES_SUMMARY.md` for change history

## Performance Results

Benchmark results are generated using Criterion and include:

- Statistical analysis (mean, median, standard deviation)
- HTML reports with visualizations
- Comparison between Hydroflow and Timely/Differential implementations

Results are stored in `target/criterion/` after running benchmarks.

## License

Apache-2.0

## Questions and Support

For questions about:
- **Benchmarks**: Check `BENCHMARK_DETAILS.md` or the inline documentation in benchmark files
- **Dependencies**: Refer to `benches/Cargo.toml`
- **Main Repository**: See the `bigweaver-agent-canary-hydro-zeta` repository

---

**Repository Version**: 1.0  
**Last Updated**: 2024  
**Purpose**: Benchmark and dependency isolation for Hydroflow project