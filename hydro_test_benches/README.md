# Hydro Test Benchmarks

This directory contains reference benchmark implementations from the hydro_test module that have been moved to the benchmarks repository.

## Files

- **paxos_bench.rs** - Benchmark implementation for the Paxos consensus protocol
- **two_pc_bench.rs** - Benchmark implementation for the Two-Phase Commit protocol

## Purpose

These files serve as reference implementations for:

1. **Performance Testing** - Measuring throughput and latency of distributed protocols
2. **Correctness Verification** - Ensuring protocol implementations maintain correctness under load
3. **Comparison** - Providing baseline implementations for performance comparisons

## Usage

These benchmark implementations depend on modules from the main Hydro repository:

- `hydro_lang` - Core Hydro language constructs
- `hydro_std::bench_client` - Benchmark client utilities
- `hydro_test::cluster::*` - Protocol implementations (paxos, two_pc, etc.)

### Running Paxos Benchmark

The Paxos benchmark tests consensus protocol performance with:
- Configurable number of clients per node
- Checkpoint frequency control
- Fault tolerance parameter (f)
- Multiple replicas

### Running Two-PC Benchmark

The Two-Phase Commit benchmark tests distributed transaction performance with:
- Configurable client load
- Multiple participants
- Coordinator coordination patterns

## Integration with Main Repository

These benchmarks reference implementations from the main repository via path dependencies. Ensure both repositories are cloned as siblings:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/      # Main repository
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
```

## Note

While these files are stored in the benchmarks repository, the actual protocol implementations (paxos, two_pc, kv_replica, etc.) remain in the main repository's `hydro_test/src/cluster/` module. This separation ensures:

- Core protocol code stays with main development
- Benchmark-specific code is isolated
- Performance testing can be done independently
- Compilation of the main repository is faster

## Related Files

- Main repository benchmarks: `hydro_test/examples/paxos.rs`, `hydro_test/examples/two_pc.rs`
- Protocol implementations: `hydro_test/src/cluster/paxos.rs`, `hydro_test/src/cluster/two_pc.rs`
- Core benchmarking utilities: `hydro_std/src/bench_client/`
