# Microbenchmarks

Performance benchmarks comparing Hydro/DFIR against timely-dataflow and differential-dataflow implementations.

## Overview

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean separation of concerns and reduce compilation time. The benchmarks allow performance comparisons between different dataflow processing approaches.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Available Benchmarks

- **arithmetic** - Basic arithmetic operations across different implementations
- **fan_in** - Fan-in dataflow patterns
- **fan_out** - Fan-out dataflow patterns  
- **fork_join** - Fork-join patterns
- **futures** - Futures-based async operations
- **identity** - Identity operations (baseline)
- **join** - Join operations
- **micro_ops** - Micro-operations benchmarks
- **reachability** - Graph reachability algorithms
- **symmetric_hash_join** - Symmetric hash join operations
- **upcase** - String uppercasing operations
- **words_diamond** - Word processing diamond pattern

## Benchmark Data

- Graph data for reachability benchmarks: `reachability_edges.txt` and `reachability_reachable.txt`
- Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Performance Comparison

Each benchmark typically compares:
1. Hydro/DFIR implementation
2. Timely-dataflow implementation
3. Differential-dataflow implementation (where applicable)
4. Raw baseline implementation

Results include throughput measurements and latency characteristics, with HTML reports generated via Criterion.

## Dependencies

These benchmarks depend on:
- `dfir_rs` and `sinktools` from the main repository (referenced via git)
- `timely-master` package
- `differential-dataflow-master` package
- `criterion` for benchmarking infrastructure
