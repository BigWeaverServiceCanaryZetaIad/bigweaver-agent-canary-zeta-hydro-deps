# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks for comparing Hydro (DFIR) performance with Timely Dataflow and Differential Dataflow. These benchmarks were moved from the main [hydro-project/hydro](https://github.com/hydro-project/hydro) repository to maintain performance comparison capabilities while keeping the main repository focused on core functionality.

## Purpose

The benchmarks in this repository serve several key purposes:

1. **Performance Comparison**: Compare DFIR performance against timely/differential-dataflow implementations
2. **Validation**: Validate DFIR operator implementations for correctness and performance
3. **Regression Testing**: Identify performance regressions in Hydro releases
4. **Feature Parity**: Demonstrate feature parity with other dataflow frameworks
5. **Optimization Baseline**: Provide performance baselines for optimization work

## Repository Structure

```
.
├── benches/                  # Benchmark crate
│   ├── Cargo.toml           # Dependencies including timely and differential-dataflow
│   ├── README.md            # Benchmark execution instructions
│   ├── build.rs             # Build script for generated benchmarks
│   └── benches/             # Individual benchmark files
│       ├── arithmetic.rs              # Basic arithmetic operations
│       ├── fan_in.rs                  # Multiple inputs to single output
│       ├── fan_out.rs                 # Single input to multiple outputs
│       ├── fork_join.rs               # Split and rejoin patterns
│       ├── futures.rs                 # Async/await patterns
│       ├── identity.rs                # No-op baseline benchmark
│       ├── join.rs                    # Basic join operations
│       ├── micro_ops.rs               # Fine-grained operation tests
│       ├── reachability.rs            # Graph algorithms with differential dataflow
│       ├── symmetric_hash_join.rs     # Hash-based join implementation
│       ├── upcase.rs                  # String transformation
│       ├── words_diamond.rs           # Diamond topology word processing
│       ├── reachability_edges.txt     # Test data for reachability
│       ├── reachability_reachable.txt # Expected results for validation
│       └── words_alpha.txt            # Word list for text benchmarks
├── Cargo.toml               # Workspace configuration
└── README.md               # This file
```

## Benchmark Categories

### Simple Operations
- **arithmetic.rs** - Basic math operations in dataflow context
- **identity.rs** - No-op baseline for minimal dataflow overhead
- **upcase.rs** - String transformations

### Dataflow Patterns
- **fan_in.rs** - Multiple input streams converging to single output
- **fan_out.rs** - Single input stream splitting to multiple outputs
- **fork_join.rs** - Split and rejoin patterns with filtering
- **words_diamond.rs** - Diamond topology with word processing

### Join Operations
- **join.rs** - Basic join operations between two dataflows
- **symmetric_hash_join.rs** - Hash-based join algorithm implementation

### Advanced Algorithms
- **reachability.rs** - Graph reachability algorithm using differential dataflow iterative computation

### Async/Modern Patterns
- **futures.rs** - Async/await patterns with tokio runtime

### Micro Benchmarks
- **micro_ops.rs** - Fine-grained operation performance tests

## Dependencies

### Core Dataflow Frameworks
- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework

### Hydro Components
- **dfir_rs** (v0.14.0) - Core DFIR runtime and operators
- **sinktools** - Utilities for pushing to outputs (from hydro repository)

### Benchmarking & Testing
- **criterion** (v0.5.0) - Benchmarking harness with async support
- **tokio** (v1.29.0) - Async runtime for futures-based benchmarks

### Utilities
- **futures** (v0.3) - Async primitives
- **rand** / **rand_distr** - Random data generation
- **seq-macro** (v0.2.0) - Sequence macro support
- **static_assertions** (v1.0.0) - Compile-time assertions
- **nameof** (v1.0.0) - Name introspection

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
# Run a single benchmark by name
cargo bench -p benches --bench reachability

# Run arithmetic benchmarks
cargo bench -p benches --bench arithmetic

# Run join-related benchmarks
cargo bench -p benches --bench join
cargo bench -p benches --bench symmetric_hash_join
```

### Run Benchmarks with Output

```bash
# Run with verbose output
cargo bench -p benches -- --verbose

# Save results to a specific baseline
cargo bench -p benches -- --save-baseline my-baseline

# Compare against a baseline
cargo bench -p benches -- --baseline my-baseline
```

## Benchmark Results

Criterion generates HTML reports in `target/criterion/` for detailed performance analysis including:
- Time series plots
- Statistical analysis
- Comparison with previous runs
- Regression detection

## Framework Usage by Benchmark

### Timely-only Benchmarks
These benchmarks use only Timely Dataflow operators:
- arithmetic.rs
- fan_in.rs
- fan_out.rs
- fork_join.rs
- identity.rs
- join.rs
- upcase.rs

### Differential Dataflow Benchmarks
These benchmarks leverage Differential Dataflow's incremental computation:
- reachability.rs (uses Input, Iterate, Join, Threshold)

### DFIR-only Benchmarks
These benchmarks use pure Hydro/DFIR implementations:
- futures.rs
- micro_ops.rs
- symmetric_hash_join.rs
- words_diamond.rs

## Data Files

### reachability_edges.txt
Graph edge data for reachability benchmarks (space-separated node pairs).

### reachability_reachable.txt
Expected reachable nodes for validation of reachability computation.

### words_alpha.txt
English word list from [dwyl/english-words](https://github.com/dwyl/english-words) used for text processing benchmarks.

## Historical Context

These benchmarks were originally part of the main Hydro repository and were used extensively during development to:
1. Ensure performance parity with established dataflow frameworks
2. Guide optimization decisions
3. Validate correctness of operator implementations
4. Provide reproducible performance metrics

They were moved to this separate repository to:
- Keep the main repository focused on core functionality
- Maintain the ability to benchmark against timely/differential-dataflow
- Allow independent versioning of benchmark dependencies
- Provide a stable reference for performance comparisons

## Contributing

When adding new benchmarks:

1. Follow the existing benchmark structure
2. Use criterion for consistent measurement
3. Document the benchmark purpose and pattern
4. Include both Hydro and timely/differential implementations when comparing
5. Add the benchmark to the `[[bench]]` section in `Cargo.toml`
6. Update this README with benchmark descriptions

## License

Apache-2.0

## Related Resources

- [Hydro Project](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)