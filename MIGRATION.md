# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Dates

- **Phase 1**: December 20, 2025 - Timely/Differential benchmarks migrated
- **Phase 2**: December 21, 2025 - DFIR_rs comparison benchmarks added

## Reason for Migration

The benchmarks and their associated dependencies were moved to a separate repository to:

1. **Reduce dependency bloat**: Remove unnecessary dependencies (timely-dataflow and differential-dataflow) from the main repository
2. **Improve build times**: Avoid compiling timely and differential-dataflow in the main codebase
3. **Maintain comparison capability**: Retain the ability to run performance comparisons between different dataflow implementations (timely/differential vs dfir_rs)
4. **Simplify maintenance**: Keep benchmarking infrastructure separate from core functionality
5. **Consolidate benchmarks**: Centralize all benchmark code in a dedicated repository for easier management and comparison

## Files Migrated

### Phase 1: Timely/Differential Benchmarks (December 20, 2025)

From `bigweaver-agent-canary-hydro-zeta` commit `513b2091`:

#### Benchmark Files
- `benches/benches/arithmetic.rs` → `timely-differential-benches/benches/arithmetic.rs`
- `benches/benches/fan_in.rs` → `timely-differential-benches/benches/fan_in.rs`
- `benches/benches/fan_out.rs` → `timely-differential-benches/benches/fan_out.rs`
- `benches/benches/fork_join.rs` → `timely-differential-benches/benches/fork_join.rs`
- `benches/benches/identity.rs` → `timely-differential-benches/benches/identity.rs`
- `benches/benches/join.rs` → `timely-differential-benches/benches/join.rs`
- `benches/benches/reachability.rs` → `timely-differential-benches/benches/reachability.rs`
- `benches/benches/upcase.rs` → `timely-differential-benches/benches/upcase.rs`
- `benches/benches/zip.rs` → `timely-differential-benches/benches/zip.rs`

#### Data Files
- `benches/benches/reachability_edges.txt` → `timely-differential-benches/benches/reachability_edges.txt`
- `benches/benches/reachability_reachable.txt` → `timely-differential-benches/benches/reachability_reachable.txt`

### Phase 2: DFIR_rs Comparison Benchmarks (December 21, 2025)

From `bigweaver-agent-canary-hydro-zeta` (remaining benchmarks):

#### Benchmark Files
- `benches/benches/micro_ops.rs` → `timely-differential-benches/benches/micro_ops.rs`
- `benches/benches/symmetric_hash_join.rs` → `timely-differential-benches/benches/symmetric_hash_join.rs`
- `benches/benches/words_diamond.rs` → `timely-differential-benches/benches/words_diamond.rs`
- `benches/benches/futures.rs` → `timely-differential-benches/benches/futures.rs`

#### Data Files
- `benches/benches/words_alpha.txt` → `timely-differential-benches/benches/words_alpha.txt`

## Dependencies Migrated

The following dependencies were moved or added to this repository:

### Phase 1: Timely/Differential Dependencies

**Added to bigweaver-agent-canary-zeta-hydro-deps:**
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`
- Supporting dependencies:
  - `criterion = { version = "0.5.0", features = ["async_tokio", "html_reports"] }`
  - `rand = "0.8.0"`
  - `rand_distr = "0.4.3"`
  - `seq-macro = "0.2.0"`
  - `tokio = { version = "1.29.0", features = ["rt-multi-thread"] }`

**Removed from bigweaver-agent-canary-hydro-zeta:**
- `timely = "*"` (from benches/Cargo.toml)
- Any references to differential-dataflow in benchmark files

### Phase 2: DFIR_rs and Comparison Dependencies

**Added to bigweaver-agent-canary-zeta-hydro-deps:**
- `dfir_rs = { git = "https://github.com/hydro-project/hydro", features = ["debugging"] }`
- `sinktools = { git = "https://github.com/hydro-project/hydro" }`
- `futures = "0.3"`
- `nameof = "1.0.0"`
- `static_assertions = "1.0.0"`

**Removed from bigweaver-agent-canary-hydro-zeta:**
- All benchmark files from benches/benches/ directory
- benches package (Cargo.toml and dependencies)

## New Structure in bigweaver-agent-canary-zeta-hydro-deps

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                           # Workspace configuration
├── README.md                            # Repository documentation
├── MIGRATION.md                         # This file
├── scripts/
│   └── compare_benchmarks.sh           # Cross-repository comparison script
└── timely-differential-benches/
    ├── Cargo.toml                       # Package configuration
    ├── README.md                        # Benchmark documentation
    ├── build.rs                         # Build script for generated benchmarks
    └── benches/                         # Benchmark implementations and data
        ├── arithmetic.rs                # Timely/Differential benchmark
        ├── fan_in.rs                    # Timely/Differential benchmark
        ├── fan_out.rs                   # Timely/Differential benchmark
        ├── fork_join.rs                 # Timely/Differential benchmark
        ├── identity.rs                  # Timely/Differential benchmark
        ├── join.rs                      # Timely/Differential benchmark
        ├── reachability.rs              # Timely/Differential benchmark
        ├── reachability_edges.txt       # Data file
        ├── reachability_reachable.txt   # Data file
        ├── upcase.rs                    # Timely/Differential benchmark
        ├── zip.rs                       # Timely/Differential benchmark
        ├── micro_ops.rs                 # DFIR_rs comparison benchmark
        ├── symmetric_hash_join.rs       # DFIR_rs comparison benchmark
        ├── words_diamond.rs             # DFIR_rs comparison benchmark
        ├── words_alpha.txt              # Data file
        └── futures.rs                   # DFIR_rs comparison benchmark
```

## Performance Comparison

After migration, performance comparisons can be conducted using:

1. **Direct benchmarking**: Run benchmarks in this repository
   ```bash
   # In bigweaver-agent-canary-zeta-hydro-deps
   
   # Run all benchmarks
   cargo bench -p timely-differential-benches
   
   # Run specific timely/differential benchmarks
   cargo bench -p timely-differential-benches --bench arithmetic
   cargo bench -p timely-differential-benches --bench join
   cargo bench -p timely-differential-benches --bench reachability
   
   # Run specific DFIR_rs comparison benchmarks
   cargo bench -p timely-differential-benches --bench micro_ops
   cargo bench -p timely-differential-benches --bench words_diamond
   cargo bench -p timely-differential-benches --bench futures
   ```

2. **Automated comparison**: Use the provided comparison script
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   ./scripts/compare_benchmarks.sh
   ```

3. **Cross-implementation comparison**: Compare Timely/Differential benchmarks with DFIR_rs benchmarks
   - Many benchmarks implement similar patterns in both frameworks
   - Results are saved in `target/criterion/` for analysis
   - HTML reports available at `target/criterion/report/index.html`

## Verification

To verify the migration was successful:

1. Build the deps repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build
   ```

2. Run the benchmarks:
   ```bash
   cargo bench
   ```

3. Check that the main repository no longer has timely/differential dependencies:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   # Check Cargo.toml files for absence of timely/differential dependencies
   ```

## Post-Migration Changes in Main Repository

After this migration, the main repository should have:

1. Updated README.md in benches/ directory to reference this repository
2. Documentation pointing users to this repository for performance comparisons
3. All benchmark code moved to this dedicated repository

Note: The main repository retains its core functionality and can still be benchmarked independently if needed.

## Maintenance

Going forward:

- **New timely/differential benchmarks**: Add to this repository in timely-differential-benches/benches/
- **New DFIR_rs benchmarks**: Add to this repository for comparison purposes
- **Core functionality benchmarks**: May be added to the main repository if they don't require cross-framework comparison
- **Dependency updates**: Update timely, differential-dataflow, and dfir_rs versions in this repository's Cargo.toml

## Benchmark Categories

### Timely/Differential Benchmarks
These benchmarks use timely-dataflow and differential-dataflow to implement dataflow patterns:
- arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase, zip

### DFIR_rs Comparison Benchmarks
These benchmarks use dfir_rs to implement comparable patterns and operations:
- micro_ops (various DFIR operations)
- symmetric_hash_join (join implementation)
- words_diamond (complex dataflow pattern)
- futures (async operations)

## References

- Main Repository: bigweaver-agent-canary-hydro-zeta
- Source Commit: 513b2091 (Add slightly more complex reachability benchmark)
- Migration Script: scripts/compare_benchmarks.sh
