# Benchmark Migration Guide

This document explains the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Background

The timely and differential-dataflow benchmarks have been moved to a separate repository to:

1. **Reduce Dependency Footprint**: The main Hydro repository no longer needs to depend on timely and differential-dataflow packages for core functionality
2. **Improve Build Times**: Developers working on core Hydro features don't need to build these heavy dependencies
3. **Maintain Focus**: Keep the main repository focused on core Hydro functionality
4. **Preserve Capability**: Retain the ability to run performance comparisons when needed

## What Was Moved

All benchmarks that depended on `timely` or `differential-dataflow` packages were moved:

- `benches/` directory containing all benchmark code
- Associated data files (word lists, graph data)
- Benchmark configuration in Cargo.toml
- GitHub workflow for benchmark automation (`.github/workflows/benchmark.yml`)

## Changes in Main Repository

### Removed from bigweaver-agent-canary-hydro-zeta

- `benches/` crate and all its contents
- `timely` and `differential-dataflow` dependencies from workspace
- References to benchmarks in `CONTRIBUTING.md`
- Benchmark GitHub Actions workflow
- Documentation references to moved benchmarks

### Updated in bigweaver-agent-canary-hydro-zeta

The following files should be updated to reference the new benchmark location:

- `README.md` - Add note about benchmark location
- `CONTRIBUTING.md` - Update performance testing section
- `.github/gh-pages/index.md` - Update benchmark links

## New Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # Repository overview
├── BENCHMARK_MIGRATION.md        # This file
└── hydro_benches/
    ├── Cargo.toml               # Benchmark crate configuration
    ├── build.rs                 # Build script
    └── benches/                 # Benchmark source files
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_diamond.rs
        ├── words_alpha.txt
        ├── reachability_edges.txt
        └── reachability_reachable.txt
```

## Running Benchmarks After Migration

### Prerequisites

Clone both repositories:

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
```

### Running Benchmarks

Navigate to the deps repository:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
```

Run all benchmarks:

```bash
cargo bench -p hydro_benches
```

Run specific benchmark:

```bash
cargo bench -p hydro_benches --bench reachability
```

### Performance Comparison Workflow

To compare performance between versions:

1. **Baseline measurement** (on main branch or before changes):
   ```bash
   cargo bench -p hydro_benches -- --save-baseline my-baseline
   ```

2. **Make your changes** in the main Hydro repository

3. **Update dependencies** in hydro_benches/Cargo.toml if needed:
   ```toml
   dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main" }
   # or use local path during development:
   # dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   ```

4. **Compare results**:
   ```bash
   cargo bench -p hydro_benches -- --baseline my-baseline
   ```

## Dependency Configuration

The benchmarks depend on:

- **timely-master**: Timely dataflow framework
- **differential-dataflow-master**: Differential dataflow library  
- **dfir_rs**: Referenced from main Hydro repository via git
- **sinktools**: Referenced from main Hydro repository via git

### Using Local Development Versions

For active development, you can use local path dependencies:

Edit `hydro_benches/Cargo.toml`:

```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

## CI/CD Considerations

If you were using the benchmark GitHub Actions workflow, it should be:

1. Moved to this repository
2. Updated to check out both repositories
3. Configured to run benchmarks from the new location

## Questions and Support

For questions about:
- **Benchmark functionality**: File an issue in this repository
- **Core Hydro features**: File an issue in the main Hydro repository
- **Performance regressions**: Use the benchmark comparison workflow above and report in the main repository

## Timeline

- **Migration Date**: [Date of migration]
- **Last Commit in Old Location**: [commit hash before removal]
- **First Commit in New Location**: [commit hash of migration]

## Related Documentation

- Main Hydro Repository: https://github.com/hydro-project/hydro
- Contributing Guide: https://github.com/hydro-project/hydro/blob/main/CONTRIBUTING.md
- Hydro Documentation: https://hydro.run/docs/
