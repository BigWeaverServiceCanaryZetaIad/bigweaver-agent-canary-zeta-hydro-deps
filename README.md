# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro (from the main `bigweaver-agent-canary-hydro-zeta` repository) with timely-dataflow and differential-dataflow implementations.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench upcase
```

## Benchmark Data Sources

- **reachability**: Uses graph data from `reachability_edges.txt` and `reachability_reachable.txt`

## Integration with Main Repository

These benchmarks provide performance comparisons between Hydro implementations (in the main repository) and timely/differential-dataflow implementations (in this repository), enabling developers to evaluate performance differences between the frameworks.
