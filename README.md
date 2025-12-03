# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow` packages, which have been separated from the main Hydro repository to reduce dependency bloat and improve build times.

## Contents

### Benches
Microbenchmarks for Hydro and related dataflow systems that depend on timely and differential-dataflow.

See [benches/README.md](benches/README.md) for more information on running benchmarks.

## Performance Comparison

These benchmarks can be used to compare the performance of Hydro against timely/differential-dataflow implementations. The benchmarks maintain compatibility with performance testing workflows used in the main Hydro repository.

## Related Repositories

- Main Hydro Repository: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow