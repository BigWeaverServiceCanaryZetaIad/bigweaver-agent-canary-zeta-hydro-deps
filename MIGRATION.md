# Migration Guide

This document describes the migration of benchmark code from the bigweaver-agent-canary-hydro-zeta repository to this dedicated bigweaver-agent-canary-zeta-hydro-deps repository.

## Overview

The benchmark code was moved to this separate repository to achieve better separation of concerns and reduce unnecessary dependencies in the main codebase. This migration ensures that:

1. The main repository remains focused on core functionality
2. Performance testing infrastructure is isolated
3. Build times for the main repository are reduced
4. Dependencies like timely-dataflow and differential-dataflow are only needed for benchmarking

## What Was Migrated

### Code

All files from the `benches/` directory in the main repository:

**Benchmark implementations:**
- `benches/arithmetic.rs` - Arithmetic operations benchmarks
- `benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/identity.rs` - Identity operation benchmarks
- `benches/join.rs` - Join operation benchmarks
- `benches/reachability.rs` - Graph reachability benchmarks
- `benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/upcase.rs` - String transformation benchmarks
- `benches/words_diamond.rs` - Words diamond pattern benchmarks
- `benches/micro_ops.rs` - Micro-operations benchmarks
- `benches/futures.rs` - Async futures benchmarks

**Data files:**
- `benches/reachability_edges.txt` - Graph edge data
- `benches/reachability_reachable.txt` - Expected reachability results
- `benches/words_alpha.txt` - English words dictionary (~3.7MB)
- `benches/.gitignore` - Git ignore rules for benchmark artifacts

**Build and configuration:**
- `Cargo.toml` - Benchmark package configuration
- `build.rs` - Code generation build script
- `README.md` - Benchmark documentation

### Configuration Files

New configuration files created to match main repository standards:

- `Cargo.toml` (workspace root) - Workspace configuration
- `rust-toolchain.toml` - Rust toolchain specification
- `rustfmt.toml` - Code formatting rules
- `clippy.toml` - Linting configuration

### Documentation

New comprehensive documentation:

- `README.md` - Repository overview and quick start
- `QUICKSTART.md` - Getting started guide
- `BENCHMARK_DETAILS.md` - Detailed benchmark descriptions
- `MIGRATION.md` - This file
- `CHANGELOG.md` - Version history

## Changes Made

### Dependency Management

**Before (in main repo):**
```toml
[dev-dependencies]
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After (in deps repo):**
```toml
[dev-dependencies]
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

This change:
- Removes local path dependencies (since we're in a separate repository)
- Uses Git dependencies to reference the main repository
- Preserves all functionality while maintaining repository separation

### Repository Structure

**Before:**
```
bigweaver-agent-canary-hydro-zeta/
├── benches/              # Benchmarks (being removed)
├── dfir_rs/
├── hydro_lang/
├── ... (other crates)
└── Cargo.toml
```

**After:**
```
bigweaver-agent-canary-hydro-zeta/     # Main repository
├── dfir_rs/
├── hydro_lang/
├── ... (other crates)
└── Cargo.toml

bigweaver-agent-canary-zeta-hydro-deps/ # New repository
├── benches/              # Migrated benchmarks
│   ├── benches/          # Benchmark source files
│   ├── Cargo.toml
│   └── build.rs
├── Cargo.toml            # Workspace configuration
└── ... (documentation)
```

## How to Use After Migration

### For Benchmark Development

Clone the deps repository:

```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### For Main Repository Development

The main repository no longer includes benchmark code:

```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
cd bigweaver-agent-canary-hydro-zeta
cargo build  # Faster now without benchmark dependencies!
```

### Running Benchmarks Against Local Changes

If you're developing in the main repository and want to test benchmarks:

1. **Option A: Use path dependencies (temporarily)**
   
   Edit `bigweaver-agent-canary-zeta-hydro-deps/benches/Cargo.toml`:
   ```toml
   [dev-dependencies]
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
   ```

2. **Option B: Use patch in workspace**
   
   Edit `bigweaver-agent-canary-zeta-hydro-deps/Cargo.toml`:
   ```toml
   [patch."https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta"]
   dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
   sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools" }
   ```

3. **Option C: Commit and push changes first**
   
   Push changes to main repository, then benchmarks will use the latest version.

## Updates to Main Repository

The following changes were made to the main repository:

### 1. Removed Files/Directories

- `benches/` directory (entire directory with all contents)
- `.github/workflows/benchmark.yml` (CI/CD workflow for benchmarks)

### 2. Updated Cargo.toml

Removed `"benches"` from workspace members:

```diff
 [workspace]
 members = [
-    "benches",
     "copy_span",
     "dfir_rs",
     ...
 ]
```

### 3. Updated Documentation

**README.md:**
Added section explaining benchmark migration:
```markdown
## Benchmarks

Benchmark code comparing Hydro/DFIR with timely-dataflow and differential-dataflow 
has been moved to a separate repository: bigweaver-agent-canary-zeta-hydro-deps

For performance testing and benchmarks, please see:
https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
```

**CONTRIBUTING.md:**
Updated repository structure section to remove `benches/` reference.

### 4. Updated .gitignore (if applicable)

Removed benchmark-specific ignore patterns (if any).

## CI/CD Changes

### Main Repository

**Removed:**
- `.github/workflows/benchmark.yml` - Automated benchmark execution workflow

**Impact:**
- Benchmarks are no longer run automatically on main repository commits
- This reduces CI/CD time and resource usage
- Benchmark CI can be set up in the deps repository if needed

### Deps Repository

**To be added** (if desired):
- New benchmark workflow in this repository
- Can be triggered manually or on schedule
- Results can be published to GitHub Pages or similar

Example workflow structure:
```yaml
name: Benchmarks
on:
  workflow_dispatch:  # Manual trigger
  schedule:
    - cron: '0 0 * * 0'  # Weekly on Sunday
```

## Benefits of Migration

### For Main Repository

1. **Reduced Dependencies**: No longer needs timely-dataflow, differential-dataflow
2. **Faster Builds**: Fewer crates to compile
3. **Cleaner Focus**: Core functionality without testing overhead
4. **Smaller Dependency Tree**: Eliminates ~10 benchmark-only dependencies

### For Deps Repository

1. **Dedicated Testing**: Benchmarks can evolve independently
2. **Better Organization**: All performance testing in one place
3. **Flexible Scheduling**: Can run benchmarks on different cadence
4. **Easier Maintenance**: Changes don't affect main repository

### For Developers

1. **Clear Separation**: Know where to find benchmarks
2. **Optional Checkout**: Don't need deps repo for main development
3. **Parallel Development**: Changes to benchmarks don't block main repo
4. **Better Performance Tracking**: Dedicated repo for performance history

## Verification Steps

After migration, verify:

### 1. Main Repository

```bash
cd bigweaver-agent-canary-hydro-zeta

# Verify workspace builds
cargo check --workspace

# Verify no timely/differential dependencies
grep -r "timely\|differential" --include="*.toml"  # Should find nothing

# Verify benchmark references removed
grep -r "benches" --include="*.toml"  # Should find nothing in workspace
```

### 2. Deps Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify workspace builds
cargo check --workspace

# Verify all benchmarks compile
cargo check -p benches

# Run a quick benchmark test
cargo bench -p benches --bench identity -- --quick

# Verify dependencies resolve
cargo tree -p benches
```

### 3. Cross-Repository

```bash
# Verify git dependencies work
cd bigweaver-agent-canary-zeta-hydro-deps
cargo update
cargo build -p benches

# Check for any missing files
git status
```

## Troubleshooting

### Issue: Can't find dfir_rs or sinktools

**Cause**: Git dependencies not resolving correctly

**Solution**:
```bash
cargo clean
cargo update
cargo check -p benches
```

### Issue: Build takes very long

**Cause**: Downloading main repository as dependency

**Solution**: This is expected on first build. Subsequent builds will be cached.

### Issue: Need to test local changes

**Solution**: Use path dependencies temporarily (see "Running Benchmarks Against Local Changes" above)

### Issue: Benchmarks fail at runtime

**Cause**: May be using incompatible version of main repository

**Solution**: Ensure deps repository references compatible version:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
# Update to latest main repo version
cargo update -p dfir_rs -p sinktools
cargo bench -p benches
```

## Future Considerations

### Version Pinning

Consider pinning to specific versions or branches:

```toml
dfir_rs = { git = "...", branch = "main", features = [ "debugging" ] }
# or
dfir_rs = { git = "...", tag = "v0.5.0", features = [ "debugging" ] }
```

### Publishing

If making benchmarks public:
- Review data files for sensitive information
- Update repository URLs to public locations
- Consider licensing implications

### Continuous Integration

Set up automated benchmarking:
- Performance regression detection
- Historical trend tracking
- Comparison reports

## Questions and Support

For questions about this migration:
- Check the main repository's issue tracker
- Review documentation at https://hydro.run
- Contact the Hydro development team

## Related Documents

- [README.md](README.md) - Repository overview
- [QUICKSTART.md](QUICKSTART.md) - Getting started guide
- [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md) - Benchmark descriptions
- [CHANGELOG.md](CHANGELOG.md) - Version history
