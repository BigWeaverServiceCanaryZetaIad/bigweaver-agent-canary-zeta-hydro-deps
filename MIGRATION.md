# Migration Summary

This repository was created to house benchmarks that depend on Timely Dataflow and Differential Dataflow, which were previously part of the bigweaver-agent-canary-hydro-zeta repository.

## Moved Benchmarks

The following benchmarks were moved from bigweaver-agent-canary-hydro-zeta:

1. **arithmetic.rs** - Arithmetic operations performance comparison
2. **fan_in.rs** - Fan-in pattern performance  
3. **fan_out.rs** - Fan-out pattern performance
4. **fork_join.rs** - Fork-join pattern performance (with build.rs for code generation)
5. **identity.rs** - Identity transformation performance
6. **join.rs** - Join operations with different data types
7. **reachability.rs** - Graph reachability algorithms (with data files)
8. **upcase.rs** - String uppercase transformation performance

## Support Files Moved

- **build.rs** - Build script for generating fork_join benchmark code
- **reachability_edges.txt** - Graph edges data for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for validation
- **.github/workflows/benchmark.yml** - CI/CD workflow for running benchmarks

## Dependencies Moved

The following dependencies were removed from bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml:
- `timely` (package: timely-master, version: 0.13.0-dev.1)
- `differential-dataflow` (package: differential-dataflow-master, version: 0.13.0-dev.1)

These dependencies are now maintained only in this repository's Cargo.toml.

## Benchmarks Remaining in hydro-zeta

The following benchmarks remain in bigweaver-agent-canary-hydro-zeta as they do not depend on timely/differential-dataflow:
- **futures.rs** - Async futures operations
- **micro_ops.rs** - Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- **symmetric_hash_join.rs** - Symmetric hash join operations
- **words_diamond.rs** - Diamond pattern with word list

## Rationale

This separation maintains clean dependency boundaries by:
1. Keeping the core Hydro/DFIR repository free from timely/differential-dataflow dependencies
2. Maintaining performance comparison capabilities
3. Supporting continuous validation of competitive performance
4. Following the team's preference for separation of concerns and dedicated repositories for different dependency sets
