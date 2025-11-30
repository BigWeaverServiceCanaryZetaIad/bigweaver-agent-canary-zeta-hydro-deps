# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on heavyweight libraries such as `timely` and `differential-dataflow`. These have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce compilation time and dependency bloat for core development.

## Contents

### Benchmarks (`benches/`)

Microbenchmarks comparing Hydro's performance against `timely` and `differential-dataflow`. These benchmarks help ensure that Hydro maintains competitive performance while providing a higher-level API.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async/futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String transformation benchmarks
- `words_diamond` - Diamond pattern with word processing

## Repository Structure

This repository depends on the main bigweaver-agent-canary-hydro-zeta repository for core Hydro crates like `dfir_rs` and `sinktools`. The dependencies are configured using relative path dependencies.

## Performance Comparisons

To run performance comparisons between Hydro and timely/differential-dataflow:

1. Ensure both repositories are checked out as siblings:
   ```
   parent-directory/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. Run benchmarks from this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. Results will be generated in `target/criterion/` with detailed HTML reports.

## Migration Notes

These benchmarks were moved from the main Hydro repository to this separate repository on 2025-11-30 as part of an effort to:
- Reduce compilation time for core Hydro development
- Separate heavyweight dependencies from the main codebase
- Maintain the ability to run performance comparisons
- Keep the main repository focused on core functionality

For more information, see the MIGRATION_SUMMARY.md in the main repository.