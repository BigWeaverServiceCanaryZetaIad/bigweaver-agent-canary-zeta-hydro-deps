# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that have dependencies on timely and differential-dataflow. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to keep the main codebase free of these dependencies.

## Microbenchmarks

Of Hydro and other crates.

### Prerequisites

This repository requires the `bigweaver-agent-canary-hydro-zeta` repository to be present in the parent directory, as it depends on `dfir_rs` and `sinktools` from that repository.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench identity
```

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in operations benchmark
- `fan_out` - Fan-out operations benchmark
- `fork_join` - Fork-join patterns benchmark
- `futures` - Futures operations benchmark
- `identity` - Identity operations benchmark
- `join` - Join operations benchmark
- `micro_ops` - Micro operations benchmark
- `reachability` - Reachability benchmark (uses graph data)
- `symmetric_hash_join` - Symmetric hash join benchmark
- `upcase` - Upcase operations benchmark
- `words_diamond` - Words diamond benchmark

### Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
