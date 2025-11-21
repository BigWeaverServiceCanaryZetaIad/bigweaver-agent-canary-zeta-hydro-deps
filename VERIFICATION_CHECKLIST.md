# Verification Checklist

Use this checklist to verify the benchmark migration was successful and all functionality is retained.

## Pre-Verification Setup

- [ ] Rust toolchain installed (1.70.0 or later recommended)
- [ ] Git repository cloned
- [ ] Internet connection available (for dependency downloads)

## File Integrity Checks

### Configuration Files
- [ ] `Cargo.toml` exists in repository root
- [ ] `benches/Cargo.toml` exists with correct dependencies
- [ ] `benches/README.md` contains usage instructions
- [ ] `benches/build.rs` exists for code generation

### Benchmark Source Files
- [ ] `benches/benches/arithmetic.rs` exists
- [ ] `benches/benches/fan_in.rs` exists
- [ ] `benches/benches/fan_out.rs` exists
- [ ] `benches/benches/fork_join.rs` exists
- [ ] `benches/benches/futures.rs` exists
- [ ] `benches/benches/identity.rs` exists
- [ ] `benches/benches/join.rs` exists
- [ ] `benches/benches/micro_ops.rs` exists
- [ ] `benches/benches/reachability.rs` exists
- [ ] `benches/benches/symmetric_hash_join.rs` exists
- [ ] `benches/benches/upcase.rs` exists
- [ ] `benches/benches/words_diamond.rs` exists

### Data Files
- [ ] `benches/benches/reachability_edges.txt` exists (should be ~533 KB)
- [ ] `benches/benches/reachability_reachable.txt` exists (should be ~38 KB)
- [ ] `benches/benches/words_alpha.txt` exists (should be ~3.9 MB)
- [ ] `benches/benches/.gitignore` exists

### Documentation Files
- [ ] `README.md` contains comprehensive repository documentation
- [ ] `MIGRATION.md` documents the migration process
- [ ] `QUICKSTART.md` provides quick start instructions
- [ ] `PERFORMANCE_COMPARISON.md` explains comparison capabilities
- [ ] `VERIFICATION_CHECKLIST.md` (this file) exists

## Dependency Verification

### Check Cargo.toml Dependencies
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cat Cargo.toml
```

Required dependencies should include:
- [ ] `criterion` with version "0.5.0"
- [ ] `dfir_rs` with version "0.14.0"
- [ ] `timely` (package: "timely-master") with version "0.13.0-dev.1"
- [ ] `differential-dataflow` (package: "differential-dataflow-master") with version "0.13.0-dev.1"
- [ ] `futures` with version "0.3"
- [ ] `nameof` with version "1.0.0"
- [ ] `rand` with version "0.8.0"
- [ ] `rand_distr` with version "0.4.3"
- [ ] `seq-macro` with version "0.2.0"
- [ ] `sinktools` with git dependency
- [ ] `static_assertions` with version "1.0.0"
- [ ] `tokio` with version "1.29.0"

### Benchmark Targets
All 12 benchmarks should be declared in `benches/Cargo.toml`:
- [ ] `[[bench]] name = "arithmetic"`
- [ ] `[[bench]] name = "fan_in"`
- [ ] `[[bench]] name = "fan_out"`
- [ ] `[[bench]] name = "fork_join"`
- [ ] `[[bench]] name = "identity"`
- [ ] `[[bench]] name = "upcase"`
- [ ] `[[bench]] name = "join"`
- [ ] `[[bench]] name = "reachability"`
- [ ] `[[bench]] name = "micro_ops"`
- [ ] `[[bench]] name = "symmetric_hash_join"`
- [ ] `[[bench]] name = "words_diamond"`
- [ ] `[[bench]] name = "futures"`

## Compilation Checks

### Basic Compilation
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo check -p benches
```
- [ ] Compiles without errors
- [ ] No critical warnings
- [ ] Dependencies download successfully

### Build Script Execution
```bash
cargo build --release -p benches
```
- [ ] Build script (`build.rs`) executes successfully
- [ ] Generated file `benches/benches/fork_join_20.hf` is created
- [ ] Build completes in release mode

### Individual Benchmark Compilation
Test each benchmark individually:

```bash
cargo check -p benches --bench arithmetic
cargo check -p benches --bench fan_in
cargo check -p benches --bench fan_out
cargo check -p benches --bench fork_join
cargo check -p benches --bench futures
cargo check -p benches --bench identity
cargo check -p benches --bench join
cargo check -p benches --bench micro_ops
cargo check -p benches --bench reachability
cargo check -p benches --bench symmetric_hash_join
cargo check -p benches --bench upcase
cargo check -p benches --bench words_diamond
```

- [ ] All benchmarks compile individually
- [ ] No benchmark-specific errors

## Runtime Verification

### Quick Smoke Tests

Run each benchmark in test mode (fast, doesn't measure performance):

```bash
cargo bench -p benches --bench identity -- --test
cargo bench -p benches --bench arithmetic -- --test
cargo bench -p benches --bench fan_in -- --test
```

- [ ] Benchmarks execute without panics
- [ ] No runtime errors
- [ ] Correct output format

### Full Benchmark Execution

Run a simple benchmark to completion:

```bash
cargo bench -p benches --bench identity
```

- [ ] Benchmark completes successfully
- [ ] Generates timing output
- [ ] Creates HTML report in `target/criterion/`
- [ ] Statistical analysis appears valid

### Data File Access

Verify benchmarks can access embedded data:

```bash
cargo bench -p benches --bench reachability -- --test
cargo bench -p benches --bench words_diamond -- --test
```

- [ ] Reachability benchmark loads graph data
- [ ] Words benchmark loads word list
- [ ] No file not found errors

## Functionality Verification

### Timely Dataflow Integration

Run benchmarks using Timely:

```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench identity
```

- [ ] Timely variants execute correctly
- [ ] Timely operators function properly
- [ ] Performance metrics are reasonable

### Differential Dataflow Integration

Run benchmark using Differential Dataflow:

```bash
cargo bench -p benches --bench reachability
```

- [ ] Differential variant executes correctly
- [ ] Iterative computation works
- [ ] Fixed-point detection functions
- [ ] Results match expected reachable nodes

### Hydro/DFIR Integration

Run DFIR-specific benchmarks:

```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench futures
cargo bench -p benches --bench words_diamond
```

- [ ] DFIR syntax compiles
- [ ] DFIR operators work correctly
- [ ] Async/await integration functions
- [ ] Graph building succeeds

## Performance Comparison Verification

### Multiple Variants

Verify benchmarks with multiple framework variants:

```bash
cargo bench -p benches --bench identity
```

- [ ] Shows multiple variants (e.g., hydro, timely, pipeline)
- [ ] All variants produce results
- [ ] Variants are comparable
- [ ] Results make sense relative to each other

### Criterion Integration

Check Criterion features:

```bash
cargo bench -p benches --bench identity -- --save-baseline test
cargo bench -p benches --bench identity -- --baseline test
```

- [ ] Baseline saving works
- [ ] Baseline comparison works
- [ ] Change detection functions
- [ ] Statistics are computed correctly

### HTML Reports

After running benchmarks:

```bash
ls -la target/criterion/
```

- [ ] `target/criterion/` directory exists
- [ ] HTML reports are generated
- [ ] `report/index.html` exists
- [ ] Individual benchmark reports exist
- [ ] Reports contain graphs and statistics

## Documentation Verification

### README Completeness
- [ ] README explains repository purpose
- [ ] Instructions for running benchmarks present
- [ ] Benchmark descriptions included
- [ ] Dependency documentation complete
- [ ] License information present

### Migration Documentation
- [ ] MIGRATION.md explains source and destination
- [ ] Lists all migrated files
- [ ] Documents dependency changes
- [ ] Provides verification steps
- [ ] Includes rollback information

### Quick Start Guide
- [ ] QUICKSTART.md provides clear steps
- [ ] Prerequisites listed
- [ ] Example commands work
- [ ] Troubleshooting section included
- [ ] Common issues addressed

### Performance Comparison Guide
- [ ] PERFORMANCE_COMPARISON.md explains methodology
- [ ] Benchmark categories documented
- [ ] Metrics explained
- [ ] Interpretation guidance provided
- [ ] Best practices included

## Compatibility Verification

### Rust Edition Compatibility
```bash
rustc --version
```

- [ ] Rust 2021 edition supported
- [ ] No edition-related errors
- [ ] Modern Rust features work (`LazyLock`, async/await)

### Platform Compatibility

Test on available platforms:

- [ ] Linux compilation and execution
- [ ] macOS compilation and execution (if available)
- [ ] Windows compilation and execution (if available)

### Dependency Resolution

```bash
cargo tree -p benches
```

- [ ] All dependencies resolve
- [ ] No conflicting versions
- [ ] Git dependencies accessible
- [ ] Crates.io dependencies available

## Integration Verification

### Git Repository

```bash
git status
git log
```

- [ ] All files are tracked
- [ ] Commit history is clean
- [ ] No unnecessary files included
- [ ] .gitignore is appropriate

### Workspace Structure

```bash
cargo workspaces list  # or equivalent
```

- [ ] Workspace is properly configured
- [ ] Member crates recognized
- [ ] Workspace-level lints apply
- [ ] Shared workspace settings work

## Regression Testing

### Compare with Original

If possible, compare results with original implementation:

- [ ] Same benchmarks exist
- [ ] Results are comparable
- [ ] No missing functionality
- [ ] Performance is similar

### Validation Checks

For benchmarks with validation:

```bash
cargo test -p benches
```

- [ ] Reachability results match expected
- [ ] Algorithms produce correct output
- [ ] No correctness regressions

## Final Checks

### Size Verification
```bash
du -sh benches/
du -sh benches/benches/*.txt
```

- [ ] Total benchmark directory: ~4.5 MB
- [ ] words_alpha.txt: ~3.9 MB
- [ ] reachability_edges.txt: ~533 KB
- [ ] reachability_reachable.txt: ~38 KB

### File Count
```bash
find benches/ -type f | wc -l
```

- [ ] Approximately 19 files (excluding generated)
- [ ] All expected files present
- [ ] No extra unexpected files

### Clean Build
```bash
cargo clean
cargo build --release -p benches
cargo bench -p benches --bench identity
```

- [ ] Clean build succeeds
- [ ] No cached artifacts cause issues
- [ ] Fresh run produces valid results

## Sign-off

**Verification performed by**: _________________

**Date**: _________________

**Results**: 
- [ ] All checks passed
- [ ] Minor issues (documented below)
- [ ] Major issues requiring attention

**Notes**:
```
[Add any notes about issues found, workarounds applied, or special conditions]
```

**Conclusion**:
- [ ] Migration verified successful
- [ ] Ready for use
- [ ] Requires fixes (see notes)

---

## Troubleshooting Common Issues

### Issue: Cargo commands not found
**Solution**: Install Rust toolchain from https://rustup.rs/

### Issue: Git dependencies fail to download
**Solution**: Verify internet connection and git configuration

### Issue: Sinktools dependency error
**Solution**: Check access to https://github.com/hydro-project/hydro

### Issue: Out of memory during benchmarks
**Solution**: Run benchmarks individually, increase available RAM

### Issue: Permission errors
**Solution**: Check file permissions, ensure write access to target/

### Issue: Benchmark times out
**Solution**: Use `-- --quick` flag for faster iteration testing

---

**Last Updated**: 2024-11-21
