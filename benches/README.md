# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks for Hydro that depend on timely and differential-dataflow.

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid adding timely and differential-dataflow as dependencies to the main codebase.

## Running Benchmarks

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

## Available Benchmarks

- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity operation benchmark
- `upcase` - String uppercase benchmark
- `join` - Join operation benchmark
- `reachability` - Graph reachability benchmark
- `micro_ops` - Micro-operations benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `words_diamond` - Words diamond pattern benchmark
- `futures` - Futures-based benchmark

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for reachability benchmark
- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Dependencies

These benchmarks use:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `dfir_rs` from the main repository (via git dependency)
- `sinktools` from the main repository (via git dependency)
