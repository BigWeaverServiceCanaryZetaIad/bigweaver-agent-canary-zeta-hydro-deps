# Microbenchmarks

Performance benchmarks comparing Hydro/DFIR to Timely Dataflow and Differential Dataflow.

This repository contains benchmarks that compare Hydro/DFIR performance against established dataflow frameworks (Timely Dataflow and Differential Dataflow). The benchmarks are maintained separately to isolate the timely and differential-dataflow dependencies from the main Hydro repository.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Benchmark Categories

The benchmarks include:
- **Graph algorithms**: reachability
- **Join operations**: join, symmetric_hash_join
- **Micro-operations**: arithmetic, fan_in, fan_out, fork_join, identity, upcase, micro_ops
- **Complex patterns**: words_diamond, futures

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
