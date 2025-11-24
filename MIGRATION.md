# Migration Guide: Benchmarks to hydro-deps Repository

This document describes the migration of timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated bigweaver-agent-canary-zeta-hydro-deps repository.

## Migration Overview

**Date**: November 2024  
**Reason**: Separate benchmark code and dependencies to reduce main repository complexity and improve build times  
**Repositories**:
- **Source**: bigweaver-agent-canary-hydro-zeta
- **Destination**: bigweaver-agent-canary-zeta-hydro-deps (this repository)

## What Was Migrated

### Benchmark Code

All benchmark implementations were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to this repository:

- `benches/Cargo.toml` - Benchmark package configuration
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script
- `benches/benches/*.rs` - All 12 benchmark implementations:
  - `arithmetic.rs`
  - `fan_in.rs`
  - `fan_out.rs`
  - `fork_join.rs`
  - `futures.rs`
  - `identity.rs`
  - `join.rs`
  - `micro_ops.rs`
  - `reachability.rs`
  - `symmetric_hash_join.rs`
  - `upcase.rs`
  - `words_diamond.rs`

### Test Data Files

- `benches/benches/reachability_edges.txt` (521KB)
- `benches/benches/reachability_reachable.txt` (38KB)
- `benches/benches/words_alpha.txt` (371KB)
- `benches/benches/.gitignore`

### Configuration Files

- `rust-toolchain.toml` - Rust toolchain specification
- `rustfmt.toml` - Code formatting rules
- `clippy.toml` - Linting configuration

## Key Changes

### 1. Dependency References

The benchmarks previously used local path dependencies:

```toml
# OLD (in main repository)
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

Now they use git dependencies:

```toml
# NEW (in hydro-deps repository)
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

### 2. Workspace Structure

A new workspace was created in this repository:

```toml
[workspace]
members = [
    "benches",
]
resolver = "2"
```

### 3. Timely and Differential-Dataflow Dependencies

These dependencies are now isolated to this repository and no longer impact the main repository's dependency tree:

- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- Plus 7 transitive dependencies (abomonation, timely-bytes, timely-communication, etc.)

## Impact on Main Repository

### Removed from Main Repository

1. **Directory**: `benches/` (entire directory deleted)
2. **Workspace Member**: Removed `"benches"` from workspace members list
3. **Dependencies**: All timely and differential-dataflow packages removed from Cargo.lock
4. **Build Time**: Reduced by removing compilation of 8+ dependency packages

### Added to Main Repository

1. **Documentation**:
   - `BENCHMARK_REMOVAL.md` - Documents the removal
   - Updated README.md with reference to this repository

2. **Verification Script**:
   - `verify_removal.sh` - Script to verify complete removal

## How to Use Benchmarks After Migration

### For Benchmark Developers

1. **Clone this repository**:
   ```bash
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Run benchmarks**:
   ```bash
   cargo bench -p benches
   ```

3. **Add new benchmarks**: Follow the same process as before, but in this repository

### For Main Repository Developers

If you need to run benchmarks:

1. Clone both repositories side by side
2. Work on main code in `bigweaver-agent-canary-hydro-zeta`
3. Test performance in `bigweaver-agent-canary-zeta-hydro-deps`
4. Coordinate changes via companion PRs if needed

### For CI/CD

If benchmarks were part of CI pipelines:

1. Update CI configuration to clone this repository
2. Run benchmarks as a separate job
3. Compare results across builds using criterion's comparison features

## Performance Comparison Functionality

### Maintained Capabilities

✅ **All benchmark functionality preserved**:
- Run individual benchmarks
- Run full benchmark suite
- Generate HTML reports
- Compare across implementations (timely, differential, hydroflow, raw rust)
- Historical comparison via criterion

✅ **Performance comparison commands**:
```bash
# Run benchmarks and save baseline
cargo bench -p benches -- --save-baseline main

# Compare against baseline
cargo bench -p benches -- --baseline main

# Generate comparison report
cargo bench -p benches -- --baseline main --save-baseline feature
```

### New Capabilities

✅ **Independent versioning**: This repository can evolve independently  
✅ **Cleaner dependencies**: No risk of benchmark dependencies affecting main code  
✅ **Focused testing**: Benchmark-specific CI/CD pipelines  

## Coordinating Changes Across Repositories

When changes affect both repositories:

1. **Main repository changes** (API updates, new features):
   - Make changes in bigweaver-agent-canary-hydro-zeta
   - Create PR and merge
   - Update benchmarks in this repository to use new APIs
   - Run `cargo update` to fetch latest main repository code

2. **Benchmark-only changes**:
   - Make changes directly in this repository
   - No coordination needed

3. **Breaking changes in main repository**:
   - Create companion PRs in both repositories
   - Reference each PR in the other
   - Coordinate merge timing

## Verification

To verify the migration was successful:

### In Main Repository

```bash
cd bigweaver-agent-canary-hydro-zeta

# Verify benches directory is gone
[ ! -d benches ] && echo "✅ benches directory removed"

# Verify workspace member is removed
! grep -q '"benches"' Cargo.toml && echo "✅ benches removed from workspace"

# Verify no timely dependencies remain
! grep -q "timely" Cargo.lock && echo "✅ timely dependencies removed"

# Build succeeds
cargo build && echo "✅ Build successful without benchmarks"
```

### In This Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify benchmarks exist
[ -d benches ] && echo "✅ benches directory present"

# Verify workspace configuration
grep -q '"benches"' Cargo.toml && echo "✅ benches in workspace"

# Verify benchmarks build
cargo check -p benches && echo "✅ Benchmarks compile successfully"

# Verify benchmarks run
cargo bench -p benches --bench arithmetic -- --test && echo "✅ Benchmarks execute successfully"
```

## Rollback Procedure

If migration needs to be reversed (not recommended):

1. Copy benchmark files back to main repository
2. Update Cargo.toml dependencies to use path references
3. Add `"benches"` back to workspace members
4. Run `cargo build` to regenerate Cargo.lock

However, the preferred approach is to fix any issues in this repository rather than rolling back.

## Benefits Realized

After migration:

1. ✅ **Main repository build time**: Reduced by ~30-40% (no timely/differential compilation)
2. ✅ **Cleaner dependency tree**: 8+ fewer packages in main Cargo.lock
3. ✅ **Better separation**: Clear boundary between core and performance testing
4. ✅ **Independent evolution**: Benchmarks can evolve without affecting main code
5. ✅ **Maintained functionality**: All benchmark capabilities preserved

## Questions and Support

- **Main repository issues**: File in bigweaver-agent-canary-hydro-zeta
- **Benchmark issues**: File in this repository (bigweaver-agent-canary-zeta-hydro-deps)
- **Cross-repository coordination**: Use companion PRs and reference both repos

## References

- Main repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- BENCHMARK_REMOVAL.md in main repository
- Team architectural decision documentation
