# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for performance comparison between Hydro and timely/differential-dataflow.

## Benchmarks

The `benches` directory contains performance benchmarks that compare Hydro implementations with timely and differential-dataflow implementations:

- **fork_join.rs** - Fork-join pattern benchmarks (timely)
- **upcase.rs** - String uppercase transformation benchmarks (timely)
- **reachability.rs** - Graph reachability computation benchmarks (differential-dataflow)
- **words_diamond.rs** - Word processing diamond pattern benchmarks
- **join.rs** - Join operation benchmarks
- **arithmetic.rs** - Basic arithmetic operation benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **identity.rs** - Identity transformation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **futures.rs** - Futures-based operation benchmarks

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench fork_join
cargo bench --bench reachability
```

## Dependencies

The benchmarks reference `dfir_rs` and `sinktools` from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository via git dependencies, ensuring they always use the latest compatible versions.