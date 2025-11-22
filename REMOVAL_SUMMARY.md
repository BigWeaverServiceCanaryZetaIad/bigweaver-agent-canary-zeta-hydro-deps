# Removal Summary

## Files Removed from bigweaver-agent-canary-hydro-zeta

This document summarizes the files removed from the `bigweaver-agent-canary-hydro-zeta` repository 
and moved to `bigweaver-agent-canary-zeta-hydro-deps`.

### Source Location
`bigweaver-agent-canary-hydro-zeta/benches/benches/`

### Removed Benchmark Files (8 files)
1. arithmetic.rs
2. fan_in.rs
3. fan_out.rs
4. fork_join.rs
5. identity.rs
6. join.rs
7. reachability.rs
8. upcase.rs

### Removed Data Files (2 files)
1. reachability_edges.txt
2. reachability_reachable.txt

### Total Files Removed
**10 files** (8 benchmark files + 2 data files)

## Configuration Changes in bigweaver-agent-canary-hydro-zeta

### Cargo.toml Changes
The following dependencies should be removed from `benches/Cargo.toml`:
- `timely` (package: "timely-master", version: "0.13.0-dev.1")
- `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")

The following benchmark declarations should be removed from `benches/Cargo.toml`:
```toml
[[bench]]
name = "arithmetic"
harness = false

[[bench]]
name = "fan_in"
harness = false

[[bench]]
name = "fan_out"
harness = false

[[bench]]
name = "fork_join"
harness = false

[[bench]]
name = "identity"
harness = false

[[bench]]
name = "upcase"
harness = false

[[bench]]
name = "join"
harness = false

[[bench]]
name = "reachability"
harness = false
```

### README.md Updates
The `benches/README.md` should be updated to:
- Remove references to timely and differential-dataflow benchmarks
- Add a note about the migration
- Link to the new repository location

## New Location

All removed files are now located in:
**Repository**: `bigweaver-agent-canary-zeta-hydro-deps`
**Path**: `benches/benches/`
**Package Name**: `timely-differential-benches`

## Running Migrated Benchmarks

To run the migrated benchmarks, use:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benches
```

## Retained Benchmarks in Main Repository

The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta/benches/`:
- futures.rs
- micro_ops.rs
- symmetric_hash_join.rs
- words_diamond.rs
- words_alpha.txt (data file)

These benchmarks use only dfir_rs and do not depend on timely or differential-dataflow.

## Benefits of Removal

1. **Reduced Dependencies**: Main repository no longer requires timely and differential-dataflow
2. **Faster Builds**: Smaller dependency tree results in faster compilation
3. **Cleaner Codebase**: Better separation of concerns
4. **Focused Repository**: Main repository stays focused on core Hydro functionality
5. **Independent Maintenance**: Dependency benchmarks can be maintained separately

## Verification

After applying these changes, verify:
- [ ] Main repository builds successfully without errors
- [ ] Remaining benchmarks still run correctly
- [ ] No broken references to removed files
- [ ] Documentation is updated appropriately
- [ ] CI/CD pipelines are updated if needed
