# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that depend on `timely` and `differential-dataflow`. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid including these dependencies in the main codebase.

## Benchmarks

This repository includes the following benchmarks:

- **arithmetic**: Pipeline arithmetic operations benchmark
- **fan_in**: Fan-in dataflow pattern benchmark
- **fan_out**: Fan-out dataflow pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **join**: Join operations benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String uppercase transformation benchmark

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:

```bash
cargo bench --bench arithmetic
```

## Performance Comparisons

This repository retains the ability to run performance comparisons using Criterion's baseline comparison features. To save a baseline:

```bash
cargo bench -- --save-baseline <baseline_name>
```

To compare against a baseline:

```bash
cargo bench -- --baseline <baseline_name>
```

## Dependencies

This repository depends on:
- `timely-master`: For timely dataflow operations
- `differential-dataflow-master`: For differential dataflow operations
- `dfir_rs`: Core Hydro DFIR runtime (from main repository)

## Relation to Main Repository

These benchmarks were originally in the `bigweaver-agent-canary-hydro-zeta` repository but were moved here to:
1. Reduce dependencies in the main repository
2. Keep the main codebase cleaner and more maintainable
3. Maintain the ability to run performance comparisons for timely/differential-based code

The main repository retains benchmarks that don't depend on timely/differential-dataflow.