# Benchmark Migration Summary

## Overview

This repository now contains all timely and differential-dataflow benchmarks that were previously in the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`). This migration improves the development experience by separating heavyweight benchmark dependencies from the core codebase.

## What Was Moved

### Benchmark Files (from main repo `benches/` directory)
- `benches/Cargo.toml` - Benchmark package configuration
- `benches/README.md` - Benchmark documentation  
- `benches/build.rs` - Build script
- `benches/benches/*.rs` - All benchmark implementations:
  - arithmetic.rs
  - fan_in.rs
  - fan_out.rs
  - fork_join.rs
  - futures.rs
  - identity.rs
  - join.rs
  - micro_ops.rs
  - reachability.rs
  - symmetric_hash_join.rs
  - upcase.rs
  - words_diamond.rs
- Test data files:
  - reachability_edges.txt
  - reachability_reachable.txt
  - words_alpha.txt

### Dependencies

The benchmarks maintain dependencies on:
- **timely-master** (v0.13.0-dev.1) - Core timely dataflow
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow
- **dfir_rs** - From main Hydro repository (via git dependency)
- **sinktools** - From main Hydro repository (via git dependency)
- **criterion** - Benchmarking framework

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark package
│   ├── benches/               # Benchmark implementations
│   ├── Cargo.toml             # Dependencies including timely/differential
│   ├── build.rs               # Build configuration
│   └── README.md              # Benchmark usage guide
├── run_benchmarks.sh          # Convenience script for running benchmarks
├── Cargo.toml                 # Workspace configuration
├── README.md                  # Repository overview
├── LICENSE                    # Apache 2.0 license
├── .gitignore                 # Git ignore patterns
└── MIGRATION_SUMMARY.md       # This file
```

## Key Changes

### 1. Dependency Management

Updated `benches/Cargo.toml` to use git dependencies for main Hydro crates:

```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = ["debugging"] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git" }
```

This ensures benchmarks always test against the current main branch.

### 2. Performance Comparison Interface

Created `run_benchmarks.sh` script that provides:
- Easy benchmark execution (`./run_benchmarks.sh --all`)
- Baseline saving for comparisons
- Result comparison against previous runs
- List of available benchmarks

### 3. Documentation

Added comprehensive documentation:
- Updated repository README with usage instructions
- Enhanced benches README with examples
- Migration guide in main repository
- This summary document

## Running Benchmarks

### Quick Start

```bash
# Run all benchmarks
cargo bench -p benches

# Or use the convenience script
./run_benchmarks.sh --all
```

### Specific Benchmarks

```bash
# Run single benchmark
cargo bench -p benches --bench reachability

# Using script
./run_benchmarks.sh --bench arithmetic
```

### Performance Comparisons

```bash
# Save baseline before making changes
./run_benchmarks.sh --all --baseline before-opt

# Make changes to Hydro/DFIR in main repository
# Cargo will automatically pull latest changes

# Run and compare
./run_benchmarks.sh --all --compare before-opt
```

## Benefits

✅ **Faster builds** - Main repository no longer depends on timely/differential-dataflow  
✅ **Cleaner dependencies** - Heavyweight dataflow dependencies isolated  
✅ **Preserved functionality** - All benchmarks and performance testing capability retained  
✅ **Better organization** - Clear separation between core development and performance testing  
✅ **Easier comparisons** - Scripts and documentation for performance analysis  

## Integration with Main Repository

### For Core Contributors

If you're working on Hydro/DFIR core:
- Continue normal development in main repository
- Faster build times without benchmark dependencies
- Only clone this repository when needed for performance testing

### For Performance Work

If you're optimizing or measuring performance:
1. Clone both repositories
2. Make changes in main repository
3. Run benchmarks in this repository
4. Git dependencies automatically pull latest main branch

### CI/CD (Future)

Potential CI/CD integration:
- Main repo PRs can trigger benchmark runs
- Results posted back to PR
- Performance regressions automatically detected
- Trend tracking over time

## Removed from Main Repository

The following were removed from `bigweaver-agent-canary-hydro-zeta`:
- `benches/` directory (entire directory structure)
- `benches` member from workspace Cargo.toml
- `.github/workflows/benchmark.yml` (if existed)
- timely and differential-dataflow from Cargo.lock

## Added to Main Repository Documentation

- `docs/docs/benchmarks/migration.md` - Comprehensive migration guide
- Updated `README.md` - Reference to benchmarks repository
- Updated `CONTRIBUTING.md` - Note about benchmark location

## Migration Date

**December 2, 2025**

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Benchmarks Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
- Migration Guide: [Main repo docs/docs/benchmarks/migration.md]
- Hydro Documentation: https://hydro.run

## Questions or Issues?

- **Benchmark functionality**: Open issues in this repository
- **Core Hydro/DFIR**: Open issues in the main repository
- **Migration questions**: See the migration guide or main repository CONTRIBUTING.md
