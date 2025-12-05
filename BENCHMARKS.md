# Microbenchmarks

Performance comparison benchmarks of Hydro against timely-dataflow and differential-dataflow.

## Running Benchmarks

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

## Benchmark Results

Results are saved to `target/criterion/` as HTML reports.

## Data Sources

- Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Reachability graph data is included in this repository
