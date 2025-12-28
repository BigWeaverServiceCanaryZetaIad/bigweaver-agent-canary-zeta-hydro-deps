# Benchmark Migration

This file documents the migration of benchmarks from the bigweaver-agent-canary-hydro-zeta repository to this repository.

## What Was Moved

The entire `benches/` directory was moved from bigweaver-agent-canary-hydro-zeta, including:

- **Cargo.toml**: Benchmark package configuration (updated to use git dependencies)
- **build.rs**: Build script for generating benchmark code
- **benches/**: Directory containing all benchmark files
  - **fork_join.rs**: Benchmarks comparing fork-join patterns
  - **identity.rs**: Identity operation benchmarks
  - **reachability.rs**: Graph reachability benchmarks
  - And other benchmark files

## Why This Was Done

The benchmarks in fork_join.rs, identity.rs, and reachability.rs use Timely Dataflow and Differential Dataflow for performance comparisons. To avoid including these dependencies in the main Hydro repository, the benchmarks were moved to this separate repository.

## Changes Made

1. **Dependencies Updated**: The `benches/Cargo.toml` file was updated to reference `dfir_rs` and `sinktools` via git instead of path dependencies.

2. **Workspace Configuration**: A new workspace `Cargo.toml` was created at the root of this repository to properly configure the benchmarks package.

3. **Source Repository**: The `benches` member was removed from the workspace configuration in bigweaver-agent-canary-hydro-zeta.

## Running the Benchmarks

See the main [README.md](README.md) for instructions on running the benchmarks.
