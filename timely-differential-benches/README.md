# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks for performance comparison with the main bigweaver-agent-canary-hydro-zeta repository. It includes:
- Benchmarks that use timely-dataflow and differential-dataflow dependencies
- Benchmarks that use dfir_rs for direct comparison

## Overview

These benchmarks were migrated from the main repository to separate benchmark dependencies from the core codebase while maintaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
# Timely/Differential benchmarks
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench upcase
cargo bench -p timely-differential-benches --bench zip

# DFIR_rs comparison benchmarks
cargo bench -p timely-differential-benches --bench micro_ops
cargo bench -p timely-differential-benches --bench symmetric_hash_join
cargo bench -p timely-differential-benches --bench words_diamond
cargo bench -p timely-differential-benches --bench futures
```

## Benchmark Descriptions

### Timely/Differential Dataflow Benchmarks

- **arithmetic** - Arithmetic operations benchmark comparing different dataflow frameworks
- **fan_in** - Fan-in pattern benchmark for data aggregation
- **fan_out** - Fan-out pattern benchmark for data distribution
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark (data pass-through)
- **join** - Join operation benchmark
- **reachability** - Graph reachability computation benchmark
- **upcase** - String uppercase transformation benchmark
- **zip** - Zip operation benchmark

### DFIR_rs Comparison Benchmarks

- **micro_ops** - Microbenchmarks of various DFIR_rs operations (identity, unique, map, filter, fold, etc.)
- **symmetric_hash_join** - Symmetric hash join implementation benchmarks
- **words_diamond** - Diamond-shaped dataflow pattern benchmark using word list
- **futures** - Async future handling benchmarks in DFIR_rs

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for verification
- `words_alpha.txt` - Word list for words_diamond benchmark (from https://github.com/dwyl/english-words)

## Cross-Repository Comparison

To compare performance between this repository and the main repository, use the comparison script in the parent directory:

```bash
cd ..
./scripts/compare_benchmarks.sh
```
