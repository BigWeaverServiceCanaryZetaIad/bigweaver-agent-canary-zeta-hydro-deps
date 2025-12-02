# Benchmark Migration Summary

## Executive Summary

The timely-dataflow and differential-dataflow performance benchmarks have been successfully migrated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to this dedicated benchmarks repository.

**Migration Date**: 2025-12-02

## Migration Goals

✅ **Achieved**:
1. Reduce dependency bloat in the main repository
2. Improve build times for core development
3. Maintain comprehensive performance testing capabilities
4. Preserve historical benchmark data
5. Enable continued performance comparisons

## What Was Migrated

### Benchmark Files (12 benchmarks)
- `arithmetic.rs` - Basic arithmetic operations
- `fan_in.rs` - Data convergence patterns
- `fan_out.rs` - Data distribution patterns
- `fork_join.rs` - Fork-join parallelism patterns
- `futures.rs` - Async/futures operations
- `identity.rs` - Identity transformations
- `join.rs` - Join operations
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability algorithms
- `symmetric_hash_join.rs` - Symmetric hash join implementations
- `upcase.rs` - String transformation operations
- `words_diamond.rs` - Diamond pattern processing

### Test Data Files
- `reachability_edges.txt` (55,008 edges)
- `reachability_reachable.txt` (7,855 nodes)
- `words_alpha.txt` (370,104 words)

### Infrastructure
- `benches/Cargo.toml` - Benchmark configuration
- `benches/build.rs` - Build script
- `benches/README.md` - Benchmark documentation
- `.github/workflows/benchmark.yml` - CI/CD workflow

### Dependencies Removed from Main Repo
- `timely-master` (timely-dataflow)
- `differential-dataflow-master`
- Related sub-crates (timely-bytes, timely-communication, etc.)

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── Cargo.toml          # Benchmark configuration with git dependencies
│   ├── build.rs            # Build script
│   ├── README.md           # Benchmark documentation
│   └── benches/            # Benchmark implementations
│       ├── arithmetic.rs
│       ├── fan_in.rs
│       ├── fan_out.rs
│       ├── fork_join.rs
│       ├── futures.rs
│       ├── identity.rs
│       ├── join.rs
│       ├── micro_ops.rs
│       ├── reachability.rs
│       ├── symmetric_hash_join.rs
│       ├── upcase.rs
│       ├── words_diamond.rs
│       ├── reachability_edges.txt
│       ├── reachability_reachable.txt
│       └── words_alpha.txt
├── .github/
│   └── workflows/
│       └── benchmark.yml   # CI/CD for benchmarks
├── Cargo.toml              # Workspace configuration
├── README.md               # Repository overview
├── CONTRIBUTING.md         # Contribution guidelines
├── MIGRATION_SUMMARY.md    # This file
└── .gitignore              # Git ignore patterns
```

## Technical Changes

### Dependency Management

**Before** (in main repository):
```toml
[dev-dependencies]
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After** (in deps repository):
```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git" }
```

This ensures benchmarks automatically track the latest changes from the main repository.

### Workspace Configuration

Created a new Cargo workspace in this repository with:
- Rust edition 2024
- Consistent lint configuration matching main repository
- Optimized release profile for accurate benchmarking

### CI/CD Integration

The benchmark workflow continues to:
- Run on push to main (with `[ci-bench]` tag)
- Run on pull requests (with `[ci-bench]` tag)
- Run on daily schedule (03:35 UTC)
- Support manual workflow dispatch
- Publish results to gh-pages branch

## Impact on Main Repository

### Files Added
- `BENCHMARKS_MIGRATION.md` - Migration guide
- `regenerate-lockfile.sh` - Script to clean Cargo.lock

### Files Modified
- `README.md` - Added benchmarks section with link to this repo
- `CONTRIBUTING.md` - Added benchmarks section
- `Cargo.lock` - Removed benches, timely, and differential entries (requires regeneration)

### Files Removed
- `benches/` directory (entire tree)
- `.github/workflows/benchmark.yml` (already removed in previous commits)

## Benefits Achieved

### For Main Repository
1. **Faster builds**: Removed heavy timely/differential dependencies
2. **Smaller repository**: Removed ~4.4MB of benchmark code and data
3. **Focused development**: Core functionality separate from benchmarking
4. **Cleaner dependencies**: No performance-comparison-only dependencies

### For Benchmarks
1. **Dedicated environment**: Benchmarks in their own repository
2. **Independent CI/CD**: Benchmark runs don't affect main CI
3. **Git dependencies**: Automatic tracking of main repository changes
4. **Preserved history**: All historical benchmark data maintained

### For Performance Testing
1. **Maintained capabilities**: All benchmarks still functional
2. **Easy comparison**: Can benchmark any commit from main repository
3. **Documented workflow**: Clear process for running benchmarks
4. **Automated testing**: CI continues to run benchmarks automatically

## Usage Instructions

### Running Benchmarks Locally

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches -- dfir
cargo bench -p benches -- micro/ops/

# View HTML reports
open target/criterion/report/index.html
```

### Triggering CI Benchmarks

Add `[ci-bench]` to:
- Commit messages (for pushes to main)
- PR titles or descriptions (for pull requests)

Or use the GitHub Actions "Run workflow" button for manual triggering.

### Comparing Performance

1. Make changes in main repository
2. Push changes to main repository
3. Run benchmarks in this repository (git deps fetch latest automatically)
4. Compare with historical results in gh-pages branch

## Rollback Plan

If needed, benchmarks can be moved back by:
1. Reverting the removal commit in main repository
2. Changing git dependencies back to path dependencies
3. Removing this repository
4. Regenerating Cargo.lock

However, this is not recommended as it would reintroduce the dependency bloat.

## Future Considerations

### Potential Enhancements
1. Add more benchmark comparisons
2. Implement automated performance regression detection
3. Create dashboards for benchmark trends
4. Add benchmark variants for different workload sizes
5. Integrate with performance monitoring tools

### Maintenance
- Keep git dependencies up to date with main repository
- Monitor benchmark execution times in CI
- Update test data as needed
- Review and update benchmarks for API changes

## Related Documentation

- Main repository migration guide: `BENCHMARKS_MIGRATION.md` in main repo
- Benchmark development: `CONTRIBUTING.md` in this repo
- Repository overview: `README.md` in this repo
- Benchmark specifics: `benches/README.md`

## Contact

For questions or issues:
- **Benchmarks**: Open an issue in this repository
- **Core functionality**: Open an issue in the main repository
- **Migration questions**: Contact the Hydro development team

## Acknowledgments

This migration preserves the valuable work of all contributors to the original benchmark suite while improving the development experience for the Hydro project.
