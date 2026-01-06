# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project that depend on Timely and Differential Dataflow frameworks. These benchmarks were moved here to isolate heavy dependencies from the main Hydro repository.

## Microbenchmarks

Benchmarks comparing Hydro/DFIR with other dataflow frameworks like Timely Dataflow and Differential Dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks  
- `fork_join` - Fork-join pattern benchmarks
- `identity` - Identity operation benchmarks
- `upcase` - String uppercase benchmarks
- `join` - Join operations benchmarks
- `reachability` - Graph reachability benchmarks
- `micro_ops` - Micro-operations benchmarks (map, flat_map, union, etc.)
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks
- `futures` - Futures-based operations benchmarks

### Dependencies

These benchmarks depend on:
- `dfir_rs` - The main DFIR runtime package
- `timely` - Timely Dataflow framework
- `differential-dataflow` - Differential Dataflow framework
- `criterion` - Benchmarking framework

Wordlist data is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
