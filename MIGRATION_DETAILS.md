# Migration Details: Timely/Differential-Dataflow Benchmarks

## Overview

This document describes the migration of timely-dataflow and differential-dataflow benchmarks from the bigweaver-agent-canary-hydro-zeta repository to this dedicated repository (bigweaver-agent-canary-zeta-hydro-deps).

## Migration Date

December 10, 2025

## Rationale

The benchmarks were moved to:
1. **Reduce dependency overhead** in the main repository
2. **Improve build performance** by removing timely and differential-dataflow from the main dependency tree
3. **Reduce security surface area** by isolating these dependencies
4. **Maintain performance comparison capability** in a dedicated location

## What Was Migrated

### Benchmark Files

All benchmark files from `bigweaver-agent-canary-hydro-zeta/benches/` were moved:

- `benches/Cargo.toml` - Benchmark package configuration
- `benches/README.md` - Benchmark documentation  
- `benches/build.rs` - Build script
- `benches/benches/` - All benchmark source files:
  - `arithmetic.rs`
  - `fan_in.rs`
  - `fan_out.rs`
  - `fork_join.rs`
  - `futures.rs`
  - `identity.rs`
  - `join.rs`
  - `micro_ops.rs`
  - `reachability.rs`
  - `reachability_edges.txt`
  - `reachability_reachable.txt`
  - `symmetric_hash_join.rs`
  - `upcase.rs`
  - `words_alpha.txt`
  - `words_diamond.rs`
  - `.gitignore`

## Changes Made

### In bigweaver-agent-canary-zeta-hydro-deps

1. **Created Cargo workspace** (`Cargo.toml`)
   - Configured workspace with benches member
   - Set up workspace-level lints and package metadata

2. **Updated benches/Cargo.toml**
   - Changed `dfir_rs` from path dependency to git dependency (rev: 484e6fdd)
   - Changed `sinktools` from path dependency to git dependency (rev: 484e6fdd)
   - Retained timely-dataflow and differential-dataflow dependencies

3. **Updated README.md**
   - Added comprehensive documentation about benchmarks
   - Included usage instructions
   - Listed all available benchmarks

4. **Created this MIGRATION_DETAILS.md**
   - Documents the migration process and rationale

### In bigweaver-agent-canary-hydro-zeta

1. **Removed benches directory** and all its contents
2. **Removed benches from workspace members** in `Cargo.toml`
3. **Cleaned Cargo.lock** to remove timely/differential-dataflow dependencies

## Performance Comparison Capability

The migration **retains** the ability to run performance comparisons between Hydro and timely/differential-dataflow implementations. Users can:

1. Clone this repository
2. Run benchmarks using `cargo bench -p benches`
3. Compare results between Hydro (dfir_rs) and timely/differential implementations

## Dependencies

The benchmarks now reference the main hydro repository via git dependencies:
- `dfir_rs` - git dependency at rev 484e6fdd
- `sinktools` - git dependency at rev 484e6fdd
- `timely-master` - crates.io version 0.13.0-dev.1
- `differential-dataflow-master` - crates.io version 0.13.0-dev.1

## References

- Source repository: https://github.com/hydro-project/hydro
- Git revision used for dependencies: 484e6fdd

## Verification

To verify the migration:

```bash
# In bigweaver-agent-canary-hydro-zeta
cargo build --workspace  # Should not pull in timely/differential
cargo tree | grep -i timely  # Should show no results
cargo tree | grep -i differential  # Should show no results

# In bigweaver-agent-canary-zeta-hydro-deps  
cargo bench -p benches --bench arithmetic  # Should run successfully
```
