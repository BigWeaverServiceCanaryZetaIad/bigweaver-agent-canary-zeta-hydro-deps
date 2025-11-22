# Migration Notes: Benchmarks from Main Repository

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Migration Date

**November 22, 2024**

## Rationale

The benchmarks were moved to this separate repository to:

1. **Dependency Isolation** - Keep timely and differential-dataflow dependencies separate from the main codebase
2. **Repository Size Reduction** - Remove approximately 4.4 MB of benchmark code and data from the main repository
3. **Cleaner Separation of Concerns** - Maintain core functionality in the main repository while housing performance comparison tools separately
4. **Improved Build Times** - The main repository no longer needs to compile external benchmark dependencies
5. **Focused Development** - Keep the main repository focused on core Hydroflow/DFIR functionality

## What Was Migrated

### Benchmark Files

All files from the `benches/` directory in the main repository:

```
benches/
├── benches/
│   ├── arithmetic.rs                    # Arithmetic operations benchmarking
│   ├── fan_in.rs                       # Fan-in pattern benchmarking
│   ├── fan_out.rs                      # Fan-out pattern benchmarking
│   ├── fork_join.rs                    # Fork-join pattern benchmarking
│   ├── identity.rs                     # Identity operation benchmarking
│   ├── join.rs                         # Join operation benchmarking
│   ├── micro_ops.rs                    # Micro-operations benchmarking
│   ├── reachability.rs                 # Graph reachability benchmarking
│   ├── symmetric_hash_join.rs          # Symmetric hash join benchmarking
│   ├── upcase.rs                       # Uppercase transformation benchmarking
│   ├── words_diamond.rs                # Word processing diamond pattern
│   ├── reachability_edges.txt          # Test data for reachability (graph edges)
│   ├── reachability_reachable.txt      # Expected results for reachability tests
│   └── words_alpha.txt                 # English word list for text processing
├── Cargo.toml                           # Benchmark dependencies configuration
├── README.md                            # Benchmark documentation
└── build.rs                             # Build script for generated code
```

### Dependencies Migrated

The following dependencies that were exclusively used by benchmarks:

From `benches/Cargo.toml`:
- **timely** (package: "timely-master", version: "0.13.0-dev.1")
- **differential-dataflow** (package: "differential-dataflow-master", version: "0.13.0-dev.1")
- **criterion** (version: "0.5.0" with features: async_tokio, html_reports)
- **rand** (version: "0.8.0")
- **rand_distr** (version: "0.4.3")
- **tokio** (version: "1.29.0" with features: rt-multi-thread)
- **nameof** (version: "1.0.0")
- **seq-macro** (version: "0.2.0")
- **static_assertions** (version: "1.0.0")

### What Was NOT Migrated

The following remain in the main repository:
- Core Hydroflow/DFIR implementation (`dfir_rs`, `dfir_lang`, `dfir_macro`)
- All library and runtime code
- Production dependencies
- Example applications
- Documentation (except benchmark-specific docs)
- Tests for core functionality
- Configuration files (clippy.toml, rustfmt.toml, etc.)

## Changes Made to Main Repository

### Workspace Configuration

Modified `Cargo.toml` in the repository root:
- Removed `"benches"` from the workspace members list

### Documentation Added

Created documentation files in the main repository:
- **REMOVAL_SUMMARY.md** - Summary of what was removed
- **PERFORMANCE_COMPARISON.md** - Instructions for running performance comparisons
- **CHANGES_README.md** - Overview of changes
- **verify_removal.sh** - Script to verify the repository still builds correctly

### Workspace Remains Functional

The main repository workspace is fully functional after the removal:
```bash
cargo check --workspace   # Succeeds
cargo test --workspace    # Succeeds
cargo build --workspace   # Succeeds
```

## Changes Made to This Repository

### Repository Structure Created

New repository structure established:
```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/               # Migrated benchmark package
├── docs/                  # New documentation
├── scripts/               # Helper scripts (to be added)
├── Cargo.toml            # Workspace configuration
├── rust-toolchain.toml   # Rust toolchain specification
└── README.md             # Comprehensive repository documentation
```

### Dependency Path Updates

Updated `benches/Cargo.toml` to reference the main repository:

**Before (in main repository):**
```toml
hydroflow = { path = "../hydroflow", features = [ "debugging" ] }
```

**After (in deps repository):**
```toml
# Path to the main repository - adjust this path if needed
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", package = "dfir_rs", features = [ "debugging" ] }
# Alias dfir_rs as hydroflow for compatibility with existing benchmark code
hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", package = "dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

**Note:** The hydroflow package has been renamed to dfir_rs in the main repository. The alias maintains compatibility with existing benchmark code.

### Workspace Configuration

Created root `Cargo.toml` with workspace definition:
```toml
[workspace]
members = ["benches"]
resolver = "2"
```

### Documentation Created

Comprehensive documentation added:
- **README.md** - Main repository documentation
- **docs/QUICKSTART.md** - Quick start guide for running benchmarks
- **docs/BENCHMARKS_COMPARISON.md** - Detailed performance comparison guide
- **docs/MIGRATION.md** - This file

### Toolchain Specification

Added `rust-toolchain.toml` matching the main repository:
```toml
[toolchain]
channel = "1.91.1"
components = ["rustfmt", "clippy", "rust-src"]
targets = ["wasm32-unknown-unknown", "x86_64-unknown-linux-musl"]
```

## Repository Relationship

### Directory Structure

Both repositories should be cloned as siblings:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/      # Main repository
│   ├── dfir_rs/                             # Core implementation
│   ├── dfir_lang/
│   ├── hydro_lang/
│   ├── sinktools/
│   └── ...
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
    ├── benches/                             # Benchmarks
    ├── docs/
    └── ...
```

### Dependency Flow

```
bigweaver-agent-canary-zeta-hydro-deps/benches
    │
    ├─→ dfir_rs (from main repository)
    ├─→ sinktools (from main repository)
    ├─→ timely-master (external)
    └─→ differential-dataflow-master (external)
```

## Testing and Verification

### Main Repository Verification

Verified that the main repository builds and tests successfully:

```bash
cd bigweaver-agent-canary-hydro-zeta
./verify_removal.sh  # Automated verification script
# OR manually:
cargo check --workspace
cargo test --workspace
cargo build --workspace
```

### This Repository Verification

Verify benchmarks work correctly:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build --workspace
cargo bench --bench identity  # Run a quick benchmark
```

## Migration Benefits

### For Main Repository

1. **Reduced Complexity** - Fewer dependencies to manage
2. **Faster Builds** - No need to compile timely/differential-dataflow
3. **Smaller Repository** - ~4.4 MB reduction in repository size
4. **Clearer Focus** - Main repository focuses on core functionality
5. **Easier Onboarding** - New developers don't need benchmark dependencies

### For Benchmark Repository

1. **Isolation** - Benchmarks can be updated independently
2. **Flexibility** - Can add more benchmark frameworks without affecting main repo
3. **Performance Focus** - Dedicated repository for performance comparison work
4. **Documentation** - Comprehensive benchmark-specific documentation
5. **Tooling** - Can add benchmark-specific tools and scripts

### For Developers

1. **Clear Separation** - Easy to understand what goes where
2. **Performance Testing** - Benchmarks remain fully functional
3. **Cross-Repository Testing** - Can test main repo changes via path dependencies
4. **Version Control** - Benchmark changes don't clutter main repo history
5. **CI/CD Flexibility** - Can set up separate CI pipelines for benchmarks

## Breaking Changes

### None for End Users

This migration does not affect:
- The public API of Hydroflow/DFIR
- Any production functionality
- Library behavior or semantics
- Published crates

### For Developers Running Benchmarks

**Before Migration:**
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

**After Migration:**
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

The only change is which repository to navigate to.

## Path Adjustments

If your directory structure differs from the expected layout, adjust paths in `benches/Cargo.toml`:

```toml
[dev-dependencies]
# Adjust these paths based on your directory structure
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", package = "dfir_rs", features = [ "debugging" ] }
hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", package = "dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

For example, if repositories are in different locations:
```toml
dfir_rs = { path = "/absolute/path/to/bigweaver-agent-canary-hydro-zeta/dfir_rs", package = "dfir_rs", features = [ "debugging" ] }
```

## Timeline

| Date | Event |
|------|-------|
| Nov 21-22, 2024 | Benchmarks removed from main repository |
| Nov 22, 2024 | This repository created with migrated benchmarks |
| Nov 22, 2024 | Documentation completed |
| Nov 22, 2024 | Migration verification completed |

## Rollback Plan

If needed, the benchmarks can be restored to the main repository:

1. Copy the `benches/` directory back to the main repository
2. Add `"benches"` back to the workspace members in `Cargo.toml`
3. Remove or archive this repository

However, given the benefits of the separation, this is unlikely to be necessary.

## Related Changes

This migration is part of a coordinated effort to improve repository organization and dependency management across the BigWeaver Canary Zeta project.

### Companion Changes

- Main repository PR: [To be added]
- This repository initial commit: [To be added]

## Future Considerations

### Potential Enhancements

1. **CI/CD Integration** - Set up automated benchmark runs
2. **Performance Dashboards** - Track performance trends over time
3. **Additional Benchmarks** - Add more framework comparisons
4. **Benchmark Automation** - Scripts for common benchmark workflows
5. **Historical Data** - Maintain long-term performance history

### Maintenance

This repository should be maintained in parallel with the main repository:
- Update benchmarks when APIs change
- Add benchmarks for new features
- Keep dependencies synchronized with main repository
- Update documentation as needed

## Questions and Support

For questions about:
- **Benchmark functionality** - See [QUICKSTART.md](QUICKSTART.md) and [BENCHMARKS_COMPARISON.md](BENCHMARKS_COMPARISON.md)
- **Repository structure** - See main [README.md](../README.md)
- **Main repository** - Refer to `bigweaver-agent-canary-hydro-zeta` documentation
- **Migration details** - This document

## References

- Main repository: `bigweaver-agent-canary-hydro-zeta`
- Main repository removal summary: `../bigweaver-agent-canary-hydro-zeta/REMOVAL_SUMMARY.md`
- Performance comparison guide: `../bigweaver-agent-canary-hydro-zeta/PERFORMANCE_COMPARISON.md`
- This repository README: [../README.md](../README.md)

## Conclusion

This migration successfully isolates benchmark dependencies while maintaining full benchmark functionality and the ability to perform cross-repository performance testing. The separation improves both repository organization and developer experience.
