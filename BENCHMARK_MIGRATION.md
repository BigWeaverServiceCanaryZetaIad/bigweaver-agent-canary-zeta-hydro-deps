# Benchmark Migration Documentation

## Overview
This repository contains benchmarks with dependencies on `timely-dataflow` and `differential-dataflow` that were migrated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Migration Date
December 16, 2024

## Purpose
The migration was performed to:
1. **Reduce build dependencies** in the main repository
2. **Improve build times** by isolating benchmarks with heavy dependencies
3. **Maintain performance comparison capabilities** between DFIR/Hydro and Timely/Differential implementations
4. **Improve dependency management** by separating external dependencies from the core codebase

## Migrated Benchmarks

The following benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to this repository:

1. **arithmetic.rs** - Arithmetic operations performance benchmark
2. **fan_in.rs** - Fan-in pattern benchmark  
3. **fan_out.rs** - Fan-out pattern benchmark
4. **fork_join.rs** - Fork-join pattern benchmark (with build.rs generator)
5. **identity.rs** - Identity operation benchmark
6. **join.rs** - Join operation benchmark
7. **reachability.rs** - Graph reachability benchmark (with test data files)
8. **upcase.rs** - String uppercase operation benchmark

## Supporting Files

In addition to the benchmark source files, the following supporting files were migrated:

- **build.rs** - Build script to generate fork_join benchmark code
- **benches/.gitignore** - Ignore generated fork_join files
- **benches/reachability_edges.txt** - Test data for reachability benchmark
- **benches/reachability_reachable.txt** - Expected results for reachability benchmark

## Dependencies

This repository maintains dependencies on:

### External Packages
- `timely-master` (version 0.13.0-dev.1) - Timely dataflow runtime
- `differential-dataflow-master` (version 0.13.0-dev.1) - Differential dataflow library
- `criterion` (version 0.5.0) - Benchmarking framework

### Main Repository References
- `dfir_rs` - Referenced via git from the main repository for DFIR implementations
- `sinktools` - Referenced via git from the main repository for utilities

This configuration allows the benchmarks to compare Timely/Differential implementations against DFIR/Hydro implementations.

## Workspace Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # Repository overview
├── BENCHMARK_MIGRATION.md        # This file
└── benches/
    ├── Cargo.toml               # Benchmark package configuration
    ├── build.rs                 # Build script for fork_join
    └── benches/
        ├── .gitignore
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── upcase.rs
```

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

Examples:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench fork_join
```

## Verification

The migration has been verified to ensure:

✓ All benchmark files are present in this repository  
✓ Dependencies on timely-master and differential-dataflow-master are properly configured  
✓ Source repository (bigweaver-agent-canary-hydro-zeta) no longer has these dependencies  
✓ Performance comparison capability is retained via git dependencies on dfir_rs  
✓ Build scripts and supporting files are properly included  

## Source Repository Cleanup

The following actions were completed in the source repository:

1. Removed the entire `benches/` directory with timely/differential benchmarks
2. Removed `timely-master` dependency from all Cargo.toml files
3. Removed `differential-dataflow-master` dependency from all Cargo.toml files
4. Updated documentation to reference this separate repository
5. Verified no remaining references to removed dependencies

Note: The source repository retained DFIR-native benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond) that do not depend on timely or differential-dataflow.

## Benefits Achieved

1. **Reduced Build Time**: Main repository builds faster without timely/differential dependencies
2. **Cleaner Dependencies**: Core codebase is not coupled to external dataflow libraries
3. **Preserved Functionality**: All performance comparison capabilities remain available
4. **Better Organization**: Clear separation between DFIR-native and comparison benchmarks
5. **Easier Maintenance**: Dependencies can be updated independently

## Related Documentation

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- README.md in this repository for usage instructions

## Future Work

- Set up CI/CD pipeline for running benchmarks from this repository
- Create performance tracking dashboard comparing DFIR vs Timely/Differential implementations
- Document baseline performance metrics for each benchmark
- Add additional comparative benchmarks as needed
