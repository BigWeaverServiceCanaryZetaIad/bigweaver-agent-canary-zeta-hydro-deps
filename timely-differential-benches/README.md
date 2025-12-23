# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that use timely-dataflow and differential-dataflow dependencies for performance comparison with the main bigweaver-agent-canary-hydro-zeta repository.

## Overview

These benchmarks were migrated from the main repository to separate the timely and differential-dataflow dependencies from the core codebase while maintaining the ability to run performance comparisons.

## Running Benchmarks

### Quick Start

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

**Note**: By default, only timely-dataflow and differential-dataflow benchmark variants will run. Some benchmarks include additional comparison variants (babyflow, hydroflow, spinachflow) that require path dependencies to be uncommented in Cargo.toml.

### Run All Benchmarks

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

## Enabling Cross-Framework Comparisons

Some benchmarks include variants that compare timely/differential-dataflow against other dataflow implementations (babyflow, hydroflow, spinachflow). These variants are disabled by default because they require path dependencies from the main repository.

To enable cross-framework comparisons:

1. Ensure the main `bigweaver-agent-canary-hydro-zeta` repository is cloned side-by-side:
   ```bash
   ls ../../bigweaver-agent-canary-hydro-zeta
   ```

2. Edit `Cargo.toml` in this directory and uncomment these lines:
   ```toml
   # babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
   # hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
   # spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
   ```

3. Run benchmarks normally:
   ```bash
   cargo bench -p timely-differential-benches
   ```

This will enable additional benchmark variants like `arithmetic/babyflow`, `arithmetic/hydroflow/compiled`, etc.
