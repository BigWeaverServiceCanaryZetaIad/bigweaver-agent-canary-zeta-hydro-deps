# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that were separated from the main bigweaver-agent-canary-hydro-zeta repository to reduce dependencies in the main codebase.

## Contents

- `benches/` - Microbenchmarks for DFIR and other frameworks including timely and differential-dataflow
- `timely-differential-benches/` - Benchmarks comparing DFIR/Hydro with Timely Dataflow and Differential Dataflow implementations

## Running Benchmarks

### DFIR-Native Benchmarks

To run all DFIR-native benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond):
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Timely/Differential Comparison Benchmarks

To run benchmarks that compare DFIR with Timely and Differential Dataflow:
```bash
cargo bench -p timely-differential-benches
```

To run specific comparison benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
```

## Dependencies

The benchmarks depend on:
- `timely` (package: "timely-master", version: "0.13.0-dev.1")
- `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- `dfir_rs` (from bigweaver-agent-canary-hydro-zeta repository)
- `sinktools` (from bigweaver-agent-canary-hydro-zeta repository)