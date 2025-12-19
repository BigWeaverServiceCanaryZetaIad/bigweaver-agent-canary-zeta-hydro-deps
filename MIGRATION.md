# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to this repository.

## Migration Date

December 19, 2024 (initial migration)
December 19, 2024 (added timely/differential implementations to all benchmarks)

## Objective

To separate benchmarks with timely/differential-dataflow dependencies from the main Hydro repository, achieving:

1. **Reduced Build Dependencies**: Remove timely and differential-dataflow from the main repository's dependency graph
2. **Faster Build Times**: Improve development iteration speed by reducing compilation overhead
3. **Maintained Functionality**: Preserve full performance comparison capabilities
4. **Clear Separation**: Establish architectural boundary between core implementation and comparative benchmarks

## What Was Migrated

### Timely/Differential-Dataflow Benchmarks (8 files)

These benchmarks compare Hydro implementations against timely/differential-dataflow:

1. **arithmetic.rs** - Arithmetic pipeline operations benchmark
2. **fan_in.rs** - Fan-in pattern benchmark (multiple inputs → single output)
3. **fan_out.rs** - Fan-out pattern benchmark (single input → multiple outputs)
4. **fork_join.rs** - Fork-join pattern with code generation
5. **identity.rs** - Identity transformation benchmark
6. **join.rs** - Join operations benchmark
7. **reachability.rs** - Graph reachability benchmark
8. **upcase.rs** - String transformation (uppercase) benchmark

### Hydro-Native Benchmarks (4 files) - Enhanced with Timely/Differential Implementations

These benchmarks were **copied** (not moved) and have been **enhanced** with timely/differential implementations for comprehensive comparison:

1. **futures.rs** - Futures-based operations benchmark
   - ✅ Added timely dataflow overhead comparison (December 19, 2024)
2. **micro_ops.rs** - Micro-operations benchmark
   - ✅ Added timely implementations for identity, map, flat_map, filter (December 19, 2024)
3. **symmetric_hash_join.rs** - Symmetric hash join benchmark
   - ✅ Added timely and differential join implementations (December 19, 2024)
4. **words_diamond.rs** - Word processing diamond pattern benchmark
   - ✅ Added timely diamond pattern implementation (December 19, 2024)

These remain in the main repository as well since they are Hydro-native implementations without external dependencies.

### Supporting Files

- **reachability_edges.txt** - Graph edges data for reachability benchmark (521 KB)
- **reachability_reachable.txt** - Expected reachable nodes for verification (38 KB)
- **words_alpha.txt** - Word list for words_diamond benchmark (3.7 MB)
- **build.rs** - Build script for fork_join benchmark code generation
- **.gitignore** - Ignore patterns for generated files

## Repository Structure

### Before Migration (Main Repository)

```
bigweaver-agent-canary-hydro-zeta/
├── benches/
│   ├── benches/
│   │   ├── arithmetic.rs          [timely/differential]
│   │   ├── fan_in.rs              [timely/differential]
│   │   ├── fan_out.rs             [timely/differential]
│   │   ├── fork_join.rs           [timely/differential]
│   │   ├── futures.rs             [Hydro-native]
│   │   ├── identity.rs            [timely/differential]
│   │   ├── join.rs                [timely/differential]
│   │   ├── micro_ops.rs           [Hydro-native]
│   │   ├── reachability.rs        [timely/differential]
│   │   ├── symmetric_hash_join.rs [Hydro-native]
│   │   ├── upcase.rs              [timely/differential]
│   │   ├── words_diamond.rs       [Hydro-native]
│   │   └── data files...
│   ├── build.rs
│   └── Cargo.toml (with timely/differential deps)
└── ...
```

### After Migration

**Main Repository** (bigweaver-agent-canary-hydro-zeta):
```
bigweaver-agent-canary-hydro-zeta/
├── benches/
│   ├── benches/
│   │   ├── futures.rs             [Hydro-native only]
│   │   ├── micro_ops.rs           [Hydro-native only]
│   │   ├── symmetric_hash_join.rs [Hydro-native only]
│   │   ├── words_diamond.rs       [Hydro-native only]
│   │   └── words_alpha.txt
│   └── Cargo.toml (NO timely/differential deps)
└── ...
```

**Deps Repository** (bigweaver-agent-canary-zeta-hydro-deps):
```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/
│   │   ├── arithmetic.rs          [timely/differential + Hydro]
│   │   ├── fan_in.rs              [timely/differential + Hydro]
│   │   ├── fan_out.rs             [timely/differential + Hydro]
│   │   ├── fork_join.rs           [timely/differential + Hydro]
│   │   ├── futures.rs             [timely + Hydro] ✨ NEW
│   │   ├── identity.rs            [timely/differential + Hydro]
│   │   ├── join.rs                [timely/differential + Hydro]
│   │   ├── micro_ops.rs           [timely + Hydro] ✨ NEW
│   │   ├── reachability.rs        [timely/differential + Hydro]
│   │   ├── symmetric_hash_join.rs [timely/differential + Hydro] ✨ NEW
│   │   ├── upcase.rs              [timely/differential + Hydro]
│   │   ├── words_diamond.rs       [timely + Hydro] ✨ NEW
│   │   ├── reachability_edges.txt
│   │   ├── reachability_reachable.txt
│   │   └── words_alpha.txt
│   ├── build.rs
│   └── Cargo.toml (WITH timely/differential deps)
├── Cargo.toml
└── README.md
```

✨ **NEW** indicates benchmarks that received timely/differential implementations on December 19, 2024

## Dependencies Changes

### Main Repository - Removed Dependencies

From `benches/Cargo.toml`:
- ❌ `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- ❌ `timely` (package: "timely-master", version: "0.13.0-dev.1")

### Deps Repository - Added Dependencies

To `benches/Cargo.toml`:
- ✅ `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- ✅ `timely` (package: "timely-master", version: "0.13.0-dev.1")
- ✅ `dfir_rs` (from main repository, features: ["debugging"])
- ✅ `criterion` (version: "0.5.0", features: ["async_tokio", "html_reports"])
- ✅ Other supporting dependencies (futures, rand, tokio, etc.)

## Performance Comparison Workflow

### Running Hydro-Native Benchmarks

From the main repository:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

This runs only Hydro-native implementations without timely/differential-dataflow overhead.

### Running Timely/Differential-Dataflow Benchmarks

From this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

This runs benchmarks with timely/differential-dataflow implementations for comparison.

### Comparing Results

1. Collect benchmark results from both repositories
2. Use Criterion's HTML reports in `target/criterion/`
3. Compare performance metrics between implementations
4. Analyze trade-offs and optimization opportunities

## Benefits Achieved

1. **Build Time Improvement**: Main repository builds faster without timely/differential-dataflow compilation
2. **Dependency Reduction**: Cleaner dependency graph for core development
3. **Maintained Capabilities**: Full performance comparison still available
4. **Clear Architecture**: Separation of concerns between implementation and comparison
5. **Flexible Development**: Can iterate on core features without external dependency overhead

## Verification Steps

### Verify Main Repository

```bash
cd bigweaver-agent-canary-hydro-zeta
# Should NOT find timely/differential references
grep -r "timely\|differential" benches/ --include="*.toml" --include="*.rs"
# Should build successfully
cargo build -p benches
# Should run benchmarks successfully
cargo bench -p benches
```

### Verify Deps Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
# SHOULD find timely/differential references in ALL 12 benchmark files
grep -l "timely\|differential" benches/benches/*.rs
# Should list: arithmetic, fan_in, fan_out, fork_join, futures, identity, join, 
#              micro_ops, reachability, symmetric_hash_join, upcase, words_diamond
# Should build successfully (may take longer due to timely/differential)
cargo build -p benches
# Should run benchmarks successfully
cargo bench -p benches
# Run only timely benchmarks
cargo bench -p benches -- timely
# Run only differential benchmarks
cargo bench -p benches -- differential
```

## Future Considerations

1. **Adding New Benchmarks**:
   - Hydro-native only → add to main repository
   - Timely/differential comparison → add to this repository
   - Consider copying Hydro-native to this repo for future comparative implementations

2. **Updating Dependencies**:
   - Keep timely/differential versions in sync with upstream
   - Monitor for breaking changes in dataflow libraries
   - Update dfir_rs references as main repository evolves

3. **CI/CD Integration**:
   - Consider separate CI pipelines for each repository
   - Implement cross-repository benchmark result collection
   - Set up automated performance regression detection

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion Benchmarking: https://github.com/bheisler/criterion.rs
