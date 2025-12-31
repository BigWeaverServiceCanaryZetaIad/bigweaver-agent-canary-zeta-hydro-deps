# Microbenchmarks

Of Hydro and other crates.

This benchmark suite has been relocated to the `bigweaver-agent-canary-zeta-hydro-deps` repository to maintain separation of concerns and avoid including `timely` and `differential-dataflow` dependencies in the main `bigweaver-agent-canary-hydro-zeta` repository.

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
