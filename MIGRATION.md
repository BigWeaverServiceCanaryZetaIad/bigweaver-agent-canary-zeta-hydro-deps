# Migration History

## Benchmark Migration from Main Repository

This repository was created to house benchmarks that depend on `timely` and `differential-dataflow` packages. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep the main repository clean and avoid unnecessary dependencies.

### Migration Details

**Date:** December 2024  
**Source Commit:** 484e6fdd (bigweaver-agent-canary-hydro-zeta)

### Benchmarks Migrated

The following benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to this repository:

1. **arithmetic.rs** - Arithmetic operations benchmarks
2. **fan_in.rs** - Fan-in pattern benchmarks
3. **fan_out.rs** - Fan-out pattern benchmarks
4. **fork_join.rs** - Fork-join pattern benchmarks
5. **futures.rs** - Futures benchmarks
6. **identity.rs** - Identity operation benchmarks
7. **join.rs** - Join operation benchmarks
8. **micro_ops.rs** - Micro-operations benchmarks
9. **reachability.rs** - Graph reachability benchmarks
10. **symmetric_hash_join.rs** - Symmetric hash join benchmarks
11. **upcase.rs** - String upcase benchmarks
12. **words_diamond.rs** - Words diamond pattern benchmarks

### Dependencies Migrated

The following dependencies are specific to these benchmarks and were removed from the main repository:

- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)

### Running Performance Comparisons

To compare performance between versions:

1. **Run benchmarks in this repository:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches --bench <benchmark_name> -- --save-baseline <baseline_name>
   ```

2. **Update the git revision in benches/Cargo.toml** to point to a different commit in the main repository.

3. **Run benchmarks again:**
   ```bash
   cargo bench -p benches --bench <benchmark_name> -- --baseline <baseline_name>
   ```

4. **View the comparison:** Criterion will automatically show the performance comparison between the baseline and the current run.

### Example Performance Comparison

```bash
# Create a baseline from commit 484e6fdd
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches --bench identity -- --save-baseline commit-484e6fdd

# Update benches/Cargo.toml to reference a newer commit
# Then run the benchmark again to compare
cargo bench -p benches --bench identity -- --baseline commit-484e6fdd
```

### Maintaining Compatibility

When the main repository (`bigweaver-agent-canary-hydro-zeta`) is updated:

1. Check if there are breaking changes to `dfir_rs` or `sinktools` APIs
2. Update the `rev` field in `benches/Cargo.toml` to point to the latest compatible commit
3. Test all benchmarks to ensure they still compile and run correctly
4. Document any API changes that affect the benchmarks

### Configuration Files

The following configuration files were copied from the main repository to ensure consistency:

- `rustfmt.toml` - Code formatting configuration
- `clippy.toml` - Linting configuration
- `rust-toolchain.toml` - Rust toolchain version specification

These files should be periodically synced with the main repository to maintain consistency.
