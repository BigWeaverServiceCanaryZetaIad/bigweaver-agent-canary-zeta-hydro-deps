# Benchmark Migration Guide

## Overview

This document describes the migration of benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository. This migration supports cleaner separation of concerns by isolating benchmark code and its dependencies from the main agent codebase.

## What Was Moved

### Benchmark Files
The following benchmark implementations were moved from `hydro_test` to the new `hydro_benchmarks` crate:

- **Paxos Benchmark** (`paxos_bench.rs`): Benchmarks for Paxos consensus protocol
- **Two-Phase Commit Benchmark** (`two_pc_bench.rs`): Benchmarks for 2PC transaction protocol

### Supporting Infrastructure
The following support modules were also moved from `hydro_std` and `hydro_test`:

- **Benchmark Client Framework** (`bench_client/`): Core benchmarking infrastructure including:
  - Client workload generation
  - Latency measurement with histograms
  - Throughput tracking with rolling averages
  - Result aggregation and printing

- **Protocol Implementations**:
  - `paxos.rs`: Core Paxos protocol implementation
  - `two_pc.rs`: Two-phase commit protocol
  - `paxos_with_client.rs`: Paxos with client interaction traits
  - `kv_replica.rs`: Key-value store replica for benchmarking

- **Utility Modules**:
  - `quorum.rs`: Quorum collection utilities
  - `membership.rs`: Cluster membership tracking
  - `request_response.rs`: Request-response pattern utilities

- **Test Snapshots**:
  - `snapshots/`: Snapshot tests for benchmark correctness
  - `snapshots-nightly/`: Nightly-specific snapshots

## Repository Structure

### New Repository: `bigweaver-agent-canary-zeta-hydro-deps`

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                          # Workspace configuration
├── README.md                           # Repository overview
├── BENCHMARK_MIGRATION.md              # This file
├── BENCHMARKS.md                       # Benchmark usage guide
└── hydro_benchmarks/
    ├── Cargo.toml                      # Benchmark crate configuration
    ├── build.rs                        # Build script
    └── src/
        ├── lib.rs                      # Library root
        ├── bench_client/               # Benchmarking framework
        │   ├── mod.rs
        │   └── rolling_average.rs
        ├── cluster/                    # Benchmark implementations
        │   ├── mod.rs
        │   ├── paxos_bench.rs
        │   ├── two_pc_bench.rs
        │   ├── paxos.rs
        │   ├── two_pc.rs
        │   ├── paxos_with_client.rs
        │   ├── kv_replica.rs
        │   ├── kv_replica/
        │   ├── snapshots/
        │   └── snapshots-nightly/
        ├── membership.rs
        ├── quorum.rs
        └── request_response.rs
```

## Running Benchmarks

### Prerequisites

Benchmarks require the following dependencies from the main Hydro project:
- `hydro_lang` (version ^0.14.0)
- `hydro_std` (version ^0.14.0)  
- `hydro_deploy` (version ^0.14.0, dev-dependencies)
- `dfir_lang` (version ^0.14.0, dev-dependencies)
- `dfir_rs` (version ^0.14.0, dev-dependencies)

### Performance Comparison

To maintain the ability to run performance comparisons between versions:

1. **Building Benchmarks**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build --release
   ```

2. **Running Specific Benchmarks**:
   ```bash
   # Run Paxos benchmark tests
   cargo test --package hydro_benchmarks paxos_bench

   # Run Two-PC benchmark tests
   cargo test --package hydro_benchmarks two_pc_bench
   ```

3. **Viewing Benchmark Results**:
   Benchmark results include:
   - Latency histograms (p50, p99, p999)
   - Throughput measurements (requests/second)
   - Rolling average statistics

### Cross-Repository Comparisons

To compare performance across different versions:

1. Check out the desired version in the main repository
2. Build and run the corresponding version's benchmarks
3. Compare results using the output metrics

## Migration Impact

### Removed from Main Repository

The following were removed from `bigweaver-agent-canary-hydro-zeta`:

- `hydro_test/src/cluster/paxos_bench.rs`
- `hydro_test/src/cluster/two_pc_bench.rs`
- `hydro_std/src/bench_client/` (directory)

Note: The main `hydro_test` and `hydro_std` crates remain in the source repository for non-benchmark functionality.

### Benefits of Migration

1. **Cleaner Codebase**: Main repository no longer contains benchmark-specific code
2. **Reduced Dependencies**: Benchmark dependencies (e.g., `hdrhistogram`) isolated
3. **Independent Evolution**: Benchmarks can evolve without affecting main codebase
4. **Focused Repository**: Clear separation between production code and performance testing

## Development Workflow

### Adding New Benchmarks

1. Add new benchmark implementations in `hydro_benchmarks/src/cluster/`
2. Update `hydro_benchmarks/src/cluster/mod.rs` to include the new module
3. Ensure proper use of the `bench_client` framework for consistency
4. Add tests to verify benchmark correctness
5. Update `BENCHMARKS.md` with usage documentation

### Updating Dependencies

When updating Hydro dependencies:
1. Update version numbers in `hydro_benchmarks/Cargo.toml`
2. Test benchmarks against the new version
3. Update any API changes in benchmark code
4. Verify performance comparisons still work

## Troubleshooting

### Common Issues

1. **Missing Dependencies**: Ensure the main Hydro crates are available (published or via path)
2. **Import Errors**: Check that module paths use `crate::` instead of `hydro_std::` or `hydro_test::`
3. **Snapshot Test Failures**: May occur when Hydro internals change; regenerate with `UPDATE_SNAPSHOTS=1`

### Getting Help

For questions or issues:
- Check `BENCHMARKS.md` for detailed usage instructions
- Review test cases in benchmark files for examples
- Consult the main Hydro documentation at https://hydro.run

## Version History

- **v0.0.0** (Current): Initial migration of benchmarks from main repository
  - Moved Paxos and Two-PC benchmarks
  - Established independent benchmark crate
  - Created migration documentation
