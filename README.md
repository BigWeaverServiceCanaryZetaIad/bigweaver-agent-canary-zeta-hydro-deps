# bigweaver-agent-canary-zeta-hydro-deps

Performance comparison benchmarks with timely and differential-dataflow dependencies.

## Overview

This repository contains benchmarks that depend on timely-dataflow and differential-dataflow, separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce build dependencies.

## Purpose

- **Performance Comparison**: Compare Hydro implementations against timely/differential-dataflow
- **Dependency Isolation**: Keep heavyweight dependencies out of the main repository
- **Faster Builds**: Main repository builds faster without these dependencies

## Structure

```
benches/
├── Cargo.toml              # Package configuration with timely/differential dependencies
├── README.md               # Detailed benchmark documentation
├── build.rs                # Build script for fork_join benchmark generation
└── benches/
    ├── arithmetic.rs       # Arithmetic operations (timely)
    ├── fan_in.rs          # Fan-in pattern (timely)
    ├── fan_out.rs         # Fan-out pattern (timely)
    ├── fork_join.rs       # Fork-join pattern (timely)
    ├── identity.rs        # Identity transformation (timely)
    ├── join.rs            # Join operations (timely)
    ├── reachability.rs    # Graph reachability (differential)
    ├── upcase.rs          # String transformation (timely)
    └── reachability_*.txt # Test data files
```

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro repository with DFIR-native benchmarks