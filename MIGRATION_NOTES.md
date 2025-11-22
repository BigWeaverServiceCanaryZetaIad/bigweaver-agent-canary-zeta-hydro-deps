# Migration Notes: Timely and Differential-Dataflow Benchmarks

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the 
`bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` 
repository.

## Migration Date

November 22, 2024

## Rationale

The benchmarks were moved to:
- Maintain a cleaner separation of concerns between core Hydro functionality and external dependencies
- Avoid unnecessary dependencies in the main repository
- Improve build times for the main repository
- Keep the main codebase focused and lean
- Facilitate independent maintenance of benchmark dependencies

## Migrated Files

### Benchmark Files
The following benchmark files were moved from `bigweaver-agent-canary-hydro-zeta/benches/benches/` 
to `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`:

1. **arithmetic.rs** - Timely dataflow arithmetic operations benchmark
2. **fan_in.rs** - Timely dataflow fan-in pattern benchmark
3. **fan_out.rs** - Timely dataflow fan-out pattern benchmark
4. **fork_join.rs** - Timely dataflow fork-join pattern benchmark
5. **identity.rs** - Timely dataflow identity transformation benchmark
6. **join.rs** - Timely dataflow join operations benchmark
7. **reachability.rs** - Differential-dataflow graph reachability benchmark
8. **upcase.rs** - Timely dataflow string uppercase transformation benchmark

### Data Files
The following data files were moved along with their associated benchmarks:

1. **reachability_edges.txt** - Graph edge data for reachability benchmark
2. **reachability_reachable.txt** - Expected reachable nodes for verification
3. **.gitignore** - Git ignore configuration for benchmark artifacts

## Benchmarks Retained in Main Repository

The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta/benches/` as they do not 
depend on timely or differential-dataflow:

1. **futures.rs** - Uses dfir_rs only
2. **micro_ops.rs** - Uses dfir_rs only
3. **symmetric_hash_join.rs** - Uses dfir_rs compiled API
4. **words_diamond.rs** - Uses dfir_rs only

### Data Files Retained
- **words_alpha.txt** - Required by words_diamond.rs benchmark

## Configuration Changes

### New Repository Structure
Created the following structure in `bigweaver-agent-canary-zeta-hydro-deps`:

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml (workspace configuration)
├── README.md (repository overview)
├── MIGRATION_NOTES.md (this file)
├── REMOVAL_SUMMARY.md (summary for main repo)
├── CHANGES_README.md (detailed changes)
└── benches/
    ├── Cargo.toml (benchmark package configuration)
    ├── README.md (benchmark documentation)
    └── benches/
        ├── .gitignore
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

### Dependency Configuration
The `benches/Cargo.toml` in the new repository includes:
- `timely` (timely-master v0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1)
- `criterion` v0.5.0 for benchmarking
- `dfir_rs` from main Hydro repository (via git)
- `sinktools` from main Hydro repository (via git)

### Main Repository Updates
In `bigweaver-agent-canary-hydro-zeta/benches/`:
- Removed timely and differential-dataflow benchmarks
- Removed associated data files (reachability_edges.txt, reachability_reachable.txt)
- Updated Cargo.toml to remove timely and differential-dataflow dependencies
- Updated README.md to reflect the removal and point to the new location
- Updated workspace configuration if needed

## Performance Comparison Functionality

The performance comparison functionality has been retained through:

1. **Consistent Criterion Usage**: Both repositories use Criterion 0.5.0 with the same features
2. **Compatible Output Format**: Benchmark results are stored in `target/criterion/` in both repositories
3. **Same Benchmark Names**: Benchmark names follow the same convention (e.g., "arithmetic/timely")
4. **Cross-Repository Comparison**: Results can be compared by examining the generated reports

### How to Compare Performance

1. Run benchmarks in the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. Run benchmarks in the deps repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p timely-differential-benches
   ```

3. Compare results by examining:
   - HTML reports in `target/criterion/*/report/index.html`
   - Raw data in `target/criterion/*/base/`
   - Criterion's built-in comparison features

## Dependencies Reference

### Timely Benchmarks
- Package: timely-master
- Version: 0.13.0-dev.1
- Used by: arithmetic, fan_in, fan_out, fork_join, identity, join, upcase

### Differential-Dataflow Benchmarks
- Package: differential-dataflow-master
- Version: 0.13.0-dev.1
- Used by: reachability

## Testing and Verification

After migration, verify that:

1. ✅ All moved benchmarks compile successfully in the new repository
2. ✅ Benchmarks can be run individually and as a group
3. ✅ Performance results are generated correctly
4. ✅ Data files are accessible to their respective benchmarks
5. ✅ Main repository builds successfully without the moved benchmarks
6. ✅ Remaining benchmarks in main repository still function correctly

## Rollback Procedure

If needed, the migration can be reversed by:

1. Copying the benchmark files back to `bigweaver-agent-canary-hydro-zeta/benches/benches/`
2. Restoring the timely and differential-dataflow dependencies in the main repo's `benches/Cargo.toml`
3. Restoring the benchmark declarations in the main repo's `benches/Cargo.toml`
4. Removing the benchmarks from `bigweaver-agent-canary-zeta-hydro-deps`

## Related Changes

This migration is part of a larger effort to:
- Modularize the Hydro project structure
- Separate external dependency benchmarks
- Improve maintainability and build performance
- Align with team preferences for repository organization

## Contact and Questions

For questions about this migration, refer to:
- The corresponding pull request in both repositories
- Team documentation on repository structure
- CONTRIBUTING.md in the main repository
