# Verification Checklist for Benchmark Migration

This checklist ensures all benchmarks have been properly migrated and remain functional.

## Pre-Migration Verification

- [x] Identified all timely and differential-dataflow benchmark files
- [x] Identified supporting data files (reachability_edges.txt, reachability_reachable.txt)
- [x] Identified build scripts (build.rs)
- [x] Documented dependencies from original Cargo.toml

## Migration Verification

### Files Migrated
- [x] `arithmetic.rs` - Timely arithmetic benchmarks
- [x] `fan_in.rs` - Timely fan-in benchmarks
- [x] `fan_out.rs` - Timely fan-out benchmarks
- [x] `fork_join.rs` - Timely fork-join benchmarks
- [x] `identity.rs` - Timely identity benchmarks
- [x] `join.rs` - Timely join benchmarks
- [x] `upcase.rs` - Timely upcase benchmarks
- [x] `reachability.rs` - Differential dataflow reachability benchmarks
- [x] `reachability_edges.txt` - Test data
- [x] `reachability_reachable.txt` - Expected results
- [x] `build.rs` - Build script

### Repository Structure
- [x] Created workspace `Cargo.toml`
- [x] Created `timely-benchmarks/Cargo.toml` with correct dependencies
- [x] Created `timely-benchmarks/benches/` directory
- [x] All benchmark files in correct location
- [x] All data files in correct location

### Documentation
- [x] Created/Updated main `README.md`
- [x] Created `timely-benchmarks/README.md`
- [x] Created `MIGRATION.md`
- [x] Created `VERIFICATION_CHECKLIST.md` (this file)

### Configuration
- [x] Workspace configuration matches original standards
- [x] All benchmark entries in Cargo.toml ([[bench]] sections)
- [x] Dependencies updated to use git references instead of paths
- [x] Lints configuration included
- [x] Profile configurations included

## Post-Migration Testing

### Build Tests
- [ ] `cargo check -p timely-benchmarks` succeeds
- [ ] `cargo build -p timely-benchmarks` succeeds
- [ ] `cargo build -p timely-benchmarks --release` succeeds

### Benchmark Tests
- [ ] `cargo bench -p timely-benchmarks --bench arithmetic` runs successfully
- [ ] `cargo bench -p timely-benchmarks --bench fan_in` runs successfully
- [ ] `cargo bench -p timely-benchmarks --bench fan_out` runs successfully
- [ ] `cargo bench -p timely-benchmarks --bench fork_join` runs successfully
- [ ] `cargo bench -p timely-benchmarks --bench identity` runs successfully
- [ ] `cargo bench -p timely-benchmarks --bench join` runs successfully
- [ ] `cargo bench -p timely-benchmarks --bench upcase` runs successfully
- [ ] `cargo bench -p timely-benchmarks --bench reachability` runs successfully

### Benchmark Functionality Tests
- [ ] Arithmetic benchmark produces valid results
- [ ] Fan-in benchmark produces valid results
- [ ] Fan-out benchmark produces valid results
- [ ] Fork-join benchmark produces valid results
- [ ] Identity benchmark produces valid results
- [ ] Join benchmark produces valid results
- [ ] Upcase benchmark produces valid results
- [ ] Reachability benchmark produces valid results

### Data File Tests
- [ ] Reachability benchmark correctly loads `reachability_edges.txt`
- [ ] Reachability benchmark correctly validates against `reachability_reachable.txt`

## Completeness Checks

### Original Repository
- [ ] Verify remaining benchmarks in original repo still work
- [ ] Update original repo's benches/Cargo.toml to remove migrated benchmarks
- [ ] Update original repo's benches/README.md to reference new location
- [ ] Ensure no broken references to migrated files

### New Repository
- [ ] All files have proper permissions
- [ ] No build artifacts committed
- [ ] Git repository initialized (if not already)
- [ ] .gitignore configured appropriately

## Integration Tests

- [ ] Clone both repositories fresh
- [ ] Run benchmarks from new repository
- [ ] Run remaining benchmarks from original repository
- [ ] Verify no cross-repository issues
- [ ] Check performance comparison scripts work

## Documentation Review

- [ ] README.md accurately describes repository contents
- [ ] MIGRATION.md provides complete migration history
- [ ] timely-benchmarks/README.md explains how to use benchmarks
- [ ] All benchmark commands in documentation are correct
- [ ] Related repository links are correct

## Rollback Readiness

- [ ] Rollback procedure documented in MIGRATION.md
- [ ] Backup of original state available (via git)
- [ ] Team notified of migration

## Notes

### Test Execution

To run all tests in this checklist:

```bash
# Navigate to repository
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps

# Check compilation
cargo check -p timely-benchmarks

# Build
cargo build -p timely-benchmarks

# Run all benchmarks
cargo bench -p timely-benchmarks

# Run individual benchmarks
cargo bench -p timely-benchmarks --bench arithmetic
cargo bench -p timely-benchmarks --bench reachability
# ... (repeat for each benchmark)
```

### Known Issues

- Cargo not available in current environment for testing
- Manual verification of file structure completed
- Actual benchmark execution requires Rust toolchain

### Success Criteria

Migration is considered successful when:
1. All files are in correct locations
2. All benchmarks compile without errors
3. All benchmarks run and produce valid results
4. Documentation is complete and accurate
5. Both repositories function independently

### Completed By

- File Migration: ✓ Completed 2024-11-25
- Documentation: ✓ Completed 2024-11-25
- Build Testing: Requires Rust toolchain installation
- Runtime Testing: Requires Rust toolchain installation
