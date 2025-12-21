# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that use timely-dataflow and differential-dataflow dependencies for performance comparison with the main bigweaver-agent-canary-hydro-zeta repository.

# Timely and Differential Dataflow Benchmarks

This directory contains **only timely-dataflow and differential-dataflow** benchmark implementations that were extracted from the main bigweaver-agent-canary-hydro-zeta repository.

## Overview

These benchmarks were migrated from the main repository (commit 513b2091) to separate the timely and differential-dataflow dependencies from the core codebase. **All other framework implementations (babyflow, spinachflow, hydroflow, baseline) have been removed** to keep this repository focused solely on timely and differential-dataflow performance testing.

## Benchmark Implementations

Each benchmark file contains **only** the timely-dataflow implementation (and differential-dataflow where applicable):

- **arithmetic** - Arithmetic operations using timely-dataflow map operators
- **fan_in** - Fan-in pattern using timely-dataflow concatenate operator
- **fan_out** - Fan-out pattern using timely-dataflow clone and map
- **fork_join** - Fork-join pattern using timely-dataflow filter and concatenate
- **identity** - Identity operation using timely-dataflow map
- **join** - Hash join operation using timely-dataflow binary operator
- **reachability** - Graph reachability using timely-dataflow iterative computation
- **upcase** - String transformation using timely-dataflow map operators
- **zip** - Placeholder (timely doesn't have native zip operator)

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p timely-differential-benches
```

### Run Specific Benchmarks
```bash
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench upcase
```

### View Results
Benchmark results are saved in `target/criterion/` directory. Open `target/criterion/report/index.html` in a browser to view detailed HTML reports.

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark (55,008 edges)
- `reachability_reachable.txt` - Expected reachable nodes for verification (7,855 nodes)

## Cross-Repository Comparison

To compare performance between this repository and the main repository, use the comparison script in the parent directory:

```bash
cd ..
./scripts/compare_benchmarks.sh
```
