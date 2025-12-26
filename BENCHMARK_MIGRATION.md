# Benchmark Migration Documentation

This document describes the migration of Timely and Differential Dataflow benchmarks from the bigweaver-agent-canary-hydro-zeta repository to the bigweaver-agent-canary-zeta-hydro-deps repository.

## Migration Overview

### Objective
To remove timely and differential-dataflow dependencies from the main bigweaver-agent-canary-hydro-zeta repository while maintaining the ability to run performance comparisons.

### What Was Moved

#### Benchmark Files
The following benchmark files were moved to bigweaver-agent-canary-zeta-hydro-deps:

1. **arithmetic.rs** - Arithmetic operations comparison benchmarks
2. **fan_in.rs** - Fan-in pattern benchmarks
3. **fan_out.rs** - Fan-out pattern benchmarks
4. **fork_join.rs** - Fork-join pattern benchmarks
5. **identity.rs** - Identity operation benchmarks
6. **join.rs** - Join operations with different value types (usize, String)
7. **reachability.rs** - Graph reachability algorithms (both Timely and Differential implementations)
8. **upcase.rs** - String transformation operations benchmarks

#### Data Files
- **reachability_edges.txt** - Graph edges data for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for validation

#### Build Configuration
- **build.rs** - Build script for generating fork_join benchmark code

### What Remained in bigweaver-agent-canary-hydro-zeta

The following DFIR-only benchmarks remain in the original repository:

1. **micro_ops.rs** - Microbenchmarks for basic operations (map, flat_map, union, tee, fold, sort, etc.)
2. **symmetric_hash_join.rs** - Symmetric hash join benchmark
3. **words_diamond.rs** - Diamond pattern benchmark using word list
4. **futures.rs** - Async/futures integration benchmark

These benchmarks do not require timely or differential-dataflow dependencies.

## Running Performance Comparisons

### In bigweaver-agent-canary-hydro-zeta (DFIR-only benchmarks)

```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

Or run specific benchmarks:
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

### In bigweaver-agent-canary-zeta-hydro-deps (Comparison benchmarks)

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

Or run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench join
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench upcase
```

### Comparing Results

Each benchmark in the hydro-deps repository includes multiple implementations:
- **Timely Dataflow** implementation (e.g., `benchmark_timely`)
- **Differential Dataflow** implementation (e.g., `benchmark_differential` in reachability)
- **DFIR/Hydroflow** implementation (e.g., `benchmark_hydroflow`)

Criterion will automatically compare all implementations and generate comparative reports.

## Dependencies

### bigweaver-agent-canary-hydro-zeta/benches
- criterion (benchmarking framework)
- dfir_rs (local path dependency)
- sinktools (local path dependency)
- futures
- rand, rand_distr
- tokio
- seq-macro
- nameof
- static_assertions

**No timely or differential-dataflow dependencies**

### bigweaver-agent-canary-zeta-hydro-deps/benches
- criterion (benchmarking framework)
- **dfir_rs** (git dependency from main hydro repository)
- **sinktools** (git dependency from main hydro repository)
- **timely** (timely-master 0.13.0-dev.1)
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1)
- futures
- rand, rand_distr
- tokio
- seq-macro
- nameof
- static_assertions

## Architecture Notes

### Why Separate Repositories?

1. **Dependency Isolation**: Timely and Differential Dataflow are heavy dependencies that are only needed for performance comparisons, not for the core DFIR functionality.

2. **Build Performance**: Removing these dependencies from the main repository reduces build times for developers not working on performance comparisons.

3. **Cleaner Dependency Tree**: The main repository maintains a cleaner dependency tree focused on its core functionality.

4. **Maintained Comparability**: Despite the separation, we can still run performance comparisons by using the deps repository when needed.

### Git Dependencies

Note that in bigweaver-agent-canary-zeta-hydro-deps, dfir_rs and sinktools are referenced via git:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", branch = "main", version = "^0.0.1" }
```

This allows the deps repository to work independently without requiring the main repository to be checked out locally.

## Continuous Integration

When setting up CI for the hydro-deps repository, ensure:

1. Rust toolchain is installed (matching rust-toolchain.toml if needed)
2. Sufficient time is allocated for benchmark runs
3. Criterion reports are optionally archived as artifacts
4. The main hydro repository is accessible (for git dependencies)

## Troubleshooting

### "Cannot find dfir_rs in registry"
This is expected in the deps repository. It uses a git dependency to the main repository.

### Benchmark differences between runs
Criterion handles statistical variance, but ensure:
- System is not under heavy load
- Same hardware is used for comparisons
- Consider running with `--sample-size` and `--warm-up-time` options for more stable results

### Build failures
If builds fail, ensure:
- All dependencies are accessible
- Network access is available for fetching git dependencies
- Rust version is compatible (check rust-toolchain.toml in main repo)

## Future Maintenance

### Adding New Benchmarks

**For DFIR-only benchmarks**: Add to bigweaver-agent-canary-hydro-zeta/benches

**For comparison benchmarks with Timely/Differential**: Add to bigweaver-agent-canary-zeta-hydro-deps/benches

### Updating Dependencies

When updating dfir_rs or sinktools:
1. Update in the main repository first
2. The deps repository will automatically pick up changes via git dependency

When updating timely or differential-dataflow:
1. Update only in bigweaver-agent-canary-zeta-hydro-deps/benches/Cargo.toml

## References

- Main Repository: https://github.com/hydro-project/hydro
- Deps Repository: https://github.com/hydro-project/bigweaver-agent-canary-zeta-hydro-deps
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion: https://github.com/bheisler/criterion.rs
