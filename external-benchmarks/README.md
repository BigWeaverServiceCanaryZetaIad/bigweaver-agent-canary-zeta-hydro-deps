# External Framework Benchmarks

This directory contains benchmarks comparing Hydro/DFIR performance against external dataflow frameworks, specifically Timely Dataflow and Differential Dataflow.

## Purpose

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Keep external framework dependencies separate from the core codebase
- Maintain performance comparison capabilities without polluting the main repository
- Enable independent benchmarking against Timely and Differential Dataflow

## Benchmarks Included

### Timely Dataflow Comparisons
- **arithmetic.rs** - Pipeline arithmetic operations
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **identity.rs** - Identity transformation benchmarks
- **join.rs** - Join operations benchmarks
- **reachability.rs** - Graph reachability (includes both Timely and Differential comparisons)
- **upcase.rs** - String uppercase transformation benchmarks

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p external-benchmarks
```

Run specific benchmarks:
```bash
cargo bench -p external-benchmarks --bench reachability
cargo bench -p external-benchmarks --bench arithmetic
```

## Data Files

- **reachability_edges.txt** - Graph edge data for reachability benchmarks
- **reachability_reachable.txt** - Expected reachable nodes for validation
- **words_alpha.txt** - Word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Dependencies

These benchmarks require:
- `timely-master` (v0.13.0-dev.1) - Timely Dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential Dataflow framework
- `dfir_rs` - The main Hydro/DFIR library (from main repository)
- `criterion` - For benchmarking infrastructure

## Note

The main repository at `bigweaver-agent-canary-hydro-zeta` contains additional benchmarks that don't require external framework dependencies (futures.rs, micro_ops.rs, symmetric_hash_join.rs, words_diamond.rs).
