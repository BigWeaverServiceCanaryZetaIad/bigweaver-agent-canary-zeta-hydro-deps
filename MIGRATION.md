# Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

**Migration Date:** 2024-11-25

## Rationale

The benchmarks were moved to achieve better separation of concerns:

1. **Dependency Isolation**: Separate dependency-specific benchmarks from core functionality
2. **Build Performance**: Reduce compilation times for the main repository
3. **Maintainability**: Easier to update and maintain dependency-related tests independently
4. **Code Organization**: Follow team standards for separating dependencies into distinct repositories

## What Was Migrated

### Files Moved

From `bigweaver-agent-canary-hydro-zeta/benches/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/timely-benchmarks/benches/`:

#### Benchmark Files
- `arithmetic.rs` - Arithmetic pipeline benchmarks (timely)
- `fan_in.rs` - Fan-in pattern benchmarks (timely)
- `fan_out.rs` - Fan-out pattern benchmarks (timely)
- `fork_join.rs` - Fork-join pattern benchmarks (timely)
- `identity.rs` - Identity transformation benchmarks (timely)
- `join.rs` - Join operation benchmarks (timely)
- `upcase.rs` - String transformation benchmarks (timely)
- `reachability.rs` - Graph reachability benchmarks (differential-dataflow + timely)

#### Data Files
- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark

#### Build Files
- `build.rs` - Build script for generating fork_join benchmark code

### Repository Structure Created

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # NEW: Workspace configuration
├── README.md                     # UPDATED: Repository overview
├── MIGRATION.md                  # NEW: This file
└── timely-benchmarks/           # NEW: Benchmark package
    ├── Cargo.toml                # NEW: Package configuration
    ├── README.md                 # NEW: Benchmark documentation
    ├── build.rs                  # MIGRATED
    └── benches/                  # NEW: Benchmark directory
        ├── arithmetic.rs         # MIGRATED
        ├── fan_in.rs            # MIGRATED
        ├── fan_out.rs           # MIGRATED
        ├── fork_join.rs         # MIGRATED
        ├── identity.rs          # MIGRATED
        ├── join.rs              # MIGRATED
        ├── reachability.rs      # MIGRATED
        ├── reachability_edges.txt      # MIGRATED
        ├── reachability_reachable.txt  # MIGRATED
        └── upcase.rs            # MIGRATED
```

## What Remained in Original Repository

The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta/benches/` as they test core Hydro functionality, not external dependencies:

- `futures.rs` - Futures integration tests
- `micro_ops.rs` - Hydro micro-operation benchmarks
- `symmetric_hash_join.rs` - Hydro symmetric hash join benchmarks
- `words_diamond.rs` - Hydro diamond pattern benchmarks
- `words_alpha.txt` - Data file for word benchmarks

## Dependencies

### Original Dependencies (in bigweaver-agent-canary-hydro-zeta)
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

### New Dependencies (in bigweaver-agent-canary-zeta-hydro-deps)
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

The key change is that dependencies now reference the main repository via git instead of local paths, maintaining clean separation between repositories.

## Running Benchmarks After Migration

### Before Migration
```bash
# From bigweaver-agent-canary-hydro-zeta repository
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### After Migration

#### In bigweaver-agent-canary-zeta-hydro-deps repository:
```bash
cargo bench -p timely-benchmarks --bench reachability
cargo bench -p timely-benchmarks --bench arithmetic
```

#### In bigweaver-agent-canary-hydro-zeta repository:
```bash
# Only Hydro-specific benchmarks remain
cargo bench -p benches --bench futures
cargo bench -p benches --bench micro_ops
```

## Testing the Migration

To verify the migration was successful:

1. **Build test in new repository:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build -p timely-benchmarks
   ```

2. **Run benchmarks in new repository:**
   ```bash
   cargo bench -p timely-benchmarks
   ```

3. **Verify specific benchmarks work:**
   ```bash
   cargo bench -p timely-benchmarks --bench reachability
   cargo bench -p timely-benchmarks --bench arithmetic
   cargo bench -p timely-benchmarks --bench join
   ```

## Rollback Procedure

If needed, to rollback this migration:

1. Copy files back from `bigweaver-agent-canary-zeta-hydro-deps/timely-benchmarks/benches/` to `bigweaver-agent-canary-hydro-zeta/benches/benches/`
2. Update `bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml` to include the benchmark entries
3. Restore path-based dependencies for `dfir_rs` and `sinktools`

## Impact Analysis

### Affected Teams
- **Development Team**: Need to use different commands to run timely/differential benchmarks
- **Performance Testing Team**: Need to run benchmarks from the new repository
- **CI/CD Team**: May need to update pipeline configurations if they reference specific benchmarks

### Breaking Changes
- Benchmark invocation commands have changed (different package name and repository)
- Dependency paths changed from local to git-based

### Migration Path
- Developers should clone both repositories to have access to all benchmarks
- Update documentation and scripts that reference the old benchmark locations
- CI/CD pipelines should be updated to test benchmarks from both repositories

## Benefits

1. **Cleaner Repository Structure**: Main repository focuses on core functionality
2. **Faster Builds**: Main repository has fewer dependencies and test files
3. **Independent Development**: Dependency benchmarks can be updated independently
4. **Better Organization**: Clear separation between core and dependency testing

## Future Considerations

- Consider adding more dependency-specific benchmarks to this repository
- May add integration tests for specific timely/differential features
- Could expand to include other dataflow framework comparisons

## References

- Original repository: `bigweaver-agent-canary-hydro-zeta`
- New repository: `bigweaver-agent-canary-zeta-hydro-deps`
- Related issue/PR: [To be filled in with actual PR number]

## Questions or Issues

If you encounter issues with the migrated benchmarks:
1. Check that you have the latest version of both repositories
2. Verify dependencies are correctly resolved
3. Ensure you're using the correct benchmark commands for the new repository structure
4. Contact the team if benchmarks fail or produce unexpected results
