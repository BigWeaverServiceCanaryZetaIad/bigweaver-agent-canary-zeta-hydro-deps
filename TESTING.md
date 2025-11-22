# Testing Guide

This document describes how to test the migrated benchmarks to ensure they work correctly.

## Prerequisites

- Rust toolchain installed (see `rust-toolchain.toml` for required version)
- Cargo package manager
- Git (for fetching dfir_rs and sinktools dependencies)

## Compilation Tests

### 1. Check that the project compiles

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo check
```

Expected result: No compilation errors

### 2. Build all benchmarks

```bash
cargo build --benches
```

Expected result: All 8 benchmarks compile successfully:
- arithmetic
- fan_in
- fan_out
- fork_join
- identity
- join
- reachability
- upcase

## Functionality Tests

### 3. Run a quick benchmark

Test that benchmarks can execute:

```bash
cargo bench --bench arithmetic -- --test
```

Expected result: Benchmark runs in test mode without errors

### 4. Run all benchmarks (takes longer)

```bash
cargo bench -p timely-differential-benches
```

Expected result: All benchmarks execute and produce results in `target/criterion/`

### 5. Run individual benchmarks

```bash
# Test each benchmark individually
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

Expected result: Each benchmark completes successfully

## Performance Comparison Tests

### 6. Verify performance comparisons work

Each benchmark should compare multiple implementations. Check that all comparison groups execute:

For arithmetic benchmark, you should see results for:
- arithmetic/pipeline
- arithmetic/raw
- arithmetic/iter
- arithmetic/iter-collect
- arithmetic/dfir_rs/compiled
- arithmetic/dfir_rs/compiled_no_cheating
- arithmetic/dfir_rs/surface
- arithmetic/timely

Expected result: All comparison groups execute and produce timing data

### 7. Check Criterion reports

After running benchmarks, verify HTML reports are generated:

```bash
ls -la target/criterion/
```

Expected result: HTML reports in `target/criterion/report/index.html`

## Dependency Tests

### 8. Verify external dependencies resolve

The benchmarks depend on external crates from crates.io and git:

```bash
cargo tree | grep -E "timely|differential|dfir_rs|sinktools"
```

Expected result: All dependencies resolve correctly:
- `timely-master` 
- `differential-dataflow-master`
- `dfir_rs` from git (hydro-project/hydro)
- `sinktools` from git (hydro-project/hydro)

## Integration Tests

### 9. Verify performance comparison with main repository

The benchmarks should successfully compare against the latest Hydro code:

```bash
# Update dependencies to latest from git
cargo update
cargo bench --bench identity
```

Expected result: Benchmarks run with latest Hydro code from main repository

## Troubleshooting

### Compilation Errors

If you get compilation errors:

1. Check that Rust toolchain matches `rust-toolchain.toml`
2. Try `cargo clean && cargo build`
3. Verify network connectivity for git dependencies
4. Check that the main Hydro repository is accessible

### Runtime Errors

If benchmarks fail to run:

1. Check data files are present:
   - `benches/benches/reachability_edges.txt`
   - `benches/benches/reachability_reachable.txt`

2. Verify criterion dependency is correct version

3. Check that build script executed: `ls benches/benches/fork_join_20.hf`

### Performance Comparison Issues

If comparisons show unexpected results:

1. Ensure you're running in release mode: `cargo bench` (not `cargo test`)
2. Close other applications that might affect timing
3. Run on a system with consistent performance characteristics
4. Consider running multiple times and comparing trends

## Verification Checklist

Use this checklist to verify the migration:

- [ ] Repository clones successfully
- [ ] `cargo check` completes without errors
- [ ] `cargo build --benches` succeeds
- [ ] All 8 benchmarks are listed in `Cargo.toml`
- [ ] All 8 benchmark files exist in `benches/benches/`
- [ ] Data files present (reachability_edges.txt, reachability_reachable.txt)
- [ ] Build script exists (`benches/build.rs`)
- [ ] `cargo bench --bench arithmetic -- --test` runs successfully
- [ ] Full benchmark suite runs: `cargo bench -p timely-differential-benches`
- [ ] HTML reports generated in `target/criterion/`
- [ ] All dependencies resolve correctly
- [ ] Performance comparisons include both Hydro and Timely/Differential results
- [ ] Documentation is complete and accurate

## Success Criteria

The migration is successful if:

1. ✅ All benchmarks compile without errors
2. ✅ All benchmarks execute and produce results
3. ✅ Performance comparisons include Hydro, Timely, and Differential Dataflow implementations
4. ✅ Results are consistent with pre-migration benchmarks
5. ✅ Dependencies resolve from both crates.io and git
6. ✅ Criterion reports are generated and viewable

## Next Steps

After verifying the migration:

1. Commit all changes to git
2. Push to remote repository
3. Update CI/CD pipelines to include benchmark repository
4. Document benchmark results in project documentation
5. Set up periodic benchmark runs to track performance trends
