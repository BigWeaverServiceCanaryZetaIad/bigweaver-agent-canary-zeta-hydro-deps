# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on `timely` and `differential-dataflow`. These benchmarks have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies in the core codebase.

## Structure

- `benches/` - Microbenchmarks comparing Hydro with timely and differential-dataflow implementations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

## Purpose

This separate repository allows:
1. The main Hydro repository to remain free of timely/differential-dataflow dependencies
2. Performance comparisons to be maintained for evaluating Hydro's performance
3. Benchmark results to be tracked independently

## Dependencies

The benchmarks reference the main Hydro repository via git dependencies to access `dfir_rs` and `sinktools` for fair performance comparisons.