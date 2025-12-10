# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that depend on timely and differential-dataflow. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies in that codebase.

## Benchmarks

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
  - Uses `reachability_edges.txt` (graph edges)
  - Uses `reachability_reachable.txt` (expected reachable nodes)

## Prerequisites

These benchmarks have dependencies on `dfir_rs` and `sinktools` from the main hydro repository. You need to have the `bigweaver-agent-canary-hydro-zeta` repository cloned at the same level as this repository:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

Run benchmarks with specific filters:
```bash
cargo bench arithmetic/timely
cargo bench -- identity
```

## Performance Comparisons

To compare performance with benchmarks in the main repository:

1. Run benchmarks in this repository: `cargo bench`
2. Run benchmarks in the main repository: `cd ../bigweaver-agent-canary-hydro-zeta && cargo bench -p benches`
3. Results are stored in `target/criterion/` in each repository
4. Use criterion's HTML reports (in `target/criterion/*/report/index.html`) to compare results

Both repositories use the same criterion version and configuration for consistency.

## Integration

These benchmarks maintain compatibility with the main hydro repository's API and test against the same core functionality, just with the additional timely/differential-dataflow dependencies isolated here.
