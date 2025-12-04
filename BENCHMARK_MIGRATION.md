# Benchmark Migration Guide

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The benchmarks were moved to:
1. **Reduce dependencies**: Remove timely and differential-dataflow dependencies from the core repository
2. **Separation of concerns**: Keep benchmarking infrastructure separate from the main codebase
3. **Maintain functionality**: Preserve all benchmark capabilities and performance comparison features
4. **Improve build times**: Reduce compilation time for the main repository

## Migration Details

### Files Moved

All files from the `benches/` directory in bigweaver-agent-canary-hydro-zeta:

#### Configuration Files
- `benches/Cargo.toml` - Package configuration with benchmark definitions
- `benches/README.md` - Benchmark usage documentation
- `benches/build.rs` - Build script
- `benches/benches/.gitignore` - Git ignore rules

#### Benchmark Source Files
- `benches/benches/arithmetic.rs` - Arithmetic operations benchmarks
- `benches/benches/fan_in.rs` - Fan-in pattern benchmarks
- `benches/benches/fan_out.rs` - Fan-out pattern benchmarks
- `benches/benches/fork_join.rs` - Fork-join pattern benchmarks
- `benches/benches/futures.rs` - Async futures benchmarks
- `benches/benches/identity.rs` - Identity transformation benchmarks
- `benches/benches/join.rs` - Stream join benchmarks
- `benches/benches/micro_ops.rs` - Micro-operations benchmarks
- `benches/benches/reachability.rs` - Graph reachability benchmarks
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `benches/benches/upcase.rs` - String transformation benchmarks
- `benches/benches/words_diamond.rs` - Diamond pattern benchmarks

#### Data Files
- `benches/benches/reachability_edges.txt` - Graph edge data for reachability tests
- `benches/benches/reachability_reachable.txt` - Expected reachability results
- `benches/benches/words_alpha.txt` - Word list for text processing benchmarks

### Dependencies Migrated

The following dependencies were moved from bigweaver-agent-canary-hydro-zeta to bigweaver-agent-canary-zeta-hydro-deps:

```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

These are now managed solely in the benchmarks repository.

### Changes Made

1. **Workspace Configuration**: Created a new workspace Cargo.toml for the deps repository
2. **Dependency Updates**: Changed path-based dependencies to crate dependencies:
   - `dfir_rs = { path = "../dfir_rs" }` → `dfir_rs = { version = "0.12" }`
   - `sinktools = { path = "../sinktools" }` → `sinktools = { version = "0.0.1" }`
3. **Documentation**: Added comprehensive README and migration documentation

## Usage After Migration

### Running Benchmarks

From the `bigweaver-agent-canary-zeta-hydro-deps` repository:

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run with specific configuration
cargo bench -p benches --bench arithmetic -- --warm-up-time 5
```

### Performance Comparison

Benchmarks maintain full compatibility with Criterion's reporting features:
- HTML reports generated in `target/criterion/`
- Statistical analysis of performance data
- Comparison with previous benchmark runs
- Support for custom baseline comparisons

### Development Workflow

1. Clone the benchmarks repository:
   ```bash
   git clone <repo-url> bigweaver-agent-canary-zeta-hydro-deps
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Run benchmarks:
   ```bash
   cargo bench -p benches
   ```

3. View results:
   - Check console output for immediate results
   - Open `target/criterion/report/index.html` for detailed reports

## Integration with Main Repository

The main `bigweaver-agent-canary-hydro-zeta` repository no longer contains these benchmarks. To run performance comparisons:

1. Ensure both repositories are available
2. Run benchmarks from the deps repository
3. Compare results with historical data or baselines

## Benefits

### For bigweaver-agent-canary-hydro-zeta
- ✅ Reduced dependency tree
- ✅ Faster build times
- ✅ Cleaner separation of concerns
- ✅ Smaller repository size

### For bigweaver-agent-canary-zeta-hydro-deps
- ✅ Dedicated benchmark infrastructure
- ✅ Independent versioning of benchmark dependencies
- ✅ Focused performance testing environment
- ✅ Maintained comparison capabilities

## Historical Context

The benchmarks were originally part of the main repository to facilitate easy comparison between Hydro/DFIR and timely/differential-dataflow implementations. As the project matured, the decision was made to separate concerns and reduce the dependency footprint of the core repository while maintaining all benchmarking capabilities.

## Future Considerations

- Benchmark results may be published to a centralized location for tracking
- CI/CD integration for automated benchmark runs
- Cross-repository performance regression detection
- Additional benchmarks may be added independently
