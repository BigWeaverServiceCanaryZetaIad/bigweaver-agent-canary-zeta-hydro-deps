# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for comparing Hydroflow with Timely Dataflow and Differential Dataflow frameworks.

## Repository Purpose

This repository was created to isolate the `timely` and `differential-dataflow` dependencies from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation provides:

- **Cleaner dependency management**: Keeps the main Hydroflow repository free from timely/differential dependencies
- **Focused performance comparisons**: Dedicated space for framework comparison benchmarks
- **Independent maintenance**: Allows updates to comparison benchmarks without affecting the main repository

## Repository Structure

* `/benches` - Contains all Timely and Differential Dataflow comparison benchmarks
  * `/benches/benches` - Individual benchmark files
  * `/benches/Cargo.toml` - Benchmark dependencies and configuration
  * `/benches/README.md` - Documentation on running benchmarks

## Prerequisites

To run the benchmarks in this repository, you need:

1. **Rust toolchain**: A compatible Rust installation (see main repository for version requirements)
2. **Main repository**: The `bigweaver-agent-canary-hydro-zeta` repository must be checked out as a sibling directory
   ```
   /projects/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

The benchmarks depend on `dfir_rs` and `sinktools` from the main Hydroflow repository via relative path dependencies.

## Running Benchmarks

Navigate to the benches directory and use cargo bench:

```bash
cd benches

# Run all benchmarks
cargo bench

# Run specific benchmarks
cargo bench --bench reachability
cargo bench --bench join
cargo bench --bench arithmetic
```

See the [benches README](./benches/README.md) for detailed information about each benchmark.

## Available Benchmarks

The following benchmarks compare Hydroflow with Timely/Differential Dataflow:

- **arithmetic**: Arithmetic operations pipeline comparison
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance
- **fork_join**: Fork-join pattern comparison
- **identity**: Identity/pass-through operations
- **join**: Join operations with different data types
- **reachability**: Graph reachability algorithm comparison
- **upcase**: String uppercase transformation

## Submitting Changes

When contributing changes to these benchmarks:

1. Follow the commit message and PR guidelines from the main Hydroflow repository
2. Ensure benchmarks remain functional with the main repository
3. Update documentation if benchmark behavior or requirements change
4. Test benchmarks locally before submitting PRs

## Cross-Repository Workflow

When making changes that affect both repositories:

1. Create PRs in both repositories
2. Reference the related PR in each PR description
3. Indicate the merge order if dependencies exist between changes
4. Use labels like "MERGE FIRST" or "MERGE SECOND" if needed

## Questions and Support

For questions about the benchmarks or this repository, please refer to the main Hydroflow repository's issue tracker or documentation.
