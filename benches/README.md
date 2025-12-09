# Hydro Microbenchmarks

Performance benchmarks comparing Hydro implementations with timely-dataflow and differential-dataflow.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench upcase
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench futures
```

## Benchmark Descriptions

### Performance Comparison Benchmarks

These benchmarks compare Hydro's performance against timely-dataflow and differential-dataflow:

- **identity**: Tests basic data flow through the system
- **arithmetic**: Tests arithmetic operations on data streams
- **fan_in**: Tests multiple input streams merging into one
- **fan_out**: Tests broadcasting data to multiple output streams
- **fork_join**: Tests parallel processing patterns
- **join**: Tests stream join operations
- **reachability**: Tests graph reachability algorithms (uses external data files)
- **upcase**: Tests simple string transformation operations

### Hydro-Specific Benchmarks

These benchmarks test Hydro-specific features:

- **symmetric_hash_join**: Tests symmetric hash join implementation
- **words_diamond**: Tests diamond-shaped dataflow patterns
- **micro_ops**: Tests low-level operation performance
- **futures**: Tests async/await integration

## Data Files

Some benchmarks require external data files:
- `reachability_edges.txt`: Edge list for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes
- `words_alpha.txt`: English word list for string processing benchmarks

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Benchmark Results

Results are generated in `target/criterion/` and can be viewed as HTML reports.
