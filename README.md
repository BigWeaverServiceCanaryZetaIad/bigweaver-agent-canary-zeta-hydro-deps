# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow performance comparisons, along with the necessary dependencies to run them.

## Contents

- **benches/**: Benchmark suite including:
  - `fan_out.rs`, `fan_in.rs`: Fan-out and fan-in pattern benchmarks
  - `upcase.rs`: Simple string transformation benchmark
  - `reachability.rs`: Graph reachability benchmark comparing timely, differential-dataflow, and dfir_rs implementations
  - `join.rs`, `symmetric_hash_join.rs`: Join operation benchmarks
  - `arithmetic.rs`: Arithmetic operation benchmarks
  - `fork_join.rs`: Fork-join pattern benchmark
  - `identity.rs`: Identity operation benchmark
  - `micro_ops.rs`: Micro-operation benchmarks
  - `words_diamond.rs`: Word processing diamond pattern benchmark
  - `futures.rs`: Futures-based benchmark

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench --workspace
```

To run a specific benchmark:
```bash
cargo bench --package benches --bench <benchmark_name>
```

For example:
```bash
cargo bench --package benches --bench reachability
```

## Dependencies

This repository includes the necessary dfir_rs and supporting libraries required to run the benchmarks with timely and differential-dataflow dependencies.
