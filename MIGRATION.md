# Migration Guide: Timely and Differential-Dataflow Benchmarks

## Overview

This document provides guidance for developers working with the benchmarks that were moved from `bigweaver-agent-canary-hydro-zeta` to `bigweaver-agent-canary-zeta-hydro-deps`.

## What Changed

### Benchmarks Moved

The following benchmarks were moved to this repository:
- `arithmetic.rs`
- `fan_in.rs`
- `fan_out.rs`
- `fork_join.rs`
- `identity.rs`
- `join.rs`
- `reachability.rs`
- `upcase.rs`

### Data Files Moved

Associated data files were also moved:
- `reachability_edges.txt`
- `reachability_reachable.txt`
- `words_alpha.txt`

### Benchmarks Remaining

These benchmarks remain in `bigweaver-agent-canary-hydro-zeta/benches`:
- `futures.rs`
- `micro_ops.rs`
- `symmetric_hash_join.rs`
- `words_diamond.rs`

These benchmarks do not depend on timely or differential-dataflow.

## Why the Migration?

### Benefits

1. **Reduced Dependencies** - The main repository no longer needs timely or differential-dataflow dependencies
2. **Faster Build Times** - Developers working on core functionality experience faster builds
3. **Better Separation of Concerns** - Performance comparison benchmarks are isolated from core functionality
4. **Cleaner Dependency Tree** - Main repository has a simpler dependency graph
5. **Maintained Performance Comparison** - We still retain the ability to benchmark against timely/differential

### Design Philosophy

This migration aligns with our team's modular architecture approach:
- Core functionality stays in the main repository
- Dependencies used only for testing/benchmarking are separated
- Each repository has a clear, focused purpose

## For Developers

### Running Benchmarks After Migration

#### From Main Repository

If you're working in `bigweaver-agent-canary-hydro-zeta`:

```bash
# Run remaining benchmarks in main repo
cargo bench -p benches

# Run timely/differential benchmarks from deps repo
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-deps-benches

# Run specific benchmark
cargo bench -p hydro-deps-benches --bench reachability
```

#### From Deps Repository

If you're working in `bigweaver-agent-canary-zeta-hydro-deps`:

```bash
# Run all benchmarks
cargo bench -p hydro-deps-benches

# Run specific benchmark
cargo bench -p hydro-deps-benches --bench arithmetic
```

### Performance Comparison Workflow

To compare dfir_rs performance against timely/differential:

1. **Navigate to deps repository**:
   ```bash
   cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Run benchmarks**:
   ```bash
   cargo bench -p hydro-deps-benches
   ```

3. **View results**:
   - HTML reports: `target/criterion/<benchmark_name>/report/index.html`
   - Console output shows comparison statistics

4. **Compare implementations**:
   Each benchmark file contains multiple functions (e.g., `benchmark_timely`, `benchmark_differential`, `benchmark_hydroflow`) that can be compared directly.

### Adding New Benchmarks

#### Benchmarks WITHOUT timely/differential dependencies

Add to `bigweaver-agent-canary-hydro-zeta/benches/`:
1. Create benchmark file in `benches/benches/your_benchmark.rs`
2. Add `[[bench]]` entry to `benches/Cargo.toml`
3. Update `benches/README.md`

#### Benchmarks WITH timely/differential dependencies

Add to `bigweaver-agent-canary-zeta-hydro-deps/benches/`:
1. Create benchmark file in `benches/benches/your_benchmark.rs`
2. Add `[[bench]]` entry to `benches/Cargo.toml`
3. Update `benches/README.md`

### Modifying Existing Benchmarks

#### For moved benchmarks (timely/differential):
- Location: `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`
- Cargo.toml: `bigweaver-agent-canary-zeta-hydro-deps/benches/Cargo.toml`
- Dependencies: Available from deps repo workspace

#### For remaining benchmarks:
- Location: `bigweaver-agent-canary-hydro-zeta/benches/benches/`
- Cargo.toml: `bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml`
- Dependencies: Available from main repo workspace

### Dependency Management

#### Main Repository
After migration, the main repository's `benches/Cargo.toml` no longer includes:
- `timely`
- `differential-dataflow`

These dependencies are only in the deps repository.

#### Deps Repository
The deps repository includes:
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`
- `dfir_rs` (via git reference to main repository)
- `sinktools` (via git reference to main repository)

### CI/CD Considerations

#### Build Pipeline
- Main repository builds are now faster (no timely/differential)
- Deps repository builds include heavyweight dependencies
- Consider running deps benchmarks on-demand or scheduled rather than every commit

#### Performance Testing
- Benchmark runs should execute from the deps repository
- Results can be published to a central location
- Trend tracking may need to accommodate the new structure

### Troubleshooting

#### "Cannot find benchmark X"
- Check which repository the benchmark is in using the lists above
- Ensure you're running `cargo bench` from the correct directory

#### "Cannot find dfir_rs"
- In deps repository, `dfir_rs` comes from git reference
- Ensure you have network access for git dependencies
- Check that the git reference is up to date

#### "Benchmark results differ from before"
- Benchmark behavior should be identical
- Results may vary due to system conditions
- Use Criterion's baseline comparison for accurate comparisons

## Version Compatibility

### Main Repository
- Rust edition: 2024
- No timely/differential dependencies

### Deps Repository
- Rust edition: 2024
- timely-master: 0.13.0-dev.1
- differential-dataflow-master: 0.13.0-dev.1
- dfir_rs: git reference (main branch)

## Timeline

- **Before Migration**: All benchmarks in main repository
- **After Migration**: Timely/differential benchmarks in deps repository
- **Backward Compatibility**: N/A (development structure change)

## Questions and Support

For questions about:
- **Benchmark implementation**: See individual benchmark files
- **Migration issues**: Consult this document or MIGRATION_SUMMARY.md
- **Performance results**: See BENCHMARK_DETAILS.md
- **Contributing**: See CONTRIBUTING.md

## Related Documentation

- `README.md` - Repository overview
- `MIGRATION_SUMMARY.md` - Quick reference for migration
- `BENCHMARK_DETAILS.md` - Detailed benchmark descriptions
- `benches/README.md` - Benchmark-specific documentation
- `CONTRIBUTING.md` - Contribution guidelines
