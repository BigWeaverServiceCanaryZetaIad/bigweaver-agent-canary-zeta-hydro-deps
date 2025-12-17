# Benchmark Migration Verification

This document provides verification steps to ensure the timely and differential-dataflow benchmarks are properly configured and functional in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Migration Completion Date

December 17, 2024

## Overview

The timely and differential-dataflow benchmarks have been successfully migrated from the bigweaver-agent-canary-hydro-zeta repository to this repository. This verification guide confirms all necessary components are in place.

## Checklist

### ✅ Benchmark Files Present

All 8 benchmarks from the migration are present in `benches/benches/`:

- [x] `arithmetic.rs` - Arithmetic operations benchmark
- [x] `fan_in.rs` - Fan-in pattern benchmark
- [x] `fan_out.rs` - Fan-out pattern benchmark
- [x] `fork_join.rs` - Fork-join pattern benchmark
- [x] `identity.rs` - Identity transformation benchmark
- [x] `join.rs` - Join operations benchmark
- [x] `reachability.rs` - Graph reachability benchmark
- [x] `upcase.rs` - String transformation benchmark

### ✅ Data Files Present

Required data files for benchmarks:

- [x] `reachability_edges.txt` - Test data for reachability benchmark
- [x] `reachability_reachable.txt` - Expected results for reachability benchmark

### ✅ Build Infrastructure

- [x] `build.rs` - Build script for fork_join benchmark code generation
- [x] `.gitignore` - Ignore patterns for generated files (fork_join_*.hf)

### ✅ Dependencies Configured

All required dependencies are present in `benches/Cargo.toml`:

- [x] **criterion** (v0.5.0) - Benchmarking framework with async_tokio and html_reports features
- [x] **dfir_rs** - Hydro's DFIR implementation (git dependency from main repository with "debugging" feature)
- [x] **differential-dataflow** (package: differential-dataflow-master v0.13.0-dev.1)
- [x] **timely** (package: timely-master v0.13.0-dev.1)
- [x] **futures** (v0.3)
- [x] **nameof** (v1.0.0)
- [x] **rand** (v0.8.0)
- [x] **rand_distr** (v0.4.3)
- [x] **seq-macro** (v0.2.0)
- [x] **static_assertions** (v1.0.0)
- [x] **tokio** (v1.29.0) - with rt-multi-thread feature

### ✅ Benchmark Entries

All benchmarks are properly declared in Cargo.toml with `harness = false`:

- [x] arithmetic
- [x] fan_in
- [x] fan_out
- [x] fork_join
- [x] identity
- [x] upcase
- [x] join
- [x] reachability

### ✅ Documentation

- [x] `README.md` - Repository overview and usage instructions
- [x] `benches/README.md` - Detailed benchmark documentation
- [x] `VERIFICATION.md` - This verification document

## Verification Steps

### 1. Check Repository Structure

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
ls -la benches/benches/*.rs
ls -la benches/benches/*.txt
ls -la benches/build.rs
```

**Expected Output:** All 8 .rs benchmark files, 2 .txt data files, and build.rs should be present.

### 2. Verify Dependencies

```bash
cd benches
grep -E "(timely|differential-dataflow|dfir_rs)" Cargo.toml
```

**Expected Output:** Should show timely, differential-dataflow, and dfir_rs in [dev-dependencies].

### 3. Verify Benchmark Imports

```bash
cd benches/benches
grep -h "^use timely\|^use differential" *.rs | sort -u
```

**Expected Output:** Should show imports from timely and differential-dataflow packages.

### 4. Build Test (requires Rust installation)

```bash
cd benches
cargo check
```

**Expected Output:** Should compile without errors, resolving all dependencies including dfir_rs from the git repository.

### 5. Run Benchmarks (requires Rust installation)

Run all benchmarks:
```bash
cd benches
cargo bench
```

Run specific benchmark:
```bash
cargo bench --bench arithmetic
```

**Expected Output:** Benchmarks should execute successfully and produce performance metrics.

### 6. Verify Build Script

```bash
cd benches
cargo clean
cargo build
ls -la benches/fork_join_*.hf
```

**Expected Output:** Build script should generate `fork_join_20.hf` file during build.

## Dependency Resolution

### dfir_rs Git Dependency

The `dfir_rs` dependency is configured as a git dependency pointing to the main repository:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", features = [ "debugging" ] }
```

This ensures:
- Access to the latest Hydro DFIR implementation
- Compatibility with the main repository
- Proper feature flags (debugging) for benchmark use

### External Package Dependencies

Timely and differential-dataflow use the `-master` development versions:

```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

These packages must be available from the configured package registry.

## Performance Comparison Workflow

### Running Comparative Benchmarks

1. **Run timely/differential-dataflow benchmarks** (this repository):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench --bench arithmetic 2>&1 | tee arithmetic_timely.log
   ```

2. **Run Hydro-native benchmarks** (main repository):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta/benches
   cargo bench --bench micro_ops 2>&1 | tee micro_ops_hydro.log
   ```

3. **Compare results**: Analyze the performance metrics from both runs

### Benchmark Categories

- **Pattern Benchmarks**: arithmetic, fan_in, fan_out, fork_join, identity
- **Data Processing**: join, reachability, upcase

Each category allows for performance comparison between Hydro and timely/differential-dataflow implementations.

## Troubleshooting

### Issue: Cargo fails to resolve dfir_rs

**Solution**: Ensure network access to GitHub and that the main repository is accessible:
```bash
git ls-remote https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
```

### Issue: timely or differential-dataflow packages not found

**Solution**: Verify package registry configuration and network connectivity. These packages should be available from crates.io or a configured registry.

### Issue: Build script fails

**Solution**: Check that the build.rs file has proper permissions and the benches/ subdirectory is writable:
```bash
chmod +x benches/build.rs
ls -ld benches/benches/
```

### Issue: Benchmarks fail to run

**Solution**: Ensure all data files are present and readable:
```bash
ls -l benches/benches/reachability_*.txt
```

## Success Criteria

The migration is successful when:

1. ✅ All 8 benchmark files are present and contain references to timely/differential-dataflow
2. ✅ Cargo.toml includes all required dependencies (timely, differential-dataflow, dfir_rs)
3. ✅ `cargo check` completes without errors
4. ✅ `cargo bench` runs successfully and produces performance metrics
5. ✅ Build script generates fork_join_20.hf during compilation
6. ✅ Performance comparisons can be made with main repository benchmarks

## Related Documentation

- **Migration Documentation**: See [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository
- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Benchmark Usage**: See [benches/README.md](benches/README.md)

## Conclusion

All necessary components for the timely and differential-dataflow benchmarks are in place:

- ✅ All benchmark source files migrated
- ✅ Data files present
- ✅ Build infrastructure configured
- ✅ Dependencies properly declared (including dfir_rs git dependency)
- ✅ Documentation complete

The repository is ready for performance comparison testing between Hydro-native and timely/differential-dataflow implementations.
