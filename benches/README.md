# Microbenchmarks

Timely and differential-dataflow benchmarks for Hydro and other crates.

**Note**: These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to isolate timely/differential-dataflow dependencies while maintaining the ability to run performance comparisons.

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

