# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on heavyweight packages like `timely-master` and `differential-dataflow-master`.

## Structure

* `benches/` - Contains microbenchmarks for DFIR and other frameworks, including:
  - `reachability.rs` - Graph reachability benchmarks
  - `join.rs` - Join operation benchmarks
  - Various other performance comparison benchmarks

## Running Benchmarks

The benchmarks can be run using `cargo bench` from the repository root:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench reachability
cargo bench --bench join
```

## Dependencies

This repository maintains dependencies on:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)
- `dfir_rs` (from the main hydro repository)
- `sinktools` (from the main hydro repository)

These dependencies are used for performance comparisons and benchmarking purposes.