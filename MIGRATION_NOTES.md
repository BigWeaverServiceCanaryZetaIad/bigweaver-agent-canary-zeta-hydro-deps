# Benchmark Migration Notes

This document describes the migration of the `benches` directory from the `bigweaver-agent-canary-hydro-zeta` repository to this repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date
Migration completed: December 25, 2024

## What Was Moved
The entire `benches` directory containing:
- **Cargo.toml**: Benchmark package configuration with all dependencies
- **build.rs**: Build script for generating fork_join benchmark code
- **README.md**: Documentation on how to run benchmarks
- **benches/**: Directory containing all benchmark source files and data files

### Benchmark Files (12 total)
1. `fork_join.rs` - Fork-join pattern benchmarks
2. `fan_in.rs` - Fan-in pattern benchmarks
3. `fan_out.rs` - Fan-out pattern benchmarks
4. `reachability.rs` - Graph reachability benchmarks
5. `join.rs` - Join operation benchmarks
6. `symmetric_hash_join.rs` - Symmetric hash join benchmarks
7. `arithmetic.rs` - Arithmetic operation benchmarks
8. `identity.rs` - Identity operation benchmarks
9. `upcase.rs` - String case conversion benchmarks
10. `micro_ops.rs` - Micro-operation benchmarks
11. `words_diamond.rs` - Word processing diamond pattern benchmarks
12. `futures.rs` - Futures-based benchmarks

### Data Files (3 total)
1. `reachability_edges.txt` (521KB) - Graph edges for reachability benchmarks
2. `reachability_reachable.txt` (38KB) - Reachable nodes data
3. `words_alpha.txt` (3.7MB) - English word list from https://github.com/dwyl/english-words

## Key Dependencies
The benchmarks depend on:
- `timely-master` version 0.13.0-dev.1
- `differential-dataflow-master` version 0.13.0-dev.1
- `dfir_rs` (via git from hydro-project/hydro)
- `sinktools` (via git from hydro-project/hydro)
- `criterion` 0.5.0 with async_tokio and html_reports features

## Changes Made During Migration

### 1. Dependency Updates
The `benches/Cargo.toml` was updated to change path dependencies to git dependencies:
- **Before**: `dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }`
- **After**: `dfir_rs = { git = "https://github.com/hydro-project/hydro", features = [ "debugging" ] }`

- **Before**: `sinktools = { path = "../sinktools", version = "^0.0.1" }`
- **After**: `sinktools = { git = "https://github.com/hydro-project/hydro" }`

### 2. Workspace Configuration
Created a new `Cargo.toml` at the repository root to define the workspace:
```toml
[workspace]
members = [
    "benches",
]
```

### 3. Source Repository Updates
In the `bigweaver-agent-canary-hydro-zeta` repository:
- Removed `"benches"` from workspace members
- Deleted the `benches` directory
- Updated `.github/workflows/benchmark.yml` to note benchmarks were moved
- Updated `CONTRIBUTING.md` to reference new benchmark location

## Using Local Path Dependencies (Optional)
If you have both repositories checked out locally and want to use path dependencies instead of git dependencies, you can modify `benches/Cargo.toml`:

```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

Adjust the paths based on your local directory structure.

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmarks
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench fan_in
```

### Filter by Pattern
```bash
cargo bench -p benches -- dfir
cargo bench -p benches -- micro/ops/
```

## Benchmark Output
Benchmarks generate:
- Console output with timing results
- HTML reports in `target/criterion/` directory
- Criterion comparison data for tracking performance over time

## Maintenance Notes
- The benchmarks use `criterion` with `harness = false` for all benchmark targets
- The `build.rs` script generates `fork_join_20.hf` at build time
- All benchmarks can be run independently or as a suite
- Performance comparisons are preserved through Criterion's history tracking

## Future Considerations
- Consider setting up CI/CD for automated benchmark runs
- May want to publish benchmark results to a dashboard
- Could add more benchmarks for new Hydro features
- Consider separating benchmarks by framework (Hydro, timely, differential-dataflow)
