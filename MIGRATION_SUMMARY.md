# Migration Summary: Timely and Differential-Dataflow Benchmarks

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The main repository needed to remove direct dependencies on `timely` and `differential-dataflow` packages to:
1. Reduce dependency complexity in the core Hydro codebase
2. Maintain cleaner separation between Hydro's core functionality and performance comparison tooling
3. Enable independent evolution of benchmark infrastructure
4. Reduce build times for developers not working on performance comparisons

## Migrated Components

### Benchmarks Directory
All benchmark files and supporting data were moved from `benches/` in the source repository to this repository:

**Benchmark Files:**
- `benches/benches/arithmetic.rs` - Arithmetic operations performance tests
- `benches/benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/benches/futures.rs` - Futures-based operation benchmarks
- `benches/benches/identity.rs` - Identity operation benchmarks
- `benches/benches/join.rs` - Join operation benchmarks
- `benches/benches/micro_ops.rs` - Micro-operations benchmarks
- `benches/benches/reachability.rs` - Graph reachability benchmarks
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/benches/upcase.rs` - String case transformation benchmarks
- `benches/benches/words_diamond.rs` - Word processing diamond pattern benchmarks

**Supporting Files:**
- `benches/benches/reachability_edges.txt` - Test data for reachability benchmarks
- `benches/benches/reachability_reachable.txt` - Expected results for reachability benchmarks
- `benches/benches/words_alpha.txt` - Wordlist data (from https://github.com/dwyl/english-words)
- `benches/benches/.gitignore` - Git ignore configuration

**Configuration Files:**
- `benches/Cargo.toml` - Package configuration with benchmark definitions
- `benches/README.md` - Documentation for running benchmarks
- `benches/build.rs` - Build script for benchmarks

## Dependency Changes

### Removed from Source Repository
The following dependencies were removed from the main repository's `Cargo.toml`:
- `timely` (package: timely-master)
- `differential-dataflow` (package: differential-dataflow-master)

### Added to This Repository
Dependencies specific to benchmarking were added to this repository's `benches/Cargo.toml`:
- `criterion` - For benchmark harness and reporting
- `dfir_rs` - Referenced via git from main repository
- `differential-dataflow` - For comparison benchmarks
- `timely` - For comparison benchmarks
- `sinktools` - Referenced via git from main repository
- Supporting crates: `futures`, `nameof`, `rand`, `rand_distr`, `seq-macro`, `static_assertions`, `tokio`

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # Repository documentation
├── MIGRATION_SUMMARY.md          # This file
├── BENCHMARK_GUIDE.md            # Detailed benchmark usage guide
└── benches/
    ├── Cargo.toml                # Benchmark package configuration
    ├── README.md                 # Benchmark-specific documentation
    ├── build.rs                  # Build script
    └── benches/
        ├── .gitignore
        ├── *.rs                  # Benchmark source files
        └── *.txt                 # Test data files
```

## Performance Comparison Functionality

The moved benchmarks retain full functionality for performance comparisons:

1. **Criterion Integration**: All benchmarks use the Criterion framework for statistical analysis
2. **HTML Reports**: Benchmarks generate HTML reports with detailed performance metrics
3. **Comparative Analysis**: Benchmarks can compare Hydro (via dfir_rs) against timely/differential-dataflow
4. **Historical Tracking**: Criterion maintains historical data for trend analysis

## Running Benchmarks

### Prerequisites
```bash
# Clone both repositories
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
```

### Running All Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Running Specific Benchmarks
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Viewing Results
Benchmark results are saved in `target/criterion/` with HTML reports available in `target/criterion/report/index.html`.

## Verification

To verify the migration was successful:

1. **Build Test**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build -p benches
   ```

2. **Run Sample Benchmark**
   ```bash
   cargo bench -p benches --bench identity
   ```

3. **Check Dependencies**
   ```bash
   cargo tree -p benches | grep -E "timely|differential"
   ```

## Impact on Main Repository

After this migration, the main repository:
- No longer has `timely` or `differential-dataflow` in its dependency tree
- Has a cleaner `Cargo.lock` with fewer transitive dependencies
- Builds faster for developers not working on performance benchmarks
- Maintains the same core functionality without benchmark dependencies

## Maintenance

### Updating Benchmarks
When updating benchmark code:
1. Make changes in this repository (`bigweaver-agent-canary-zeta-hydro-deps`)
2. Test with `cargo bench -p benches --bench <benchmark_name>`
3. Commit and push to this repository

### Syncing with Main Repository
If benchmarks need to reference updated APIs from the main repository:
1. Update the git reference in `benches/Cargo.toml` to point to the latest commit
2. Run `cargo update` to fetch the latest changes
3. Update benchmark code as needed for API changes

## References

- Source Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- This Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
- Hydro Project: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

## Migration Date

This migration was completed on 2025-11-29, consolidating all timely and differential-dataflow benchmark code into this dedicated repository.
