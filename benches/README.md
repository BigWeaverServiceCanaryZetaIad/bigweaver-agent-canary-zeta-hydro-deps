# Timely and Differential Dataflow Benchmarks

Microbenchmarks comparing Hydro (DFIR) with Timely Dataflow and Differential Dataflow.

## Overview

This package contains benchmarks that compare the performance of Hydro's dataflow implementation against:
- **Timely Dataflow**: A low-latency cyclic dataflow computational model
- **Differential Dataflow**: An incremental data processing framework built on Timely

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate the timely and differential-dataflow dependencies.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench join
```

## Available Benchmarks

### Core Operation Benchmarks
- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Multiple input streams merging
- **fan_out**: Single stream splitting to multiple outputs
- **fork_join**: Fork-join dataflow patterns
- **identity**: Simple identity/pass-through operations
- **join**: Join operations between streams
- **upcase**: String transformation operations

### Graph Algorithm Benchmarks
- **reachability**: Graph reachability algorithms comparing:
  - Timely Dataflow implementation
  - Differential Dataflow implementation
  - Hydro (DFIR) scheduled implementation
  - Hydro surface syntax implementations

## Performance Comparisons

To compare performance across repositories:

### 1. Run benchmarks in this repository (timely/differential):
```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benches --bench reachability
```

### 2. Run corresponding benchmarks in the main repository:
```bash
cd /path/to/bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench futures
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
```

### 3. Compare results:
Criterion outputs HTML reports in `target/criterion/` for detailed analysis and comparison.

## Data Files

- **reachability_edges.txt**: Graph edge data for reachability benchmarks
- **reachability_reachable.txt**: Expected reachable nodes for validation
- **words_alpha.txt**: English word list from https://github.com/dwyl/english-words

## Dependencies

Key dependencies used in these benchmarks:
- `timely`: v0.13.0-dev.1 (as timely-master)
- `differential-dataflow`: v0.13.0-dev.1 (as differential-dataflow-master)
- `criterion`: v0.5.0 (benchmarking framework)

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main Hydro framework repository containing non-timely/differential benchmarks
