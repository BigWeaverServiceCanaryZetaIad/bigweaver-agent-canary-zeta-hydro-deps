# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The main goals of this migration were:

1. **Reduce Dependencies**: Remove `timely` and `differential-dataflow` dependencies from the main hydro repository to keep the codebase lean.
2. **Improve Compilation Time**: Isolating these heavy dependencies reduces compilation time for developers working on the main repository.
3. **Maintain Performance Comparisons**: Preserve the ability to run comparative performance benchmarks between different dataflow implementations.
4. **Better Separation of Concerns**: Keep benchmarks that test external frameworks separate from those testing internal Hydroflow components.

## Migrated Benchmarks

The following benchmarks were moved to this repository:

### Timely Dataflow Benchmarks
- **arithmetic.rs** - Tests pipeline arithmetic operations with 20 sequential add operations
- **fan_in.rs** - Tests fan-in patterns where multiple streams merge into one
- **fan_out.rs** - Tests fan-out patterns where one stream splits into multiple
- **fork_join.rs** - Tests fork-join patterns with filtering and union operations
- **identity.rs** - Tests identity/no-op operations to measure framework overhead
- **join.rs** - Tests join operations between two streams
- **upcase.rs** - Tests string transformation operations (uppercase conversion)

### Differential Dataflow Benchmarks
- **reachability.rs** - Tests graph reachability computation using differential dataflow's iterative operators

### Associated Data Files
- **reachability_edges.txt** - Graph edge data for reachability benchmark (532KB)
- **reachability_reachable.txt** - Expected reachable nodes for verification (38KB)
- **words_alpha.txt** - English word list for string processing benchmarks (3.8MB)

## Benchmarks Remaining in Main Repository

The following benchmarks remain in the main `bigweaver-agent-canary-hydro-zeta` repository as they only depend on Hydroflow components:

- **futures.rs** - Async futures handling benchmark
- **micro_ops.rs** - Micro-operations performance benchmark
- **symmetric_hash_join.rs** - Symmetric hash join benchmark
- **words_diamond.rs** - Diamond pattern word processing benchmark
- **words_alpha.txt** - Shared data file (kept in both repositories)

## Technical Details

### Dependency Changes

**Removed from main repository (`bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml`):**
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

**Added to this repository (`bigweaver-agent-canary-zeta-hydro-deps/benches/Cargo.toml`):**
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
# Path references maintained for performance comparisons:
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### Build Configuration

The `build.rs` file was also migrated as it's specifically used by the `fork_join` benchmark to generate Hydroflow code for comparison purposes.

## Running Benchmarks

### In This Repository (Timely/Differential)

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run specific test within a benchmark
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"
```

### In Main Repository (Hydroflow)

```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### Cross-Repository Comparison

Use the provided comparison script:

```bash
./compare_benchmarks.sh
```

This script will:
1. Run all benchmarks in both repositories
2. Display results locations
3. Provide guidance on comparing criterion output

## Performance Comparison Workflow

To compare Hydroflow performance against timely/differential-dataflow:

1. **Run benchmarks in both repositories** using the comparison script or manually
2. **Examine criterion reports** in `target/criterion/` directories
3. **Compare metrics** such as:
   - Throughput (elements/second)
   - Latency (time per operation)
   - Memory usage
   - CPU utilization

### Example Comparison

For the arithmetic benchmark, you can compare:
- `arithmetic/dfir_rs/surface` (Hydroflow - main repo)
- `arithmetic/timely` (Timely - this repo)
- `arithmetic/raw` (Baseline - main repo)
- `arithmetic/iter` (Iterator baseline - main repo)

## Verification

A verification script is provided at `/projects/sandbox/verify_migration.sh` to ensure the migration was completed successfully. It checks:

- ✅ Moved benchmarks are removed from source repository
- ✅ Moved benchmarks exist in target repository
- ✅ Data files are properly migrated
- ✅ Remaining benchmarks stay in source repository
- ✅ Dependencies are correctly updated
- ✅ Build configuration is migrated
- ✅ Documentation is updated

Run verification:
```bash
cd /projects/sandbox
./verify_migration.sh
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                  # Workspace configuration
├── README.md                   # Repository overview
├── MIGRATION.md               # This file
├── compare_benchmarks.sh      # Performance comparison script
└── benches/
    ├── Cargo.toml             # Benchmark package configuration
    ├── build.rs               # Build script for fork_join
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── upcase.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── words_alpha.txt
```

## Future Considerations

### Updating Benchmarks

When updating benchmarks in this repository:

1. Ensure changes are compatible with the current versions of timely/differential-dataflow
2. Update Hydroflow references if the main repository API changes
3. Run comparative benchmarks to verify performance characteristics
4. Document any significant performance changes

### Dependency Updates

When updating timely or differential-dataflow versions:

1. Update version numbers in `benches/Cargo.toml`
2. Test all benchmarks for compatibility
3. Run full benchmark suite to detect performance regressions
4. Document any API changes needed in benchmarks

### Adding New Benchmarks

When adding new benchmarks that use timely/differential-dataflow:

1. Add benchmark files to `benches/benches/`
2. Add benchmark entry to `benches/Cargo.toml`
3. Update README.md with benchmark description
4. Add corresponding Hydroflow comparison to main repository if applicable

## Links and References

- **Main Repository**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow
- **Criterion.rs**: https://github.com/bheisler/criterion.rs

## Contact

For questions about this migration or the benchmarks, please refer to the main Hydro project documentation and issue tracker.
