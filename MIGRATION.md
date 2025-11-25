# Migration Guide

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Overview

**Migration Date**: November 25, 2024  
**Source Repository**: bigweaver-agent-canary-hydro-zeta  
**Destination Repository**: bigweaver-agent-canary-zeta-hydro-deps  

### Rationale

The benchmarks were moved to:
1. **Reduce dependencies** in the main repository
2. **Improve maintainability** through clear separation of concerns
3. **Enable independent versioning** of benchmark code
4. **Maintain performance comparison** capabilities
5. **Follow team's architectural pattern** of separating benchmarks into dedicated repositories

## What Was Migrated

### Benchmark Files

The following benchmark files were moved from `bigweaver-agent-canary-hydro-zeta/benches/benches/` to this repository:

| File | Type | Description |
|------|------|-------------|
| `arithmetic.rs` | Timely | Arithmetic operations benchmark |
| `fan_in.rs` | Timely | Fan-in pattern benchmark |
| `fan_out.rs` | Timely | Fan-out pattern benchmark |
| `fork_join.rs` | Timely | Fork-join pattern benchmark |
| `identity.rs` | Timely | Identity operations benchmark |
| `join.rs` | Timely | Join operations benchmark |
| `upcase.rs` | Timely | String transformation benchmark |
| `reachability.rs` | Differential | Graph reachability benchmark |

### Data Files

| File | Size | Purpose |
|------|------|---------|
| `reachability_edges.txt` | 521 KB | Graph edges for reachability benchmark |
| `reachability_reachable.txt` | 38 KB | Expected reachable nodes |

### Configuration Files

| File | Purpose |
|------|---------|
| `build.rs` | Build script for generating benchmark code |
| `Cargo.toml` | Benchmark dependencies and configuration |
| `rust-toolchain.toml` | Rust toolchain specification |
| `rustfmt.toml` | Code formatting rules |
| `clippy.toml` | Linting configuration |

## What Was NOT Migrated

The following benchmarks remain in the main repository as they don't use timely or differential-dataflow:

- `futures.rs` - Tests futures/async operations
- `micro_ops.rs` - Tests micro-operations
- `symmetric_hash_join.rs` - Tests Hydro-specific join implementation
- `words_diamond.rs` - Tests Hydro diamond patterns
- `words_alpha.txt` - Word list (used by non-migrated benchmarks)

## Changes Made During Migration

### 1. Cargo.toml Updates

**Before** (in main repository):
```toml
[dev-dependencies]
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After** (in deps repository):
```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro", branch = "main", version = "^0.0.1" }
```

**Reason**: Changed from local path dependencies to git dependencies since we're now in a separate repository.

### 2. Workspace Structure

Created new workspace structure:
```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml          # Workspace root
└── benches/
    ├── Cargo.toml      # Benchmark package
    ├── build.rs
    └── benches/        # Benchmark files
```

### 3. Package Naming

- Package renamed from `benches` to `timely-differential-benchmarks` for clarity
- Better reflects the specific purpose of this benchmark suite

### 4. Documentation

Created comprehensive documentation:
- `README.md` - Repository overview and usage
- `QUICKSTART.md` - Quick start guide
- `BENCHMARK_DETAILS.md` - Detailed benchmark documentation
- `MIGRATION.md` - This file
- `CHANGELOG.md` - Version history

## Running Benchmarks After Migration

### In the New Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benchmarks
```

### In the Main Repository

The main repository still contains Hydro-specific benchmarks:

```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench futures
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
```

## Comparing Performance

To compare performance between repositories:

### 1. Run benchmarks in both repositories

```bash
# In deps repository
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benchmarks --bench arithmetic

# In main repository (for comparison with Hydro implementation)
cd bigweaver-agent-canary-hydro-zeta
# Hydro benchmarks are still available in the main repo for comparison
```

### 2. Compare results

- Both repositories generate results in `target/criterion/`
- Use Criterion's HTML reports for visual comparison
- Results are backward compatible with previous benchmarks

## Backward Compatibility

### Benchmark Names

Benchmark names remain unchanged:
- `arithmetic`
- `fan_in`
- `fan_out`
- `fork_join`
- `identity`
- `join`
- `upcase`
- `reachability`

### Results Format

Criterion results format is unchanged, allowing:
- Historical comparison with pre-migration results
- Continuous performance tracking across the migration
- Same HTML report structure

## Integration with CI/CD

### GitHub Actions

If you have CI/CD pipelines, update them to:

1. **Check out both repositories** if you need comparison benchmarks
2. **Run benchmarks independently** in each repository
3. **Aggregate results** if needed for combined reporting

Example:
```yaml
- name: Run timely/differential benchmarks
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench -p timely-differential-benchmarks
    
- name: Run Hydro benchmarks
  run: |
    cd bigweaver-agent-canary-hydro-zeta
    cargo bench -p benches
```

## Dependencies

### Git Dependencies

The migrated benchmarks now depend on the main repository via git:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main" }
sinktools = { git = "https://github.com/hydro-project/hydro", branch = "main" }
```

### Considerations

- **Network access** required for initial build
- **Cargo caching** reduces rebuild times
- **Version pinning** may be needed for reproducibility

## Rollback Plan

If you need to revert the migration:

1. **Copy benchmarks back** to main repository:
   ```bash
   cp bigweaver-agent-canary-zeta-hydro-deps/benches/benches/*.rs \
      bigweaver-agent-canary-hydro-zeta/benches/benches/
   ```

2. **Restore Cargo.toml entries** in main repository

3. **Update workspace members** in main repository

## Post-Migration Tasks

### For Main Repository

- [x] Remove migrated benchmark files
- [ ] Update workspace members in Cargo.toml
- [ ] Update CI/CD configuration
- [ ] Update documentation references
- [ ] Archive old benchmark results

### For Deps Repository

- [x] Set up benchmark structure
- [x] Create documentation
- [x] Verify all benchmarks compile
- [ ] Set up CI/CD
- [ ] Run initial benchmark suite
- [ ] Establish baseline results

## Testing Migration

### Verification Steps

1. **Build both repositories:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build --all-targets
   
   cd bigweaver-agent-canary-hydro-zeta
   cargo build --all-targets
   ```

2. **Run migrated benchmarks:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p timely-differential-benchmarks
   ```

3. **Verify results match historical data:**
   - Compare execution times
   - Check for regressions
   - Validate output format

4. **Test build script:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo build
   # Verify fork_join_20.hf is generated
   ```

## Known Issues

### Issue 1: Git Dependency Resolution

**Symptom**: Slow initial build due to git dependency fetching

**Solution**: 
- Use `cargo vendor` for offline builds
- Consider using a git mirror for faster access
- Cargo caches git dependencies after first fetch

### Issue 2: Version Compatibility

**Symptom**: Build failures due to API changes in main repository

**Solution**:
- Pin specific git commit in Cargo.toml:
  ```toml
  dfir_rs = { git = "https://github.com/hydro-project/hydro", rev = "abc123" }
  ```
- Update dependencies regularly
- Test after main repository updates

## Support and Questions

For questions about the migration:

1. Check this documentation
2. Review the source repository history
3. Consult team documentation
4. Reach out to the development team

## Timeline

- **Pre-migration**: Benchmarks in main repository
- **Migration date**: November 25, 2024
- **Post-migration**: Independent benchmark repository with cross-repository coordination

## References

- Source repository: `bigweaver-agent-canary-hydro-zeta`
- Destination repository: `bigweaver-agent-canary-zeta-hydro-deps`
- Related PR: (To be added when PRs are created)
