# Verification Checklist

Use this checklist to verify that the benchmark migration was completed successfully and that all functionality is preserved.

## Pre-Migration Verification

- [ ] Confirm all benchmarks run successfully in the original repository
- [ ] Document current benchmark performance baselines
- [ ] List all files in the `benches/` directory
- [ ] Identify all dependencies used by benchmarks
- [ ] Note any CI/CD workflows that reference benchmarks

## Migration Execution

### File Migration

- [x] Copy all benchmark source files from `benches/benches/`
- [x] Copy benchmark Cargo.toml
- [x] Copy build.rs script
- [x] Copy data files (reachability_edges.txt, reachability_reachable.txt, words_alpha.txt)
- [x] Copy .gitignore
- [x] Copy benchmark README

### Repository Setup

- [x] Create workspace Cargo.toml
- [x] Configure workspace members to include benches
- [x] Copy rust-toolchain.toml
- [x] Copy rustfmt.toml
- [x] Copy clippy.toml
- [x] Set up proper workspace structure

### Dependency Configuration

- [x] Update dfir_rs to use git dependency
- [x] Update sinktools to use git dependency
- [x] Verify timely-dataflow dependency configuration
- [x] Verify differential-dataflow dependency configuration
- [x] Check all other dependencies are present

### Documentation

- [x] Create comprehensive README.md
- [x] Create QUICKSTART.md guide
- [x] Create BENCHMARK_DETAILS.md
- [x] Create MIGRATION.md
- [x] Create CHANGELOG.md
- [x] Create VERIFICATION_CHECKLIST.md (this file)

## Post-Migration Verification

### Build Verification

Run these commands and check for successful completion:

- [ ] `cargo check --workspace`
  ```bash
  cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
  cargo check --workspace
  ```
  - [ ] No compilation errors
  - [ ] All dependencies resolve correctly
  - [ ] Git dependencies download successfully

- [ ] `cargo check -p benches`
  ```bash
  cargo check -p benches
  ```
  - [ ] Benchmark package compiles
  - [ ] All features enabled correctly

- [ ] `cargo build --workspace`
  ```bash
  cargo build --workspace
  ```
  - [ ] Full build succeeds
  - [ ] Build artifacts generated correctly

### Individual Benchmark Verification

Verify each benchmark compiles and runs:

- [ ] `arithmetic` benchmark
  ```bash
  cargo bench -p benches --bench arithmetic -- --quick
  ```

- [ ] `fan_in` benchmark
  ```bash
  cargo bench -p benches --bench fan_in -- --quick
  ```

- [ ] `fan_out` benchmark
  ```bash
  cargo bench -p benches --bench fan_out -- --quick
  ```

- [ ] `fork_join` benchmark
  ```bash
  cargo bench -p benches --bench fork_join -- --quick
  ```

- [ ] `identity` benchmark
  ```bash
  cargo bench -p benches --bench identity -- --quick
  ```

- [ ] `join` benchmark
  ```bash
  cargo bench -p benches --bench join -- --quick
  ```

- [ ] `reachability` benchmark
  ```bash
  cargo bench -p benches --bench reachability -- --quick
  ```

- [ ] `symmetric_hash_join` benchmark
  ```bash
  cargo bench -p benches --bench symmetric_hash_join -- --quick
  ```

- [ ] `upcase` benchmark
  ```bash
  cargo bench -p benches --bench upcase -- --quick
  ```

- [ ] `words_diamond` benchmark
  ```bash
  cargo bench -p benches --bench words_diamond -- --quick
  ```

- [ ] `micro_ops` benchmark
  ```bash
  cargo bench -p benches --bench micro_ops -- --quick
  ```

- [ ] `futures` benchmark
  ```bash
  cargo bench -p benches --bench futures -- --quick
  ```

### Full Benchmark Suite

- [ ] Run all benchmarks together
  ```bash
  cargo bench -p benches
  ```
  - [ ] All benchmarks complete successfully
  - [ ] Results generated in target/criterion/
  - [ ] HTML reports created
  - [ ] No panics or crashes

### Data File Verification

- [ ] Verify reachability data files are present and readable
  ```bash
  ls -lh benches/benches/reachability_edges.txt
  ls -lh benches/benches/reachability_reachable.txt
  ```

- [ ] Verify words data file is present and readable
  ```bash
  ls -lh benches/benches/words_alpha.txt
  wc -l benches/benches/words_alpha.txt  # Should be ~370,000 words
  ```

### Code Quality

- [ ] Run rustfmt
  ```bash
  cargo fmt --all --check
  ```
  - [ ] All code properly formatted

- [ ] Run clippy
  ```bash
  cargo clippy --all-targets --all-features
  ```
  - [ ] No clippy warnings (or acceptable warnings only)

### Documentation Verification

- [ ] README.md is complete and accurate
- [ ] QUICKSTART.md provides clear instructions
- [ ] BENCHMARK_DETAILS.md describes all benchmarks
- [ ] MIGRATION.md explains the migration process
- [ ] CHANGELOG.md documents initial setup
- [ ] All documentation links work correctly
- [ ] Code examples in documentation are correct

### Performance Verification

- [ ] Compare benchmark results with pre-migration baselines
  - [ ] Performance is similar (within 5-10% variance expected)
  - [ ] No significant regressions
  - [ ] All test patterns execute correctly

- [ ] Verify benchmark result files
  ```bash
  ls target/criterion/
  ```
  - [ ] HTML reports generated
  - [ ] Data files present
  - [ ] Graphs rendered correctly

### Main Repository Cleanup

Verify changes to the main repository:

- [ ] `benches/` directory removed
- [ ] Workspace Cargo.toml updated (benches removed from members)
- [ ] README.md updated with benchmark migration note
- [ ] CONTRIBUTING.md updated (if applicable)
- [ ] No remaining references to removed benchmarks
  ```bash
  cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
  grep -r "benches" --include="*.toml" --include="*.md"
  ```

- [ ] Main repository builds successfully
  ```bash
  cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
  cargo check --workspace
  ```

- [ ] Benchmark dependencies removed from dependency tree
  ```bash
  cargo tree | grep -i "timely\|differential"  # Should find nothing
  ```

## Integration Testing

### Cross-Repository Testing

- [ ] Clone both repositories fresh
- [ ] Build deps repository against main repository
- [ ] Verify git dependencies resolve correctly
- [ ] Test with specific branch/tag references

### CI/CD Verification

- [ ] Document removed CI/CD workflows from main repository
- [ ] Consider setting up new CI/CD in deps repository
- [ ] Update any external systems that reference benchmarks

## Final Checks

### Completeness

- [ ] All benchmark files migrated
- [ ] All data files migrated
- [ ] All configuration files present
- [ ] Documentation complete
- [ ] No broken references

### Functionality

- [ ] All benchmarks run successfully
- [ ] Results match expected patterns
- [ ] No crashes or panics
- [ ] Memory usage reasonable
- [ ] Performance comparable to pre-migration

### Repository Health

- [ ] Git repository initialized (if new)
- [ ] Appropriate .gitignore in place
- [ ] No large unnecessary files committed
- [ ] Proper file permissions
- [ ] Clean git status

## Issues Found

Document any issues discovered during verification:

### Issue 1: [Description]
- **Severity**: [Critical/Major/Minor]
- **Status**: [Open/Resolved]
- **Details**: 
- **Resolution**: 

### Issue 2: [Description]
- **Severity**: [Critical/Major/Minor]
- **Status**: [Open/Resolved]
- **Details**: 
- **Resolution**: 

## Sign-Off

- [ ] All critical items verified
- [ ] All benchmarks functional
- [ ] Documentation complete
- [ ] Ready for use

**Verified by**: _______________
**Date**: _______________
**Notes**: 

---

## Quick Verification Script

For automated verification, run:

```bash
#!/bin/bash
# Quick verification script

echo "=== Checking workspace builds ==="
cargo check --workspace || exit 1

echo "=== Checking code format ==="
cargo fmt --all --check || exit 1

echo "=== Running clippy ==="
cargo clippy --all-targets --all-features || exit 1

echo "=== Verifying data files ==="
test -f benches/benches/words_alpha.txt || exit 1
test -f benches/benches/reachability_edges.txt || exit 1
test -f benches/benches/reachability_reachable.txt || exit 1

echo "=== Running quick benchmark test ==="
cargo bench -p benches --bench identity -- --quick || exit 1

echo "=== All checks passed! ==="
```

Save as `verify.sh`, make executable with `chmod +x verify.sh`, and run with `./verify.sh`.
