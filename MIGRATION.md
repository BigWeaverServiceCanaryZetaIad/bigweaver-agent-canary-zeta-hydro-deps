# Benchmark Migration Information

## Overview

This repository was created to house the timely and differential-dataflow benchmark files that were previously in the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`). This separation allows the main repository to avoid dependencies on timely and differential-dataflow while still maintaining the ability to run performance comparisons.

## Repository Structure

The repository is now organized into two packages:

### benches
Contains comprehensive benchmarks that include implementations for DFIR, Timely, and Differential Dataflow frameworks side-by-side. This allows for direct performance comparisons on identical workloads.

### timely-differential-benches
Contains standalone benchmarks focusing exclusively on Timely and Differential Dataflow implementations (without DFIR). This package was added to provide:
- Baseline performance measurements without DFIR overhead
- Independent testing of Timely/Differential implementations
- Easier maintenance of framework-specific code

## What Was Moved

The following items were moved from `bigweaver-agent-canary-hydro-zeta` to this repository:

### Benchmark Files
- `benches/` directory containing all benchmark source files:
  - `arithmetic.rs` - Basic arithmetic operations benchmarks (timely comparison)
  - `fan_in.rs` - Fan-in pattern benchmarks (timely comparison)
  - `fan_out.rs` - Fan-out pattern benchmarks (timely comparison)
  - `fork_join.rs` - Fork-join pattern benchmarks (timely comparison)
  - `futures.rs` - Async futures benchmarks (both timely and differential comparison)
  - `identity.rs` - Identity operation benchmarks (timely comparison)
  - `join.rs` - Join operation benchmarks (timely comparison)
  - `micro_ops.rs` - Micro operations benchmarks
  - `reachability.rs` - Graph reachability benchmarks (timely and differential comparison)
  - `symmetric_hash_join.rs` - Symmetric hash join benchmarks
  - `upcase.rs` - String case conversion benchmarks (timely comparison)
  - `words_diamond.rs` - Word processing diamond pattern benchmarks
  - Supporting data files: `reachability_edges.txt`, `reachability_reachable.txt`, `words_alpha.txt`

### Configuration Files
- `benches/Cargo.toml` - Updated to use git dependencies for dfir_rs and sinktools
- `benches/build.rs` - Build script for generating benchmark code
- `benches/README.md` - Benchmark usage documentation

### Dependencies Removed from Main Repository

The following dependencies were removed from the main Hydro repository and are now only present in this repository:

- `timely` (package: `timely-master`, version: `0.13.0-dev.1`)
- `differential-dataflow` (package: `differential-dataflow-master`, version: `0.13.0-dev.1`)

## Changes Made to Main Repository

1. **Cargo.toml**: Removed "benches" from workspace members
2. **CONTRIBUTING.md**: Updated to reference this separate repository for benchmarks
3. **.github/workflows/benchmark.yml**: Disabled benchmark workflow (benchmarks now run from this repository)

## Running Benchmarks

To run benchmarks after the migration:

```bash
# Clone this repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks (both packages)
cargo bench

# Run all DFIR comparison benchmarks
cargo bench -p benches

# Run specific DFIR comparison benchmarks
cargo bench -p benches --bench reachability

# Run benchmarks with filtering
cargo bench -p benches -- dfir          # Only DFIR benchmarks
cargo bench -p benches -- timely        # Only timely benchmarks
cargo bench -p benches -- differential  # Only differential benchmarks

# Run all Timely/Differential standalone benchmarks
cargo bench -p timely-differential-benches

# Run specific Timely/Differential benchmarks
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench join
```

## Performance Comparison Functionality

The benchmarks maintain the ability to compare DFIR performance with timely and differential-dataflow by:

1. Implementing the same algorithms in multiple frameworks
2. Using criterion for fair performance measurement
3. Generating HTML reports for visual comparison
4. Maintaining consistent test data across implementations

## Dependencies on Main Repository

This repository depends on the following packages from the main Hydro repository:

- `dfir_rs` - The main DFIR runtime and flow syntax
- `sinktools` - Utility tools for data sinks

These dependencies are specified as git dependencies in `benches/Cargo.toml` and will pull from the main repository automatically during builds.

## Future Maintenance

When making changes to the benchmark suite:

### For DFIR comparison benchmarks (benches package):
1. Clone this repository
2. Make changes to benchmark files in `benches/benches/`
3. Update `benches/Cargo.toml` if adding new benchmarks
4. Test locally with `cargo bench -p benches`
5. Commit and push changes
6. CI/CD workflows (if configured) will validate benchmarks

### For Timely/Differential standalone benchmarks (timely-differential-benches package):
1. Clone this repository
2. Make changes to benchmark files in `timely-differential-benches/benches/`
3. Update `timely-differential-benches/Cargo.toml` if adding new benchmarks
4. Copy any required data files to `timely-differential-benches/benches/`
5. Test locally with `cargo bench -p timely-differential-benches`
6. Commit and push changes
7. CI/CD workflows (if configured) will validate benchmarks

## References

- Main Hydro Repository: `bigweaver-agent-canary-hydro-zeta`
- Hydro Documentation: https://hydro.run
- Criterion Documentation: https://bheisler.github.io/criterion.rs/
