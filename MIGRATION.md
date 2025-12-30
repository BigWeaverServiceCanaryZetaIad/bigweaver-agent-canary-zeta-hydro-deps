# Migration Documentation

## Overview

This document describes the migration of Timely Dataflow and Differential Dataflow comparison benchmarks from the main Hydro repository to this dedicated benchmarks repository.

## Migration Date

December 30, 2025

## Purpose

The benchmarks were moved to this separate repository to:
1. Reduce dependency burden on the main Hydro repository
2. Improve maintainability through separation of concerns
3. Allow independent benchmark evolution
4. Keep the main repository focused on core functionality

## Migrated Components

### Benchmark Files

The following 8 benchmark files were migrated:

1. **arithmetic.rs** (7.6 KB) - Arithmetic operations comparison
2. **fan_in.rs** (3.5 KB) - Fan-in pattern benchmark
3. **fan_out.rs** (3.6 KB) - Fan-out pattern benchmark
4. **fork_join.rs** (4.3 KB) - Fork-join pattern benchmark
5. **identity.rs** (6.8 KB) - Identity transformation benchmark
6. **join.rs** (4.4 KB) - Join operation benchmark
7. **reachability.rs** (14 KB) - Graph reachability benchmark
8. **upcase.rs** (3.1 KB) - String uppercase operation benchmark

### Data Files

- **reachability_edges.txt** (521 KB) - Graph edge data for reachability benchmark
- **reachability_reachable.txt** (38 KB) - Expected reachable nodes for verification

### Build Configuration

- **build.rs** - Build script that generates Hydroflow code for fork_join benchmark at compile time
- **benches/.gitignore** - Git ignore file for generated fork_join_*.hf files

## Dependencies Added

### External Dependencies

The following dependencies were added to support the benchmarks:

```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

### Hydro Dependencies

The benchmarks depend on components from the main Hydro repository:

```toml
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

### Supporting Dependencies

Additional dependencies required by the benchmarks:

- `criterion` (v0.5.0) - Benchmarking framework with async support
- `futures` (v0.3) - Async runtime utilities
- `nameof` (v1.0.0) - Name reflection macro
- `rand` (v0.8.0) - Random number generation
- `rand_distr` (v0.4.3) - Random distributions
- `seq-macro` (v0.2.0) - Sequence macros
- `static_assertions` (v1.0.0) - Compile-time assertions
- `tokio` (v1.29.0) - Async runtime with multi-threading

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Package manifest with dependencies
├── README.md               # Repository documentation
├── MIGRATION.md            # This file
├── build.rs                # Build script for code generation
└── benches/                # Benchmark source directory
    ├── .gitignore          # Ignore generated files
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

### Run All Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Run Specific Benchmarks

```bash
# Individual benchmarks
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
cargo bench --bench identity
cargo bench --bench upcase
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join

# Run benchmarks matching a pattern
cargo bench arithmetic
cargo bench fan
```

### Build Benchmarks Without Running

```bash
cargo build --benches
```

## Performance Comparison Features

Each benchmark typically includes multiple implementations for comparison:

1. **Raw/Native Implementation** - Pure Rust baseline implementation
2. **Hydro/DFIR Implementation** - Implementation using Hydro's DFIR
3. **Timely Implementation** - Implementation using Timely Dataflow
4. **Differential Implementation** - Implementation using Differential Dataflow (where applicable)

This allows for direct performance comparison across different dataflow frameworks.

## Build Process Details

### Code Generation

The `build.rs` script generates Hydroflow source code for the `fork_join` benchmark at compile time:

- Generates `benches/fork_join_20.hf` with 20 operations
- Creates a complex fork-join dataflow pattern
- File is included in the benchmark using `include!("fork_join_20.hf")`
- Generated file is ignored by git (see `benches/.gitignore`)

### Compilation

The benchmarks require:
- Rust 2021 edition or later
- Access to the main Hydro repository (for dfir_rs and sinktools)
- Network access to download crates.io dependencies

## Verification

To verify the benchmarks are functional:

1. **Build test:**
   ```bash
   cargo build --benches
   ```

2. **Quick benchmark run:**
   ```bash
   cargo bench --bench identity -- --quick
   ```

3. **Check specific benchmark:**
   ```bash
   cargo bench --bench reachability -- --sample-size 10
   ```

## Maintenance Notes

- The benchmarks depend on the main Hydro repository via relative path
- Both repositories should be in the same parent directory
- Keep dependency versions synchronized with the main repository
- Update benchmarks when Hydro APIs change
- Monitor performance regressions across framework versions

## Related Documentation

- Main repository: `../bigweaver-agent-canary-hydro-zeta/benches/REMOVED_BENCHMARKS.md`
- Benchmark methodology: See individual benchmark source files for implementation details
- Criterion documentation: https://bheisler.github.io/criterion.rs/book/

## Contact

For questions about these benchmarks, refer to the main Hydro repository documentation and contribution guidelines.
