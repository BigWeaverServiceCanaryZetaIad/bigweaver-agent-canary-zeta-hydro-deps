# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Contents

### Benches

The `benches` directory contains microbenchmarks for DFIR and other frameworks, including:
- Performance benchmarks using Criterion
- Comparisons with timely-dataflow and differential-dataflow
- Various benchmark scenarios (fork_join, arithmetic, reachability, etc.)

See [benches/README.md](benches/README.md) for details on running the benchmarks.