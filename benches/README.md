# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that use timely and differential-dataflow dependencies for performance comparison with Hydro implementations.

## Overview

These benchmarks were separated from the main bigweaver-agent-canary-hydro-zeta repository to:
- Reduce build dependencies in the main repository
- Improve build times for core development
- Maintain the ability to run performance comparisons with Timely/Differential implementations

## Benchmark Structure

Each benchmark file contains multiple implementations of the same operation to enable performance comparison:
- **Timely/Differential-Dataflow** - Reference implementations using timely and differential-dataflow
- **Hydro (dfir_rs)** - Hydro-native implementations for direct comparison
- **Raw Rust/Pipeline** - Baseline implementations for performance context

This design allows developers to:
- Compare Hydro performance against established dataflow frameworks
- Identify optimization opportunities
- Validate that Hydro implementations meet performance expectations

## Available Benchmarks

- **arithmetic** - Arithmetic operations benchmark (20 sequential map operations)
- **fan_in** - Fan-in pattern benchmark (multiple inputs merging into one)
- **fan_out** - Fan-out pattern benchmark (single input splitting to multiple outputs)
- **fork_join** - Fork-join pattern benchmark (parallel processing with merge)
- **identity** - Identity transformation benchmark (passthrough operations)
- **join** - Join operations benchmark (relational join operations)
- **reachability** - Graph reachability benchmark (graph traversal operations)
- **upcase** - String transformation benchmark (text processing operations)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

Run specific benchmark implementations:
```bash
# Run only timely implementations
cargo bench -p benches --bench arithmetic timely

# Run only Hydro implementations
cargo bench -p benches --bench arithmetic dfir_rs
```

## Performance Comparison Workflow

1. **Run benchmarks in this repository** to get timely/differential-dataflow baseline:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench
   ```

2. **Run benchmarks in main repository** for Hydro-native comparisons:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta/benches
   cargo bench
   ```

3. **Compare results** from both repositories using criterion's HTML reports (located in `target/criterion/`)

## Dependencies

This repository requires:
- **timely-master** (0.13.0-dev.1) - Timely dataflow library
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow library
- **dfir_rs** (from main repository) - Hydro's DFIR implementation
- **sinktools** (from main repository) - Hydro's sink utilities
- **criterion** - Benchmarking framework

The dfir_rs and sinktools dependencies are pulled from the main bigweaver-agent-canary-hydro-zeta repository via git dependencies.

## Data Files

- `reachability_edges.txt` - Test data for reachability benchmark (graph edges)
- `reachability_reachable.txt` - Expected results for reachability benchmark (reachable nodes)

## Build Requirements

The `build.rs` file generates code for the fork_join benchmark during the build process. It creates a `fork_join_20.hf` file with 20 operations that is included in the benchmark at compile time.

## Troubleshooting

If you encounter build errors:
- Ensure you have Rust 2021 edition or later
- Check that git dependencies can be accessed
- Verify that timely and differential-dataflow packages are available in your registry
