# Microbenchmarks

Performance benchmarks comparing Hydro (DFIR) with timely and differential-dataflow.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
```

## Benchmark Data

- **words_alpha.txt** - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- **reachability_edges.txt** - Graph edges for reachability benchmarks
- **reachability_reachable.txt** - Expected reachable nodes for validation

## Performance Comparison

These benchmarks compare the performance of:
- **Hydro/DFIR** - The Dataflow Intermediate Representation runtime
- **Timely** - The Timely dataflow system
- **Differential-Dataflow** - Incremental dataflow computation

The benchmarks help track performance improvements and identify optimization opportunities across different dataflow systems.

## Adding New Benchmarks

To add a new benchmark:
1. Create a new `.rs` file in `benches/benches/`
2. Use the criterion benchmark harness
3. Add a `[[bench]]` section to `Cargo.toml` with `harness = false`
4. Include comparisons with relevant baseline implementations
