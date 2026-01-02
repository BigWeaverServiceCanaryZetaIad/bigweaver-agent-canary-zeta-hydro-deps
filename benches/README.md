# Microbenchmarks

Of Hydro and other crates.

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Note

This benchmark package references dependencies from the `bigweaver-agent-canary-hydro-zeta` repository using relative paths:
- `dfir_rs`: `../../bigweaver-agent-canary-hydro-zeta/dfir_rs`
- `sinktools`: `../../bigweaver-agent-canary-hydro-zeta/sinktools`

Ensure both repositories are cloned in the same parent directory for the benchmarks to work correctly.

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
