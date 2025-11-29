# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on `timely` and `differential-dataflow` packages.

These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain cleaner dependency management and prevent unnecessary dependencies in the core project.

## Microbenchmarks

Performance benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

### Available Benchmarks

- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in communication patterns
- `fan_out` - Fan-out communication patterns
- `fork_join` - Fork-join patterns
- `futures` - Async futures benchmarks
- `identity` - Identity/passthrough operations
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join implementation
- `upcase` - String uppercase transformation
- `words_diamond` - Diamond pattern word processing

## Dependencies

This crate depends on:
- `timely-master` - Timely Dataflow library
- `differential-dataflow-master` - Differential Dataflow library
- `dfir_rs` - From the main repository
- `sinktools` - From the main repository

## References

- Wordlist used in benchmarks: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Main Hydro repository: https://github.com/hydro-project/hydro
