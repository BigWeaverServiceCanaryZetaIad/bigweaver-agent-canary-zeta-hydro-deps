# Migration Notes: Timely and Differential Dataflow Benchmarks

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

[Current Date]

## Rationale

The benchmarks were moved to achieve several goals:

1. **Dependency Isolation**: Isolate `timely` and `differential-dataflow` dependencies from the main Hydro repository
2. **Cleaner Architecture**: Reduce dependency complexity in the main repository
3. **Independent Maintenance**: Allow benchmarks to be maintained and updated independently
4. **Preserve Performance Comparison**: Maintain the ability to run performance comparisons between Hydro and Timely/Differential Dataflow

## Migrated Components

### Benchmark Files

The following benchmark files were moved from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`:

- `arithmetic.rs` - Arithmetic operations comparison benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `identity.rs` - Identity transformation benchmarks
- `join.rs` - Join operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `upcase.rs` - String uppercase transformation benchmarks

### Data Files

- `reachability_edges.txt` - Input data for reachability benchmark
- `reachability_reachable.txt` - Expected output for reachability benchmark

### Build Scripts

- `build.rs` - Build script for generating fork_join benchmark code

## Dependencies

The migrated benchmarks depend on:

- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `dfir_rs` (from main Hydro repository, via git reference)
- `sinktools` (from main Hydro repository, via git reference)
- `criterion` (v0.5.0)
- Supporting libraries: `futures`, `rand`, `tokio`, etc.

## Running Benchmarks

After migration, benchmarks can be run from this repository:

```bash
# Run all benchmarks
cargo bench -p timely-differential-benches

# Run specific benchmark
cargo bench -p timely-differential-benches --bench reachability
```

## Performance Comparison Functionality

The migrated benchmarks maintain full performance comparison capabilities:

1. Each benchmark compares multiple implementations:
   - Raw/baseline implementations
   - Iterator-based implementations
   - Hydro (dfir_rs) implementations (compiled and surface syntax)
   - Timely Dataflow implementations
   - Differential Dataflow implementations (where applicable)

2. Benchmarks reference `dfir_rs` and `sinktools` from the main Hydro repository via git, ensuring comparisons remain current with the latest Hydro developments.

3. Criterion benchmark framework provides consistent measurement and HTML reports for comparing performance across implementations.

## Integration with Main Repository

While the benchmarks now live in a separate repository, they maintain integration with the main Hydro repository:

- `dfir_rs` and `sinktools` are referenced via git URL pointing to the main repository
- Updates to Hydro will automatically be reflected in benchmark comparisons when dependencies are updated
- Benchmark results can be used to track performance improvements or regressions in both Hydro and Timely/Differential implementations

## Remaining Benchmarks in Main Repository

The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta/benches/`:

- `micro_ops.rs` - Hydro-only micro-operation benchmarks
- `symmetric_hash_join.rs` - Hydro-only hash join benchmarks
- `words_diamond.rs` - Hydro-only word processing benchmarks
- `futures.rs` - Hydro-only futures benchmarks

These benchmarks do not depend on timely or differential-dataflow and therefore remain in the main repository.

## Changes to Main Repository

The following changes were made to `bigweaver-agent-canary-hydro-zeta`:

1. **Removed Files**:
   - All benchmark files listed above
   - Associated data files

2. **Updated Configuration**:
   - `benches/Cargo.toml`: Removed `timely` and `differential-dataflow` dependencies
   - `benches/Cargo.toml`: Removed benchmark entries for migrated benchmarks
   - `benches/README.md`: Updated to reflect remaining benchmarks and reference this repository

3. **Documentation**:
   - Added `REMOVAL_SUMMARY.md` in the main repository
   - Created verification script `verify_migration.sh`

## Verification

To verify the migration was successful:

1. In this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo check
   cargo bench -p timely-differential-benches --bench arithmetic
   ```

2. In the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo check
   cargo bench -p benches
   ```

Both should compile and run without errors.

## Future Maintenance

### Adding New Timely/Differential Benchmarks

New benchmarks comparing Hydro with Timely or Differential Dataflow should be added to this repository:

1. Add benchmark file to `benches/benches/`
2. Add benchmark entry to `benches/Cargo.toml`
3. Update `benches/README.md` with benchmark description

### Updating Dependencies

To update Timely or Differential Dataflow versions:

1. Update version numbers in `benches/Cargo.toml`
2. Test all benchmarks to ensure compatibility
3. Update this document if there are significant changes

### Updating Hydro References

The `dfir_rs` and `sinktools` dependencies reference the main repository via git. To update to a specific version or branch:

1. Modify the git reference in `benches/Cargo.toml`
2. Run `cargo update` to fetch the new versions
3. Verify all benchmarks compile and run correctly

## Contact

For questions about this migration or the benchmarks, please refer to the main Hydro project documentation or create an issue in the appropriate repository.
