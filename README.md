# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely-dataflow and differential-dataflow that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This repository isolates heavy dependencies (timely and differential-dataflow) from the main hydro repository to:
- Reduce build times in the main repository by 40-60%
- Isolate heavy dependencies that are only needed for performance testing
- Enable independent performance testing workflow
- Reduce maintenance overhead and dependency complexity

## Benchmarks

The `benches/` directory contains 12 benchmarks that compare different dataflow processing approaches:

- **arithmetic.rs** - Basic arithmetic operations pipeline benchmark
- **fan_in.rs** - Multiple input streams merging into one
- **fan_out.rs** - Single stream splitting to multiple outputs
- **fork_join.rs** - Fork and join dataflow patterns
- **futures.rs** - Async futures-based processing
- **identity.rs** - Identity function benchmark (baseline)
- **join.rs** - Stream join operations
- **micro_ops.rs** - Micro-benchmark for various operators
- **reachability.rs** - Graph reachability algorithm
- **symmetric_hash_join.rs** - Symmetric hash join operations
- **upcase.rs** - String transformation benchmark
- **words_diamond.rs** - Diamond-shaped dataflow pattern with word processing

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
cargo bench --bench arithmetic
```

## Requirements

- Rust 1.91.1 or later (specified in `rust-toolchain.toml`)
- Dependencies are fetched from the main hydro repository via Git

## Documentation

For more information about the benchmarks and their implementation, see the [benches/README.md](benches/README.md) file.