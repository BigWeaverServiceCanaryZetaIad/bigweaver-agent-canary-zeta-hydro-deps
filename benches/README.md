# Microbenchmarks

Performance benchmarks comparing Hydro with timely and differential-dataflow implementations.

## Overview

This directory contains benchmarks that demonstrate the performance characteristics of:
- **Hydro (dfir_rs)** - The Hydro dataflow runtime
- **Timely Dataflow** - Used in benchmarks like fork_join, upcase
- **Differential Dataflow** - Used in benchmarks like reachability

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench fork_join
cargo bench --bench upcase
```

## Benchmark Files

- **fork_join.rs** - Fork-join pattern comparison
- **upcase.rs** - String uppercase transformation
- **reachability.rs** - Graph reachability computation (differential-dataflow)
- **words_diamond.rs** - Word processing diamond pattern
- **join.rs** - Join operations
- **arithmetic.rs**, **fan_in.rs**, **fan_out.rs**, **identity.rs** - Various dataflow patterns
- **micro_ops.rs** - Micro-operations
- **symmetric_hash_join.rs** - Symmetric hash join operations
- **futures.rs** - Futures-based operations

## Data Files

- **words_alpha.txt** - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- **reachability_edges.txt** - Graph edges for reachability benchmarks
- **reachability_reachable.txt** - Expected reachable nodes
