# Benchmark Migration Details

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Rationale

### Why Separate the Benchmarks?

1. **Reduced Dependencies**: The main repository no longer needs to depend on timely and differential-dataflow, which are large dependencies primarily used only for comparative benchmarking.

2. **Improved Build Performance**: By removing these dependencies, builds of the main repository are faster and require less disk space.

3. **Reduced Security Surface Area**: Fewer dependencies mean a smaller attack surface and fewer potential security vulnerabilities to monitor.

4. **Maintained Performance Comparison Capability**: Despite the separation, the ability to compare Hydro performance against timely and differential-dataflow is fully preserved.

5. **Better Organization**: Benchmarks that compare different frameworks are logically separated from the main codebase.

## What Was Moved

### Benchmarks Migrated

The following benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to this repository:

- `arithmetic.rs` - Uses timely for comparison
- `fan_in.rs` - Uses timely for comparison
- `fan_out.rs` - Uses timely for comparison
- `fork_join.rs` - Uses timely for comparison
- `identity.rs` - Uses timely for comparison
- `join.rs` - Uses timely for comparison
- `reachability.rs` - Uses both timely and differential-dataflow for comparison
- `upcase.rs` - Uses timely for comparison

### Supporting Files

- `reachability_edges.txt` - Test data for reachability benchmark
- `reachability_reachable.txt` - Expected results for reachability benchmark
- `build.rs` - Build script that generates code for fork_join benchmark
- `.gitignore` - Git ignore patterns for benchmark artifacts

## What Remained in Main Repository

Benchmarks that do not depend on timely or differential-dataflow remained in the main repository (if applicable):

- `micro_ops.rs` - Pure Hydro benchmark
- `symmetric_hash_join.rs` - Pure Hydro benchmark
- `words_diamond.rs` - Pure Hydro benchmark

> **Note**: The specific location of non-timely benchmarks in the main repository should be verified. They may have been moved to a different location or removed as part of repository restructuring.

## Changes Made to Main Repository

### Cargo.toml Changes

The following dependencies were removed from the main repository's `benches/Cargo.toml` (or equivalent):

```toml
# REMOVED:
timely = "0.12"
differential-dataflow = "0.12"
```

### Workspace Members

If the `benches` directory was a workspace member, it was removed from the workspace configuration.

## Dependencies Setup in This Repository

### Git Dependencies

This repository depends on the main repository for core Hydro functionality:

```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "484e6fddffa97d507384773d51bf728770a6ac38" }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "484e6fddffa97d507384773d51bf728770a6ac38" }
```

The specific commit (`484e6fddffa97d507384773d51bf728770a6ac38`) was chosen as a stable reference point that includes all necessary Hydro functionality without the timely/differential benchmarks.

### External Dependencies

```toml
timely = "0.12"
differential-dataflow = "0.12"
```

These are now isolated to this repository only.

## Migration Process Summary

1. **Identification**: Located all benchmark files that used `timely` or `differential-dataflow` imports
2. **Extraction**: Copied benchmark files and supporting data from historical git commits
3. **Repository Setup**: Created new Cargo.toml with appropriate dependencies and benchmark definitions
4. **Documentation**: Created comprehensive README and this migration document
5. **Testing**: Verified benchmarks build and run correctly (to be done)
6. **Cleanup**: Removed timely/differential dependencies from main repository (to be verified)

## Maintaining Cross-Repository Compatibility

### Updating to New Hydro Versions

When the main repository is updated:

1. Identify the new commit hash
2. Update `Cargo.toml` in this repository:
   ```toml
   dfir_rs = { git = "...", rev = "NEW_COMMIT_HASH" }
   ```
3. Run `cargo update`
4. Test all benchmarks

### Handling Breaking Changes

If the main repository introduces breaking API changes:

1. Update benchmark code to match new APIs
2. Document the changes in benchmark comments
3. Consider keeping compatibility notes in this file

## Performance Comparison Workflow

Developers can compare performance across implementations by:

1. **Running these benchmarks**: `cd bigweaver-agent-canary-zeta-hydro-deps && cargo bench`
2. **Analyzing results**: Review Criterion output in `target/criterion/`
3. **Comparing frameworks**: Each benchmark includes multiple implementations (raw Rust, Hydro, timely, differential)
4. **Tracking over time**: Criterion maintains historical performance data

## Future Considerations

- Consider setting up automated CI to run these benchmarks on schedule
- Potentially publish performance comparison results to a dashboard
- Maintain compatibility with major versions of timely/differential-dataflow
- Add more comparative benchmarks as needed

## Questions or Issues

For questions about this migration or issues with benchmarks, please:

1. Check the main README.md for usage instructions
2. Review the individual benchmark source code for implementation details
3. Open an issue in the appropriate repository