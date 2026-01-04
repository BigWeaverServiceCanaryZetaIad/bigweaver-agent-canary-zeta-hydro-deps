# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external framework benchmarks and dependencies for the Hydro project.

## Benchmarks

This repository includes microbenchmarks for Hydro and other crates, including benchmarks that use timely and differential-dataflow operators.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
cargo bench -p benches --bench join
```

### Benchmark Contents

The `benches` directory contains:
- **timely dataflow benchmarks**: `upcase.rs`, `join.rs` - benchmarks using timely dataflow operators
- **differential-dataflow benchmarks**: `reachability.rs` - benchmarks using differential-dataflow operators
- Various other performance tests for the Hydro framework

### Dependencies

This repository includes dependencies on:
- `timely` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)
- `dfir_rs` from the main Hydro repository
- `sinktools` from the main Hydro repository

### Notes

The benchmarks in this repository have been separated from the main Hydro repository to avoid introducing unnecessary dependencies into the core codebase while maintaining the ability to run performance comparisons.

Wordlist data is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
