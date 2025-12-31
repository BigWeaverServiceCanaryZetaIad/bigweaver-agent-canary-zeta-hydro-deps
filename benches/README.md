# Microbenchmarks

Comparative benchmarks between Hydro and external dataflow frameworks (Timely Dataflow and Differential Dataflow).

This repository contains benchmarks that depend on timely and differential-dataflow, separated from the main repository to reduce dependency footprint.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench upcase
```

## Benchmarks

- `reachability.rs` - Graph reachability comparison (Hydro vs Timely vs Differential)
- `fork_join.rs` - Fork-join pattern comparison (Hydro vs Timely)
- `upcase.rs` - String transformation comparison (Hydro vs Timely)
- `join.rs` - Join operations comparison
- `arithmetic.rs` - Arithmetic operations comparison
- `fan_in.rs` - Fan-in pattern comparison
- `fan_out.rs` - Fan-out pattern comparison
- `identity.rs` - Identity operations comparison

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
