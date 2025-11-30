# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project that depend on `timely` and `differential-dataflow` packages.

## Overview

These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:
- Reduce dependency bloat in the main repository
- Improve build times for developers working on the core codebase
- Maintain the ability to run performance comparisons between Hydro and timely/differential implementations
- Separate test/benchmark code from production code

## Benchmarks Included

The following benchmarks are available:

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance
- **fork_join**: Fork-join pattern performance
- **futures**: Async futures-based operations
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase transformation
- **words_diamond**: Diamond-shaped dataflow pattern

## Running Benchmarks

### Prerequisites

This repository depends on the main Hydro repository for certain dependencies (`dfir_rs`, `sinktools`). These are fetched via git during build.

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

```bash
# Run a specific benchmark
cargo bench -p benches --bench reachability

# Run benchmarks matching a pattern
cargo bench -p benches --bench identity
```

## Dependencies

This repository requires:
- **timely-master** (0.13.0-dev.1): Timely dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1): Differential dataflow framework
- **dfir_rs**: Hydro's dataflow intermediate representation (from main repository)
- **sinktools**: Utility tools (from main repository)

## Performance Comparison

These benchmarks allow comparison of performance characteristics between:
- Hydro implementations
- Timely dataflow implementations
- Differential dataflow implementations

This helps validate that Hydro achieves competitive performance while providing its additional features and abstractions.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main Hydro repository

## Data Files

Several benchmarks use data files located in `benches/benches/`:
- `words_alpha.txt`: English word list from [dwyl/english-words](https://github.com/dwyl/english-words)
- `reachability_edges.txt`: Graph edges for reachability benchmarks
- `reachability_reachable.txt`: Expected reachability results

## License

Apache-2.0