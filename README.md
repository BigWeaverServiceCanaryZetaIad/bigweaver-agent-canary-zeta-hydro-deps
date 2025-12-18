# bigweaver-agent-canary-zeta-hydro-deps

Benchmarks repository with timely and differential-dataflow dependencies for performance comparison.

## Overview

This repository contains all benchmarks for the Hydro project, including those that depend on timely and differential-dataflow for performance comparison. By maintaining benchmarks separately, we avoid adding external dependencies to the main development workflow.

**As of December 18, 2024, all benchmarks have been migrated to this repository.**

## Structure

- `benches/` - Complete benchmark suite
  - `benches/benches/` - Individual benchmark files
  - `benches/Cargo.toml` - Package configuration with timely/differential-dataflow dependencies
  - `benches/README.md` - Detailed benchmark documentation

## Available Benchmarks

### Phase 2 Benchmarks (Added December 18, 2024)
- **micro_ops** - Micro-operations benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks
- **futures** - Futures-based operations benchmarks

### Phase 1 Benchmarks (Added December 17, 2024)
- **arithmetic** - Arithmetic operations benchmarks
- **fan_in** - Fan-in pattern benchmarks
- **fan_out** - Fan-out pattern benchmarks
- **fork_join** - Fork-join pattern benchmarks
- **identity** - Identity transformation benchmarks
- **join** - Join operations benchmarks
- **reachability** - Graph reachability benchmarks
- **upcase** - String transformation benchmarks

## Dependencies

### Timely and Differential-Dataflow
- `timely-master` version 0.13.0-dev.1
- `differential-dataflow-master` version 0.13.0-dev.1

### Supporting Libraries
- criterion (benchmarking framework)
- dfir_rs (Hydro's DFIR implementation, path reference to main repository)
- futures
- rand, rand_distr
- tokio
- Other utilities

## Running Benchmarks

Run all benchmarks:
```bash
cd benches
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
cargo bench --bench arithmetic
cargo bench --bench join
```

## Performance Analysis

Criterion generates HTML reports in `target/criterion/` that can be used to analyze performance characteristics and compare different implementations.

## Benefits

1. **Reduced Build Dependencies**: The main repository no longer needs any benchmark dependencies
2. **Faster Build Times**: Core development builds are faster without external dataflow dependencies
3. **Maintained Functionality**: All performance comparison capabilities are preserved in this repository
4. **Clear Separation**: Clean architectural boundary between core implementation and benchmarks
5. **Improved Maintainability**: Each repository has a focused purpose and dependency set
6. **Consolidated Benchmarks**: All benchmarks are maintained in a single location

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native implementations

## Migration

For information about the benchmark migration from the main repository, see the BENCHMARK_MIGRATION.md document in the main repository.

## Development

This repository references the main repository's `dfir_rs` implementation via path dependency:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
```

Ensure both repositories are cloned as siblings in your workspace for the path reference to work correctly.
