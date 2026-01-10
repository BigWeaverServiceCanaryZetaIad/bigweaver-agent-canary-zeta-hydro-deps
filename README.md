# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid dependency pollution.

## Purpose

This repository hosts performance comparison benchmarks that depend on external dataflow frameworks (timely-dataflow and differential-dataflow). By separating these benchmarks, the main Hydro repository remains focused on core functionality without requiring these additional dependencies.

## Contents

### Benchmarks

The `benches/` directory contains performance comparison benchmarks:

- **arithmetic**: Pipeline arithmetic operations using timely-dataflow
- **fan_in**: Fan-in pattern benchmarks using timely-dataflow
- **fan_out**: Fan-out pattern benchmarks using timely-dataflow
- **fork_join**: Fork-join pattern benchmarks using timely-dataflow
- **identity**: Identity transformation benchmarks using timely-dataflow
- **join**: Join operation benchmarks using timely-dataflow
- **reachability**: Graph reachability benchmarks using differential-dataflow
- **upcase**: String uppercase transformation benchmarks using timely-dataflow

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench -p benches
```

To run a specific benchmark:

```bash
cargo bench -p benches --bench reachability
```

To run benchmarks with specific parameters:

```bash
cargo bench -p benches --bench arithmetic -- --sample-size 100
```

## Performance Comparisons

These benchmarks enable performance comparisons between Hydro and other dataflow frameworks (timely-dataflow, differential-dataflow). The results help validate Hydro's performance characteristics and identify optimization opportunities.

## Dependencies

This repository references the main Hydro repository via git dependencies to access `dfir_rs` and `sinktools` crates needed for benchmarking.

## Contributing

When adding new benchmarks that require external framework dependencies:

1. Add the benchmark files to the `benches/benches/` directory
2. Update `benches/Cargo.toml` with the new benchmark definition
3. Document the benchmark purpose in this README
4. Ensure benchmarks include both Hydro and comparison framework implementations

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository