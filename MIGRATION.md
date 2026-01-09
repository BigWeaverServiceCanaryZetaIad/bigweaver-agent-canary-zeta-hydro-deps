# Benchmark Migration Guide

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from `bigweaver-agent-canary-hydro-zeta` to `bigweaver-agent-canary-zeta-hydro-deps`.

## What Was Moved

The following benchmarks comparing DFIR with timely-dataflow and differential-dataflow have been moved to this repository:

### Benchmark Files
- `benches/benches/arithmetic.rs` - Arithmetic pipeline operations
- `benches/benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join parallelism benchmarks
- `benches/benches/identity.rs` - Identity/passthrough benchmarks
- `benches/benches/join.rs` - Relational join benchmarks
- `benches/benches/micro_ops.rs` - Micro-operation benchmarks
- `benches/benches/reachability.rs` - Graph reachability benchmarks
- `benches/benches/symmetric_hash_join.rs` - Hash join benchmarks
- `benches/benches/upcase.rs` - String transformation benchmarks
- `benches/benches/words_diamond.rs` - Complex word processing benchmarks

### Supporting Files
- `benches/benches/reachability_edges.txt` - Test data for reachability benchmark
- `benches/benches/reachability_reachable.txt` - Expected results for reachability
- `benches/benches/words_alpha.txt` - Word list for word processing benchmarks
- `benches/benches/.gitignore` - Ignores benchmark output
- `benches/build.rs` - Build script
- `benches/Cargo.toml` - Benchmark dependencies and configuration
- `benches/README.md` - Benchmark documentation

### Configuration Files
- `Cargo.toml` - Workspace configuration
- `rustfmt.toml` - Code formatting configuration
- `clippy.toml` - Linting configuration
- `rust-toolchain.toml` - Rust toolchain version

## Changes Made

### In bigweaver-agent-canary-zeta-hydro-deps

1. **Created benchmark workspace**: Added all benchmark files with proper directory structure
2. **Updated dependencies**: 
   - Changed `hydroflow` references to `dfir_rs` (reflecting the rename)
   - Updated path dependencies to reference the main repository: `path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs"`
   - Kept timely-dataflow and differential-dataflow dependencies
3. **Updated source code**: Replaced all `use hydroflow` with `use dfir_rs` in benchmark files
4. **Added documentation**: Created README.md and MIGRATION.md

### In bigweaver-agent-canary-hydro-zeta

1. **Removed dependencies**: Cleaned up Cargo.lock to remove:
   - `benches` package
   - `timely-master` and related packages
   - `differential-dataflow-master`
2. **Added documentation**:
   - Created `BENCHMARKS.md` documenting where benchmarks moved and how to run them
   - Updated `CONTRIBUTING.md` to reference the benchmark repository

## Benefits of This Migration

1. **Cleaner Dependencies**: The main repository no longer has timely-dataflow and differential-dataflow as dependencies
2. **Faster Builds**: Removing external dataflow dependencies significantly speeds up builds
3. **Better Organization**: Clear separation between internal benchmarks and comparative benchmarks
4. **Reduced Technical Debt**: External dependencies no longer clutter the main repository
5. **Independent Evolution**: Comparative benchmarks can evolve without affecting the main repository

## Running Benchmarks After Migration

### Setup
```bash
# Clone both repositories at the same level
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

### Running All Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### Running Specific Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench --bench arithmetic
cargo bench --bench reachability
# etc.
```

## Cross-Repository References

The benchmarks in this repository depend on DFIR runtime components from the main repository:
- `dfir_rs` - The main DFIR runtime
- `sinktools` - Utility tools

These are referenced via path dependencies in `benches/Cargo.toml`:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

This ensures benchmarks always test against the latest version of DFIR in the main repository.

## Verification Steps

To verify the migration was successful:

1. **Check main repository builds without timely/differential**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo build
   ```

2. **Check benchmarks still run**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench --bench identity
   ```

3. **Verify dependencies are correct**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo tree | grep -E "dfir_rs|timely|differential"
   ```

## Future Maintenance

When updating benchmarks:
1. Make changes in `bigweaver-agent-canary-zeta-hydro-deps`
2. Ensure path dependencies still point correctly to the main repository
3. Update benchmark documentation as needed
4. Run benchmarks to verify they still work correctly

When the main repository changes:
1. Benchmarks automatically pick up changes via path dependencies
2. Re-run benchmarks to ensure compatibility
3. Update benchmark code if DFIR APIs change
