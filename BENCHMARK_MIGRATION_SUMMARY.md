# Benchmark Migration Summary

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

November 26, 2024

## Motivation

The primary motivation for this migration is to improve dependency management and maintainability:

1. **Dependency Isolation**: The benchmarks require `timely` and `differential-dataflow` packages, which are not needed in the main codebase. Separating these benchmarks prevents these dependencies from affecting the main repository's dependency tree.

2. **Build Time Optimization**: Removing these dependencies from the main repository reduces build times for developers working on core functionality.

3. **Modular Architecture**: This separation aligns with the team's preference for modular code organization with clear separation of concerns.

4. **Technical Debt Management**: Proactive dependency management helps prevent technical debt accumulation.

## What Was Migrated

### Directory Structure

The entire `benches/` directory from `bigweaver-agent-canary-hydro-zeta` was migrated, including:

```
benches/
├── Cargo.toml
├── README.md
├── build.rs
└── benches/
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── reachability_edges.txt
    ├── reachability_reachable.txt
    ├── symmetric_hash_join.rs
    ├── upcase.rs
    ├── futures.rs
    ├── micro_ops.rs
    ├── words_alpha.txt
    └── words_diamond.rs
```

### Configuration Files

The following configuration files were copied to maintain consistency:

- `rust-toolchain.toml`: Ensures the same Rust toolchain version
- `rustfmt.toml`: Maintains consistent code formatting
- `clippy.toml`: Preserves linting standards

### Benchmark Types

The migrated benchmarks cover various dataflow patterns and operations:

1. **Arithmetic Operations** (`arithmetic.rs`)
   - Pipeline benchmarks
   - Raw copy operations
   - Iterator-based operations
   - Hydroflow compiled and surface syntax benchmarks
   - Timely dataflow comparisons

2. **Data Distribution Patterns**
   - `fan_in.rs`: Multiple inputs to single output
   - `fan_out.rs`: Single input to multiple outputs
   - `fork_join.rs`: Parallel processing with joins

3. **Data Operations**
   - `identity.rs`: Pass-through operations
   - `join.rs`: Data joining operations
   - `symmetric_hash_join.rs`: Symmetric hash join implementations

4. **Graph Algorithms**
   - `reachability.rs`: Graph reachability algorithms with test data files

5. **String Processing**
   - `upcase.rs`: String transformation operations
   - `words_diamond.rs`: Diamond-shaped dataflow patterns with word list data

6. **Async Operations**
   - `futures.rs`: Futures-based async operations

7. **Micro-benchmarks**
   - `micro_ops.rs`: Fine-grained operation benchmarks

## Changes Made

### Dependency Updates

The `benches/Cargo.toml` was updated to use git dependencies instead of path dependencies:

**Before:**
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After:**
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro", version = "^0.0.1" }
```

### Workspace Configuration

A new workspace `Cargo.toml` was created at the root of the repository with:
- Workspace member configuration
- Shared package metadata
- Build profiles (release, profile)
- Workspace-level lints for Rust and Clippy

## Key Dependencies

The benchmarks maintain dependencies on:

### External Crates
- `timely` (package: "timely-master", version: "0.13.0-dev.1")
- `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- `criterion` (version: "0.5.0", features: async_tokio, html_reports)
- `futures` (version: "0.3")
- `tokio` (version: "1.29.0", features: rt-multi-thread)
- `rand` (version: "0.8.0")
- `rand_distr` (version: "0.4.3")
- `seq-macro` (version: "0.2.0")
- `nameof` (version: "1.0.0")
- `static_assertions` (version: "1.0.0")

### Hydro Project Dependencies (Git)
- `dfir_rs`: Hydro's dataflow IR with debugging features
- `sinktools`: Sink utilities from the Hydro project

## Impact Analysis

### Development Team
✅ **Benefits:**
- Cleaner dependency tree in main repository
- Faster builds when not working on benchmarks
- Clearer separation of concerns

⚠️ **Considerations:**
- Benchmark changes now require working with a separate repository
- Git dependencies mean benchmark builds pull from remote repository

### Performance Testing Team
✅ **Benefits:**
- Dedicated repository for performance testing infrastructure
- Easier to manage benchmark-specific dependencies
- Can iterate on benchmarks independently

⚠️ **Considerations:**
- Need to coordinate with main repository for API changes
- Must ensure git dependencies point to correct versions/branches

### CI/CD Team
✅ **Benefits:**
- Can set up separate CI pipelines for benchmarks
- Benchmark CI failures don't block main repository builds
- More granular control over when benchmarks run

⚠️ **Considerations:**
- Need to maintain CI configuration for new repository
- Cross-repository performance tracking requires coordination

### Documentation Team
✅ **Benefits:**
- Clear documentation of benchmark repository purpose
- Easier to document performance testing procedures

⚠️ **Considerations:**
- Need to update main repository documentation to reference benchmark repository

## Running Benchmarks

### All Benchmarks
```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Specific Benchmark
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Specific Benchmark Function
```bash
cargo bench -p benches --bench arithmetic -- timely
```

## Maintenance Considerations

### Keeping Benchmarks Up-to-Date

1. **API Changes**: When APIs in `dfir_rs` or `sinktools` change, benchmarks may need updates
2. **Git Dependencies**: Currently points to main branch; consider using specific tags/revisions for stability
3. **Version Coordination**: Ensure benchmark repository stays compatible with main repository versions

### Future Improvements

1. **Version Pinning**: Consider pinning git dependencies to specific commits or tags
2. **CI Integration**: Set up automated benchmark runs and performance regression detection
3. **Documentation**: Add benchmark result documentation and performance tracking
4. **Cross-repository Testing**: Establish procedures for testing benchmarks against main repository changes

## Verification Steps

To verify the migration was successful:

1. ✅ All benchmark files copied to new repository
2. ✅ Configuration files (rust-toolchain.toml, rustfmt.toml, clippy.toml) in place
3. ✅ Workspace Cargo.toml created
4. ✅ Dependency paths updated to git dependencies
5. ✅ README.md updated with comprehensive documentation
6. ✅ Build succeeds: `cargo build --release`
7. ✅ Benchmarks can be listed: `cargo bench -p benches --list`

## Related Changes

This migration is part of a coordinated effort to improve the Hydro project's architecture. Related changes should include:

1. **Main Repository Changes** (bigweaver-agent-canary-hydro-zeta):
   - Remove `benches/` directory
   - Update workspace `Cargo.toml` to remove benches member
   - Update main README.md to reference benchmark repository
   - Add documentation about where benchmarks are located

2. **Documentation Updates**:
   - Update developer guides to mention benchmark repository
   - Add performance testing documentation
   - Update contribution guidelines

## References

- Main Repository: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion Benchmarking: https://github.com/bheisler/criterion.rs

## Contact

For questions about this migration or the benchmark repository, please refer to the main Hydro project documentation and contribution guidelines.
