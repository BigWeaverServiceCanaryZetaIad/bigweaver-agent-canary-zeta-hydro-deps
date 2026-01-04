# Microbenchmarks

Of Hydro and other crates.

This benchmarks directory has been migrated from the main bigweaver-agent-canary-hydro-zeta repository to support independent benchmark management and reduce build dependencies in the main codebase.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

## Benchmarks Included

- `identity.rs` - Benchmarks comparing Hydro with Timely performance
- `join.rs` - Join operation benchmarks for Timely
- `reachability.rs` - Benchmarks using differential dataflow operators
- Additional benchmarks for various operations (arithmetic, fan_in, fan_out, fork_join, etc.)

## Data Sources

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
