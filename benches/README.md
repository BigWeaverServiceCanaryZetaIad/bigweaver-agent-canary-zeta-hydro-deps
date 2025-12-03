# Microbenchmarks

Performance benchmarks comparing Hydro with timely and differential-dataflow implementations.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench identity
cargo bench --bench join
```

## Benchmark Descriptions

See [BENCHMARK_GUIDE.md](../BENCHMARK_GUIDE.md) in the root directory for detailed information about each benchmark and how to run performance comparisons.

## Data Sources

- Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Reachability edges and reachable nodes are generated test data

## Dependencies

These benchmarks depend on:
- timely-master (0.13.0-dev.1)
- differential-dataflow-master (0.13.0-dev.1)
- dfir_rs (from main repository)
- sinktools (from main repository)

Dependencies are fetched from the main repository via git to ensure version compatibility.
