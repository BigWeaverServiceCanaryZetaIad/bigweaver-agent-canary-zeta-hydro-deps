# Microbenchmarks

Timely and differential-dataflow benchmarks comparing performance with Hydro.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository 
to avoid having timely and differential-dataflow as dependencies in the main project.

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Cross-Repository Performance Comparison

To compare performance with the main bigweaver-agent-canary-hydro-zeta repository,
refer to the benchmark documentation in the main repository at:
https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
