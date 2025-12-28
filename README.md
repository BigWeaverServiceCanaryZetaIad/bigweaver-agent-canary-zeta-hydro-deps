# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that depend on external frameworks like timely-dataflow and differential-dataflow, which are separated from the main hydro repository.

## Microbenchmarks

Of Hydro and other crates.

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt