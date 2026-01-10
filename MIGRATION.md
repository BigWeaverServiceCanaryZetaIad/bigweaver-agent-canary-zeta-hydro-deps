# Benchmark Migration Documentation

This document describes the migration of benchmarks from the main Hydro repository to this separate hydro-deps repository.

## Background

Previously, benchmarks comparing Hydro with other dataflow frameworks (timely and differential-dataflow) were located in the main Hydro repository under the `benches/` directory. These benchmarks have been moved to this separate repository to:

1. **Reduce Dependency Footprint**: Keep the main Hydro repository free from dependencies on external frameworks
2. **Maintain Clean Separation**: Separate core functionality from comparison benchmarks
3. **Preserve Performance Testing**: Retain the ability to run performance comparisons
4. **Avoid Transitive Dependencies**: Prevent timely and differential-dataflow dependencies from polluting the main codebase

## What Was Migrated

The following items were moved from the main repository to this repository:

### Benchmark Files
All benchmark source files from `benches/benches/`:
- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark
- `fork_join.rs` - Fork-join pattern benchmark
- `futures.rs` - Async futures benchmark
- `identity.rs` - Identity/passthrough benchmark
- `join.rs` - Join operations benchmark
- `micro_ops.rs` - Micro-operations benchmark
- `reachability.rs` - Graph reachability benchmark
- `symmetric_hash_join.rs` - Symmetric hash join benchmark
- `upcase.rs` - String uppercasing benchmark
- `words_diamond.rs` - Diamond pattern word processing benchmark

### Data Files
Large test data files:
- `reachability_edges.txt` - Graph edges for reachability tests
- `reachability_reachable.txt` - Expected reachability results
- `words_alpha.txt` - Word list for text processing benchmarks

### Configuration Files
- `benches/Cargo.toml` - Package configuration with benchmark definitions
- `benches/build.rs` - Build script for generating benchmark code
- `benches/README.md` - Basic usage instructions

### Supporting Files
- `rustfmt.toml` - Code formatting configuration
- `clippy.toml` - Linting configuration
- `rust-toolchain.toml` - Rust toolchain specification

## What Was Changed

### In the Main Hydro Repository

1. **Removed Files**:
   - Entire `benches/` directory
   - `.github/workflows/benchmark.yml` (CI workflow)

2. **Updated Documentation**:
   - `CONTRIBUTING.md` - Added section referencing this repository for benchmarks
   - Other documentation updated to remove benchmark references

3. **Workspace Configuration**:
   - Removed `benches` from workspace members in root `Cargo.toml`

4. **Dependencies**:
   - No more references to timely or differential-dataflow in any Cargo.toml files

### In This Repository (hydro-deps)

1. **New Structure**:
   - Created workspace with `benches/` as a member
   - Added root `Cargo.toml` for workspace configuration

2. **Updated Dependencies**:
   - Changed `dfir_rs` from path dependency to git dependency:
     ```toml
     dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
     ```
   - Changed `sinktools` from path dependency to git dependency:
     ```toml
     sinktools = { git = "https://github.com/hydro-project/hydro.git" }
     ```
   - Kept timely and differential-dataflow dependencies as-is

3. **New Documentation**:
   - `README.md` - Repository overview and quick start
   - `BENCHMARKING.md` - Comprehensive benchmarking guide
   - `MIGRATION.md` - This document

4. **Configuration**:
   - `.gitignore` - Git ignore patterns for Rust projects

## Directory Structure

### Before Migration (Main Repository)
```
hydro/
├── benches/
│   ├── Cargo.toml
│   ├── README.md
│   ├── build.rs
│   └── benches/
│       ├── arithmetic.rs
│       ├── ...
│       └── words_diamond.rs
├── dfir_rs/
├── hydro_lang/
└── ... (other packages)
```

### After Migration

**Main Repository (hydro)**:
```
hydro/
├── dfir_rs/
├── hydro_lang/
├── sinktools/
└── ... (other packages, no benches/)
```

**This Repository (hydro-deps)**:
```
hydro-deps/
├── Cargo.toml (workspace)
├── README.md
├── BENCHMARKING.md
├── MIGRATION.md
├── .gitignore
├── rustfmt.toml
├── clippy.toml
├── rust-toolchain.toml
└── benches/
    ├── Cargo.toml
    ├── README.md
    ├── build.rs
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_alpha.txt
        └── words_diamond.rs
```

## Dependency Changes

### Original (Path Dependencies)
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

### Updated (Git Dependencies)
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git" }
```

This change allows the benchmarks to work independently without requiring a local clone of the main repository, though you can override with path dependencies for local development if needed.

## Running Benchmarks After Migration

### Quick Start
```bash
# Clone this repository
git clone https://github.com/hydro-project/hydro-deps.git
cd hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench identity
```

### For Development with Local Hydro

If you're working on both repositories simultaneously:

1. Clone both repositories:
   ```bash
   git clone https://github.com/hydro-project/hydro.git
   git clone https://github.com/hydro-project/hydro-deps.git
   ```

2. Temporarily override dependencies in `hydro-deps/benches/Cargo.toml`:
   ```toml
   [dev-dependencies]
   dfir_rs = { path = "../../hydro/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../hydro/sinktools" }
   ```

3. Run benchmarks:
   ```bash
   cd hydro-deps
   cargo bench -p benches
   ```

## Performance Comparison Workflow

The migration preserves all performance comparison capabilities:

1. **Baseline Establishment**: Run benchmarks to establish baseline performance
2. **Change Testing**: Make changes to Hydro, update dependencies, re-run benchmarks
3. **Result Analysis**: Criterion automatically compares with previous runs
4. **Trend Tracking**: Archive criterion results for long-term trend analysis

See [BENCHMARKING.md](BENCHMARKING.md) for detailed instructions.

## Verification

To verify the migration was successful:

### In Main Repository (hydro)
- [ ] No `benches/` directory exists
- [ ] No references to `timely` or `differential-dataflow` in any Cargo.toml
- [ ] Workspace builds successfully: `cargo build`
- [ ] No `benches` in workspace members in root Cargo.toml
- [ ] CONTRIBUTING.md references this repository for benchmarks

### In This Repository (hydro-deps)
- [ ] All benchmark files present in `benches/benches/`
- [ ] Workspace structure set up correctly
- [ ] Git dependencies configured for dfir_rs and sinktools
- [ ] Configuration files present (rustfmt.toml, clippy.toml, rust-toolchain.toml)
- [ ] Documentation complete (README.md, BENCHMARKING.md, MIGRATION.md)
- [ ] Benchmarks can be run: `cargo bench -p benches`

## Maintenance

### Updating Benchmarks

To add or modify benchmarks:

1. Edit files in `benches/benches/`
2. Update `benches/Cargo.toml` if adding new benchmark files
3. Update documentation to reflect changes
4. Run benchmarks to verify they work
5. Commit and push changes

### Updating Hydro Dependencies

The benchmarks automatically use the latest version from the main repository's git master branch. To update:

```bash
cargo update -p dfir_rs -p sinktools
```

Or to use a specific version/tag:
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", tag = "v0.14.0", features = [ "debugging" ] }
```

## Questions and Issues

If you encounter issues with the migrated benchmarks:

1. Check that you're using the correct Rust version (see `rust-toolchain.toml`)
2. Ensure dependencies are up to date: `cargo update`
3. Try cleaning and rebuilding: `cargo clean && cargo bench`
4. For dependency issues, verify the main Hydro repository is accessible
5. For benchmark-specific issues, check [BENCHMARKING.md](BENCHMARKING.md)

## History

- **Migration Date**: December 2025
- **Reason**: Separate external framework comparison dependencies from main codebase
- **Preserved Functionality**: All benchmarks and performance comparison capabilities
- **Main Repository Commit**: See git history for removal of benches/ directory
- **This Repository Commit**: Initial addition of migrated benchmarks

## Related Documentation

- [README.md](README.md) - Repository overview
- [BENCHMARKING.md](BENCHMARKING.md) - Detailed benchmarking guide
- [Main Hydro Repository](https://github.com/hydro-project/hydro)
- [Hydro Documentation](https://hydro.run/)
