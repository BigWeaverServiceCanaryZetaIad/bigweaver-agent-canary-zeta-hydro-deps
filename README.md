# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely-dataflow and differential-dataflow packages.

These components were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce dependencies in the main codebase while maintaining the ability to run performance comparisons.

## Contents

### Benchmarks

The `benches/` directory contains microbenchmarks that use timely-dataflow and differential-dataflow:

- **arithmetic** - Basic arithmetic operations benchmark
- **fan_in** - Fan-in dataflow pattern benchmark
- **fan_out** - Fan-out dataflow pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark
- **join** - Join operation benchmark
- **reachability** - Graph reachability benchmark (uses differential-dataflow)
- **upcase** - String uppercase transformation benchmark

For more details, see [benches/README.md](benches/README.md).

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability
```

## Performance Comparisons

To compare performance between this repository and the main repository:

1. Clone both repositories
2. Run benchmarks in each repository
3. Use Criterion's comparison features to analyze the results

## Migration Notes

These benchmarks were moved from the main repository to:
- Reduce the dependency footprint of the main Hydro repository
- Maintain separate build and test cycles for timely/differential-dependent code
- Allow independent versioning and updates of heavy dependencies

The main repository retains benchmarks that only depend on the core DFIR runtime.