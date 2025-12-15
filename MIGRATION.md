# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated benchmarks repository (bigweaver-agent-canary-zeta-hydro-deps).

## Motivation

The benchmark migration was performed to:

1. **Reduce Build Dependencies**: Remove timely and differential-dataflow dependencies from the main repository, significantly reducing build times for developers who don't need performance comparison benchmarks
2. **Isolate External Dependencies**: Keep external framework dependencies separate from the core Hydro/DFIR codebase
3. **Improve Maintainability**: Separate concerns between core development and performance benchmarking
4. **Preserve Functionality**: Maintain the ability to run performance comparisons with Timely/Differential-Dataflow when needed

## Migrated Benchmarks

The following benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to this repository:

### Benchmark Files

1. **arithmetic.rs** - Arithmetic operations benchmark comparing pipeline performance across implementations (uses timely)
2. **fan_in.rs** - Fan-in pattern benchmark measuring aggregation performance (uses timely)
3. **fan_out.rs** - Fan-out pattern benchmark measuring distribution performance (uses timely)
4. **fork_join.rs** - Fork-join pattern benchmark for parallel computation patterns (uses timely)
5. **identity.rs** - Identity operations benchmark measuring baseline overhead (uses timely)
6. **join.rs** - Join operations benchmark comparing join implementations (uses timely)
7. **reachability.rs** - Graph reachability benchmark using differential dataflow (uses differential-dataflow)
8. **upcase.rs** - String transformation benchmark (uses timely)

### Supporting Files

- **build.rs** - Build script for generating fork_join benchmark code
- **reachability_edges.txt** - Graph edge data for reachability benchmark (55,008 edges)
- **reachability_reachable.txt** - Expected reachable nodes for reachability benchmark validation

### Configuration Files

- **Cargo.toml** - Package configuration with timely/differential-dataflow dependencies
- **README.md** - Documentation for running benchmarks
- **.gitignore** - Ignore patterns for generated files

## Removed Dependencies

The following dependencies were removed from `bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml`:

```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

These dependencies are now only present in this repository's `benches/Cargo.toml`.

## Benchmarks Remaining in Main Repository

The following Hydro-native benchmarks remain in `bigweaver-agent-canary-hydro-zeta` as they don't depend on external frameworks:

- **futures.rs** - Futures-based operations benchmark
- **micro_ops.rs** - Micro-operations performance benchmark
- **symmetric_hash_join.rs** - Symmetric hash join implementation benchmark
- **words_diamond.rs** - Word processing diamond pattern benchmark

Associated data file remaining:
- **words_alpha.txt** - Word list for word processing benchmarks

## Migration Process

The migration involved:

1. Extracting benchmark files from git history (commit 30839475^ where they existed before removal)
2. Creating proper workspace structure in this repository
3. Setting up Cargo.toml with appropriate dependencies
4. Including build scripts and data files
5. Creating documentation (README.md, MIGRATION.md)
6. Updating CONTRIBUTING.md in main repository to reference this repository

## Running Benchmarks

### In This Repository

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench upcase
```

### Viewing Results

Benchmark results are stored in `target/criterion/` with HTML reports. Open the HTML files in your browser to view:
- Performance metrics (throughput, latency)
- Statistical analysis
- Historical comparison graphs (if running multiple times)

## Performance Comparison Workflow

To compare performance between Hydro/DFIR and Timely/Differential-Dataflow:

1. **Clone both repositories**:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Run benchmarks in main repository** (Hydro-native):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Run benchmarks in deps repository** (Timely/Differential comparisons):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

4. **Compare results**: 
   - Both repositories use criterion for consistent benchmarking
   - Results are in `target/criterion/` in each repository
   - HTML reports allow easy visualization of performance differences
   - Criterion's statistical analysis helps determine significance of differences

## Impact on Development Workflow

### For Core Hydro Development

Developers working on core Hydro/DFIR functionality no longer need to:
- Build timely and differential-dataflow dependencies
- Wait for external dependency compilation
- Manage complex dependency chains

This results in:
- Faster initial builds
- Faster incremental compilation
- Reduced disk space usage
- Simpler development environment setup

### For Performance Analysis

Developers interested in performance comparisons:
- Clone this repository separately
- Run benchmarks independently
- Can still make direct comparisons with identical benchmark code

## Repository Relationship

```
bigweaver-agent-canary-hydro-zeta/
├── Core Hydro/DFIR implementation
├── Hydro-native benchmarks (no external deps)
└── Documentation and examples

bigweaver-agent-canary-zeta-hydro-deps/
└── Benchmarks with timely/differential-dataflow dependencies
```

## Future Benchmark Additions

When adding new benchmarks:

- **Benchmarks WITHOUT timely/differential-dataflow dependencies** → Add to main repository
- **Benchmarks WITH timely/differential-dataflow dependencies** → Add to this repository

This keeps the separation of concerns clear and maintains the performance benefits of the migration.

## Version Compatibility

Both repositories should maintain compatibility:
- Use the same `dfir_rs` version for fair comparisons
- Update benchmark code in parallel when APIs change
- Coordinate releases when benchmark interfaces change

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- This Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
