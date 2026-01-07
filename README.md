# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that are not included in the main repository.

## Benchmarks

This repository contains the timely and differential-dataflow benchmarks that were previously in the main Hydro repository. These benchmarks compare the performance of Hydro (dfir_rs) against timely-dataflow and differential-dataflow.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

### Available Benchmarks

- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark
- **fan_out** - Fan-out pattern benchmark
- **fork_join** - Fork-join pattern benchmark
- **futures** - Futures-based benchmark
- **identity** - Identity transformation benchmark
- **join** - Join operations benchmark
- **micro_ops** - Micro-operations benchmark
- **reachability** - Graph reachability benchmark
- **symmetric_hash_join** - Symmetric hash join benchmark
- **upcase** - String uppercasing benchmark
- **words_diamond** - Diamond pattern with word processing benchmark

### Performance Comparisons

These benchmarks retain the ability to run performance comparisons between:
- **Hydro (dfir_rs)** - The main Hydro dataflow framework
- **Timely Dataflow** - Low-level dataflow framework
- **Raw implementations** - Baseline comparisons using standard Rust constructs

Each benchmark typically includes multiple implementations to allow direct performance comparisons across different approaches.

### Dependencies

The benchmarks depend on:
- `dfir_rs` - The core Hydro runtime (from main repository)
- `sinktools` - Sink utilities (from main repository)
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow framework
- `criterion` - Benchmarking framework

Dependencies on the main Hydro repository are resolved via git references, ensuring benchmarks always test against the latest main branch.
