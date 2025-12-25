# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark suites and dependencies for the Hydro project.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and related crates, including performance comparisons with timely-master (version 0.13.0-dev.1) and differential-dataflow-master (version 0.13.0-dev.1).

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench fan_in
```

### Benchmark Files

The benchmarks include:
- `fork_join.rs` - Fork-join pattern benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `reachability.rs` - Graph reachability benchmarks
- `join.rs` - Join operation benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `arithmetic.rs` - Arithmetic operation benchmarks
- `identity.rs` - Identity operation benchmarks
- `upcase.rs` - String case conversion benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `words_diamond.rs` - Word processing diamond pattern benchmarks
- `futures.rs` - Futures-based benchmarks

### Dependencies

The benchmarks depend on:
- `dfir_rs` - Core dataflow IR library (from hydro-project/hydro)
- `sinktools` - Sink utilities (from hydro-project/hydro)
- `timely-master` (v0.13.0-dev.1) - Timely dataflow
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential dataflow
- `criterion` - Benchmarking framework

Note: The `dfir_rs` and `sinktools` dependencies are configured as git dependencies pointing to the main Hydro repository. If you need to use local path dependencies instead, update the `benches/Cargo.toml` file accordingly.
