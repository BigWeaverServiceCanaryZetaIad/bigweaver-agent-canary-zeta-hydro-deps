# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks with dependencies on `timely-dataflow` and `differential-dataflow` packages that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

The benchmarks in this repository enable performance comparison between DFIR/Hydro implementations and Timely/Differential-Dataflow implementations. By isolating these benchmarks with their specific dependencies, we:

- Reduce build dependencies and improve build times in the main repository
- Maintain the ability to run performance comparisons
- Keep the main codebase clean of unnecessary external dependencies

## Benchmarks

The following benchmarks are included:

- **arithmetic**: Arithmetic operations benchmark
- **fan_in**: Fan-in pattern benchmark  
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operation benchmark
- **join**: Join operation benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String uppercase operation benchmark

## Running Benchmarks

To run the benchmarks:

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

## Dependencies

This repository depends on:
- `timely-master` (timely-dataflow)
- `differential-dataflow-master` 
- `dfir_rs` and `sinktools` from the main repository (referenced via git)

## Related Documentation

For more information about the benchmark migration, see the main repository's documentation.