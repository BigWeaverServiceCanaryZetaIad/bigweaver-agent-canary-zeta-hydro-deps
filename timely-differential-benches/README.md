# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that use timely-dataflow and differential-dataflow dependencies for performance comparison with the main bigweaver-agent-canary-hydro-zeta repository.

## Overview

These benchmarks were migrated from the main repository to separate the timely and differential-dataflow dependencies from the core codebase while maintaining the ability to run performance comparisons.

## Running Benchmarks

### Running Timely/Differential Benchmarks Only

By default, the benchmarks run only the timely-dataflow and differential-dataflow implementations:

```bash
cargo bench -p timely-differential-benches
```

This will run benchmarks without requiring the babyflow, hydroflow, and spinachflow dependencies.

### Running Cross-Repository Comparison Benchmarks

To enable benchmarks that compare with babyflow, hydroflow, and spinachflow implementations from the main repository, use the `cross-repo-compare` feature:

```bash
# First ensure the main repository is cloned side-by-side
git clone <repository-url>/bigweaver-agent-canary-hydro-zeta.git ../bigweaver-agent-canary-hydro-zeta

# Then run with the feature flag
cargo bench -p timely-differential-benches --features cross-repo-compare
```

### Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench upcase
cargo bench -p timely-differential-benches --bench zip
```

## Benchmark Descriptions

- **arithmetic** - Arithmetic operations benchmark comparing different dataflow frameworks
- **fan_in** - Fan-in pattern benchmark for data aggregation
- **fan_out** - Fan-out pattern benchmark for data distribution
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark (data pass-through)
- **join** - Join operation benchmark
- **reachability** - Graph reachability computation benchmark
- **upcase** - String uppercase transformation benchmark
- **zip** - Zip operation benchmark

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for verification

## Cross-Repository Comparison

To compare performance between this repository and the main repository, you have two options:

### Option 1: Use the comparison script

```bash
cd ..
./scripts/compare_benchmarks.sh
```

### Option 2: Manual comparison

```bash
# Run benchmarks with cross-repo-compare feature
cargo bench --features cross-repo-compare

# The benchmarks will automatically include babyflow, hydroflow, and spinachflow implementations
# Results are saved in target/criterion/
```

## Features

- **default**: Runs only timely and differential-dataflow benchmarks
- **cross-repo-compare**: Enables benchmarks for babyflow, hydroflow, and spinachflow (requires these crates to be available as path dependencies from ../bigweaver-agent-canary-hydro-zeta)
