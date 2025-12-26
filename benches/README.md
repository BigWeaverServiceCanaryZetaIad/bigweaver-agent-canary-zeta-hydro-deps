# Timely and Differential Dataflow Benchmarks

This repository contains benchmarks that depend on `timely` and `differential-dataflow` dependencies, which were migrated from the bigweaver-agent-canary-hydro-zeta repository to isolate external framework dependencies.

## Available Benchmarks

These benchmarks enable performance comparisons between Hydro (DFIR) and established dataflow frameworks:

- `arithmetic.rs` - Arithmetic operations benchmark using timely dataflow
- `fan_in.rs` - Fan-in pattern benchmark using timely dataflow
- `fan_out.rs` - Fan-out pattern benchmark using timely dataflow
- `fork_join.rs` - Fork-join pattern benchmark using timely dataflow
- `identity.rs` - Identity operation benchmark using timely dataflow
- `join.rs` - Join operations benchmark using timely dataflow
- `reachability.rs` - Graph reachability benchmark using differential dataflow
- `upcase.rs` - String transformation benchmark using timely dataflow

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Dependencies

This repository requires:
- `timely` (timely-master v0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1)
- `dfir_rs` and `sinktools` from the main bigweaver-agent-canary-hydro-zeta repository

## Data Files

The reachability benchmark uses the following data files:
- `reachability_edges.txt` - Graph edge data
- `reachability_reachable.txt` - Expected reachability results

## Migration Information

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to:
1. Simplify the main repository's dependency graph
2. Isolate external dataflow framework dependencies
3. Retain the ability to run performance comparisons between frameworks

For more information about the migration, see the BENCHMARK_MIGRATION.md file in the main repository.
