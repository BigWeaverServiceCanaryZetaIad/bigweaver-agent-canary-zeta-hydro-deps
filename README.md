# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that depend on `timely` and `differential-dataflow`. These benchmarks have been separated from the main repository to keep those dependencies isolated.

## Benchmarks

The `/benches` directory contains microbenchmarks for Hydro and related crates, including benchmarks that use `timely` and `differential-dataflow`.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

### Available Benchmarks

- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `reachability` - Graph reachability benchmarks
- `arithmetic` - Arithmetic operation benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Futures-based operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase operation benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

### Data Sources

- Wordlist: https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Integration with Main Repository

This repository references the main `bigweaver-agent-canary-hydro-zeta` repository for the `dfir_rs` and `sinktools` dependencies. Both repositories should be cloned in the same parent directory for the benchmarks to work correctly:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Performance Comparisons

To run performance comparisons between different implementations:

1. Ensure both repositories are up to date
2. Run benchmarks in this repository: `cargo bench -p benches`
3. Compare results with historical data or across different branches
4. Benchmark results are stored in `target/criterion/` directory