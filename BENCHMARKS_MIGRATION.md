# Benchmarks Migration Guide

## Overview

The timely and differential-dataflow benchmark code has been moved from the `bigweaver-agent-canary-hydro-zeta` repository to this `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Background

The benchmarks were originally located in the `benches/` directory of the main Hydro repository. They included performance comparisons between:
- Hydro (dfir_rs) implementations
- timely-dataflow implementations
- differential-dataflow implementations

These benchmarks required dependencies on `timely` (timely-master) and `differential-dataflow` (differential-dataflow-master), which were not needed by the main repository's core functionality.

## Migration Rationale

The migration was performed to:
1. **Reduce dependency overhead**: Remove timely and differential-dataflow dependencies from the main repository
2. **Improve maintainability**: Keep the main repository focused on Hydro's core functionality
3. **Retain comparison capabilities**: Maintain the ability to run performance comparisons between Hydro and other dataflow systems
4. **Separate concerns**: Isolate benchmark code that requires external dependencies

## What Was Moved

### Files Moved to `bigweaver-agent-canary-zeta-hydro-deps`

All files from `benches/` directory:
- `benches/Cargo.toml` - Benchmark package configuration
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script for generating benchmark code
- `benches/benches/.gitignore` - Git ignore patterns
- `benches/benches/arithmetic.rs` - Arithmetic operations benchmark
- `benches/benches/fan_in.rs` - Fan-in pattern benchmark
- `benches/benches/fan_out.rs` - Fan-out pattern benchmark
- `benches/benches/fork_join.rs` - Fork-join pattern benchmark
- `benches/benches/futures.rs` - Async futures benchmark
- `benches/benches/identity.rs` - Identity operation benchmark
- `benches/benches/join.rs` - Join operation benchmark
- `benches/benches/micro_ops.rs` - Micro-operations benchmark
- `benches/benches/reachability.rs` - Graph reachability benchmark
- `benches/benches/reachability_edges.txt` - Test data for reachability
- `benches/benches/reachability_reachable.txt` - Expected results for reachability
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmark
- `benches/benches/upcase.rs` - String uppercase transformation benchmark
- `benches/benches/words_alpha.txt` - Word list test data
- `benches/benches/words_diamond.rs` - Word processing diamond pattern benchmark

### Dependencies Added to `bigweaver-agent-canary-zeta-hydro-deps`

The following dependencies are now in this repository:
- `timely` (timely-master version 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master version 0.13.0-dev.1)

### Dependencies Removed from `bigweaver-agent-canary-hydro-zeta`

The main repository no longer includes:
- timely-dataflow dependencies
- differential-dataflow dependencies
- The `benches` workspace member

## How to Run Benchmarks

### Prerequisites

Clone both repositories side by side:
```bash
cd /projects/sandbox/
git clone <url>/bigweaver-agent-canary-hydro-zeta.git
git clone <url>/bigweaver-agent-canary-zeta-hydro-deps.git
```

### Running All Benchmarks

From the `bigweaver-agent-canary-zeta-hydro-deps` directory:
```bash
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run join benchmark
cargo bench -p benches --bench join
```

### Viewing Results

Benchmark results are generated in HTML format and can be found in:
```
target/criterion/
```

## Architecture Changes

### Dependency Structure

Before migration:
```
bigweaver-agent-canary-hydro-zeta/
├── benches/              (with timely/differential deps)
├── dfir_rs/
├── sinktools/
└── [other crates]
```

After migration:
```
bigweaver-agent-canary-hydro-zeta/
├── dfir_rs/
├── sinktools/
└── [other crates]

bigweaver-agent-canary-zeta-hydro-deps/
└── benches/              (with timely/differential deps)
    └── references dfir_rs and sinktools via relative paths
```

### Relative Path References

The benchmarks in `bigweaver-agent-canary-zeta-hydro-deps` reference the main repository via relative paths:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

This allows the benchmarks to use the current versions of Hydro components without duplication.

## Performance Comparison Capabilities

The benchmarks continue to provide performance comparisons between:

1. **Hydro (dfir_rs)**: Using the Hydro dataflow system
2. **Timely**: Using timely-dataflow directly
3. **Differential**: Using differential-dataflow for incremental computations

Each benchmark typically includes implementations for all three systems where applicable, allowing for direct performance comparisons.

## Future Development

To add new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_new_benchmark"
   harness = false
   ```
3. Implement benchmark functions using the Criterion framework
4. Run with `cargo bench -p benches --bench my_new_benchmark`

## Related Changes

This migration is part of a coordinated change across repositories:
- Main repository: Removed benchmarks and dependencies
- This repository: Added benchmarks with necessary dependencies
- Both repositories maintain integration through relative path references

## Questions or Issues

For questions about the benchmarks or issues running them, please refer to:
- The main repository's issue tracker for Hydro-related questions
- This repository's documentation for benchmark-specific questions
