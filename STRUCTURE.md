# Repository Structure

This document explains the structure of the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Purpose

This repository contains benchmarks for Hydro that depend on `timely` and `differential-dataflow`. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. Remove timely and differential-dataflow dependencies from the main repository
2. Keep the main codebase cleaner and more maintainable
3. Retain the ability to run performance comparisons for all code

## Directory Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark source files
│   ├── arithmetic.rs          # Pipeline arithmetic operations
│   ├── fan_in.rs              # Fan-in dataflow pattern
│   ├── fan_out.rs             # Fan-out dataflow pattern
│   ├── fork_join.rs           # Fork-join pattern
│   ├── identity.rs            # Identity operation
│   ├── join.rs                # Join operations
│   ├── reachability.rs        # Graph reachability
│   ├── upcase.rs              # String uppercase transformation
│   ├── reachability_edges.txt # Data file for reachability benchmark
│   └── reachability_reachable.txt # Data file for reachability benchmark
├── Cargo.toml                 # Package configuration and dependencies
├── build.rs                   # Build script
├── README.md                  # Main repository documentation
├── SETUP.md                   # Setup and usage instructions
├── STRUCTURE.md               # This file
├── verify.sh                  # Verification script
└── .gitignore                 # Git ignore rules
```

## Key Files

### Cargo.toml

The main package configuration file. Contains:
- Package metadata
- Lint configuration
- Dev dependencies including:
  - `timely-master` - Timely dataflow library
  - `differential-dataflow-master` - Differential dataflow library
  - `dfir_rs` - From main Hydro repository (via git dependency)
  - `criterion` - Benchmarking framework
- Benchmark definitions (`[[bench]]` sections)

### build.rs

Build script that runs before compilation. Used for any pre-build setup required by the benchmarks.

### benches/

Contains all benchmark source files. Each benchmark file:
- Is a standalone Rust source file
- Uses Criterion for benchmarking
- Compares DFIR implementations with timely/differential-dataflow implementations
- Generates performance reports in `target/criterion/`

## Benchmarks

### arithmetic.rs
Tests pipeline arithmetic operations with multiple stages of computation.

### fan_in.rs
Tests the fan-in dataflow pattern where multiple inputs converge to a single output.

### fan_out.rs
Tests the fan-out dataflow pattern where a single input diverges to multiple outputs.

### fork_join.rs
Tests the fork-join pattern combining fan-out and fan-in operations.

### identity.rs
Tests simple identity operations, useful for baseline performance measurements.

### join.rs
Tests join operations between data streams.

### reachability.rs
Tests graph reachability algorithms. Uses external data files:
- `reachability_edges.txt` - Graph edge data
- `reachability_reachable.txt` - Expected reachability results

### upcase.rs
Tests string transformation operations (uppercase conversion).

## Dependencies

### From crates.io
- `criterion` - Benchmarking framework
- `timely-master` - Timely dataflow
- `differential-dataflow-master` - Differential dataflow
- Various utilities: `futures`, `nameof`, `rand`, `rand_distr`, `seq-macro`, `static_assertions`, `tokio`

### From Main Repository (Git Dependencies)
- `dfir_rs` - Core DFIR runtime
- `sinktools` - Utility library
- `hydro_build_utils` - Build utilities

These dependencies point to `https://github.com/hydro-project/hydro.git` and are fetched automatically by Cargo.

## Build Process

1. Cargo reads `Cargo.toml` to understand dependencies and benchmark structure
2. `build.rs` runs any pre-build setup
3. Dependencies are fetched (including git dependencies from main repository)
4. Benchmarks are compiled
5. When run, Criterion generates performance reports

## Running Benchmarks

See [SETUP.md](SETUP.md) for detailed instructions on running benchmarks.

Quick reference:
```bash
# Build all benchmarks
cargo bench --no-run

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
```

## Performance Tracking

Criterion automatically tracks performance over time:
- Results are stored in `target/criterion/`
- Each run compares against previous runs
- Baselines can be saved and compared explicitly

## Maintenance

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/`
2. Add a corresponding `[[bench]]` entry in `Cargo.toml`
3. Follow the pattern of existing benchmarks
4. Test with `cargo bench --bench <new_benchmark>`

### Updating Dependencies

Dependencies from the main repository are tracked via git. To update:
```bash
cargo update
```

### Syncing with Main Repository

This repository depends on the main Hydro repository. When the main repository is updated:
1. The git dependencies in `Cargo.toml` will automatically fetch the latest version
2. Run `cargo update` to ensure you have the latest
3. Test benchmarks to ensure compatibility

## Relation to Main Repository

This repository is a companion to `bigweaver-agent-canary-hydro-zeta`. The split is organized as:

| Location | Contains | Dependencies |
|----------|----------|--------------|
| `bigweaver-agent-canary-hydro-zeta/benches/` | Non-timely/differential benchmarks | No timely/differential |
| `bigweaver-agent-canary-zeta-hydro-deps/` | Timely/differential benchmarks | Timely + differential |

Both repositories can run performance comparisons independently through Criterion's baseline features.
