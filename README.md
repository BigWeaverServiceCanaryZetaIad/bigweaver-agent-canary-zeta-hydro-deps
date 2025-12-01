# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code and timely/differential-dataflow dependencies that were migrated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This separate repository was created to:
- Isolate timely-dataflow and differential-dataflow dependencies from the main codebase
- Reduce compilation time for core development work
- Maintain the ability to run comprehensive performance comparisons
- Keep benchmark dependencies separate from production dependencies

## Contents

### Benchmarks (`benches/`)

Standalone microbenchmarks comparing Hydro/DFIR performance against timely-dataflow and differential-dataflow implementations.

**Available benchmarks:**
- `arithmetic` - Pipeline arithmetic operations
- `fan_in` - Fan-in pattern performance
- `fan_out` - Fan-out pattern performance
- `fork_join` - Fork-join pattern
- `identity` - Identity operation overhead
- `join` - Join operation performance
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability algorithm
- `symmetric_hash_join` - Symmetric hash join performance
- `upcase` - String transformation operations
- `words_diamond` - Diamond pattern with word processing
- `futures` - Futures-based async operations

**Running benchmarks:**

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

### Hydro Test Benchmarks (`hydro_test_benchmarks/`)

These files contain benchmark code for cluster protocols (Paxos and Two-Phase Commit) that were part of the `hydro_test` crate. See the [hydro_test_benchmarks/README.md](hydro_test_benchmarks/README.md) for details on their integration with the main repository.

## Dependencies

The benchmarks in this repository depend on:
- **timely-dataflow** (timely-master package) - Version 0.13.0-dev.1
- **differential-dataflow** (differential-dataflow-master package) - Version 0.13.0-dev.1
- **dfir_rs** - From the main hydro repository (via git dependency)
- **sinktools** - From the main hydro repository (via git dependency)
- **criterion** - For benchmarking framework

## Development Workflow

### For Performance Testing

1. Clone this repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Run benchmarks:
   ```bash
   cargo bench
   ```

### For Core Development

Core development should be done in the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. This repository is only needed when running performance comparisons against timely/differential-dataflow.

## Migration History

This repository was created as part of a dependency isolation effort. The benchmarks and timely/differential-dataflow dependencies were removed from the main repository to:
- Reduce the main repository's dependency footprint
- Speed up compilation for everyday development
- Simplify dependency management for the core project
- Provide a dedicated space for performance analysis

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro implementation

## License

Apache-2.0