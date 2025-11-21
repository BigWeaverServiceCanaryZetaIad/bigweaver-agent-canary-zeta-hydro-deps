# Migration Guide: Timely and Differential Dataflow Benchmarks

This document explains the migration of benchmarks from the bigweaver-agent-canary-hydro-zeta repository to this dedicated benchmarking repository.

## What Was Migrated

### Benchmark Files
All 12 benchmark test files were migrated from the main repository:
- arithmetic.rs - Pipeline arithmetic operations
- fan_in.rs - Fan-in pattern
- fan_out.rs - Fan-out pattern  
- fork_join.rs - Fork-join pattern
- futures.rs - Futures handling
- identity.rs - Identity/passthrough
- join.rs - Join operations
- micro_ops.rs - Micro operations
- reachability.rs - Graph reachability
- symmetric_hash_join.rs - Symmetric hash join
- upcase.rs - String transformation
- words_diamond.rs - Diamond pattern with word processing

### Supporting Files
- **Test Data Files**:
  - reachability_edges.txt - Graph edges for reachability benchmark
  - reachability_reachable.txt - Expected reachability results
  - words_alpha.txt - Word list for string processing benchmarks

- **Build Configuration**:
  - Cargo.toml - Benchmark package configuration
  - build.rs - Build script
  - README.md - Benchmark usage instructions

### CI/CD Workflow
- **.github/workflows/benchmark.yml** - Complete benchmark automation workflow that:
  - Runs benchmarks on schedule and on-demand
  - Generates performance reports
  - Publishes results to GitHub Pages
  - Tracks performance history

## Key Changes

### 1. Dependency Management

**Before (in main repository):**
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After (in benchmarks repository):**
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", branch = "main", version = "^0.0.1" }
```

Dependencies on dfir_rs and sinktools now reference the main Hydro repository via git, ensuring benchmarks always use the latest versions for comparison.

### 2. Repository Structure

**Main Repository (bigweaver-agent-canary-hydro-zeta):**
- Removed `/benches` directory
- Removed benchmark workflow
- Removed timely/differential-dataflow dependencies from workspace
- Faster build times and simplified dependency tree

**Benchmarks Repository (bigweaver-agent-canary-zeta-hydro-deps):**
- Dedicated workspace for benchmarks
- Isolated dependency management
- Independent CI/CD for performance tracking

### 3. Workspace Configuration

Created new workspace in benchmarks repository:
```toml
[workspace]
resolver = "2"
members = [
    "benches",
]
```

## Performance Comparison Functionality

All performance comparison functionality has been **fully retained**:

### ✅ Benchmark Implementations
- All 12 benchmark tests comparing DFIR with timely/differential-dataflow
- Original test logic and data unchanged
- Same performance metrics collected

### ✅ CI/CD Automation
- Automated benchmark execution on schedule
- Performance tracking over time
- GitHub Pages publication for results
- Historical data preservation

### ✅ Reporting
- Criterion-based HTML reports
- Bencher format output
- Time-series performance data
- Comparative metrics between frameworks

## Running Benchmarks

The benchmark commands remain the same:

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run DFIR benchmarks
cargo bench -p benches -- dfir

# Run micro operations
cargo bench -p benches -- micro/ops/
```

## CI/CD Triggers

The workflow can be triggered by:

1. **Schedule**: Daily at 3:35 AM UTC
2. **Commit Message**: Include `[ci-bench]` in commit message on main branch
3. **Pull Request**: Include `[ci-bench]` in PR title or body
4. **Manual**: Via GitHub Actions workflow_dispatch

## Benefits of Migration

### For Main Repository
- ✅ Removed ~50MB of dependencies (timely, differential-dataflow, etc.)
- ✅ Faster build times
- ✅ Simpler dependency tree
- ✅ Focused on core Hydro/DFIR functionality
- ✅ Reduced CI/CD complexity

### For Benchmarks Repository
- ✅ Dedicated focus on performance analysis
- ✅ Independent version control for benchmark updates
- ✅ Isolated dependency management
- ✅ Flexible CI/CD configuration for performance needs
- ✅ Clear separation of concerns

## Accessing Results

Benchmark results are published to GitHub Pages at:
```
https://BigWeaverServiceCanaryZetaIad.github.io/bigweaver-agent-canary-zeta-hydro-deps/bench/
```

Historical data is tracked in the `gh-pages` branch.

## Maintenance

### Updating Benchmarks
1. Clone this repository
2. Make changes to benchmark files in `/benches/benches/`
3. Test locally: `cargo bench -p benches`
4. Commit with `[ci-bench]` to trigger CI

### Updating Dependencies
Update `benches/Cargo.toml` to:
- Bump criterion version
- Update timely/differential-dataflow versions
- Adjust dfir_rs features as needed

### Modifying CI/CD
Edit `.github/workflows/benchmark.yml` to:
- Change benchmark schedule
- Adjust performance thresholds
- Modify reporting format

## Migration Verification

To verify the migration was successful:

1. ✅ All benchmark files present in `/benches/benches/`
2. ✅ All test data files present
3. ✅ Cargo.toml properly configured
4. ✅ Workspace created
5. ✅ CI/CD workflow configured
6. ✅ Dependencies updated to git references
7. ✅ Documentation complete

## Rollback Procedure

If needed to restore benchmarks to main repository:

1. Copy `/benches` directory back to main repository
2. Update Cargo.toml paths to use relative paths
3. Add "benches" to workspace members
4. Restore `.github/workflows/benchmark.yml`
5. Update dependencies in Cargo.lock

## Questions or Issues

For questions about:
- **Benchmark implementation**: See `/benches/README.md`
- **CI/CD configuration**: See `.github/workflows/benchmark.yml`
- **Migration**: See this document
- **Performance results**: Check GitHub Pages

## Timeline

- **Original State**: Benchmarks in main repository
- **Migration Date**: 2025-11-20
- **Migration Commit**: [commit hash from git history]
- **New Repository**: bigweaver-agent-canary-zeta-hydro-deps

## Related Documents

- [README.md](README.md) - Repository overview
- [benches/README.md](benches/README.md) - Benchmark usage
- [BENCHMARK_REMOVAL_SUMMARY.md in main repo](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_REMOVAL_SUMMARY.md) - Removal details
