# Hydro Benchmarks - Timely and Differential-Dataflow

This repository contains benchmarks that depend on `timely` and `differential-dataflow` packages. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies in the main codebase.

## Benchmarks

The following benchmarks are included:

### Timely Benchmarks
- `arithmetic.rs` - Arithmetic operations using timely
- `fan_in.rs` - Fan-in pattern using timely
- `fan_out.rs` - Fan-out pattern using timely
- `fork_join.rs` - Fork-join pattern using timely
- `identity.rs` - Identity operation using timely
- `join.rs` - Join operation using timely
- `upcase.rs` - String uppercase using timely

### Differential-Dataflow Benchmarks
- `reachability.rs` - Graph reachability using differential-dataflow
  - `reachability_edges.txt` - Input data for reachability benchmark
  - `reachability_reachable.txt` - Expected output data

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

Run a specific test within a benchmark:
```bash
cargo bench --bench reachability differential
```

## Performance Comparisons

Benchmark results are stored in `target/criterion/` and can be viewed as HTML reports. To compare performance across different runs:

1. Run benchmarks and save baseline:
   ```bash
   cargo bench --bench reachability -- --save-baseline my-baseline
   ```

2. Make changes and compare:
   ```bash
   cargo bench --bench reachability -- --baseline my-baseline
   ```

3. View HTML reports in `target/criterion/*/report/index.html`

## Dependencies

This benchmark suite depends on:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)
- `criterion` for benchmarking framework

Note: Some benchmarks from the main repository (micro_ops, symmetric_hash_join, words_diamond, futures) are not included here as they don't depend on timely/differential-dataflow and remain in the main repository.

## Migration

For details on the benchmark migration, see [MIGRATION.md](./MIGRATION.md).

## Note on Historical Benchmarks

Some of the recovered benchmarks (arithmetic, fan_in, fan_out, fork_join, identity, join, upcase) reference legacy package names like `babyflow`, `spinachflow`, and early versions of `hydroflow`. These benchmarks were recovered from the git history and may need to be updated to work with current package names and APIs.

The `reachability` benchmark uses `differential-dataflow` and should work with the current dependencies.

To update the legacy benchmarks, you may need to:
1. Replace references to `babyflow`/`spinachflow` with current Hydro APIs
2. Update imports and function calls to match current API signatures
3. Verify functionality with current dependency versions
