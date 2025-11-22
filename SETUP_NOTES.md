# Setup Notes

## Current Status

This repository contains the recovered timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository. The benchmarks are structured and documented, but some may require additional configuration to run.

## Dependencies Status

### ✅ Available Dependencies

The following dependencies are configured and available:

- **timely** (timely-master v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1) - Differential computation
- **criterion** (v0.5.0) - Benchmarking framework
- **lazy_static** (v1.4) - Static initialization
- **rand** (v0.8.0) and **rand_distr** (v0.4.3) - Random number generation

### ⚠️ Historical Dependencies

Some benchmarks reference **babyflow**, which was an early prototype implementation. These benchmark implementations are included for historical comparison but may not compile without additional configuration.

**Affected benchmarks:**
- arithmetic.rs (babyflow implementation)
- fan_in.rs (babyflow implementation)
- fan_out.rs (babyflow implementation)  
- fork_join.rs (babyflow implementation)
- identity.rs (babyflow implementation)
- join.rs (babyflow implementation)
- reachability.rs (babyflow implementation - commented out)
- upcase.rs (babyflow implementation)

### 🔧 Optional Dependencies

**DFIR/Hydroflow integration:**

The `reachability.rs` benchmark includes an optional hydroflow implementation. To enable cross-framework comparison with DFIR:

1. Ensure the main repository is cloned alongside this one:
   ```bash
   # Expected structure:
   /projects/sandbox/
   ├── bigweaver-agent-canary-hydro-zeta/     # Main repo
   └── bigweaver-agent-canary-zeta-hydro-deps/ # This repo
   ```

2. Uncomment the dfir_rs dependency in `benchmarks/Cargo.toml`:
   ```toml
   [dev-dependencies]
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   ```

3. Ensure benchmark implementations reference the correct imports

## Running Benchmarks

### Option 1: Run All Benchmarks (May Have Compilation Errors)

```bash
cargo bench -p hydro-deps-benchmarks
```

**Expected result:** Timely and differential-dataflow implementations will compile and run. Babyflow implementations may fail to compile.

### Option 2: Run Specific Working Benchmarks

Run benchmarks that only use timely/differential-dataflow:

```bash
# These should work without additional configuration
cargo bench -p hydro-deps-benchmarks --bench reachability
cargo bench -p hydro-deps-benchmarks --bench join
```

### Option 3: Comment Out Babyflow Implementations

To use benchmarks without babyflow:

1. Edit benchmark files to comment out babyflow functions
2. Update criterion_group! to exclude babyflow benchmarks
3. Rebuild

**Example for `identity.rs`:**
```rust
// Comment out benchmark_babyflow function
// fn benchmark_babyflow(c: &mut Criterion) { ... }

criterion_group!(
    identity,
    // benchmark_babyflow,  // Commented out
    benchmark_pipeline,
    benchmark_raw_copy,
    benchmark_iter,
    benchmark_timely
);
```

## Troubleshooting

### Cannot Find Package `babyflow`

**Error:**
```
error[E0432]: unresolved import `babyflow`
```

**Solutions:**

1. **Comment out babyflow implementations** (recommended for now)
   - Edit each benchmark file
   - Comment out functions using babyflow
   - Update criterion_group! macro

2. **Remove babyflow dependency** from benchmarks
   - Some benchmarks can be simplified to only test timely

3. **Locate babyflow source** (if available)
   - Add as dependency if source is available
   - Update Cargo.toml with correct path

### Cannot Find Package `dfir_rs` or `hydroflow`

**Error:**
```
error[E0432]: unresolved import `hydroflow`
```

**Solution:**

This is expected for the hydroflow implementation in `reachability.rs`. The benchmark includes both timely and hydroflow implementations for comparison.

**To enable hydroflow benchmarks:**

1. Clone the main repository:
   ```bash
   cd /projects/sandbox/
   git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
   ```

2. Uncomment in `benchmarks/Cargo.toml`:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   ```

3. Uncomment hydroflow benchmark in `reachability.rs`:
   ```rust
   criterion_group!(
       reachability,
       benchmark_timely,
       benchmark_hydroflow,  // Uncomment this
   );
   ```

### Compilation Takes Very Long

Timely and differential-dataflow are large dependencies with significant compilation time.

**Solutions:**
- Use `cargo check` first to verify syntax
- Use `--release` mode for actual benchmarking only
- Enable incremental compilation (should be default)
- Consider using `sccache` or similar caching tools

## Verification Steps

To verify the setup:

### 1. Check Workspace Structure

```bash
cargo check -p hydro-deps-benchmarks
```

Should show any compilation errors clearly.

### 2. Test Single Benchmark

```bash
cargo bench -p hydro-deps-benchmarks --bench reachability -- --test
```

The `--test` flag runs benchmarks in test mode (faster, no actual benchmarking).

### 3. View Available Benchmarks

```bash
./run_benchmarks.sh list
```

Should display all available benchmarks.

## Recommended First Steps

1. **Verify timely/differential-dataflow work:**
   ```bash
   cargo check -p hydro-deps-benchmarks
   ```
   Fix any immediate compilation errors.

2. **Comment out babyflow references:**
   This is the quickest path to working benchmarks. Update each benchmark file to remove or comment out babyflow implementations.

3. **Run working benchmarks:**
   ```bash
   cargo bench -p hydro-deps-benchmarks --bench reachability
   ```

4. **Add DFIR comparison** (optional):
   Follow steps above to enable hydroflow integration.

## Future Improvements

Potential enhancements for this repository:

1. **Remove babyflow dependencies**
   - Update benchmarks to remove legacy babyflow implementations
   - Keep only timely, differential-dataflow, and baseline implementations

2. **Add DFIR implementations**
   - Add comparable DFIR implementations to each benchmark
   - Enable direct performance comparison

3. **Streamline dependencies**
   - Make hydroflow dependency optional via feature flags
   - Document which benchmarks work with which configurations

4. **CI Integration**
   - Add GitHub Actions workflow
   - Run benchmarks on PRs
   - Track performance over time

5. **Benchmark Gallery**
   - Collect and publish benchmark results
   - Create performance comparison dashboards

## Questions or Issues?

If you encounter issues not covered here:

1. Check if timely/differential-dataflow versions are correct
2. Verify Rust toolchain version (1.70+)
3. Review individual benchmark source for specific requirements
4. Create an issue in this repository with:
   - Full error message
   - Rust version (`rustc --version`)
   - Steps to reproduce

## See Also

- [README.md](README.md) - Repository overview
- [BENCHMARKS.md](BENCHMARKS.md) - Detailed benchmark documentation
- [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md) - Performance comparison guide
- [CHANGELOG.md](CHANGELOG.md) - Version history
