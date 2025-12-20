# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) to this dedicated reference benchmark repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date

December 20, 2025

## Rationale

The benchmarks were separated to achieve the following goals:

1. **Dependency Isolation** - Remove timely and differential-dataflow dependencies from the main Hydro codebase
2. **Cleaner Build** - Reduce compilation time and dependency tree complexity for the main repository
3. **Clear Separation** - Distinguish between DFIR-native benchmarks and reference/comparison benchmarks
4. **Maintainability** - Easier to maintain and update reference benchmarks independently

## Migrated Files

### Benchmark Files (from `bigweaver-agent-canary-hydro-zeta/benches/benches/`)

The following benchmark files were moved because they contain timely-dataflow or differential-dataflow implementations:

- `arithmetic.rs` - Arithmetic operations comparing timely, differential, and DFIR
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Relational join benchmarks
- `reachability.rs` - Graph reachability benchmarks with differential-dataflow
- `upcase.rs` - String transformation benchmarks

### Supporting Data Files

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark
- `words_alpha.txt` - English word list for word processing benchmarks
- `.gitignore` - Benchmark-specific ignore patterns

## Files Remaining in Main Repository

The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta/benches/` because they are DFIR-native and do not depend on timely or differential-dataflow:

- `futures.rs` - Async/futures operation benchmarks
- `micro_ops.rs` - DFIR micro-operation benchmarks
- `symmetric_hash_join.rs` - DFIR symmetric hash join benchmarks
- `words_diamond.rs` - DFIR word processing diamond pattern benchmark

## Dependency Changes

### Main Repository (bigweaver-agent-canary-hydro-zeta)

Removed from `benches/Cargo.toml`:
```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

### Reference Repository (bigweaver-agent-canary-zeta-hydro-deps)

Added to `benches/Cargo.toml`:
```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

## Running Benchmarks After Migration

### DFIR-Native Benchmarks (Main Repository)

```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### Reference/Comparison Benchmarks (This Repository)

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-zeta-reference-benches
```

### Cross-Repository Performance Comparison

To compare performance between DFIR and timely/differential implementations:

1. Run benchmarks in the main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

2. Run reference benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-zeta-reference-benches
   ```

3. Compare results from `target/criterion/` directories in both repositories

## Performance Comparison Workflow

For systematic performance comparisons:

1. **Baseline Measurements**
   - Run reference benchmarks to establish baseline performance
   - Document system specifications and conditions

2. **DFIR Measurements**
   - Run DFIR-native benchmarks under identical conditions
   - Ensure same input data and parameters

3. **Analysis**
   - Compare execution times, throughput, and memory usage
   - Identify performance characteristics and trade-offs
   - Document findings for future reference

## Impact on Existing Workflows

### Build Times
- Main repository builds faster without timely/differential dependencies
- Reference benchmarks can be built independently as needed

### CI/CD
- Main repository CI no longer needs to compile timely/differential
- Separate CI can be configured for reference benchmarks if needed

### Development
- DFIR development can proceed without timely/differential concerns
- Reference benchmarks remain available for performance validation

## Verification Steps

To verify the migration was successful:

1. **Build Verification**
   ```bash
   # Main repository should build without timely/differential
   cd bigweaver-agent-canary-hydro-zeta
   cargo build -p benches
   
   # Reference repository should build with timely/differential
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build -p hydro-zeta-reference-benches
   ```

2. **Benchmark Execution**
   ```bash
   # Both repositories should run their benchmarks successfully
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches --bench micro_ops
   
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-zeta-reference-benches --bench reachability
   ```

3. **Dependency Verification**
   ```bash
   # Main repository should not depend on timely/differential
   cd bigweaver-agent-canary-hydro-zeta
   cargo tree -p benches | grep -E "timely|differential" # Should return nothing
   
   # Reference repository should depend on them
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo tree -p hydro-zeta-reference-benches | grep -E "timely|differential" # Should show dependencies
   ```

## Future Considerations

### Adding New Benchmarks

- **DFIR-native benchmarks** → Add to `bigweaver-agent-canary-hydro-zeta/benches/`
- **Reference/comparison benchmarks** → Add to this repository

### Updating Dependencies

- Reference benchmarks may need periodic updates to track latest timely/differential versions
- Main repository DFIR development is independent of these updates

### Performance Tracking

- Consider establishing a performance tracking system across both repositories
- Archive benchmark results for historical comparison
- Document significant performance changes and their causes

## Rollback Procedure

If the migration needs to be reversed:

1. Copy benchmark files back to main repository
2. Restore dependencies in main repository's Cargo.toml
3. Update documentation to remove migration references

## Contact

For questions about this migration or benchmark usage, please:
- Open an issue in the respective repository
- Refer to benchmark documentation in README.md
- Consult the main Hydro documentation

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- This Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
