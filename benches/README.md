# Timely and Differential-Dataflow Benchmarks

Benchmarks comparing Hydro performance against Timely Dataflow and Differential Dataflow.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
```

## Benchmarks

### Timely Dataflow Comparisons
- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark
- `fork_join.rs` - Fork-join pattern benchmark
- `identity.rs` - Identity operation benchmark
- `upcase.rs` - String uppercase benchmark
- `join.rs` - Join operations with different data types

### Differential Dataflow Comparisons
- `reachability.rs` - Graph reachability algorithm benchmark

## Data Files

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
