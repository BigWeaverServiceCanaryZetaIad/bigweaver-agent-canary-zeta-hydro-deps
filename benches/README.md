# Microbenchmarks

Of Hydro and other dataflow frameworks (timely, differential-dataflow).

**Note**: These benchmarks have been moved from the main bigweaver-agent-canary-hydro-zeta repository to this separate repository to avoid adding timely and differential-dataflow as dependencies in the main codebase.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Performance Comparisons

These benchmarks compare Hydro's performance with timely and differential-dataflow implementations to ensure competitive performance and identify optimization opportunities.
