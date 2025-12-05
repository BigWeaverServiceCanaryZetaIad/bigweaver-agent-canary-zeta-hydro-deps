# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely and differential-dataflow packages, which were moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid adding these dependencies to the main codebase.

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and comparison benchmarks with timely/differential-dataflow.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

- **arithmetic** - Arithmetic operation benchmarks
- **fan_in** - Fan-in pattern benchmarks
- **fan_out** - Fan-out pattern benchmarks
- **fork_join** - Fork-join pattern benchmarks
- **futures** - Async futures benchmarks
- **identity** - Identity (no-op) pipeline benchmarks
- **join** - Join operation benchmarks
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability benchmarks
- **symmetric_hash_join** - Symmetric hash join benchmarks
- **upcase** - String uppercase transformation benchmarks
- **words_diamond** - Word processing diamond pattern benchmarks

### Dependencies

These benchmarks depend on:
- `timely-master` - Timely dataflow system
- `differential-dataflow-master` - Differential dataflow computation
- `dfir_rs` - Dataflow IR from the main Hydro repository (fetched via git)
- `sinktools` - Utilities from the main Hydro repository (fetched via git)

## Performance Comparisons

These benchmarks enable performance comparisons between Hydro and timely/differential-dataflow implementations. The benchmarks are structured to test similar workloads across different frameworks.