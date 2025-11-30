# Benchmark Migration Summary

## Overview

Timely and differential-dataflow benchmarks have been moved from the `bigweaver-agent-canary-hydro-zeta` repository to this repository to maintain cleaner dependency management while preserving performance comparison capabilities.

## What Was Moved

### Entire `benches/` Directory Structure
All benchmark files and related resources have been moved:

```
benches/
├── Cargo.toml                     # Benchmark package configuration
├── README.md                      # Benchmark usage instructions
├── build.rs                       # Build script for generating test files
└── benches/                       # Individual benchmark implementations
    ├── .gitignore
    ├── arithmetic.rs              # Arithmetic operations benchmark
    ├── fan_in.rs                  # Fan-in pattern benchmark
    ├── fan_out.rs                 # Fan-out pattern benchmark
    ├── fork_join.rs               # Fork-join pattern benchmark
    ├── futures.rs                 # Async futures benchmark
    ├── identity.rs                # Identity transformation benchmark
    ├── join.rs                    # Join operations benchmark
    ├── micro_ops.rs               # Micro-operations benchmark
    ├── reachability.rs            # Graph reachability benchmark
    ├── reachability_edges.txt     # Test data for reachability
    ├── reachability_reachable.txt # Expected results for reachability
    ├── symmetric_hash_join.rs     # Symmetric hash join benchmark
    ├── upcase.rs                  # String transformation benchmark
    ├── words_alpha.txt            # Word list test data (370k+ words)
    └── words_diamond.rs           # Diamond pattern benchmark
```

## Dependencies Now in This Repository

The following dependencies are exclusive to the benchmarks and are now in this repository:

- `timely` (package: `timely-master`, version: `0.13.0-dev.1`)
- `differential-dataflow` (package: `differential-dataflow-master`, version: `0.13.0-dev.1`)

These dependencies were removed from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Dependencies Referenced from Main Repository

The benchmarks still reference packages from the main repository via path dependencies:

- `dfir_rs` - Core DFIR runtime and syntax
- `sinktools` - Push-based iterator utilities

These are referenced using relative paths pointing to the main repository as a sibling directory:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## Benefits of Migration

### For Main Repository
1. **Cleaner dependency graph** - No timely/differential-dataflow dependencies
2. **Faster builds** - Fewer dependencies to compile
3. **Smaller Cargo.lock** - Reduced lock file size
4. **Focused scope** - Main repository focuses on core functionality

### For This Repository
1. **Dedicated benchmarking** - Clear separation of concerns
2. **Independent updates** - Can update benchmark dependencies without affecting main repo
3. **Performance tracking** - Centralized location for all performance benchmarks
4. **Easy comparison** - Compare Hydro with timely/differential side-by-side

## How to Run Benchmarks

From this repository root:

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability

# Run benchmarks with more iterations (for more accurate results)
CRITERION_SAMPLE_SIZE=100 cargo bench -p benches
```

See [BENCHMARK_GUIDE.md](./BENCHMARK_GUIDE.md) for detailed instructions.

## Source Commit

The benchmarks were originally removed from `bigweaver-agent-canary-hydro-zeta` in commit `b161bc10` with the message:
```
chore(benches): remove timely/differential-dataflow dependencies and benchmarks
```

## Migration Date

This migration was completed on 2025-11-30.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                # Workspace configuration
├── README.md                 # Repository overview
├── MIGRATION_SUMMARY.md      # This file
├── BENCHMARK_GUIDE.md        # Detailed benchmark usage guide
└── benches/                  # Benchmark package
    ├── Cargo.toml
    ├── README.md
    ├── build.rs
    └── benches/              # Benchmark implementations
```

## Related Changes

### In Main Repository (bigweaver-agent-canary-hydro-zeta)
- Removed `benches/` directory and all its contents
- Removed `benches` from workspace members in root `Cargo.toml`
- Removed timely and differential-dataflow from `Cargo.lock`
- Updated documentation to reference this repository for benchmarks

### In This Repository (bigweaver-agent-canary-zeta-hydro-deps)
- Added complete `benches/` directory
- Created workspace configuration
- Updated path dependencies to reference main repository
- Added documentation (README.md, MIGRATION_SUMMARY.md, BENCHMARK_GUIDE.md)

## Verification

To verify the migration was successful:

1. **Main repository builds without timely/differential**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo check --all-features
   # Should complete without errors
   ```

2. **This repository can run benchmarks**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches --bench identity
   # Should compile and run the benchmark
   ```

3. **No references to timely/differential in main repository**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   grep -r "timely\|differential-dataflow" */Cargo.toml
   # Should return no results
   ```

## Maintenance

### When APIs Change in Main Repository

If `dfir_rs` or `sinktools` APIs change in the main repository:

1. Check if benchmarks are affected
2. Update benchmarks in this repository to use new APIs
3. Test that benchmarks still compile and run
4. Consider adding new benchmarks for new features

### Adding New Benchmarks

To add new benchmarks:

1. Create new `.rs` file in `benches/benches/`
2. Add `[[bench]]` section to `benches/Cargo.toml`
3. Follow existing benchmark patterns (use Criterion)
4. Document the benchmark purpose in comments
5. Update BENCHMARK_GUIDE.md if needed

### Updating Dependencies

To update timely/differential-dataflow:

1. Update versions in `benches/Cargo.toml`
2. Run `cargo update -p benches`
3. Test all benchmarks to ensure compatibility
4. Commit changes with clear message about version updates

## Contact

For questions or issues related to the benchmarks:
- Open an issue in this repository
- Reference the main repository for API-related questions

## References

- Main Repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)
- Timely Dataflow: [https://github.com/TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- Differential Dataflow: [https://github.com/TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)
