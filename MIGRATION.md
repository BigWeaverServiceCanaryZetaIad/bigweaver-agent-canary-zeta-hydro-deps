# Migration Documentation

This document describes the migration of timely and differential-dataflow benchmarks from the bigweaver-agent-canary-hydro-zeta repository to this dedicated repository.

## Migration Overview

**Date**: 2024
**Source**: bigweaver-agent-canary-hydro-zeta/benches
**Destination**: bigweaver-agent-canary-zeta-hydro-deps/benches

## Rationale

### Why Migrate?

1. **Dependency Isolation**: Timely and differential-dataflow dependencies were adding unnecessary complexity to the main repository
2. **Build Time Improvement**: Removing these dependencies reduces main repository build times
3. **Architectural Alignment**: Follows team's pattern of separating concerns into dedicated repositories
4. **Cleaner Main Repository**: Keeps the main codebase focused on core Hydro functionality
5. **Dependency Hygiene**: Maintains clean dependency structure and easier maintenance

### Benefits

#### For Development Team
- ✅ Faster builds in main repository
- ✅ Cleaner dependency tree
- ✅ Focused main repository
- ✅ Easier maintenance

#### For Performance Testing Team
- ✅ Dedicated benchmarking repository
- ✅ All comparison benchmarks in one place
- ✅ Independent benchmark versioning
- ✅ Preserved comparison capabilities

#### For CI/CD Team
- ✅ Faster main repository CI builds
- ✅ Optional benchmark runs
- ✅ Separate benchmark CI pipeline possible
- ✅ Reduced CI resource usage for main repo

## Migrated Files

### Benchmark Source Files

All files extracted from git commit `484e6fddffa97d507384773d51bf728770a6ac38`:

| File | Size | Description |
|------|------|-------------|
| `arithmetic.rs` | ~8KB | Arithmetic operation benchmarks |
| `fan_in.rs` | ~8KB | Fan-in pattern benchmarks |
| `fan_out.rs` | ~8KB | Fan-out pattern benchmarks |
| `fork_join.rs` | ~12KB | Fork-join pattern benchmarks |
| `identity.rs` | ~8KB | Identity operation benchmarks |
| `join.rs` | ~10KB | Join operation benchmarks |
| `reachability.rs` | ~15KB | Graph reachability benchmarks |
| `upcase.rs` | ~8KB | String transformation benchmarks |

### Data Files

| File | Size | Purpose |
|------|------|---------|
| `reachability_edges.txt` | 521KB | Graph edge data for reachability benchmark |
| `reachability_reachable.txt` | 38KB | Expected reachable nodes for validation |

### Configuration Files

| File | Purpose |
|------|---------|
| `build.rs` | Build script for generating fork_join code |
| `Cargo.toml` | Benchmark dependencies and targets |
| `README.md` | Benchmark documentation |

## Changes Made

### Source Repository (bigweaver-agent-canary-hydro-zeta)

The following changes were already made in the source repository (see BENCHMARK_REMOVAL_SUMMARY.md):

1. **Removed Files**:
   - 8 benchmark source files
   - 2 data files
   - build.rs

2. **Updated Files**:
   - `benches/Cargo.toml` - Removed timely/differential dependencies and benchmark targets
   - `benches/README.md` - Updated to note removal
   - `Cargo.lock` - Updated dependency tree

3. **Retained Files**:
   - `futures.rs` - Hydro-only benchmark
   - `micro_ops.rs` - Hydro-only benchmark
   - `symmetric_hash_join.rs` - Hydro-only benchmark
   - `words_diamond.rs` - Hydro-only benchmark

### New Repository (bigweaver-agent-canary-zeta-hydro-deps)

Created structure:

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/           # Migrated benchmark files
│   ├── build.rs           # Migrated build script
│   ├── Cargo.toml         # Updated with dependencies
│   └── README.md          # Comprehensive documentation
├── Cargo.toml             # Workspace configuration
├── rust-toolchain.toml    # Rust toolchain spec
├── rustfmt.toml          # Code formatting
├── clippy.toml           # Linting configuration
├── .gitignore            # Git ignore rules
├── LICENSE               # Apache 2.0 License
├── README.md             # Main documentation
├── QUICK_START.md        # Setup guide
├── RUNNING_BENCHMARKS.md # Benchmark instructions
└── MIGRATION.md          # This file
```

## Technical Details

### Dependency Configuration

**Added to benches/Cargo.toml**:
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

**Maintained from main repository**:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### Path Dependencies

Since this repository is separate, it references dfir_rs and sinktools from the main repository using relative paths. This requires:

1. Both repositories cloned as siblings:
   ```
   workspace/
   ├── bigweaver-agent-canary-zeta-hydro-deps/
   └── bigweaver-agent-canary-hydro-zeta/
   ```

2. Path resolution in Cargo.toml:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
   ```

### Build Script

The `build.rs` script was migrated unchanged. It generates `fork_join_20.hf` with 20 operations for the fork_join benchmark.

## Verification

### Pre-Migration State

In bigweaver-agent-canary-hydro-zeta:
```bash
# Before removal
ls benches/benches/*.rs | wc -l
# Output: 12 files

cargo tree -p benches | grep timely
# Output: Shows timely dependencies
```

### Post-Migration State

In bigweaver-agent-canary-hydro-zeta:
```bash
# After removal
ls benches/benches/*.rs | wc -l
# Output: 4 files (futures, micro_ops, symmetric_hash_join, words_diamond)

cargo tree -p benches | grep timely
# Output: No results (dependencies removed)
```

In bigweaver-agent-canary-zeta-hydro-deps:
```bash
# New repository
ls benches/benches/*.rs | wc -l
# Output: 8 files (all migrated benchmarks)

cargo tree -p timely-differential-benches | grep timely
# Output: Shows timely dependencies
```

## Testing Migrated Benchmarks

### Functional Testing

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Build all benchmarks
cargo build --release -p timely-differential-benches

# Run each benchmark to verify functionality
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench upcase
```

### Verification Checklist

- [x] All 8 benchmark files migrated
- [x] Data files (reachability_edges.txt, reachability_reachable.txt) migrated
- [x] Build script (build.rs) migrated
- [x] Dependencies correctly configured
- [x] Benchmarks compile successfully
- [x] Benchmarks run without errors
- [x] Criterion reports generated
- [x] Code formatting applied (rustfmt)
- [x] Linting passed (clippy)
- [x] Documentation complete

## Known Issues and Considerations

### Path Dependencies

**Issue**: Requires specific directory structure

**Solution**: Document clearly in README and QUICK_START

**Impact**: Users must clone both repositories as siblings

### Dependency Updates

**Issue**: timely/differential-dataflow versions are pinned

**Consideration**: May need updates over time

**Monitoring**: Check for new versions periodically

### Build Times

**Note**: First build in this repository still takes time (timely/differential are large)

**Mitigation**: This is expected and acceptable since it's isolated from main repo

## Future Considerations

### Alternative Dependency Management

Consider these alternatives if path dependencies become problematic:

1. **Git Dependencies**: Reference specific commits
   ```toml
   dfir_rs = { git = "https://github.com/...", rev = "..." }
   ```

2. **Vendored Dependencies**: Copy necessary crates
   - Pros: Self-contained
   - Cons: Duplication, sync issues

3. **Published Crates**: If dfir_rs is published to crates.io
   ```toml
   dfir_rs = "0.x.y"
   ```

### Maintenance

- Monitor timely and differential-dataflow for updates
- Keep benchmarks in sync with main repository APIs
- Update documentation as benchmarks evolve
- Consider adding more comparison benchmarks

## References

- **Original Discussion**: See git history in main repository
- **Removal Summary**: bigweaver-agent-canary-hydro-zeta/BENCHMARK_REMOVAL_SUMMARY.md
- **Team Pattern**: Separation of concerns into dedicated repositories
- **Related Changes**: Companion PR in main repository

## Contact and Questions

For questions about this migration:
1. Review this documentation
2. Check README.md and other docs in this repository
3. Refer to main repository documentation
4. Review git history for context

## Rollback Procedure

If issues are found and benchmarks need to be restored to main repository:

1. Copy benchmark files back to main repo benches/benches/
2. Update main repo benches/Cargo.toml with dependencies
3. Update main repo benches/README.md
4. Restore build.rs if needed
5. Update Cargo.lock

All files are preserved in git history of main repository (commit 484e6fddffa97d507384773d51bf728770a6ac38).
