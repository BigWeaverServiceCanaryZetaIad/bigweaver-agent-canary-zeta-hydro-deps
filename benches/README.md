# Microbenchmarks

Of Hydro and other crates, including timely-dataflow and differential-dataflow.

## Available Benchmarks

### Timely Dataflow Benchmarks
- **join**: Benchmark using timely dataflow operators for hash joins
- **fork_join**: Benchmark using timely dataflow operators for fork-join patterns

### Differential Dataflow Benchmarks
- **reachability**: Benchmark using differential-dataflow operators for graph reachability

### Other Benchmarks
- arithmetic, fan_in, fan_out, identity, upcase, micro_ops, symmetric_hash_join, words_diamond, futures

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench fork_join
```

Run a specific benchmark function:
```
cargo bench -p benches --bench join -- timely
cargo bench -p benches --bench reachability -- differential
```

## Dependencies

The benchmarks use the following key dependencies:
- `timely-master` (version 0.13.0-dev.1) - for timely dataflow benchmarks
- `differential-dataflow-master` (version 0.13.0-dev.1) - for differential dataflow benchmarks
- `criterion` - for benchmark framework

## Notes

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
