# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for Hydro that depend on timely-dataflow and differential-dataflow.

## Benchmarks

The `benches` directory contains microbenchmarks for Hydro and other crates. These benchmarks were moved here from the main repository to isolate the timely-dataflow and differential-dataflow dependencies.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

### Available Benchmarks

- **arithmetic** - Arithmetic operation benchmarks
- **fan_in** - Fan-in operation benchmarks
- **fan_out** - Fan-out operation benchmarks
- **fork_join** - Fork-join pattern benchmarks
- **futures** - Futures-based operation benchmarks
- **identity** - Identity operation benchmarks
- **join** - Join operation benchmarks
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **upcase** - String uppercase benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks

### Dependencies

The benchmarks depend on:
- `dfir_rs` - From the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - From the main bigweaver-agent-canary-hydro-zeta repository
- `timely-dataflow` - Timely dataflow processing framework
- `differential-dataflow` - Differential dataflow processing framework
- `criterion` - Benchmarking framework

### Notes

- The wordlist used in word-processing benchmarks is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- The benchmarks reference the main repository via relative paths (`../../bigweaver-agent-canary-hydro-zeta`)
- Make sure the main repository is cloned alongside this repository for the benchmarks to work correctly