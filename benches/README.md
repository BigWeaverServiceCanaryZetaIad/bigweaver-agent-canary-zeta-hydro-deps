# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that depend on timely and differential-dataflow packages, which were moved from the main bigweaver-agent-canary-hydro-zeta repository to reduce build dependencies.

## Benchmarks

The following benchmarks compare Hydro implementations with Timely/Differential-Dataflow implementations:

- `arithmetic.rs` - Arithmetic operations benchmark (uses timely)
- `fan_in.rs` - Fan-in operations benchmark (uses timely)
- `fan_out.rs` - Fan-out operations benchmark (uses timely)
- `fork_join.rs` - Fork-join pattern benchmark (uses timely)
- `identity.rs` - Identity operations benchmark (uses timely)
- `join.rs` - Join operations benchmark (uses timely)
- `reachability.rs` - Graph reachability benchmark (uses differential-dataflow)
- `upcase.rs` - String transformation benchmark (uses timely)

### Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for reachability benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

## Performance Comparisons

These benchmarks are designed to enable performance comparisons between:
- Hydro/DFIR implementations
- Timely Dataflow implementations
- Differential Dataflow implementations

Results are generated using criterion and stored in `target/criterion/` with HTML reports for easy visualization.

## Dependencies

This package depends on:
- `timely` (timely-master) - For timely dataflow benchmarks
- `differential-dataflow` (differential-dataflow-master) - For differential dataflow benchmarks
- `dfir_rs` - For Hydro/DFIR implementations
- `criterion` - For benchmarking framework

## Relationship to Main Repository

These benchmarks were separated from [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) to:
- Reduce build dependencies and build times in the main repository
- Isolate timely and differential-dataflow dependencies
- Maintain the ability to run performance comparisons when needed
- Improve maintainability by separating concerns

The main repository still contains Hydro-native benchmarks that don't require external dependencies.
