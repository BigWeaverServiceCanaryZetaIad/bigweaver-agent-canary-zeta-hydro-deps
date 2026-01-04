# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro with timely and differential-dataflow implementations.

## Purpose

The benchmarks in this repository allow performance comparisons between:
- Hydro (dfir_rs) implementations
- Timely dataflow implementations
- Differential dataflow implementations

By separating these benchmarks into a dedicated repository, we avoid adding timely and differential-dataflow as dependencies to the main Hydro repository while maintaining the ability to run performance comparisons.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench fan_in
```

## Prerequisites

This repository depends on the bigweaver-agent-canary-hydro-zeta repository being present in the same parent directory:
```
/parent-directory/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```

## Benchmark Files

The `benches` directory contains:
- **Cargo.toml**: Benchmark configuration with timely and differential-dataflow dependencies
- **benches/fan_in.rs**: Fan-in pattern benchmark
- **benches/join.rs**: Join operation benchmark
- **benches/reachability.rs**: Graph reachability benchmark
- Additional benchmark files for various dataflow patterns

## Notes

- Wordlist used in benchmarks is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt