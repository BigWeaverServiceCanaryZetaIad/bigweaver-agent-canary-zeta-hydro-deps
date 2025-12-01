# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and additional dependencies for the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) (Hydro) project.

## Benchmarks

The `benches` directory contains microbenchmarks comparing Hydro's DFIR with timely-dataflow and differential-dataflow implementations. These benchmarks were separated from the main repository to:

- Reduce the dependency footprint of the main repository
- Improve build times for core development
- Isolate performance testing infrastructure

### Running Benchmarks

To run all benchmarks:
```shell
cargo bench -p benches
```

To run specific benchmarks:
```shell
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

- `arithmetic` - Arithmetic operation pipelines
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures benchmarks
- `identity` - Identity/passthrough benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String transformation benchmarks
- `words_diamond` - Diamond pattern benchmarks

## Dependencies

This repository maintains dependencies on:
- `timely-dataflow` - For comparison benchmarks
- `differential-dataflow` - For comparison benchmarks
- `dfir_rs` - From the main Hydro repository (via git dependency)
- `sinktools` - From the main Hydro repository (via git dependency)

## Contributing

For general Hydro development guidelines, see the [main repository's CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md).
