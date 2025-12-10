# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow packages. These were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies.

## Contents

### Benchmarks

The `benches/` directory contains microbenchmarks that require timely and differential-dataflow:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity transformation benchmark
- `join` - Join operations benchmark
- `reachability` - Graph reachability benchmark
- `upcase` - Uppercase transformation benchmark

See [benches/README.md](benches/README.md) for more details on running benchmarks.

## Performance Comparisons

This repository retains the ability to run performance comparisons with the main repository. Benchmarks in both repositories use the same criterion framework and can be compared by running benchmarks separately and analyzing the results.