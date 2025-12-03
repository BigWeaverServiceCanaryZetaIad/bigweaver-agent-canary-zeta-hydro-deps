# Migration Documentation

This document describes the migration of timely and differential-dataflow benchmarks from `bigweaver-agent-canary-hydro-zeta` to `bigweaver-agent-canary-zeta-hydro-deps`.

## Migration Date
November 21, 2024

## Rationale

The benchmarks were moved to this dedicated repository to:
1. **Maintain clean dependency boundaries** - Isolate timely/differential-dataflow dependencies
2. **Reduce complexity** - Keep the main codebase focused on core functionality
3. **Enable independent evolution** - Allow benchmarks to evolve separately
4. **Improve build times** - Avoid compiling benchmark dependencies in main repo
5. **Facilitate specialized CI/CD** - Enable dedicated benchmark workflows

## What Was Migrated

### Directory Structure
```
benchmarks/
├── Cargo.toml           # Benchmark package configuration
├── build.rs             # Build script for code generation
├── README.md            # Quick reference for running benchmarks
└── benches/             # Benchmark implementations
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
All benchmark implementations were preserved exactly as they were in the source repository, including:
- Performance comparison implementations for Timely, Differential, and Hydroflow
- Test data files (reachability graphs, word lists)
- Build scripts for code generation

### Dependencies
The following dependencies are now isolated in this repository:
- `timely-master` (v0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (v0.13.0-dev.1) - Differential dataflow framework
- `criterion` (v0.5.0) - Benchmarking framework
- Supporting dependencies: futures, rand, tokio, etc.

Dependencies on main Hydro code (`dfir_rs`, `sinktools`) are referenced via git from the source repository.

## Changes Made

### 1. Repository Structure

Created new repository structure:
```
bigweaver-agent-canary-zeta-hydro-deps/
├── .github/
│   └── workflows/
│       └── benchmark.yml       # CI/CD for benchmarks
├── benchmarks/                 # Migrated benchmark code
├── Cargo.toml                  # Workspace configuration
├── rust-toolchain.toml         # Rust toolchain specification
├── .gitignore                  # Git ignore rules
├── README.md                   # Repository documentation
├── BENCHMARK_GUIDE.md          # Comprehensive benchmark guide
└── MIGRATION.md                # This file
```

### 2. Dependency Updates

**Original (in source repository):**
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**Updated (in this repository):**
```toml
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

### 3. Workspace Configuration

Created a minimal workspace `Cargo.toml` that:
- Defines workspace members (benchmarks)
- Sets edition, license, and repository metadata
- Includes workspace-level lints matching the source repository
- Uses resolver = "2" for dependency resolution

### 4. CI/CD Workflow

Created `.github/workflows/benchmark.yml` that:
- Runs benchmarks on schedule (weekly)
- Supports manual triggering
- Runs on commits with `[ci-bench]` tag
- Stores benchmark results as artifacts
- Compares PR performance with main branch
- Provides benchmark completion notifications

### 5. Documentation

Created comprehensive documentation:
- **README.md** - Overview, usage, and quick start
- **BENCHMARK_GUIDE.md** - Detailed guide for running and creating benchmarks
- **MIGRATION.md** - This migration documentation

## Preserved Functionality

All performance comparison functionality has been retained:

✅ **Timely Dataflow Benchmarks**
- All timely implementations work exactly as before
- Same algorithms and patterns
- Identical performance characteristics

✅ **Differential Dataflow Benchmarks**
- All differential implementations preserved
- Same incremental computation patterns
- Identical semantics

✅ **Hydroflow/DFIR Benchmarks**
- Both scheduled and compiled implementations
- Referenced from source repository via git
- Same API and behavior

✅ **Test Data**
- All test data files included (reachability graphs, word lists)
- Checksums verified

✅ **Build Scripts**
- Code generation scripts preserved
- Same build process

✅ **Statistical Analysis**
- Criterion.rs integration unchanged
- Same HTML reports and statistical output
- Baseline comparison capabilities

## Usage Changes

### Before (in source repository)

From the source repository root:
```bash
cargo bench -p benches
```

### After (in this repository)

From this repository root:
```bash
cargo bench -p benchmarks
```

Note: Package name changed from `benches` to `benchmarks` for clarity.

## Verification

### Functionality Checklist

- [x] All benchmark files migrated
- [x] Test data files included
- [x] Build scripts work
- [x] Dependencies correctly referenced
- [x] Workspace configuration valid
- [x] CI/CD workflow configured
- [x] Documentation complete
- [x] Git repository initialized
- [x] .gitignore configured

### Testing

To verify the migration:

```bash
# Clone this repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Check workspace structure
cargo metadata --no-deps

# Build benchmarks
cargo build -p benchmarks --release

# Run a single benchmark to verify
cargo bench -p benchmarks --bench identity

# Run all benchmarks (takes longer)
cargo bench -p benchmarks
```

## Impact on Source Repository

The source repository (`bigweaver-agent-canary-hydro-zeta`) has been cleaned up:

### Files Removed
- `benches/` directory (entire directory)
- `.github/workflows/benchmark.yml` (benchmark CI workflow)
- Benchmark-related entries in `Cargo.toml`
- Benchmark dependencies from `Cargo.lock`

### Files Added/Modified
- `BENCHMARK_REMOVAL_SUMMARY.md` - Detailed summary of removal
- `BENCHMARK_REMOVAL_QUICK_REFERENCE.md` - Quick reference
- `CONTRIBUTING.md` - Removed reference to benches directory
- `Cargo.toml` - Removed "benches" from workspace members
- `Cargo.lock` - Removed benchmark dependencies

### Dependencies Removed from Source
The following dependencies were completely removed as they were only used by benchmarks:
- `criterion`
- `differential-dataflow-master`
- `timely-master`
- `abomonation`
- `abomonation_derive`
- `timely-bytes-master`
- `timely-communication-master`
- `timely-container-master`
- `timely-logging-master`

## Benefits Achieved

### 1. Clean Dependency Boundaries
- Main repository no longer depends on timely/differential
- Clear separation of concerns
- Easier to understand dependency tree

### 2. Reduced Build Times
- Main repository builds faster without benchmark dependencies
- CI/CD for main repo is more efficient
- Developers working on core features don't need benchmark deps

### 3. Independent Evolution
- Benchmarks can be updated without affecting main repo
- Can upgrade timely/differential independently
- Separate versioning and release cycles

### 4. Improved Documentation
- Dedicated documentation for benchmarks
- Clear usage instructions
- Comprehensive benchmark guide

### 5. Specialized CI/CD
- Benchmark-specific workflows
- Performance tracking over time
- Independent benchmark scheduling

## Future Enhancements

Potential improvements for this repository:

1. **Performance Tracking**
   - Store historical benchmark results
   - Visualize performance trends over time
   - Automated performance regression detection

2. **Additional Benchmarks**
   - More complex dataflow patterns
   - Real-world application benchmarks
   - Scalability benchmarks with varying data sizes

3. **Cross-Framework Comparisons**
   - Add benchmarks for other dataflow frameworks
   - Include Apache Flink comparisons
   - Streaming SQL engine comparisons

4. **Automated Reporting**
   - Generate markdown reports
   - Post results to dashboards
   - Integrate with monitoring systems

5. **Distributed Benchmarks**
   - Multi-node performance tests
   - Network overhead analysis
   - Scaling characteristics

## Maintenance

### Keeping Benchmarks Updated

The benchmarks reference `dfir_rs` and `sinktools` from the main repository. To update:

```bash
# Update to latest main branch
cargo update -p dfir_rs -p sinktools

# Or pin to specific commit
# Edit Cargo.toml and add rev = "..."
```

### Adding New Benchmarks

See `BENCHMARK_GUIDE.md` for detailed instructions on adding new benchmarks.

### Updating Dependencies

```bash
# Update timely/differential
cargo update -p timely-master -p differential-dataflow-master

# Update criterion
cargo update -p criterion

# Update all dependencies
cargo update
```

## Rollback Plan

If issues arise, the benchmarks can be restored to the source repository:

1. Copy `benchmarks/` directory back to source as `benches/`
2. Update `Cargo.toml` to use path dependencies
3. Add "benches" to workspace members
4. Restore `.github/workflows/benchmark.yml`
5. Run `cargo update` to regenerate Cargo.lock

The git history in the source repository preserves the original benchmark code at commit `484e6fdd`.

## Contact

For questions about this migration:
- Review the source repository documentation
- Check the Hydro project documentation
- Consult the team's architectural guidelines

## References

- Source Repository: https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Benchmark Removal Summary: See `BENCHMARK_REMOVAL_SUMMARY.md` in source repo
- Criterion.rs: https://bheisler.github.io/criterion.rs/book/
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

## License

Apache-2.0 (same as source repository)
