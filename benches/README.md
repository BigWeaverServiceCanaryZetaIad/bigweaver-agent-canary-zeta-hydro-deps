# Microbenchmarks

Of Hydro and other dataflow frameworks including Timely Dataflow and Differential Dataflow.

## Running Benchmarks

This benchmarks package has been moved to the `bigweaver-agent-canary-zeta-hydro-deps` repository to separate performance comparison dependencies from the main Hydro codebase.

Run all benchmarks from the repository root:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Notes

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
