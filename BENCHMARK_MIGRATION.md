# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the bigweaver-agent-canary-hydro-zeta repository to this dedicated benchmarking repository (bigweaver-agent-canary-zeta-hydro-deps).

## Background

The benchmarks were originally part of the main Hydro repository but were removed to maintain clean dependency separation and reduce technical debt. These benchmarks relied on `timely-dataflow` and `differential-dataflow` packages, which introduced significant dependency overhead into the main repository.

The team's architectural strategy emphasizes:
- Clean separation of concerns
- Isolated dependency management
- Modular repository organization
- Independent component development

By moving these benchmarks to a dedicated repository, we maintain the ability to run performance comparisons while keeping the main codebase free from benchmark-specific dependencies.

## Migration Details

### Source

**Original Repository**: bigweaver-agent-canary-hydro-zeta  
**Original Location**: `benches/` directory  
**Git Commit Reference**: `871a388d^` (parent of first removal commit)

### Destination

**New Repository**: bigweaver-agent-canary-zeta-hydro-deps  
**New Location**: `benches/` directory (workspace member)

### Migrated Files

#### Benchmark Configuration
- `benches/Cargo.toml` - Package configuration with all dependencies
- `benches/README.md` - Benchmark usage documentation
- `benches/build.rs` - Build-time code generation script
- `benches/benches/.gitignore` - Ignore patterns for generated files

#### Benchmark Implementations
- `benches/benches/arithmetic.rs` - Arithmetic operations benchmark
- `benches/benches/fan_in.rs` - Fan-in pattern benchmark
- `benches/benches/fan_out.rs` - Fan-out pattern benchmark
- `benches/benches/fork_join.rs` - Fork-join pattern benchmark
- `benches/benches/futures.rs` - Futures-based operations benchmark
- `benches/benches/identity.rs` - Identity transformation benchmark
- `benches/benches/join.rs` - Join operations benchmark
- `benches/benches/micro_ops.rs` - Micro-operations benchmark
- `benches/benches/reachability.rs` - Graph reachability benchmark
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmark
- `benches/benches/upcase.rs` - String transformation benchmark
- `benches/benches/words_diamond.rs` - Diamond pattern word processing

#### Test Data Files
- `benches/benches/reachability_edges.txt` - Graph edges data (532 KB)
- `benches/benches/reachability_reachable.txt` - Expected results (38 KB)
- `benches/benches/words_alpha.txt` - English word list (3.8 MB)

#### Workspace Configuration
- `Cargo.toml` - Workspace configuration
- `rust-toolchain.toml` - Rust toolchain specification (v1.91.1)
- `rustfmt.toml` - Code formatting rules
- `clippy.toml` - Linting configuration

## Changes Made During Migration

### Dependency Updates

The `benches/Cargo.toml` dependencies were updated to use Git references instead of local paths:

**Before (Original)**:
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

**After (Migration)**:
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git" }
differential-dataflow = { git = "https://github.com/TimelyDataflow/differential-dataflow.git" }
timely = { git = "https://github.com/TimelyDataflow/timely-dataflow.git" }
```

This change ensures that:
- The benchmarks can be built independently
- No local filesystem dependencies are required
- The repository is self-contained
- Updates from the main repository are automatically available

### New Files Created

- `README.md` - Comprehensive repository documentation
- `BENCHMARK_MIGRATION.md` - This migration documentation file
- `Cargo.toml` - Workspace-level configuration
- `rust-toolchain.toml` - Consistent toolchain specification
- `rustfmt.toml` - Code formatting standards
- `clippy.toml` - Linting standards

## Preserved Functionality

All original benchmark functionality has been preserved:

### ✅ Performance Comparison Capability
- Benchmarks compare timely, differential-dataflow, and Hydro (dfir_rs)
- All comparison metrics remain available
- Historical performance tracking can continue

### ✅ Independent Execution
- Benchmarks can be run without the main repository
- All dependencies are accessible via Git
- No manual setup required beyond standard Rust toolchain

### ✅ Data Files
- All test data files (reachability graphs, word lists) are included
- File paths and references remain unchanged
- Benchmarks can run with original test data

### ✅ Build Configuration
- Build script (`build.rs`) preserved for code generation
- All compiler configurations maintained
- Profile settings (release, dev) configured appropriately

## Benefits of Migration

### 1. Cleaner Main Repository
- Removed 13+ benchmark files from main repository
- Eliminated timely/differential-dataflow dependencies
- Reduced compilation time for main repository
- Simplified dependency tree

### 2. Improved Dependency Isolation
- Benchmark-specific dependencies contained in separate repository
- Main repository no longer needs timely/differential packages
- Reduced risk of dependency conflicts
- Clearer separation between core functionality and benchmarking

### 3. Independent Development
- Benchmarks can be updated independently
- No risk of benchmark changes affecting main codebase
- Easier to maintain and extend benchmarks
- Can add new benchmarks without touching main repository

### 4. Maintained Performance Testing
- All performance comparison capabilities preserved
- Benchmarks can still be run on-demand
- Results can be compared with historical data
- No loss of performance visibility

## Usage After Migration

### Running Benchmarks

From this repository:
```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

### Updating Dependencies

Dependencies are automatically fetched from Git. To update to the latest versions:
```bash
cargo update
```

To use a specific revision of dfir_rs or sinktools, update `benches/Cargo.toml`:
```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "abc123", features = [ "debugging" ] }
```

## Verification

### Build Verification
```bash
cargo build --workspace
```
Expected: Clean build with all dependencies resolved.

### Benchmark Execution Verification
```bash
cargo bench -p benches --bench identity
```
Expected: Benchmark runs and produces timing results.

### Dependency Check
```bash
cargo tree -p benches
```
Expected: Shows timely, differential-dataflow, dfir_rs, and sinktools in the dependency tree.

### Format Check
```bash
cargo fmt --all -- --check
```
Expected: All code follows formatting standards.

### Lint Check
```bash
cargo clippy --all
```
Expected: No clippy warnings or errors.

## Related Documentation

- [Main Repository BENCHMARK_REMOVAL.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_REMOVAL.md) - Documents the removal from main repository
- [benches/README.md](benches/README.md) - Benchmark-specific usage documentation
- [Main Repository README.md](README.md) - This repository's main documentation

## Timeline

- **Original Implementation**: Benchmarks created in main repository
- **Removal**: Benchmarks removed from main repository (multiple commits)
- **Migration**: Benchmarks added to this dedicated repository
- **Status**: Active and maintained

## Coordination

This migration is part of a coordinated effort across repositories:
- **Main Repository**: Removed benchmarks and dependencies
- **This Repository**: Added complete benchmark suite with all dependencies
- **Companion PRs**: Coordinated changes ensure smooth transition

## Future Enhancements

Potential improvements for this benchmark repository:

1. **CI/CD Integration**
   - Automated benchmark runs
   - Performance regression detection
   - Trend analysis and reporting

2. **Additional Benchmarks**
   - New dataflow patterns
   - Real-world workload simulations
   - Memory usage benchmarks

3. **Documentation**
   - Benchmark interpretation guide
   - Performance optimization tips
   - Comparison methodology documentation

4. **Tooling**
   - Scripts for result comparison
   - Visualization tools
   - Automated report generation

## Questions or Issues

If you encounter issues with the migrated benchmarks or have questions about this migration:

1. Check this documentation for common scenarios
2. Review the benchmark README in `benches/README.md`
3. Consult the main repository's BENCHMARK_REMOVAL.md
4. Open an issue in this repository with detailed information

## Conclusion

This migration successfully moves timely and differential-dataflow benchmarks to a dedicated repository while:
- Maintaining all performance comparison functionality
- Ensuring independent execution capability
- Preserving test data and configurations
- Following team standards for code quality and documentation
- Achieving cleaner dependency separation

The benchmarks remain fully functional and can be executed independently, supporting the team's ongoing performance testing and optimization efforts.

---

**Document Version**: 1.0  
**Last Updated**: 2024  
**Migration Completion**: Successful  
**Related Request**: Add timely and differential-dataflow benchmarks to hydro-deps repository
