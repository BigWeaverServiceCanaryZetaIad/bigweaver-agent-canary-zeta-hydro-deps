# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for Hydro that depend on timely and differential-dataflow frameworks.

## Purpose

This repository was created to separate benchmarks that require timely and differential-dataflow dependencies from the main Hydro repository. This separation helps:

1. Keep the main Hydro repository free of unnecessary dependencies
2. Reduce build times for the main repository
3. Maintain the ability to run performance comparisons with timely and differential-dataflow
4. Improve the modularity and maintainability of the codebase

## Contents

### Benchmarks

The `benches` directory contains microbenchmarks for Hydro using timely and differential-dataflow frameworks. These benchmarks provide performance comparisons and help track performance regressions.

See [benches/README.md](benches/README.md) for more information on running the benchmarks.

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench -p benches
```

To run a specific benchmark:

```bash
cargo bench -p benches --bench reachability
```

## Migration

For information about the migration of benchmarks from the main Hydro repository, see [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md).

## Related Repositories

- [Main Hydro Repository](https://github.com/hydro-project/hydro)

## License

Licensed under the Apache License, Version 2.0.