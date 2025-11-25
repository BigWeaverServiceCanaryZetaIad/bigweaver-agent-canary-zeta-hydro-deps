# Benchmark Migration Guide

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from `bigweaver-agent-canary-hydro-zeta` to this repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date

November 25, 2024

## Rationale

The benchmarks were moved to this dedicated repository to:

1. **Reduce Dependencies**: Remove benchmark-only dependencies from the main repository
2. **Improve Build Times**: Separate benchmark compilation from main project builds
3. **Maintain Separation of Concerns**: Keep performance testing code separate from production code
4. **Enable Focused Development**: Allow independent development and versioning of benchmarks

## What Was Moved

### Benchmarks Migrated

The following benchmarks focusing on timely and differential-dataflow were migrated:

1. **arithmetic.rs** - Basic arithmetic operations through dataflow
2. **fan_in.rs** - Stream concatenation operations
3. **upcase.rs** - String transformation operations
4. **join.rs** - Hash join operations
5. **reachability.rs** - Graph reachability with differential dataflow

### Supporting Files

- Benchmark data files (`reachability_edges.txt`, `reachability_reachable.txt`)
- Build configuration (`build.rs`)
- Package configuration (`Cargo.toml`)

## What Was Modified

### Dependency Changes

**Removed Dependencies:**
- `dfir_rs` - Hydroflow-specific dataflow library (not needed for timely/differential benchmarks)
- `sinktools` - Hydroflow utilities (not needed)

**Retained Dependencies:**
- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)  
- `criterion` (0.5.0)
- `futures`, `tokio`, `rand`, and other supporting libraries

### Benchmark Code Changes

Each benchmark file was modified to:
- Remove `dfir_rs` and `sinktools` imports
- Remove Hydroflow-specific benchmark functions
- Retain timely and differential-dataflow benchmark functions
- Retain baseline/comparison benchmark functions (raw iterations, etc.)

### Excluded Benchmarks

The following benchmarks were NOT migrated as they primarily tested Hydroflow/dfir_rs functionality:

- `fan_out.rs` (primarily Hydroflow-focused)
- `fork_join.rs` (primarily Hydroflow-focused)
- `futures.rs` (primarily Hydroflow-focused)
- `identity.rs` (primarily Hydroflow-focused)
- `micro_ops.rs` (primarily Hydroflow-focused)
- `symmetric_hash_join.rs` (primarily Hydroflow-focused)
- `words_diamond.rs` (primarily Hydroflow-focused)

These remain in the main `bigweaver-agent-canary-hydro-zeta` repository.

## Impact on Main Repository

### In bigweaver-agent-canary-hydro-zeta

The following changes should be made:

1. **Remove timely/differential benchmarks** from the benches directory
2. **Update Cargo.toml** to remove benchmark entries for migrated files
3. **Update documentation** to reference this repository for timely/differential benchmarks
4. **Optional**: Add this repository as a git submodule if tight integration is desired

## Using the Benchmarks

### From the New Repository

```bash
# Clone this repository
git clone <repo-url> bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Run benchmarks
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
# Run only timely benchmarks
cargo bench -p benches --bench arithmetic -- timely
cargo bench -p benches --bench reachability -- timely

# Run only differential benchmarks
cargo bench -p benches --bench reachability -- differential

# Run a complete benchmark suite
cargo bench -p benches --bench reachability
```

## Workspace Configuration

This repository includes its own workspace configuration with:

- Rust edition 2024
- Optimized release profile
- Appropriate linting rules
- Profile configurations for benchmarking

## Verification

To verify the migration was successful:

1. **Build Check**:
   ```bash
   cargo check --benches
   ```

2. **Run Benchmarks**:
   ```bash
   cargo bench -p benches
   ```

3. **Verify Outputs**:
   - Check that criterion generates HTML reports in `target/criterion/`
   - Verify benchmark results are reasonable compared to historical data

## Rollback Procedure

If issues arise, benchmarks can be restored to the main repository:

1. Copy benchmark files back to `bigweaver-agent-canary-hydro-zeta/benches/benches/`
2. Restore Cargo.toml entries
3. Restore dependencies (timely, differential-dataflow, criterion)

## Future Considerations

### Potential Enhancements

1. **CI/CD Integration**: Set up automated benchmark runs on commits
2. **Performance Tracking**: Implement historical performance tracking
3. **Additional Benchmarks**: Add more timely/differential-dataflow patterns
4. **Comparison Reports**: Generate automated comparison reports

### Maintenance

- Keep timely and differential-dataflow versions in sync with main repository
- Update benchmarks when new features are added to timely/differential
- Monitor for performance regressions

## Questions and Support

For questions about this migration or the benchmarks:

1. Check the main [README.md](README.md) for usage instructions
2. Review benchmark source code for implementation details
3. Consult timely/differential-dataflow documentation for dataflow concepts

## Change History

- **2024-11-25**: Initial migration of timely and differential-dataflow benchmarks
  - Migrated 5 core benchmarks
  - Removed dfir_rs dependencies
  - Created dedicated repository structure
  - Established workspace configuration
