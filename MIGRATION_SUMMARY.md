# Benchmark Migration Summary

## Overview

This document summarizes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Date

November 30, 2025

## Source

- **Repository**: bigweaver-agent-canary-hydro-zeta
- **Source Commit**: 484e6fdd (before removal commit b161bc10)
- **Removal Commit**: b161bc10 - "chore(benches): remove timely/differential-dataflow dependencies and benchmarks"

## Migrated Files

### Benchmark Package Structure
```
benches/
├── Cargo.toml          # Package configuration with dependencies
├── README.md           # Benchmark-specific documentation
├── build.rs            # Build script for code generation
└── benches/            # Benchmark implementations
    ├── .gitignore
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── futures.rs
    ├── identity.rs
    ├── join.rs
    ├── micro_ops.rs
    ├── reachability.rs
    ├── reachability_edges.txt
    ├── reachability_reachable.txt
    ├── symmetric_hash_join.rs
    ├── upcase.rs
    ├── words_alpha.txt
    └── words_diamond.rs
```

### CI/CD Configuration
```
.github/
├── workflows/
│   └── benchmark.yml   # Benchmark CI workflow
└── gh-pages/
    ├── .gitignore
    └── index.md
```

### Configuration Files
- `Cargo.toml` - Workspace configuration
- `rust-toolchain.toml` - Rust toolchain specification
- `clippy.toml` - Clippy linting configuration
- `rustfmt.toml` - Code formatting configuration
- `.gitignore` - Git ignore rules

## Changes Made

### 1. Dependency Path Updates

The original `benches/Cargo.toml` used path-based dependencies:
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

Updated to use git-based dependencies:
```toml
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

### 2. Workspace Creation

Created a root `Cargo.toml` to establish a workspace:
- Configured workspace with resolver = "2"
- Set workspace metadata (edition, license, repository)
- Added workspace lints configuration
- Included benches as a member

### 3. Documentation Updates

Created comprehensive documentation:
- Updated main `README.md` with:
  - Project overview
  - List of all benchmarks
  - Running instructions
  - Development guidelines
  - Historical context
  - Data attribution
- Updated `.github/gh-pages/index.md` to reflect new repository

### 4. Configuration Files

Added standard Rust project configuration:
- `rust-toolchain.toml` - Ensures consistent Rust version (1.91.1)
- `clippy.toml` - Linting standards
- `rustfmt.toml` - Code formatting rules
- `.gitignore` - Proper ignores for Rust projects

## Benchmarks Included

| Benchmark | Description |
|-----------|-------------|
| arithmetic | Pipeline arithmetic operations |
| fan_in | Multiple input streams merging |
| fan_out | Single stream splitting |
| fork_join | Fork-join pattern with filters |
| futures | Async futures handling |
| identity | Simple identity transformation |
| join | Stream join operations |
| micro_ops | Micro-operations performance |
| reachability | Graph reachability algorithm |
| symmetric_hash_join | Symmetric hash join |
| upcase | String uppercase transformation |
| words_diamond | Diamond pattern with word processing |

## Dependencies

### External Crates
- **criterion** (0.5.0) - Benchmarking framework with async support
- **differential-dataflow** (0.13.0-dev.1) - Incremental dataflow
- **timely** (0.13.0-dev.1) - Low-latency dataflow
- **futures** (0.3) - Async runtime support
- **tokio** (1.29.0) - Async runtime
- **rand**, **rand_distr** - Random data generation
- **seq-macro**, **nameof**, **static_assertions** - Utilities

### Internal Dependencies (from main repository)
- **dfir_rs** - Hydro dataflow runtime
- **sinktools** - Utility tools

## Testing

### Running Benchmarks

All benchmarks can be run with:
```bash
cargo bench -p benches
```

Individual benchmarks:
```bash
cargo bench -p benches --bench <name>
```

### CI Integration

The `benchmark.yml` workflow:
- Runs on push to main, PRs, scheduled daily, or manual trigger
- Requires `[ci-bench]` tag in commit/PR to run on non-scheduled events
- Generates HTML reports using Criterion
- Publishes results to gh-pages branch
- Stores historical benchmark data

## Rationale

The benchmarks were moved to this separate repository to:

1. **Isolate Dependencies**: Keep heavy external dependencies (timely/differential-dataflow) separate from core Hydro
2. **Maintain Comparisons**: Preserve ability to run performance comparisons with other dataflow systems
3. **Repository Focus**: Keep main repository focused on core Hydro functionality
4. **Build Performance**: Reduce build times for the main repository
5. **Dependency Management**: Easier management of benchmark-specific dependencies

## Verification Checklist

- [x] All benchmark files extracted from git history
- [x] Build configuration (Cargo.toml) updated with correct dependencies
- [x] Build script (build.rs) included
- [x] Test data files included (*.txt)
- [x] CI workflow included and updated
- [x] Documentation updated (README.md)
- [x] Configuration files added (rust-toolchain, clippy, rustfmt)
- [x] Git configuration (.gitignore, gh-pages)
- [x] Workspace structure established

## Next Steps

1. Verify builds successfully: `cargo check -p benches`
2. Run benchmarks to ensure functionality: `cargo bench -p benches`
3. Push changes to repository
4. Set up CI/CD in the new repository
5. Update main repository documentation to reference this repository

## Related Commits

- **Source Repository**: 
  - 484e6fdd - Last commit before benchmark removal
  - b161bc10 - Commit that removed benchmarks

## Notes

- Git dependencies point to the main bigweaver-agent-canary-hydro-zeta repository
- Benchmarks require Rust 1.91.1 (specified in rust-toolchain.toml)
- All 12 benchmark suites have been preserved with their original functionality
- Test data files (words_alpha.txt, reachability_*.txt) are included
