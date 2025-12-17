# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains Timely and Differential-Dataflow benchmarks for performance comparison with Hydro implementations. These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

1. **Reduce Build Dependencies** - The main repository no longer requires timely and differential-dataflow dependencies
2. **Improve Build Times** - Core development builds are faster without external dataflow dependencies
3. **Maintain Performance Comparison** - Full benchmark suite remains available for performance analysis
4. **Clear Separation** - Architectural boundary between core implementation and comparative benchmarks

## Repository Structure

```
benches/
├── Cargo.toml          # Package configuration with timely/differential-dataflow dependencies
├── build.rs            # Build script for fork_join benchmark code generation
├── README.md           # Detailed benchmark documentation
└── benches/            # Benchmark implementations
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── upcase.rs
    ├── reachability_edges.txt
    └── reachability_reachable.txt
```

## Running Benchmarks

```bash
cd benches
cargo bench -p benches
```

For specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
```

## Performance Comparison

To compare Hydro with Timely/Differential-Dataflow:

1. Run benchmarks in this repository (Timely/DD implementations)
2. Run benchmarks in the main repository (Hydro-native implementations)
3. Compare criterion reports in `target/criterion/`

## Dependencies

- **timely-master**: 0.13.0-dev.1
- **differential-dataflow-master**: 0.13.0-dev.1
- **criterion**: Benchmarking framework
- Supporting libraries: futures, tokio, rand, etc.

## Migration

These benchmarks were migrated from the main repository on December 17, 2024. See `BENCHMARK_MIGRATION.md` in the main repository for detailed migration information.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro implementation with native benchmarks