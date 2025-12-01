# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for Hydro that were separated from the main repository to reduce compilation time and dependency bloat for core development.

## Contents

### Timely and Differential-Dataflow Benchmarks
- **Location**: `benches/`
- **Purpose**: Performance comparison benchmarks using timely and differential-dataflow
- **Dependencies**: timely-master, differential-dataflow-master

### Hydro Test Benchmarks
- **Location**: `hydro_test_benches/`
- **Purpose**: Cluster benchmarks for Paxos and Two-Phase Commit protocols
- **Files**:
  - `paxos_bench.rs` - Paxos consensus protocol benchmark
  - `two_pc_bench.rs` - Two-phase commit protocol benchmark

## Prerequisites

To run these benchmarks, you need:
1. Rust toolchain (see main repository for version requirements)
2. The main `bigweaver-agent-canary-hydro-zeta` repository cloned as a sibling directory

## Repository Structure

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/    # Main Hydro repository
└── bigweaver-agent-canary-zeta-hydro-deps/   # This repository (benchmarks)
```

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmarks
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Available Benchmarks
- `arithmetic` - Arithmetic operation benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async/futures benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String transformation benchmarks
- `words_diamond` - Diamond pattern benchmarks

## Rationale

This repository was created to:
1. **Reduce Compilation Time**: Core Hydro development no longer requires compiling timely and differential-dataflow
2. **Clean Separation**: Benchmark infrastructure is separated from core functionality
3. **Maintain Performance Testing**: Performance comparison capabilities are fully preserved
4. **Reduce Dependency Bloat**: Main repository has fewer heavyweight dependencies

## Integration with Main Repository

The benchmarks in this repository depend on the main Hydro repository through path dependencies:
- `dfir_rs` - Core dataflow runtime
- `sinktools` - Sink utilities

These dependencies are specified as relative paths, so both repositories must be cloned as siblings.

## Related Documentation

For more information about the benchmark migration, see:
- Main repository's `CONTRIBUTING.md`
- Main repository's documentation on performance testing

## License

Apache-2.0 (same as main Hydro repository)