# Benchmark Migration Documentation

This document describes the benchmarks that were migrated from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated benchmarks repository.

## Migration Date

December 29, 2024

## Purpose

This repository separates benchmarks and dependency-heavy components from the core Hydro functionality to:
- Maintain a cleaner dependency tree in the main repository
- Reduce technical debt
- Enable independent development and maintenance of benchmark infrastructure
- Facilitate performance comparisons with Timely Dataflow and Differential Dataflow

## Migrated Files

### Benchmark Source Files

All benchmark files from `bigweaver-agent-canary-hydro-zeta/benches/` have been copied:

1. **benches/benches/micro_ops.rs** (12KB)
   - Benchmarks for micro-operations: identity, unique, map, flat_map, join, difference, union, tee, fold, sort, cross_join, anti_join, next_tick, group_by
   - Tests core dataflow operations performance

2. **benches/benches/symmetric_hash_join.rs** (4.5KB)
   - Benchmarks for symmetric hash join operations
   - Tests various join scenarios: no match, matching keys with different values, matching with random data

3. **benches/benches/words_diamond.rs** (7KB)
   - Diamond pattern dataflow benchmark using English word dictionary
   - Tests complex dataflow patterns with branching and merging

4. **benches/benches/futures.rs** (4.8KB)
   - Benchmarks for async futures handling
   - Tests immediately available futures, delayed futures in various states

5. **benches/benches/words_alpha.txt** (3.7MB)
   - English words dictionary used by word benchmarks
   - Source: https://github.com/dwyl/english-words

### Build Configuration

- **benches/build.rs** (1.1KB)
  - Build script that generates fork-join benchmark configurations
  - Creates dynamic benchmark code for testing parallel operations

- **benches/Cargo.toml**
  - Benchmark package configuration
  - Updated with timely and differential-dataflow dependencies

### Supporting Configuration Files

- **Cargo.toml** - Workspace configuration
- **rust-toolchain.toml** - Rust toolchain version (1.91.1)
- **rustfmt.toml** - Code formatting rules
- **clippy.toml** - Linting configuration
- **.gitignore** - Git ignore patterns

### Documentation

- **README.md** - Repository overview and usage instructions
- **CONTRIBUTING.md** - Contribution guidelines and development workflow
- **benches/README.md** - Benchmark-specific documentation

## Key Changes from Original

### Dependency Configuration

The `benches/Cargo.toml` has been updated:

1. **Added Dependencies** (in [dependencies] section):
   - `timely = "0.12"` - For Timely Dataflow comparison benchmarks
   - `differential-dataflow = "0.12"` - For Differential Dataflow comparison benchmarks

2. **Updated References** (in [dev-dependencies] section):
   - `dfir_rs`: Changed from `path = "../dfir_rs"` to `git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git"`
   - `sinktools`: Changed from `path = "../sinktools"` to `git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git"`

### Rationale for Changes

- Git references allow the benchmarks to access the core Hydro functionality without requiring local path dependencies
- Adding timely and differential-dataflow as explicit dependencies enables future benchmarks that compare Hydro's performance against these established frameworks
- This separation aligns with the team's architectural preference for isolating dependency-heavy components

## Benchmark Functionality

All benchmarks retain their original functionality:

✅ Micro-operations benchmarks measure individual operator performance  
✅ Symmetric hash join benchmarks test join algorithm efficiency  
✅ Words diamond benchmarks verify complex dataflow patterns  
✅ Futures benchmarks evaluate async operation handling  

## Running Benchmarks

### Quick Start

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

### Viewing Results

Benchmark results are generated as HTML reports in `target/criterion/`. The reports include:
- Performance measurements with statistical analysis
- Historical comparisons (when running multiple times)
- Detailed per-benchmark metrics
- Visualization of performance trends

## Future Enhancements

With timely and differential-dataflow dependencies now available, future work can include:

1. **Comparative Benchmarks**: Direct performance comparisons between Hydro, Timely, and Differential Dataflow for equivalent operations
2. **Reachability Algorithms**: Graph traversal and reachability benchmarks comparing frameworks
3. **Complex Joins**: Multi-way join benchmarks across different implementations
4. **Incremental Computation**: Benchmarks testing incremental update performance

## Dependencies

### Direct Dependencies (Added)
- `timely = "0.12"` - Timely dataflow framework
- `differential-dataflow = "0.12"` - Differential dataflow framework

### Development Dependencies (Migrated)
- `criterion = "0.5.0"` - Benchmarking framework with async support
- `dfir_rs` (git reference) - Core Hydro/DFIR implementation
- `sinktools` (git reference) - Utility tools
- `futures = "0.3"` - Futures and async utilities
- `rand = "0.8.0"` - Random number generation
- `rand_distr = "0.4.3"` - Random distributions
- `tokio = "1.29.0"` - Async runtime
- Various utility crates (nameof, seq-macro, static_assertions)

## Verification

All benchmark files have been successfully copied and verified:
- ✅ All source files present
- ✅ Build configuration maintained
- ✅ Data files included (words_alpha.txt)
- ✅ Dependencies updated correctly
- ✅ Configuration files in place

## Notes for Maintainers

1. **Dependency Updates**: When updating timely or differential-dataflow, ensure compatibility with the Hydro implementation
2. **Git References**: The git references to dfir_rs and sinktools pull from the main repository - ensure the main repository remains accessible
3. **Benchmark History**: Criterion stores historical benchmark data in `target/criterion/` - consider preserving this across builds for trend analysis
4. **Performance Baselines**: Establish baseline performance metrics for each benchmark to detect regressions

## Related Documentation

- Main repository: `bigweaver-agent-canary-hydro-zeta`
- Hydro documentation: See main repository's docs/
- Criterion documentation: https://bheisler.github.io/criterion.rs/
