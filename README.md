# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that require timely and differential-dataflow.

## Structure

* `benches` - Microbenchmarks for DFIR and other frameworks including timely and differential-dataflow comparisons.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

See the [benches README](benches/README.md) for more information about the available benchmarks.