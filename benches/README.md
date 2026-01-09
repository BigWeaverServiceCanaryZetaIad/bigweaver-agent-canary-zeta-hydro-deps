# Microbenchmarks

Of Hydro and other crates.

**Note**: These benchmarks are designed to be run from the main Hydro repository workspace. 
To use these benchmarks, clone or reference this repository from the Hydro workspace.

Run all benchmarks from the Hydro repository:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
