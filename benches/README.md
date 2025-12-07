# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that depend on `timely` and `differential-dataflow` libraries.
These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to keep
the main codebase free from these dependencies.

## Benchmarks

The following benchmarks are included:

- **arithmetic**: Benchmark for basic arithmetic operations
- **fan_in**: Tests fan-in (many-to-one) data flow patterns
- **fan_out**: Tests fan-out (one-to-many) data flow patterns
- **fork_join**: Tests fork-join parallel execution patterns
- **identity**: Simple identity/passthrough benchmark
- **join**: Tests various join operations
- **reachability**: Graph reachability benchmark using provided edge data
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
cargo bench --bench reachability
```

## Performance Comparisons

These benchmarks use Criterion, which supports baseline comparisons. To compare performance:

1. Run benchmarks and save as baseline:
   ```bash
   cargo bench -- --save-baseline before
   ```

2. Make changes to the code

3. Run benchmarks and compare to baseline:
   ```bash
   cargo bench -- --baseline before
   ```

## Dependencies

These benchmarks depend on:
- `timely-master`: The Timely Dataflow library
- `differential-dataflow-master`: The Differential Dataflow library
- `dfir_rs`: From the main bigweaver-agent-canary-hydro-zeta repository (via git dependency)
- `sinktools`: Utility tools from the main repository (via git dependency)

The git dependencies allow these benchmarks to test against the latest version of the main
repository code while keeping those dependencies isolated in this separate repository.
