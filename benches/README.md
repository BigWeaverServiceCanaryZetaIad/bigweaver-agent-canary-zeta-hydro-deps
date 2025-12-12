# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks for timely-dataflow and differential-dataflow.
These benchmarks have been moved here from the main Hydro repository to avoid
introducing timely and differential-dataflow as dependencies in the main codebase.

## Purpose

These benchmarks serve as reference implementations for comparing Hydro's performance
against timely-dataflow and differential-dataflow. They can be used to:

- Establish baseline performance metrics for various dataflow patterns
- Compare Hydro implementations against established streaming frameworks
- Validate performance improvements in Hydro

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench upcase
```

## Benchmark Descriptions

- **arithmetic**: Simple arithmetic operations in a dataflow
- **fan_in**: Multiple input streams merging into one
- **fan_out**: Single stream splitting into multiple outputs
- **fork_join**: Fork-join pattern with filtering
- **identity**: Identity transformation (pass-through)
- **join**: Stream join operations
- **reachability**: Graph reachability using differential-dataflow
- **upcase**: String transformation operations

## Cross-Repository Comparison

To compare these benchmarks with equivalent Hydro implementations:

1. Run benchmarks in this repository to get timely/differential baseline:
   ```bash
   cargo bench --bench <benchmark_name> > results_timely.txt
   ```

2. Run equivalent benchmarks in the main Hydro repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches --bench <benchmark_name> > results_hydro.txt
   ```

3. Compare the results from both outputs

## Data Files

- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes
- Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
