# Benchmark Migration Documentation

## Summary

As of December 2024, the microbenchmarks including timely-dataflow and differential-dataflow dependencies have been moved from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## What Changed

### Source Repository (bigweaver-agent-canary-hydro-zeta)

**Removed:**
- `benches/` directory (all benchmark files and code)
- `benches` from workspace members in `Cargo.toml`
- Timely and differential-dataflow package dependencies

**Updated:**
- `Cargo.toml` - Removed "benches" from workspace members
- `CONTRIBUTING.md` - Updated to reference new benchmark location
- `README.md` - Added benchmarks section pointing to new repository
- `.github/workflows/benchmark.yml` - Converted to redirect workflow

### Destination Repository (bigweaver-agent-canary-zeta-hydro-deps)

**Added:**
- `benches/` directory with all benchmark files
  - `benches/benches/` - All benchmark source files (*.rs)
  - `benches/benches/*.txt` - Benchmark data files (reachability graphs, word lists)
  - `benches/Cargo.toml` - Updated with relative paths to dfir_rs and sinktools
  - `benches/README.md` - Benchmark usage instructions
  - `benches/build.rs` - Build script for generated benchmarks
- `Cargo.toml` - Workspace configuration with benches member
- `.gitignore` - Standard Rust project ignores
- `rust-toolchain.toml` - Rust toolchain specification
- `.github/workflows/benchmark.yml` - Full benchmark CI workflow
- `.github/workflows/ci.yml` - CI workflow to verify benchmarks compile
- Updated `README.md` - Comprehensive documentation

**Dependencies Added:**
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)

## Why This Change Was Made

1. **Dependency Separation**: Timely-dataflow and differential-dataflow are external framework dependencies used solely for performance comparison benchmarks. Moving them to a separate repository keeps the main Hydro repository focused on its core functionality.

2. **Build Time Optimization**: Users who only need Hydro/DFIR functionality don't need to build or download the comparison framework dependencies.

3. **Maintenance Clarity**: Benchmark code that compares against other frameworks is now clearly separated from the core Hydro implementation.

4. **Performance Comparison Focus**: The separate repository makes it clear that these benchmarks serve as performance comparisons and empirical validation rather than core functionality.

## How to Run Benchmarks After Migration

### From the bigweaver-agent-canary-zeta-hydro-deps repository:

```bash
# Clone both repositories if needed
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Run benchmarks
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run specific benchmarks:

```bash
# Reachability benchmark (includes timely, differential, and Hydro/DFIR implementations)
cargo bench -p benches --bench reachability

# Other benchmarks
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench micro_ops
```

## CI/CD Integration

The benchmark workflows have been migrated:

- **Original Repository**: The `benchmark.yml` workflow now redirects users to the new location
- **New Repository**: Full benchmark workflow with automated gh-pages publishing for results

The new repository's CI workflow:
1. Checks out both repositories (main hydro + deps)
2. Runs benchmarks
3. Publishes results to gh-pages branch
4. Generates HTML reports for viewing benchmark history

## Impact on Existing Workflows

### Developers Working on Core Hydro/DFIR
- **No benchmark dependencies to build** - Faster clean builds
- **Benchmark comparisons still available** - Just in a separate repository
- **No change to core development workflow** - All main functionality remains

### Developers Working on Performance Comparison
- **Clone both repositories** - Main hydro repo and deps repo
- **Run benchmarks from deps repo** - Simple cargo commands as before
- **Performance comparison functionality preserved** - All benchmarks still functional

## File Locations Reference

### Moved Files

All files from `bigweaver-agent-canary-hydro-zeta/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/benches/`:

- `benches/arithmetic.rs`
- `benches/fan_in.rs`
- `benches/fan_out.rs`
- `benches/fork_join.rs`
- `benches/futures.rs`
- `benches/identity.rs`
- `benches/join.rs`
- `benches/micro_ops.rs`
- `benches/reachability.rs`
- `benches/symmetric_hash_join.rs`
- `benches/upcase.rs`
- `benches/words_diamond.rs`
- `benches/reachability_edges.txt`
- `benches/reachability_reachable.txt`
- `benches/words_alpha.txt`
- `benches/.gitignore`
- `Cargo.toml` (benches package)
- `README.md` (benches)
- `build.rs` (benches)

## Questions or Issues?

If you encounter any issues with the benchmark migration or have questions:

1. Check the README.md in the bigweaver-agent-canary-zeta-hydro-deps repository
2. Verify both repositories are cloned and accessible
3. Ensure the relative paths in `benches/Cargo.toml` correctly point to the main repository

## Verification

To verify the migration was successful:

```bash
# In bigweaver-agent-canary-zeta-hydro-deps
cargo check -p benches  # Should compile successfully
cargo bench -p benches --bench reachability  # Should run benchmarks
```
