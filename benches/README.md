# Timely/Differential-Dataflow Comparison Benchmarks

This repository contains benchmarks that compare DFIR (Hydro) with timely-dataflow and differential-dataflow implementations. These benchmarks have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid including timely and differential-dataflow dependencies in the main codebase.

## Purpose

The benchmarks maintained in this repository enable performance comparisons between:
- DFIR (Hydro) implementations
- Timely Dataflow implementations  
- Differential Dataflow implementations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
```

## Benchmark Descriptions

- **arithmetic** - Arithmetic operation benchmarks comparing DFIR, Timely, and Differential implementations
- **fan_in** - Fan-in pattern performance tests
- **fan_out** - Fan-out pattern performance tests
- **fork_join** - Fork-join pattern benchmarks
- **identity** - Identity operation performance tests
- **join** - Join operation benchmarks
- **reachability** - Graph reachability computation performance tests
- **upcase** - String transformation (upcase) benchmarks

## Repository Structure

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository for:
- `dfir_rs` - The DFIR runtime and operators
- `sinktools` - Supporting utilities

The dependencies are referenced via relative paths, so both repositories should be cloned in the same parent directory:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Migration

These benchmarks were previously part of the main Hydro repository but were moved to this separate repository to:
1. Reduce build dependencies in the main repository
2. Improve build times for developers not running performance comparisons
3. Maintain clear separation between core functionality and benchmarking infrastructure
4. Preserve the ability to run performance comparisons when needed

For more information about Hydro-native benchmarks (without timely/differential dependencies), see the `benches` directory in the main `bigweaver-agent-canary-hydro-zeta` repository.

## Data Files

- Wordlist data from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Reachability test data included in this repository
