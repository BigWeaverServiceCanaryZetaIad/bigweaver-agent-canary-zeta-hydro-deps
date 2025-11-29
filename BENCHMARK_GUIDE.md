# Benchmark Guide

## Overview

This repository contains performance benchmarks that compare Hydro's dfir_rs implementation with other dataflow systems, specifically Timely Dataflow and Differential Dataflow. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to keep benchmark-specific dependencies separate from the core codebase.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark crate
│   ├── benches/               # Individual benchmark files
│   │   ├── arithmetic.rs      # Arithmetic operations benchmark
│   │   ├── fan_in.rs          # Fan-in pattern benchmark
│   │   ├── fan_out.rs         # Fan-out pattern benchmark
│   │   ├── fork_join.rs       # Fork-join pattern benchmark
│   │   ├── futures.rs         # Futures-based operations benchmark
│   │   ├── identity.rs        # Identity operation benchmark
│   │   ├── join.rs            # Join operation benchmark
│   │   ├── micro_ops.rs       # Micro-operations benchmark
│   │   ├── reachability.rs    # Graph reachability benchmark
│   │   ├── symmetric_hash_join.rs  # Symmetric hash join benchmark
│   │   ├── upcase.rs          # String uppercase benchmark
│   │   ├── words_diamond.rs   # Word processing diamond pattern
│   │   ├── reachability_edges.txt  # Test data for reachability
│   │   ├── reachability_reachable.txt  # Expected results
│   │   └── words_alpha.txt    # Word list for word benchmarks
│   ├── Cargo.toml             # Benchmark dependencies
│   ├── README.md              # Benchmark-specific documentation
│   └── build.rs               # Build script for generated benchmarks
├── Cargo.toml                 # Workspace configuration
└── README.md                  # This file
```

## Dependencies

The benchmarks depend on:
- **dfir_rs**: Referenced from `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
- **sinktools**: Referenced from `../../bigweaver-agent-canary-hydro-zeta/sinktools`
- **timely-master**: For Timely Dataflow comparisons
- **differential-dataflow-master**: For Differential Dataflow comparisons
- **criterion**: For benchmark harness and reporting

## Running Benchmarks

### Prerequisites

Make sure both repositories are checked out side-by-side:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Run All Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

### View Results

Benchmark results are generated in HTML format and can be found in:
```
target/criterion/
```

Open `target/criterion/report/index.html` in a browser to view detailed results.

## Benchmark Categories

### Dataflow Operations
- **arithmetic.rs**: Tests basic arithmetic operations in streaming pipelines
- **identity.rs**: Tests the overhead of identity operations
- **micro_ops.rs**: Tests various micro-operations for performance baseline

### Pattern Benchmarks
- **fan_in.rs**: Multiple streams merging into one
- **fan_out.rs**: One stream splitting into multiple
- **fork_join.rs**: Fork-join parallelism patterns

### Join Benchmarks
- **join.rs**: Basic join operations
- **symmetric_hash_join.rs**: Symmetric hash join implementation

### Real-World Scenarios
- **reachability.rs**: Graph reachability computation (uses provided graph data)
- **words_diamond.rs**: Word processing in diamond topology
- **upcase.rs**: String transformation operations
- **futures.rs**: Async/futures-based operations

## Performance Comparison

Each benchmark typically compares three implementations:
1. **Hydro (dfir_rs)**: The native Hydro implementation
2. **Timely**: Timely Dataflow implementation
3. **Differential**: Differential Dataflow implementation

This allows for direct performance comparison across different dataflow systems.

## Maintenance

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add benchmark entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Follow the existing benchmark structure using Criterion

### Updating Dependencies

When the main Hydro repository is updated, ensure that:
1. The relative paths in `benches/Cargo.toml` still point correctly
2. API changes in dfir_rs are reflected in benchmark code
3. Version numbers are updated if needed

## Migration History

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta` to this separate repository to:
1. Keep benchmark-specific dependencies (timely, differential-dataflow) separate from core Hydro
2. Maintain cleaner dependency graphs in the main repository
3. Allow independent versioning and updates of benchmark code
4. Improve build times for the main repository by removing heavy benchmark dependencies

The migration preserved all functionality while updating dependency paths to reference the main repository from this location.
