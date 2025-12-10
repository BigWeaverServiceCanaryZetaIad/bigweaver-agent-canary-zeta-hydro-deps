# Benchmark Migration

## Overview

These benchmarks depend on timely and differential-dataflow and were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid unnecessary dependencies there.

## Benchmarks in This Repository

The following benchmarks were moved from [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta):

### Timely Benchmarks
- `arithmetic.rs` - Pipeline arithmetic operations benchmark
- `fan_in.rs` - Fan-in dataflow pattern benchmark
- `fan_out.rs` - Fan-out dataflow pattern benchmark
- `fork_join.rs` - Fork-join dataflow pattern benchmark
- `identity.rs` - Identity/pass-through benchmark
- `join.rs` - Join operation benchmark
- `upcase.rs` - String uppercasing benchmark

### Differential-Dataflow Benchmarks
- `reachability.rs` - Graph reachability computation benchmark

### Associated Data Files
- `reachability_edges.txt` - Test graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation

## Benchmarks Remaining in Main Repository

The following benchmarks remain in bigweaver-agent-canary-hydro-zeta as they do not depend on timely or differential-dataflow:

- `futures.rs`
- `micro_ops.rs`
- `symmetric_hash_join.rs`
- `words_diamond.rs`

Associated data files:
- `words_alpha.txt`

## Running Benchmarks

### In this repository:
```bash
cd benches
cargo bench
```

### In the main repository:
```bash
cd /path/to/bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

## Performance Comparisons

To compare performance across repositories:

1. Run benchmarks in this repository: `cd benches && cargo bench`
2. Run benchmarks in the main repository: `cd ../bigweaver-agent-canary-hydro-zeta && cargo bench -p benches`
3. Results are stored in `target/criterion/` in each repository
4. Use criterion's HTML reports (in `target/criterion/*/report/index.html`) to compare results
5. Both repositories use the same criterion version and configuration for consistency

## Dependencies

### Added to This Repository
From the main repository's benches/Cargo.toml:
- `differential-dataflow` (package: differential-dataflow-master, version 0.13.0-dev.1)
- `timely` (package: timely-master, version 0.13.0-dev.1)

### Shared Dependencies (via path)
- `dfir_rs` - Referenced from the main hydro repository
- `sinktools` - Referenced from the main hydro repository

These path dependencies assume both repositories are cloned at the same level:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Integration

These benchmarks maintain compatibility with the main hydro repository's API. The separation allows:
- Faster builds in the main repository (no heavy timely/differential-dataflow dependencies)
- Continued performance testing and comparisons
- Modular codebase organization
- Reduced dependency footprint for most developers
