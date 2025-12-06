# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow that were moved from the main bigweaver-agent-canary-hydro-zeta repository. These benchmarks are maintained separately to avoid unnecessary dependencies in the main repository while preserving the ability to run performance comparisons.

## Benchmarks

The following benchmarks are included:

### Timely Benchmarks
- **arithmetic.rs**: Arithmetic operations pipeline benchmark
- **fan_in.rs**: Fan-in pattern benchmark
- **fan_out.rs**: Fan-out pattern benchmark
- **fork_join.rs**: Fork-join pattern benchmark
- **identity.rs**: Identity operation benchmark
- **join.rs**: Join operation benchmark
- **upcase.rs**: String uppercase benchmark

### Differential-Dataflow Benchmarks
- **reachability.rs**: Graph reachability benchmark (includes test data files)

## Running Benchmarks

To run these benchmarks:

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

These benchmarks compare the performance of timely/differential-dataflow implementations with hydroflow implementations. They help maintain visibility into relative performance characteristics across different dataflow frameworks.

## Dependencies

The benchmarks depend on:
- `timely`: For timely dataflow benchmarks
- `differential-dataflow`: For differential dataflow benchmarks
- `dfir_rs`: For DFIR/Hydroflow comparison benchmarks (referenced from the main repository via git)
- `criterion`: For benchmark harness and reporting

Note: The `dfir_rs` dependency references the main bigweaver-agent-canary-hydro-zeta repository. When running these benchmarks, they will use the latest version from the main repository's git HEAD.