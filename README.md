# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and other dependency-heavy components for the Hydro project, separated from the main repository to avoid unnecessary dependencies.

## Contents

### Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and comparison benchmarks with timely and differential-dataflow.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

Available benchmarks:
- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

#### Performance Comparisons

These benchmarks allow for performance comparisons between:
- Hydro (dfir_rs)
- Timely Dataflow
- Differential Dataflow

The benchmarks use Criterion for statistical analysis and HTML report generation.

## Dependencies

This repository depends on:
- `dfir_rs` - From the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - From the main bigweaver-agent-canary-hydro-zeta repository
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow framework
- `criterion` - Benchmarking framework

## Development

The benchmarks are configured to reference the main repository via git dependencies, ensuring they always use the latest version of the core libraries while keeping the main repository clean of heavy benchmark dependencies.