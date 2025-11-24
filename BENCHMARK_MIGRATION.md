# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Background

### Motivation

The benchmarks that compare Timely Dataflow, Differential Dataflow, and Hydroflow/dfir_rs implementations were moved to this separate repository for several reasons:

1. **Dependency Isolation**: Keep timely and differential-dataflow dependencies separate from the main Hydro codebase
2. **Reduced Complexity**: Simplify the main repository's dependency tree
3. **Independent Execution**: Enable benchmarks to run independently without requiring the full Hydro workspace
4. **Faster Compilation**: Reduce compilation time for the main repository
5. **Clear Separation of Concerns**: Distinguish between core functionality and performance comparison tools

### Original Location

The benchmarks were originally located in the `bigweaver-agent-canary-hydro-zeta` repository at:
- Path: `benches/`
- Workspace member: Listed in root `Cargo.toml`
- CI/CD: `.github/workflows/benchmark.yml`

## What Was Migrated

### Directory Structure

```
benches/
├── Cargo.toml              # Package configuration
├── README.md               # Benchmark documentation
├── build.rs                # Build script for code generation
└── benches/                # Benchmark implementations
    ├── .gitignore
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

### Benchmark Files

All 12 benchmark implementations were migrated:

1. **arithmetic.rs**: Arithmetic operations and computations
2. **fan_in.rs**: Multiple inputs to single output
3. **fan_out.rs**: Single input to multiple outputs
4. **fork_join.rs**: Parallel execution with synchronization
5. **futures.rs**: Async/future operations
6. **identity.rs**: Pass-through baseline benchmarks
7. **join.rs**: Data joining operations
8. **micro_ops.rs**: Fine-grained operation benchmarks
9. **reachability.rs**: Graph reachability algorithms
10. **symmetric_hash_join.rs**: Hash join implementations
11. **upcase.rs**: String transformations
12. **words_diamond.rs**: Diamond dataflow pattern

### Data Files

- **words_alpha.txt**: 370K+ English words (3.7 MB)
- **reachability_edges.txt**: Graph edge data (520 KB)
- **reachability_reachable.txt**: Expected reachability results (38 KB)

### Dependencies

The following dependencies are now isolated in this repository:

```toml
[dev-dependencies]
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

### CI/CD Workflow

The benchmark workflow was migrated and updated:
- Original: `.github/workflows/benchmark.yml` in main repository
- New: `.github/workflows/benchmark.yml` in this repository
- Maintains same functionality:
  - Scheduled daily runs
  - Manual trigger support
  - PR-triggered runs with `[ci-bench]` tag
  - Results published to GitHub Pages

## Migration Changes

### Dependency References

**Before** (path-based references):
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After** (git-based references):
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro", version = "^0.0.1" }
```

### Workspace Configuration

A new workspace `Cargo.toml` was created at the root level:
```toml
[workspace]
members = [
    "benches",
]
resolver = "2"

[workspace.package]
edition = "2024"
license = "Apache-2.0"
repository = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps"
```

### Documentation Updates

1. **README.md**: Comprehensive repository documentation
2. **benches/README.md**: Enhanced benchmark usage guide
3. **BENCHMARK_MIGRATION.md**: This migration document
4. **CONTRIBUTING.md**: Contribution guidelines (to be created)

## Verification

### Functionality Preserved

All benchmarks retain their original functionality:
- ✅ Timely Dataflow implementations
- ✅ Differential Dataflow implementations
- ✅ Hydroflow/dfir_rs implementations
- ✅ Performance comparison capabilities
- ✅ Statistical analysis via Criterion
- ✅ HTML report generation
- ✅ Code generation (fork_join via build.rs)

### Independent Execution

Benchmarks can now run independently:
```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run benchmarks (no other repository needed)
cargo bench -p benches
```

### Performance Comparison Maintained

The ability to compare performance across implementations is fully preserved:
```bash
# Compare all implementations
cargo bench -p benches

# Compare specific patterns
cargo bench -p benches -- dfir
cargo bench -p benches -- timely
cargo bench -p benches -- differential
```

## Impact on Main Repository

### Changes in bigweaver-agent-canary-hydro-zeta

The main repository was updated with:

1. **Removed `benches` directory**: Entire benchmark crate removed
2. **Updated root Cargo.toml**: Removed `"benches"` from workspace members
3. **Removed CI workflow**: Deleted `.github/workflows/benchmark.yml`
4. **Added documentation**: Created `BENCHMARK_REMOVAL.md` explaining the removal
5. **Created verification script**: Added `verify_removal.sh` to validate cleanup

### Benefits to Main Repository

- ✅ No timely/differential-dataflow dependencies
- ✅ Faster compilation times
- ✅ Simplified dependency tree
- ✅ Smaller repository size
- ✅ Clearer focus on core functionality

### Maintained Capabilities

- ✅ Benchmarks still available (in this repository)
- ✅ Performance tracking continues
- ✅ Historical data preserved
- ✅ CI/CD integration maintained

## Usage After Migration

### For Developers

**Running Benchmarks**:
```bash
# Clone the deps repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench identity
```

**Comparing Implementations**:
```bash
# Compare Hydroflow vs Timely vs Differential
cargo bench -p benches --bench arithmetic

# Focus on Hydroflow
cargo bench -p benches -- dfir
```

**Viewing Results**:
```bash
# Open HTML report
open target/criterion/report/index.html
```

### For CI/CD

The benchmark workflow continues to run automatically:
- **Daily**: Scheduled at 8:35 PM PDT / 7:35 PM PST
- **On-demand**: Manual workflow dispatch with `should_bench: true`
- **Pull Requests**: Include `[ci-bench]` in PR title or description
- **Commits**: Include `[ci-bench]` in commit message

Results are published to GitHub Pages for tracking over time.

### For Researchers

Benchmarks provide fair comparisons between dataflow systems:
- Statistical rigor via Criterion
- Multiple implementations of same algorithms
- Real-world data sets
- Comprehensive test coverage

## Future Enhancements

### Planned Improvements

1. **Additional Benchmarks**:
   - More dataflow patterns
   - Larger scale tests
   - Memory usage profiling
   - Network overhead tests

2. **Better Documentation**:
   - Performance tuning guide
   - Architecture comparison analysis
   - Best practices for each system

3. **Enhanced CI/CD**:
   - Performance regression alerts
   - Automatic comparison reports
   - Integration with main repository CI

4. **Expanded Comparisons**:
   - Other dataflow systems
   - Different hardware configurations
   - Various data sizes and patterns

### Contributing

To contribute new benchmarks or improvements:

1. Fork this repository
2. Create a feature branch
3. Implement your changes
4. Add documentation
5. Submit a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## Coordination Between Repositories

### Cross-Repository Changes

When making changes that affect both repositories:

1. **Create companion PRs**: Coordinate changes across repositories
2. **Reference in PR descriptions**: Link related PRs
3. **Update documentation**: Ensure both repositories' docs are current
4. **Test integration**: Verify benchmarks work with latest main repository changes

### Version Compatibility

This repository tracks the main repository's changes:
- Git dependencies reference the main repository
- Updates are coordinated through companion PRs
- Breaking changes are documented

### Communication

For questions or coordination:
- Open issues in the relevant repository
- Reference this migration documentation
- Tag related issues across repositories

## Related Resources

### Documentation

- [Main Repository](https://github.com/hydro-project/hydro)
- [Benchmark Documentation](benches/README.md)
- [Repository README](README.md)

### External Resources

- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)
- [Hydroflow Documentation](https://hydro.run/)

## Migration Timeline

- **Initial Development**: Benchmarks created in main repository
- **Decision Point**: Team decided to separate dependencies
- **Migration**: Benchmarks moved to dedicated repository
- **Documentation**: Comprehensive documentation created
- **CI/CD Setup**: Automated workflows configured
- **Verification**: Independent execution confirmed

## Lessons Learned

### Best Practices

1. **Preserve Git History**: Use git operations that maintain history
2. **Comprehensive Documentation**: Document rationale and process
3. **Independent Testing**: Ensure standalone functionality
4. **Clear Communication**: Update all relevant documentation

### Challenges Addressed

1. **Dependency Resolution**: Changed from path to git dependencies
2. **Workspace Setup**: Created new workspace configuration
3. **CI/CD Updates**: Adapted workflows for new repository
4. **Documentation**: Created comprehensive guides for both repositories

## Conclusion

The migration of benchmarks to this dedicated repository successfully:
- ✅ Isolated timely and differential-dataflow dependencies
- ✅ Maintained all performance comparison capabilities
- ✅ Enabled independent benchmark execution
- ✅ Simplified the main repository
- ✅ Preserved historical context and documentation

The benchmarks continue to serve their purpose of providing fair, comprehensive performance comparisons between different dataflow implementations while keeping the main Hydro repository focused on core functionality.

## Appendix: Complete File List

### Files Migrated
```
benches/Cargo.toml
benches/README.md
benches/build.rs
benches/benches/.gitignore
benches/benches/arithmetic.rs
benches/benches/fan_in.rs
benches/benches/fan_out.rs
benches/benches/fork_join.rs
benches/benches/futures.rs
benches/benches/identity.rs
benches/benches/join.rs
benches/benches/micro_ops.rs
benches/benches/reachability.rs
benches/benches/reachability_edges.txt
benches/benches/reachability_reachable.txt
benches/benches/symmetric_hash_join.rs
benches/benches/upcase.rs
benches/benches/words_alpha.txt
benches/benches/words_diamond.rs
```

### Files Created
```
Cargo.toml                    # Workspace configuration
README.md                     # Repository documentation
BENCHMARK_MIGRATION.md        # This file
CONTRIBUTING.md               # Contribution guidelines
.github/workflows/benchmark.yml  # CI/CD workflow
```

Total: 19 files migrated, 5 files created, ~4.4 MB of data