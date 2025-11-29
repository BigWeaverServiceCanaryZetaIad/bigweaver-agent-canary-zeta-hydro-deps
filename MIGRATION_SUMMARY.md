# Benchmark Migration Summary

## Overview
This document summarizes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migrated Components

### Benchmarks Directory (`benches/`)
All benchmark-related files and code have been moved to this repository:

#### Core Files
- `Cargo.toml` - Benchmark package configuration with timely and differential-dataflow dependencies
- `README.md` - Documentation on how to run benchmarks
- `build.rs` - Build script for generating fork_join benchmark code

#### Benchmark Suites (`benches/`)
- `arithmetic.rs` - Arithmetic operation benchmarks comparing Hydro, timely, and raw implementations
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Async futures benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String uppercase operation benchmarks
- `words_diamond.rs` - Words diamond pattern benchmarks

#### Data Files
- `reachability_edges.txt` - Edge data for reachability benchmarks (~532KB)
- `reachability_reachable.txt` - Reachability results data (~38KB)
- `words_alpha.txt` - English words dictionary for benchmarks (~3.8MB)

## Removed from Source Repository

The following were removed from `bigweaver-agent-canary-hydro-zeta`:

1. **`benches/` directory** - Entire benchmark suite moved to this repository
2. **Cargo.toml workspace member** - `benches` removed from workspace members list
3. **Cargo.lock entries** - Stale timely and differential-dataflow package entries removed:
   - `benches` (version 0.0.0)
   - `differential-dataflow-master` (version 0.13.0-dev.1)
   - `timely-master` (version 0.13.0-dev.1)
   - `timely-bytes-master` (version 0.13.0-dev.1)
   - `timely-communication-master` (version 0.13.0-dev.1)
   - `timely-container-master` (version 0.13.0-dev.1)
   - `timely-logging-master` (version 0.13.0-dev.1)
4. **GitHub workflow** - `.github/workflows/benchmark.yml` removed
5. **Documentation references** - Benchmark references removed from `.github/gh-pages/index.md` and `CONTRIBUTING.md`

## Dependencies

### External Dependencies (timely/differential-dataflow)
The benchmarks maintain dependencies on:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)

These dependencies are now isolated to this repository, avoiding pollution of the main repository's dependency tree.

### Main Repository Dependencies
The benchmarks reference the following packages from the main hydro repository via git:
- `dfir_rs` - Required for dfir_syntax macros and Hydro implementations
- `sinktools` - Required for certain benchmark utilities

These are referenced using git dependencies:
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git" }
```

## Performance Comparison Functionality

The benchmarks retain full performance comparison capabilities:
- All benchmarks can be executed independently in this repository
- Comparisons between Hydro, timely, differential-dataflow, and raw implementations are preserved
- Criterion-based benchmarking infrastructure remains intact

## Running Benchmarks

### Run All Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run Specific Benchmarks
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

### View Benchmark Reports
HTML reports are generated in `target/criterion/` directory after running benchmarks.

## Benefits of Migration

1. **Cleaner Main Repository** - The main hydro repository no longer has timely/differential-dataflow dependencies
2. **Separation of Concerns** - Benchmarks are isolated in a dedicated repository
3. **Maintained Functionality** - All performance comparison capabilities are retained
4. **Better Scalability** - Independent development and versioning of benchmark suite
5. **Reduced Build Times** - Main repository builds faster without benchmark dependencies

## Verification

To verify the migration was successful:

1. **Source Repository** - Confirm no timely/differential-dataflow dependencies:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   grep -r "timely\|differential" --include="*.toml" .
   # Should return no results
   ```

2. **Target Repository** - Confirm benchmarks work:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches --bench arithmetic
   # Should run successfully
   ```

## Maintenance

### Updating Benchmark Dependencies
When the main hydro repository structure changes, update the git references in `benches/Cargo.toml`.

### Adding New Benchmarks
1. Add new benchmark files to `benches/benches/`
2. Add `[[bench]]` entry to `benches/Cargo.toml`
3. Follow existing benchmark patterns for consistency

### Updating timely/differential-dataflow Versions
Update the version numbers in `benches/Cargo.toml`:
```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.X.Y" }
timely = { package = "timely-master", version = "0.X.Y" }
```
