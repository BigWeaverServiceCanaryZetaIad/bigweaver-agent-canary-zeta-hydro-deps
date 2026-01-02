# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that have been isolated from the main 
[bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) 
repository to avoid dependency conflicts.

## Contents

### `benches/`

Microbenchmarks for DFIR and comparison with other dataflow frameworks (Timely Dataflow and Differential Dataflow).

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench micro_ops
```

#### Benchmarks Included

- **arithmetic.rs** - Arithmetic operation benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join operation benchmarks
- **futures.rs** - Futures/async operation benchmarks
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks (map, flat_map, union, tee, fold, sort, etc.)
- **reachability.rs** - Graph reachability algorithm benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String upper-case operation benchmarks
- **words_diamond.rs** - Word processing diamond pattern benchmarks

## Dependencies

The benchmarks depend on:
- **timely-master** (version 0.13.0-dev.1) - For Timely Dataflow comparisons
- **differential-dataflow-master** (version 0.13.0-dev.1) - For Differential Dataflow comparisons
- **dfir_rs** - From the main Hydro repository (via git)
- **sinktools** - From the main Hydro repository (via git)
- **criterion** - For benchmarking infrastructure