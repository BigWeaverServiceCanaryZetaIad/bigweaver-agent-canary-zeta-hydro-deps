# Migration Guide: Benchmarks to bigweaver-agent-canary-zeta-hydro-deps

This document explains the migration of timely and differential-dataflow benchmarks from the main bigweaver-agent-canary-hydro-zeta repository to this dedicated dependencies repository.

## Background

The benchmarks were moved to isolate dependencies on timely and differential-dataflow packages. This separation:
- Keeps the main repository free from these heavy dependencies
- Maintains the ability to run performance comparisons
- Provides a dedicated space for benchmark development and CI workflows
- Follows the team's policy of avoiding timely and differential-dataflow dependencies in the main codebase

## What Was Migrated

### Benchmark Code
All benchmark files from the `benches` directory:
- `benches/Cargo.toml` - Package configuration
- `benches/build.rs` - Build script for generating test code
- `benches/README.md` - Benchmark documentation
- `benches/benches/*.rs` - All benchmark implementations:
  - `arithmetic.rs` - Arithmetic operations
  - `fan_in.rs` - Fan-in dataflow patterns
  - `fan_out.rs` - Fan-out dataflow patterns
  - `fork_join.rs` - Fork-join patterns
  - `futures.rs` - Async futures operations
  - `identity.rs` - Identity transformations
  - `join.rs` - Join operations
  - `micro_ops.rs` - Micro-operations
  - `reachability.rs` - Graph reachability algorithms
  - `symmetric_hash_join.rs` - Symmetric hash join operations
  - `upcase.rs` - String uppercase operations
  - `words_diamond.rs` - Diamond pattern word processing

### Test Data Files
- `benches/benches/reachability_edges.txt` - Graph edge data for reachability benchmarks
- `benches/benches/reachability_reachable.txt` - Expected reachable nodes
- `benches/benches/words_alpha.txt` - Word list from https://github.com/dwyl/english-words

### CI/CD Configuration
- `.github/workflows/benchmark.yml` - GitHub Actions workflow for running benchmarks

## Changes Made

### Dependencies Updated
The `benches/Cargo.toml` was updated to reference `dfir_rs` and `sinktools` from the main repository via git instead of local paths:

```toml
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

### Main Repository Changes
In bigweaver-agent-canary-hydro-zeta:
1. Removed `benches` directory and all its contents
2. Removed `benches` from workspace members in `Cargo.toml`
3. Removed `.github/workflows/benchmark.yml`
4. Updated `CONTRIBUTING.md` to reference this repository for benchmarks
5. Updated `.github/gh-pages/index.md` to remove benchmark links

## Running Benchmarks After Migration

### From this Repository
```bash
# Clone the deps repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

### CI/CD Workflow
Benchmarks run automatically via GitHub Actions when:
- Code is pushed to main or feature branches
- Pull requests include `[ci-bench]` in title or body
- Daily at 8:35 PM PDT / 7:35 PM PST
- Manually triggered via workflow_dispatch

Results are published to the gh-pages branch.

## Maintaining Compatibility

When making changes to the main repository that affect benchmarks:

1. **Breaking Changes to dfir_rs or sinktools**: Update benchmark code in this repository to match
2. **New Features**: Consider adding new benchmarks to test performance characteristics
3. **Version Updates**: The git dependencies will pull from the main branch by default

## Team Contacts

For questions about:
- **Core Development**: Hydro Development Team
- **Performance Testing**: Performance Engineering Team
- **CI/CD Issues**: CI/CD Team
- **Documentation**: Documentation Team

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Hydro Documentation: https://hydro.run
