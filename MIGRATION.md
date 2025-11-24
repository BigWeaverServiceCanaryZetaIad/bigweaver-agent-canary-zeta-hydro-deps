# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

November 24, 2025

## Rationale

### Why Separate Repository?

1. **Dependency Isolation**: Removes heavy dependencies (timely-dataflow and differential-dataflow) from the main Hydro repository
2. **Faster Builds**: Main repository builds faster without benchmark dependencies
3. **Optional Testing**: Developers can clone and run benchmarks only when needed
4. **Clean Separation**: Maintains clear boundaries between core functionality and performance testing
5. **Independent Versioning**: Benchmarks can evolve independently from the main codebase

### Benefits

✅ **Reduced Dependency Footprint**: ~4.4MB less in main repository  
✅ **Faster CI/CD**: Main repository CI builds complete faster  
✅ **Cleaner Codebase**: Main repository focused on Hydro core functionality  
✅ **Preserved Functionality**: All performance comparison capabilities retained  
✅ **Independent Development**: Benchmark improvements don't affect main repo

## What Was Migrated

### Directory Structure

```
benches/
├── Cargo.toml                    # Benchmark package manifest
├── README.md                     # Benchmark documentation
├── build.rs                      # Build script for generated code
└── benches/                      # Benchmark implementations
    ├── .gitignore
    ├── arithmetic.rs             # ~7.6KB
    ├── fan_in.rs                 # ~3.5KB
    ├── fan_out.rs                # ~3.6KB
    ├── fork_join.rs              # ~4.3KB
    ├── futures.rs                # ~4.9KB
    ├── identity.rs               # ~6.9KB
    ├── join.rs                   # ~4.5KB
    ├── micro_ops.rs              # ~12KB
    ├── reachability.rs           # ~13.7KB
    ├── reachability_edges.txt    # ~533KB (test data)
    ├── reachability_reachable.txt # ~38.7KB (test data)
    ├── symmetric_hash_join.rs    # ~4.5KB
    ├── upcase.rs                 # ~3.2KB
    ├── words_alpha.txt           # ~3.86MB (test data)
    └── words_diamond.rs          # ~7.1KB
```

**Total Size**: Approximately 4.5MB

### Dependencies Migrated

From the main repository's `benches/Cargo.toml`:

- `timely` (package: "timely-master", version: "0.13.0-dev.1")
- `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- All transitive dependencies of timely and differential-dataflow

### Benchmark Categories

1. **Basic Operations**
   - arithmetic.rs
   - identity.rs
   - micro_ops.rs

2. **Stream Patterns**
   - fan_in.rs
   - fan_out.rs
   - fork_join.rs

3. **Join Operations**
   - join.rs
   - symmetric_hash_join.rs

4. **Graph Algorithms**
   - reachability.rs

5. **String Processing**
   - upcase.rs
   - words_diamond.rs

6. **Async Operations**
   - futures.rs

## Implementation Changes

### Repository Structure

Created new standalone repository with:

1. **Workspace Configuration** (`Cargo.toml`)
   - Workspace-level settings
   - Shared lints and package metadata
   - Single member: `benches`

2. **Configuration Files**
   - `rust-toolchain.toml`: Rust version specification
   - `rustfmt.toml`: Formatting rules
   - `clippy.toml`: Linting configuration

3. **Documentation**
   - `README.md`: Comprehensive repository documentation
   - `QUICKSTART.md`: Quick reference guide
   - `MIGRATION.md`: This file
   - `benches/README.md`: Benchmark-specific instructions

### Dependency Resolution

**Before** (in main repository):
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After** (in hydro-deps repository):
```toml
dfir_rs = { git = "https://...bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://...bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

This ensures benchmarks always test against the current version of Hydro from the main repository.

### Performance Comparison Preserved

All benchmark implementations remain functional and can compare:
- Hydro/DFIR implementations
- Timely-dataflow implementations
- Differential-dataflow implementations
- Raw Rust baseline implementations

## Changes in Main Repository

The following changes were made to the main `bigweaver-agent-canary-hydro-zeta` repository:

1. **Removed**: `benches/` directory and all contents
2. **Updated**: `Cargo.toml` - removed `benches` from workspace members
3. **Removed**: `.github/workflows/benchmark.yml` (if existed)
4. **Added**: Documentation referencing this repository

## Running Benchmarks After Migration

### Before Migration
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### After Migration
```bash
# Clone the deps repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run benchmarks
cargo bench -p benches
```

## Verification

To verify the migration was successful:

1. **Check Compilation**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build --release -p benches
   ```

2. **Run Sample Benchmark**:
   ```bash
   cargo bench -p benches --bench identity
   ```

3. **Verify Dependencies**:
   ```bash
   cargo tree -p benches
   ```

## Historical Context

### Previous State

Benchmarks were part of the main workspace at `bigweaver-agent-canary-hydro-zeta/benches/`, which:
- Added ~4.5MB to repository size
- Introduced heavy dependencies to the main build
- Coupled benchmark development with core development
- Required all developers to download benchmark data

### Current State

Benchmarks are in a separate repository:
- Main repository is leaner and faster to build
- Benchmarks can be cloned independently
- Performance testing is optional
- Clear separation of concerns

## Rollback Plan

If issues arise, benchmarks can be restored to the main repository:

1. Clone this repository
2. Copy `benches/` directory to main repository
3. Update main repository's `Cargo.toml` to include `benches` in workspace members
4. Change dependency paths back to local paths

## Future Enhancements

Potential improvements to this repository:

1. **CI/CD**: Add automated benchmark runs
2. **Historical Tracking**: Store benchmark results over time
3. **Comparison Reports**: Generate automated comparison reports
4. **Additional Benchmarks**: Add new benchmarks as needed
5. **Performance Regression Detection**: Alert on performance regressions

## References

- Main Repository: https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
- Team Learning: "The team demonstrates a preference for separating core functionality from dependencies"
- Team Learning: "Performance testing is highly valued within the team's development process"

## Contact

For questions about this migration:
- Review the main Hydro repository documentation
- Check the benchmark-specific README in `benches/README.md`
- Refer to team learnings about dependency management
