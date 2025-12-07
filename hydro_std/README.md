# Hydro Std Benchmark Client

This directory contains the benchmark client code that was moved from the main repository's `hydro_std/src/bench_client/` module.

## Files

- `src/bench_client/mod.rs` - Main benchmark client framework for distributed systems
- `src/bench_client/rolling_average.rs` - Rolling average calculation for throughput metrics

## Dependencies

This code depends on:
- `hydro_lang` - Core Hydro language runtime
- `hdrhistogram` - High dynamic range histogram for latency tracking
- `serde` - Serialization/deserialization

## Usage with Main Repository

To use this benchmark client with the main Hydro codebase, configure your `Cargo.toml` with git dependencies:

```toml
[dependencies]
hydro_lang = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", version = "^0.14.0" }
hydro_std = { path = "../hydro_std" }
```

Or reference the local path if both repositories are checked out side by side:

```toml
[dependencies]
hydro_lang = { path = "../bigweaver-agent-canary-hydro-zeta/hydro_lang", version = "^0.14.0" }
```

## Functionality

The benchmark client provides:

- **Latency Measurement** - High-precision latency histograms for transactions
- **Throughput Calculation** - Rolling average throughput over time windows
- **Concurrent Workload Generation** - Multiple virtual clients per node
- **Result Aggregation** - Distributed histogram merging across cluster

## Example

See `hydro_test/src/cluster/paxos_bench.rs` and `two_pc_bench.rs` for usage examples.
