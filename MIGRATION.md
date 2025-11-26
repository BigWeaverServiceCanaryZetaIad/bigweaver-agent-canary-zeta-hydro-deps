# Migration Guide

This document describes the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated repository.

## Overview

As part of a dependency cleanup initiative, benchmarks that require `timely` and `differential-dataflow` dependencies have been moved to this separate repository. This migration improves the main repository by:

- Reducing dependency footprint
- Improving build times
- Simplifying the main codebase
- Maintaining benchmark capabilities in a dedicated location

## What Was Moved

### Benchmark Files

The following benchmark files were migrated from `bigweaver-agent-canary-hydro-zeta/benches/benches/`:

1. **identity.rs** - Identity transformation benchmarks comparing multiple implementations
2. **fork_join.rs** - Fork-join pattern benchmarks
3. **join.rs** - Join operation benchmarks
4. **upcase.rs** - String uppercase transformation benchmarks
5. **fan_in.rs** - Fan-in pattern benchmarks
6. **fan_out.rs** - Fan-out pattern benchmarks
7. **arithmetic.rs** - Arithmetic operations benchmarks
8. **reachability.rs** - Graph reachability benchmarks using differential-dataflow

### Supporting Files

- **reachability_edges.txt** - Test data for reachability benchmark (521 KB)
- **reachability_reachable.txt** - Expected results for reachability benchmark (38 KB)
- **words_alpha.txt** - Word list for text processing benchmarks (3.7 MB)
- **build.rs** - Build script for generating benchmark code

### Dependencies Added

The following dependencies are now in this repository's `Cargo.toml`:

```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

## What Remains in Main Repository

The main `bigweaver-agent-canary-hydro-zeta` repository retains benchmarks that don't depend on timely or differential-dataflow:

- **futures.rs** - Futures-based benchmarks
- **micro_ops.rs** - Micro-operations benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **words_diamond.rs** - Words diamond pattern benchmarks

## Migration Timeline

The migration was completed in phases:

1. **Phase 1**: Identification of timely/differential dependencies
2. **Phase 2**: Repository setup and initial structure
3. **Phase 3**: Benchmark file migration
4. **Phase 4**: Dependency configuration
5. **Phase 5**: Documentation creation
6. **Phase 6**: Verification and testing

## For Users of the Main Repository

### What Changed

If you previously ran benchmarks in the main repository:

**Before migration:**
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench identity
```

**After migration:**
```bash
# For Hydro-specific benchmarks (still in main repo)
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench futures

# For timely/differential comparison benchmarks (moved to this repo)
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench identity
```

### Documentation Updates

The main repository documentation was updated:

- **BENCHMARK_REMOVAL_SUMMARY.md** - Details what was removed and why
- **benches/README.md** - Updated to reflect remaining benchmarks
- References added pointing to this repository

### Build Time Improvements

With the removal of timely and differential-dataflow dependencies, the main repository build time is significantly improved:

- Fewer dependencies to compile
- Reduced total compilation time
- Faster incremental builds

## For Developers

### Using Both Repositories

If you're working on both repositories:

```bash
# Clone both repositories side-by-side
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps

# Main repo: Hydro development
cd bigweaver-agent-canary-hydro-zeta
cargo build

# Deps repo: Performance comparisons
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Local Path Dependencies

For development with local changes, modify this repository's `Cargo.toml`:

```toml
# Instead of git dependencies:
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }

# Use local paths:
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### Updating Benchmarks

When updating benchmarks:

1. **Hydro-specific changes**: Update in main repository
2. **Comparison benchmarks**: Update in this repository
3. **Cross-repository changes**: Coordinate PRs across both repos

### Testing Changes

Test workflow:

```bash
# Test main repository changes
cd bigweaver-agent-canary-hydro-zeta
cargo test
cargo bench -p benches

# Test this repository with updated dependencies
cd ../bigweaver-agent-canary-zeta-hydro-deps
# Update Cargo.toml to use local path
cargo bench
```

## Repository Structure Comparison

### Before Migration (Main Repository)

```
bigweaver-agent-canary-hydro-zeta/
├── benches/
│   ├── Cargo.toml (with timely/differential deps)
│   ├── build.rs
│   └── benches/
│       ├── identity.rs (MOVED)
│       ├── fork_join.rs (MOVED)
│       ├── join.rs (MOVED)
│       ├── upcase.rs (MOVED)
│       ├── fan_in.rs (MOVED)
│       ├── fan_out.rs (MOVED)
│       ├── arithmetic.rs (MOVED)
│       ├── reachability.rs (MOVED)
│       ├── futures.rs (KEPT)
│       ├── micro_ops.rs (KEPT)
│       ├── symmetric_hash_join.rs (KEPT)
│       └── words_diamond.rs (KEPT)
└── ...
```

### After Migration

**Main Repository:**
```
bigweaver-agent-canary-hydro-zeta/
├── benches/
│   ├── Cargo.toml (NO timely/differential deps)
│   ├── build.rs
│   └── benches/
│       ├── futures.rs
│       ├── micro_ops.rs
│       ├── symmetric_hash_join.rs
│       └── words_diamond.rs
├── BENCHMARK_REMOVAL_SUMMARY.md (NEW)
└── ...
```

**This Repository:**
```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml (with timely/differential deps)
├── build.rs
├── benches/
│   ├── identity.rs
│   ├── fork_join.rs
│   ├── join.rs
│   ├── upcase.rs
│   ├── fan_in.rs
│   ├── fan_out.rs
│   ├── arithmetic.rs
│   ├── reachability.rs
│   ├── reachability_edges.txt
│   ├── reachability_reachable.txt
│   └── words_alpha.txt
├── README.md
├── RUNNING_BENCHMARKS.md
└── MIGRATION.md (this file)
```

## Dependency Management

### Version Synchronization

Keep dependency versions synchronized with the main repository:

**Main Repository versions:**
- Check `bigweaver-agent-canary-hydro-zeta/Cargo.toml` for shared dependencies
- Match versions of: criterion, futures, tokio, rand, etc.

**This Repository specific versions:**
- timely: 0.13.0-dev.1 (package: timely-master)
- differential-dataflow: 0.13.0-dev.1 (package: differential-dataflow-master)

### Updating Dependencies

When updating dependencies:

```bash
# Update Cargo.toml versions
# Then update Cargo.lock
cargo update

# Test that everything still works
cargo build
cargo bench --no-run
```

## CI/CD Considerations

### Separate Pipelines

The repositories should have separate CI/CD pipelines:

**Main Repository CI:**
- Build and test main codebase
- Run Hydro-specific benchmarks
- Fast feedback loop (no timely/differential compilation)

**This Repository CI:**
- Build comparison benchmarks
- Run performance comparisons
- Can be scheduled less frequently (e.g., nightly)
- Longer build times acceptable

### Integration Points

Coordinate releases:
- When main repository releases new version, test this repository
- Update git dependencies to point to released versions
- Tag this repository with corresponding version

## Breaking Changes

### API Changes in dfir_rs

If the main repository's dfir_rs API changes:

1. This repository's benchmarks may need updates
2. Create companion PRs in both repositories
3. Test locally before merging
4. Coordinate merge timing

### Backward Compatibility

To maintain compatibility:

1. Use stable APIs where possible
2. Test against main repository's stable branch
3. Document any version-specific requirements
4. Provide migration guides for major changes

## Performance History

### Preserving Historical Data

Benchmark results from before the migration are still relevant:

- Historical data remains in main repository's criterion results
- New baseline established in this repository
- Compare apples-to-apples (same benchmark, before and after migration)

### Establishing New Baselines

After migration:

```bash
# Establish new baseline
cargo bench -- --save-baseline initial

# Future comparisons
cargo bench -- --baseline initial
```

## Troubleshooting Migration Issues

### Benchmarks Don't Compile

**Issue:** Compilation errors after migration

**Solution:**
1. Verify all data files were copied
2. Check dependency versions match
3. Ensure dfir_rs API compatibility
4. Review error messages for missing imports

### Performance Results Differ

**Issue:** Results differ from pre-migration runs

**Solution:**
1. Verify same hardware used
2. Check for environmental differences
3. Confirm same Rust version
4. Review benchmark parameters (NUM_OPS, etc.)

### Git Dependency Issues

**Issue:** Cannot fetch dfir_rs from git

**Solution:**
1. Check network connectivity
2. Verify repository URL is correct
3. Use local path dependency as alternative
4. Check SSH keys if using SSH URL

### Missing Data Files

**Issue:** Benchmarks fail due to missing data

**Solution:**
1. Verify all .txt files were copied:
   - reachability_edges.txt
   - reachability_reachable.txt
   - words_alpha.txt
2. Check file permissions
3. Verify paths in benchmark code

## Contributing to This Repository

### Contribution Guidelines

When contributing to this repository:

1. **Follow existing patterns**: Match the style of existing benchmarks
2. **Update documentation**: Keep README and this guide current
3. **Test thoroughly**: Run all benchmarks before submitting PR
4. **Coordinate with main repo**: For API-dependent changes
5. **Preserve comparability**: Maintain consistency with previous results

### Adding New Benchmarks

To add a new benchmark:

1. Create `benches/new_benchmark.rs`
2. Add `[[bench]]` section to `Cargo.toml`
3. Document in README.md
4. Add usage examples to RUNNING_BENCHMARKS.md
5. Test with `cargo bench --bench new_benchmark`

## Future Considerations

### Potential Enhancements

- **Automated result tracking**: Store and compare results over time
- **Performance regression detection**: Alert on significant changes
- **Extended comparisons**: Add more dataflow framework comparisons
- **Cloud benchmarking**: Run on standardized cloud infrastructure
- **Visualization tools**: Better result analysis and presentation

### Maintenance

Regular maintenance tasks:

- **Dependency updates**: Keep timely and differential-dataflow current
- **API synchronization**: Update when main repo changes
- **Documentation**: Keep guides current
- **Benchmark relevance**: Review and update benchmarks as needed

## Questions and Support

For questions about this migration:

1. Review this document and README.md
2. Check main repository's BENCHMARK_REMOVAL_SUMMARY.md
3. Consult the team or maintainers
4. Open an issue in the appropriate repository

## References

- Main Repository: `bigweaver-agent-canary-hydro-zeta`
- Main Repo Migration Doc: `BENCHMARK_REMOVAL_SUMMARY.md`
- Main Repo Benchmarks: `benches/README.md`
- This Repo Benchmarks Guide: `RUNNING_BENCHMARKS.md`

---

Migration completed: 2024
Last updated: 2024
