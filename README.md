# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the bigweaver-agent-canary-hydro-zeta project.

## Microbenchmarks

This repository hosts the benchmark suite for Hydro and other crates, including benchmarks that depend on `timely` and `differential-dataflow`.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_out
```

### Available Benchmarks

The following benchmarks are available:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity transformation benchmark
- `upcase` - String uppercase benchmark
- `join` - Join operations benchmark
- `reachability` - Graph reachability benchmark
- `micro_ops` - Micro-operations benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `words_diamond` - Words diamond pattern benchmark
- `futures` - Futures-based benchmark

### Dependencies

The benchmarks require dependencies from the main `bigweaver-agent-canary-hydro-zeta` repository, which should be located in a sibling directory.

**Note:** Wordlist data is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
