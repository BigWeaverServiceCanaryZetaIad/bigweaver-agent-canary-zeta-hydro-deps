# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and tooling for the Hydro project that are separated from the main repository to isolate specific dependencies.

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks for Hydro and related frameworks. These benchmarks include dependencies on `timely` and `differential-dataflow` which are kept separate from the main Hydro codebase.

The benchmarks include:
- **arithmetic.rs** - Arithmetic operations benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **identity.rs** - Identity operation benchmarks
- **upcase.rs** - String uppercase transformation benchmarks
- **join.rs** - Join operation benchmarks
- **reachability.rs** - Graph reachability benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **words_diamond.rs** - Word processing diamond pattern benchmarks
- **futures.rs** - Futures-based benchmarks

### Usage

These benchmarks are designed to be used as part of the main Hydro repository workspace. Reference this repository from the Hydro workspace to run benchmarks with isolated dependencies.