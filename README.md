# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies and performance comparison utilities for the Hydro project, specifically for comparing against Timely Dataflow and Differential Dataflow.

## Benchmarks

The `benches` directory contains comprehensive microbenchmarks comparing Hydro (DFIR) with Timely Dataflow and Differential Dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
```

### Available Benchmarks

- **arithmetic.rs** - Pipeline arithmetic operations comparison
- **fan_in.rs** - Fan-in pattern performance
- **fan_out.rs** - Fan-out pattern performance
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Async futures performance
- **identity.rs** - Identity transformation benchmarks
- **join.rs** - Join operation comparisons
- **micro_ops.rs** - Micro-operations (map, flat_map, union, tee, fold, sort)
- **reachability.rs** - Graph reachability algorithms
- **symmetric_hash_join.rs** - Symmetric hash join performance
- **upcase.rs** - String transformation benchmarks
- **words_diamond.rs** - Diamond pattern on word processing

### Data Files

The benchmarks include supporting data files:
- `reachability_edges.txt` - Graph edge data for reachability tests
- `reachability_reachable.txt` - Expected reachable vertices
- `words_alpha.txt` - English word list from https://github.com/dwyl/english-words

### Dependencies

The benchmarks depend on:
- **dfir_rs** - The Hydro dataflow runtime
- **sinktools** - Sink utilities from the main Hydro repository
- **timely** - Timely Dataflow framework
- **differential-dataflow** - Differential Dataflow framework
- **criterion** - Statistics-driven benchmarking library

Path dependencies reference the main `bigweaver-agent-canary-hydro-zeta` repository for dfir_rs and sinktools.
