# Hydro Test Benchmarks

This directory contains benchmark tests that were moved from the main repository's `hydro_test/src/cluster/` module.

## Files

- `src/cluster/paxos_bench.rs` - Paxos consensus protocol benchmarks
- `src/cluster/two_pc_bench.rs` - Two-phase commit protocol benchmarks

## Dependencies

These benchmarks depend on code in the main repository:
- `hydro_lang` - Core Hydro language
- `hydro_std` - Standard library including benchmark client
- Main repository's `hydro_test` module for:
  - `kv_replica.rs` - Key-value replica implementation (used by paxos_bench)
  - `paxos_with_client.rs` - Paxos protocol implementation (used by paxos_bench)
  - `two_pc.rs` - Two-phase commit protocol (used by two_pc_bench)

## Running These Benchmarks

Due to the dependencies on the main repository, these benchmarks should be run as integration tests with appropriate git or path dependencies configured.

### Option 1: As Part of Main Repository Tests

Keep these files in the main repository but in a separate feature flag:

```toml
[dependencies]
timely = { package = "timely-master", version = "0.13.0-dev.1", optional = true }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1", optional = true }

[features]
bench_with_timely = ["dep:timely", "dep:differential-dataflow"]
```

### Option 2: Use Git Dependencies

Configure `Cargo.toml` to reference the main repository:

```toml
[dependencies]
hydro_test = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta" }
```

### Option 3: Local Development

If both repositories are checked out locally:

```toml
[dependencies]
hydro_test = { path = "../bigweaver-agent-canary-hydro-zeta/hydro_test" }
```

## What These Benchmarks Test

### paxos_bench.rs

Benchmarks the Paxos consensus protocol implementation:
- Measures latency of consensus decisions
- Tests throughput under concurrent client load
- Validates correct behavior with configurable number of replicas and fault tolerance

### two_pc_bench.rs

Benchmarks the two-phase commit protocol:
- Measures commit latency
- Tests coordinator and participant performance
- Validates atomicity guarantees under load

## Integration

These benchmarks are preserved here to maintain the ability to run performance comparisons between Hydro implementations and timely/differential-dataflow implementations of the same protocols.
