# Benchmark Migration Guide

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Motivation

The benchmarks were moved to achieve the following goals:

1. **Reduce Dependencies**: Remove timely and differential-dataflow dependencies from the main Hydro repository
2. **Improve Build Times**: Decrease build times for the main repository by removing unnecessary dependencies
3. **Maintain Performance Testing**: Preserve the ability to run performance comparisons with timely and differential-dataflow
4. **Improve Modularity**: Better separate concerns by isolating framework-specific benchmarks

## What Was Moved

### Benchmarks

The entire `benches` crate was moved, including:

- All benchmark source files (`.rs` files)
- Benchmark data files (`reachability_edges.txt`, `reachability_reachable.txt`, `words_alpha.txt`)
- Build script (`build.rs`)
- Package configuration (`Cargo.toml`)
- Documentation (`README.md`)

### Removed from Main Repository

The following were removed from the main Hydro repository:

1. **The `benches` directory** and all its contents
2. **Workspace member** `"benches"` from the root `Cargo.toml`
3. **GitHub workflow** `.github/workflows/benchmark.yml`
4. **Documentation references** to the local benchmarks in `CONTRIBUTING.md` and `.github/gh-pages/index.md`

## Changes Made

### Dependencies

The `benches/Cargo.toml` was updated to use git dependencies instead of path dependencies:

**Before:**
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

**After:**
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", branch = "main" }
```

### Documentation

Updated documentation to:
- Reference the new benchmark location
- Provide clear instructions for running benchmarks
- Include migration history

## Running Benchmarks

### In the New Location

```bash
# Clone the benchmarks repository
git clone https://github.com/hydro-project/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
```

### Performance Comparison

To compare performance with previous runs:

1. Clone this repository
2. Run the benchmarks as shown above
3. Compare results with historical data (if available)

## For Current and Future Team Members

### When to Use This Repository

Use this repository when you need to:

- Run benchmarks that compare Hydro with timely/differential-dataflow
- Add new benchmarks that depend on timely or differential-dataflow
- Profile performance characteristics that require these frameworks

### When to Use the Main Repository

Use the main Hydro repository for:

- Development of core Hydro features
- Benchmarks that don't require timely or differential-dataflow
- All other Hydro-related work

## Timeline

- **Date of Migration**: December 2025
- **Reason**: Proactive dependency management and technical debt reduction
- **Related PRs**: 
  - Main repository: Removal of benchmarks and dependencies
  - This repository: Addition of migrated benchmarks

## Questions and Support

For questions about:
- **Running benchmarks**: See [benches/README.md](benches/README.md)
- **Adding new benchmarks**: Follow the patterns in existing benchmark files
- **Migration issues**: Contact the Hydro Development Team

## References

- [Main Hydro Repository](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
