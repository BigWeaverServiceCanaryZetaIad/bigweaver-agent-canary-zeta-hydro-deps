# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow comparison benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

December 20, 2024

## Rationale

### Why Separate the Benchmarks?

1. **Dependency Isolation**: The timely and differential-dataflow dependencies are substantial and only needed for performance comparison purposes, not for core functionality.

2. **Build Performance**: Removing these dependencies from the main repository reduces compilation time for developers working on core Hydro features.

3. **Clearer Architecture**: Separating reference implementations from native DFIR benchmarks makes the purpose of each benchmark suite clearer.

4. **Maintenance**: Allows independent versioning and updating of comparison benchmarks without affecting the main codebase.

## What Was Migrated

### Benchmark Files
The following benchmark files were moved from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to this repository:

- `arithmetic.rs` - Arithmetic operation comparisons
- `fan_in.rs` - Fan-in pattern comparisons
- `fan_out.rs` - Fan-out pattern comparisons
- `fork_join.rs` - Fork-join pattern comparisons
- `identity.rs` - Identity operation comparisons
- `join.rs` - Join operation comparisons
- `reachability.rs` - Graph reachability comparisons
- `upcase.rs` - String transformation comparisons

### Data Files
Supporting data files for benchmarks:
- `reachability_edges.txt` - Graph edge data for reachability benchmarks
- `reachability_reachable.txt` - Expected reachability results

### Dependencies
The following dependencies were moved from the main repository to this repository:
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`

## What Remained in the Main Repository

### DFIR-Native Benchmarks
The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta` as they are pure DFIR implementations without external dependencies:

- `futures.rs` - Futures/async operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join performance tests
- `words_diamond.rs` - Word processing diamond pattern benchmark
- `words_alpha.txt` - Word list data file

## Impact on Existing Workflows

### For Developers Working on DFIR

**Before Migration:**
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches  # Runs all benchmarks including comparisons
```

**After Migration:**
```bash
# Run DFIR-native benchmarks
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# Run comparison benchmarks separately
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-benches-comparison
```

### For CI/CD Pipelines

If your CI/CD pipeline runs benchmarks, you'll need to update it to:
1. Clone both repositories
2. Run benchmarks in each repository separately
3. Aggregate results if needed

### For Performance Analysis

To perform comprehensive performance analysis:

1. **Run native benchmarks:**
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. **Run comparison benchmarks:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-benches-comparison
   ```

3. **View results:**
   - Native benchmark results: `bigweaver-agent-canary-hydro-zeta/target/criterion/`
   - Comparison benchmark results: `bigweaver-agent-canary-zeta-hydro-deps/target/criterion/`

## Repository Structure After Migration

### bigweaver-agent-canary-hydro-zeta
```
benches/
├── Cargo.toml          # No timely/differential dependencies
├── README.md           # Updated to reference this repository
└── benches/
    ├── futures.rs
    ├── micro_ops.rs
    ├── symmetric_hash_join.rs
    ├── words_diamond.rs
    └── words_alpha.txt
```

### bigweaver-agent-canary-zeta-hydro-deps (this repository)
```
benches/
├── Cargo.toml          # Includes timely/differential dependencies
├── README.md           # Comprehensive documentation
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
    └── upcase.rs
```

## Technical Notes

### Dependency References

The benchmarks in this repository use git dependencies to reference `dfir_rs` and `sinktools`:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

This ensures the benchmarks always use the latest version of DFIR for accurate comparisons.

### Benchmark Compatibility

All benchmarks were migrated without modification to their core logic. The performance characteristics should remain identical to their previous implementations.

## Future Considerations

### Adding New Comparison Benchmarks

When adding new benchmarks that compare DFIR with timely/differential-dataflow:

1. Add the benchmark to this repository (`bigweaver-agent-canary-zeta-hydro-deps`)
2. Ensure both DFIR and reference implementations are included
3. Document the benchmark purpose and expected performance characteristics

### Adding New DFIR-Only Benchmarks

When adding benchmarks that only test DFIR functionality:

1. Add the benchmark to the main repository (`bigweaver-agent-canary-hydro-zeta`)
2. Ensure no timely or differential-dataflow dependencies are introduced
3. Consider if a comparison version would be valuable in this repository

## Rollback Procedure

If the migration needs to be reverted:

1. Copy benchmark files from this repository back to `bigweaver-agent-canary-hydro-zeta/benches/benches/`
2. Update `bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml` to include timely and differential dependencies
3. Add the benchmark entries back to the `[[bench]]` sections
4. Update the README.md to remove migration references

## Questions or Issues

If you encounter issues related to this migration:

1. Check that you have both repositories cloned
2. Verify you're running benchmarks in the correct repository
3. Ensure dependencies are up to date: `cargo update`
4. Check that git dependencies can be fetched: `cargo fetch`

For persistent issues, please file an issue in the appropriate repository.
