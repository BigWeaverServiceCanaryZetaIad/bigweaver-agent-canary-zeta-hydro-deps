# Migration Documentation

## Timely and Differential-Dataflow Benchmarks Migration

**Migration Date**: 2024-11-25  
**Source Repository**: bigweaver-agent-canary-hydro-zeta  
**Destination Repository**: bigweaver-agent-canary-zeta-hydro-deps  

### Overview

This document details the migration of timely-dataflow and differential-dataflow 
benchmarks from the main repository to this dedicated dependencies repository.

### Rationale

1. **Separation of Concerns**: Keep benchmarks for external dependencies separate 
   from the main codebase
2. **Dependency Management**: Reduce unnecessary dependencies in the main repository
3. **Independent Evolution**: Allow benchmarks to evolve independently
4. **Cleaner Main Repository**: Keep the main repository focused on core functionality

### Migrated Files

#### Source Files
From: `bigweaver-agent-canary-hydro-zeta/benches/benches/`

| File | Size | Purpose |
|------|------|---------|
| arithmetic.rs | ~8KB | Arithmetic operation benchmarks |
| fan_in.rs | ~4KB | Stream merging benchmarks |
| fan_out.rs | ~4KB | Stream splitting benchmarks |
| fork_join.rs | ~8KB | Fork-join pattern benchmarks |
| identity.rs | ~8KB | Identity/pass-through benchmarks |
| join.rs | ~8KB | Stream join benchmarks |
| reachability.rs | ~16KB | Graph reachability benchmarks |
| upcase.rs | ~8KB | String transformation benchmarks |

#### Data Files
| File | Size | Purpose |
|------|------|---------|
| reachability_edges.txt | ~524KB | Graph edges for reachability test |
| reachability_reachable.txt | ~40KB | Expected reachable nodes |
| words_alpha.txt | ~3.7MB | Word list for string benchmarks |

#### Configuration Files
| File | Purpose |
|------|---------|
| build.rs | Build script for generating benchmark code |
| Cargo.toml | Package configuration (adapted for new location) |

### Changes Made

#### 1. Removed Dependencies

The following dfir_rs (Hydroflow) specific code was removed from benchmark files:

```rust
// Removed imports
use dfir_rs::dfir_syntax;
use dfir_rs::scheduled::graph::Dfir;
use dfir_rs::scheduled::graph_ext::GraphExt;
use dfir_rs::scheduled::handoff::{Iter, VecHandoff};
use dfir_rs::sinktools::{SinkBuild, SinkBuilder, ToSinkBuild};
```

#### 2. Removed Benchmark Functions

The following types of benchmark functions were removed:
- `benchmark_hydroflow_*`
- `benchmark_dfir_rs_*`
- Any functions using `dfir_syntax!` macro
- Functions depending on `sinktools` crate

#### 3. Retained Functionality

**Kept all**:
- Timely-dataflow benchmarks (`benchmark_timely*`)
- Differential-dataflow benchmarks (`benchmark_differential*`)
- Baseline comparison benchmarks (raw, iter, pipeline, etc.)
- All data files
- All criterion benchmark configurations

#### 4. Updated Configuration

**New Cargo.toml**:
- Removed `dfir_rs` dependency
- Removed `sinktools` dependency
- Removed workspace references
- Added standalone package configuration
- Kept all other dependencies (criterion, timely, differential-dataflow, etc.)

**New Workspace Structure**:
Created `Cargo.toml` at repository root to define workspace.

### Verification Steps

To verify the migration was successful:

1. **Check all timely benchmarks compile**:
   ```bash
   cargo check -p timely-benchmarks
   ```

2. **Run all benchmarks**:
   ```bash
   cargo bench -p timely-benchmarks
   ```

3. **Verify specific benchmarks**:
   ```bash
   cargo bench -p timely-benchmarks --bench arithmetic
   cargo bench -p timely-benchmarks --bench reachability
   cargo bench -p timely-benchmarks --bench join
   ```

4. **Check data files are included**:
   ```bash
   ls -lh timely-benchmarks/benches/*.txt
   ```

5. **Verify baseline benchmarks work**:
   ```bash
   cargo bench -p timely-benchmarks -- raw
   cargo bench -p timely-benchmarks -- iter
   ```

### Performance Comparison Capability

The migration maintains full performance comparison capability:

#### Before Migration
```
arithmetic/dfir_rs/compiled
arithmetic/dfir_rs/surface  
arithmetic/timely            ✅ Kept
arithmetic/pipeline          ✅ Kept
arithmetic/raw              ✅ Kept
arithmetic/iter             ✅ Kept
```

#### After Migration
```
arithmetic/timely           ✅ Available
arithmetic/pipeline         ✅ Available  
arithmetic/raw              ✅ Available
arithmetic/iter             ✅ Available
```

All timely and differential-dataflow benchmarks continue to support:
- Performance measurement
- Comparison against baselines
- Historical performance tracking
- Regression detection

### Impact on Main Repository

After this migration, the main repository (`bigweaver-agent-canary-hydro-zeta`) 
can optionally:

1. **Remove migrated benchmarks** from `benches/benches/` (if desired)
2. **Update documentation** to reference this repository for timely benchmarks
3. **Remove or keep** the timely/differential-dataflow dependencies as needed
4. **Maintain only** Hydroflow-specific benchmarks

### Usage Examples

#### Running Timely Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-benchmarks -- timely
```

#### Running Differential Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-benchmarks -- differential
```

#### Running Specific Pattern Benchmarks
```bash
# Reachability benchmarks
cargo bench -p timely-benchmarks --bench reachability

# Join benchmarks  
cargo bench -p timely-benchmarks --bench join

# String operation benchmarks
cargo bench -p timely-benchmarks --bench upcase
```

#### Comparing with Baselines
```bash
# Compare timely with raw implementations
cargo bench -p timely-benchmarks -- "arithmetic/(timely|raw)"

# Compare all implementations of identity pattern
cargo bench -p timely-benchmarks --bench identity
```

### Maintenance Guidelines

#### When Adding New Benchmarks

1. Add benchmark file to `timely-benchmarks/benches/`
2. Update `timely-benchmarks/Cargo.toml` with new `[[bench]]` entry
3. Update `timely-benchmarks/README.md` with benchmark description
4. Ensure only timely/differential-dataflow dependencies are used
5. Include baseline comparisons where applicable

#### When Updating Benchmarks

1. Maintain backward compatibility in benchmark names
2. Document changes in commit messages
3. Update relevant documentation
4. Run full benchmark suite to verify
5. Consider performance regression implications

#### When Updating Dependencies

1. Update dependency versions in `Cargo.toml`
2. Test all benchmarks compile and run
3. Document any breaking changes
4. Consider maintaining compatibility with main repository versions

### Rollback Procedure

If needed, to rollback this migration:

1. Copy benchmark files back to original location
2. Restore dfir_rs specific benchmark functions
3. Add back removed dependencies
4. Update main repository workspace configuration
5. Remove this repository or keep for future use

### Related Documentation

- [Main README](README.md) - Repository overview
- [Timely Benchmarks README](timely-benchmarks/README.md) - Detailed benchmark docs
- [Main Repository](../bigweaver-agent-canary-hydro-zeta/README.md) - Original location

### Migration Checklist

- [x] Create destination repository structure
- [x] Copy benchmark source files
- [x] Copy data files
- [x] Copy build.rs
- [x] Create new Cargo.toml configurations
- [x] Remove dfir_rs dependencies from code
- [x] Remove dfir_rs benchmark functions
- [x] Update criterion_group! macros
- [x] Create comprehensive README
- [x] Create migration documentation
- [x] Verify file integrity
- [x] Document verification steps
- [x] Document usage examples
- [x] Document maintenance guidelines

### Questions and Support

For questions about this migration or the benchmarks:

1. Check the [Timely Benchmarks README](timely-benchmarks/README.md)
2. Check the [Main README](README.md)
3. Review commit history for specific changes
4. Contact the team responsible for the migration
