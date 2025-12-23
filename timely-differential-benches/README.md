# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that use timely-dataflow and differential-dataflow dependencies for performance comparison with the main bigweaver-agent-canary-hydro-zeta repository.

## Overview

These benchmarks were migrated from the main repository to separate the timely and differential-dataflow dependencies from the core codebase while maintaining the ability to run performance comparisons.

## Running Benchmarks

### Prerequisites

The benchmarks compare timely/differential-dataflow performance with babyflow, hydroflow, and spinachflow implementations. You need:

1. This repository (bigweaver-agent-canary-zeta-hydro-deps)
2. The main bigweaver-agent-canary-hydro-zeta repository (for babyflow/hydroflow/spinachflow)

### Setup

Clone both repositories side-by-side:
```bash
# Clone repositories in the same parent directory
git clone <url>/bigweaver-agent-canary-hydro-zeta.git
git clone <url>/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

Configure path dependencies in `timely-differential-benches/Cargo.toml` by uncommenting:
```toml
babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
```

### Running

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
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

To compare performance between this repository and the main repository, use the comparison script in the parent directory:

```bash
cd ..
./scripts/compare_benchmarks.sh
```
