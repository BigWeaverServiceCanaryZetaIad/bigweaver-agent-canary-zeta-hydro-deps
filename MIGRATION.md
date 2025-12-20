# Benchmark Migration Documentation

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The main Hydro repository (bigweaver-agent-canary-hydro-zeta) aims to remain dependency-free with respect to timely-dataflow and differential-dataflow. However, maintaining performance comparison benchmarks is valuable for:

1. **Performance Validation** - Ensuring DFIR performance remains competitive
2. **Regression Detection** - Identifying performance regressions across releases
3. **Research & Development** - Supporting academic and industrial research
4. **Design Decisions** - Informing architectural and implementation choices

By separating these benchmarks into a dedicated repository, we achieve both goals: keeping the main codebase clean while preserving performance comparison capabilities.

## Migration Details

### Date
December 20, 2025

### Migrated Benchmarks

The following benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to `bigweaver-agent-canary-zeta-hydro-deps/benches/`:

| Benchmark File | Description | Data Files |
|----------------|-------------|------------|
| `arithmetic.rs` | Arithmetic operation performance tests | - |
| `fan_in.rs` | Fan-in pattern (multiple inputs to one) | - |
| `fan_out.rs` | Fan-out pattern (one input to multiple) | - |
| `fork_join.rs` | Fork-join with filtering operations | - |
| `identity.rs` | Identity/pass-through operations | - |
| `join.rs` | Join operation implementations | - |
| `reachability.rs` | Graph reachability algorithms | `reachability_edges.txt`, `reachability_reachable.txt` |
| `upcase.rs` | String uppercase transformations | - |

### Benchmarks Remaining in Main Repository

The following DFIR-native benchmarks remain in `bigweaver-agent-canary-hydro-zeta/benches/`:

| Benchmark File | Description | Data Files |
|----------------|-------------|------------|
| `micro_ops.rs` | DFIR micro-operation benchmarks | - |
| `futures.rs` | Async/futures operation benchmarks | - |
| `symmetric_hash_join.rs` | Symmetric hash join performance tests | - |
| `words_diamond.rs` | Word processing diamond pattern | `words_alpha.txt` |

These benchmarks do not require timely or differential-dataflow dependencies and use only DFIR operations.

## Dependencies

### Before Migration (bigweaver-agent-canary-hydro-zeta)

The benchmarks package included:
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`
- Local path dependencies: `dfir_rs`, `sinktools`

### After Migration

**bigweaver-agent-canary-hydro-zeta:**
- Removed timely and differential-dataflow dependencies
- Retained only DFIR-native benchmarks
- Local path dependencies: `dfir_rs`, `sinktools`

**bigweaver-agent-canary-zeta-hydro-deps:**
- Added timely and differential-dataflow dependencies
- Git dependencies: `dfir_rs`, `sinktools` (from upstream hydro repository)
- All timely/differential comparison benchmarks

## Usage After Migration

### Running DFIR-Native Benchmarks

In the main repository:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### Running Comparison Benchmarks

In the deps repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benchmarks
```

### Running All Benchmarks

To run both sets of benchmarks:
```bash
# In main repository
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# In deps repository
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benchmarks
```

## File Structure

### bigweaver-agent-canary-zeta-hydro-deps Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md                      # Repository overview
├── MIGRATION.md                   # This file
└── benches/
    ├── Cargo.toml                 # Package configuration with timely/differential deps
    ├── README.md                  # Benchmark documentation
    ├── build.rs                   # Build script for generated code
    └── benches/
        ├── arithmetic.rs          # Arithmetic benchmarks
        ├── fan_in.rs             # Fan-in benchmarks
        ├── fan_out.rs            # Fan-out benchmarks
        ├── fork_join.rs          # Fork-join benchmarks
        ├── identity.rs           # Identity benchmarks
        ├── join.rs               # Join benchmarks
        ├── reachability.rs       # Reachability benchmarks
        ├── upcase.rs             # Upcase benchmarks
        ├── reachability_edges.txt       # Graph data
        ├── reachability_reachable.txt   # Expected results
        └── .gitignore            # Ignore generated files
```

## Maintaining Benchmarks

### Adding New Comparison Benchmarks

New benchmarks that compare DFIR with timely/differential-dataflow should be added to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

### Adding New DFIR-Native Benchmarks

New benchmarks that only use DFIR features should be added to the `bigweaver-agent-canary-hydro-zeta` repository.

### Updating Existing Benchmarks

When updating benchmarks:
1. Ensure DFIR implementations are in sync across both repositories
2. Test both benchmark suites after changes
3. Update documentation if benchmark behavior changes

## Performance Comparison Workflow

To maintain performance validation:

1. **Before Releases**: Run both benchmark suites
2. **Compare Results**: Check for regressions in DFIR performance
3. **Document Changes**: Note significant performance changes in release notes
4. **Investigate Regressions**: If DFIR performance degrades relative to timely/differential, investigate and address

## References

- Main Hydro Repository: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

## Questions and Support

For questions about:
- **Benchmark implementation**: See individual benchmark source files
- **Running benchmarks**: See `benches/README.md`
- **Migration rationale**: See this document's Motivation section
- **Contributing**: See `CONTRIBUTING.md` in the main repository
