# File Manifest

This document lists all files in the repository with brief descriptions.

## Root Directory

| File | Type | Size | Description |
|------|------|------|-------------|
| `Cargo.toml` | Config | 782 B | Workspace configuration (Rust 2024) |
| `README.md` | Docs | 6.7 KB | Main repository documentation |
| `GETTING_STARTED.md` | Docs | 8.0 KB | Setup and usage guide |
| `PERFORMANCE_COMPARISON.md` | Docs | 12.3 KB | Performance comparison methodology |
| `RELATIONSHIP_TO_MAIN_REPO.md` | Docs | 13.8 KB | Repository relationship documentation |
| `CHANGELOG.md` | Docs | 4.8 KB | Version history and release notes |
| `SETUP_COMPLETE.md` | Docs | 9.5 KB | Migration completion summary |
| `MIGRATION_GUIDE_FOR_MAIN_REPO.md` | Docs | 4.2 KB | Guide for main repository users |
| `FILE_MANIFEST.md` | Docs | - | This file |
| `verify_setup.sh` | Tool | 7.8 KB | Automated verification script |

## benches/ Directory

| File | Type | Size | Description |
|------|------|------|-------------|
| `Cargo.toml` | Config | 897 B | Benchmark dependencies configuration |
| `build.rs` | Build | 1.0 KB | Build script for benchmarks |
| `README.md` | Docs | 3.8 KB | Benchmarks quick reference |

## benches/benches/ Directory

### Benchmark Implementations

| File | Framework | Lines | Description |
|------|-----------|-------|-------------|
| `identity.rs` | Timely | 27 | Identity transformation benchmark |
| `arithmetic.rs` | Timely | 32 | Arithmetic operations benchmark |
| `fan_in.rs` | Timely | 30 | Stream fan-in pattern benchmark |
| `fan_out.rs` | Timely | 26 | Stream fan-out pattern benchmark |
| `fork_join.rs` | Timely | 28 | Fork-join pattern benchmark |
| `join.rs` | Timely | 39 | Relational join benchmark |
| `upcase.rs` | Timely | 37 | String manipulation benchmark |
| `reachability.rs` | Timely + Differential | 128 | Graph reachability benchmark |

### Test Data Files

| File | Size | Description |
|------|------|-------------|
| `reachability_edges.txt` | 521 KB | Graph edges for reachability tests |
| `reachability_reachable.txt` | 38 KB | Expected reachable nodes |
| `words_alpha.txt` | 3.7 MB | Word list for string operations |

## File Statistics

### By Type

- **Configuration**: 2 files (Cargo.toml)
- **Documentation**: 9 files (~70 KB total)
- **Source Code**: 8 benchmarks + 1 build script = 9 files
- **Test Data**: 3 files (4.3 MB total)
- **Tools**: 1 file (verify_setup.sh)

### By Purpose

- **Setup & Configuration**: 3 files
- **Documentation**: 9 files
- **Benchmarks**: 8 files
- **Test Data**: 3 files
- **Build & Verification**: 2 files

### Total

**Files**: 24 files  
**Size**: ~7.7 MB (including test data)

## Key File Relationships

```
Cargo.toml (workspace)
└── benches/
    ├── Cargo.toml (dependencies)
    ├── build.rs (build script)
    └── benches/
        ├── *.rs (8 benchmarks)
        └── *.txt (3 test data files)

Documentation hierarchy:
- README.md (start here)
  ├── GETTING_STARTED.md (setup)
  ├── PERFORMANCE_COMPARISON.md (usage)
  └── RELATIONSHIP_TO_MAIN_REPO.md (architecture)
```

## Essential Files for Different Users

### For First-Time Users

1. `README.md` - Start here
2. `GETTING_STARTED.md` - Setup instructions
3. `verify_setup.sh` - Verify installation

### For Performance Analysis

1. `PERFORMANCE_COMPARISON.md` - Comparison methodology
2. `benches/benches/*.rs` - Benchmark implementations
3. `RELATIONSHIP_TO_MAIN_REPO.md` - Understanding architecture

### For Contributors

1. `CHANGELOG.md` - Version history
2. `benches/README.md` - Development guide
3. `Cargo.toml` files - Configuration

### For Main Repository Users

1. `MIGRATION_GUIDE_FOR_MAIN_REPO.md` - Migration information
2. `README.md` - Overview
3. `PERFORMANCE_COMPARISON.md` - How to compare

## File Purposes

### Configuration Files

- `Cargo.toml` (root) - Workspace configuration
- `benches/Cargo.toml` - Benchmark dependencies
- `benches/build.rs` - Build script

### Documentation Files

- `README.md` - Repository overview
- `GETTING_STARTED.md` - Quick start guide
- `PERFORMANCE_COMPARISON.md` - Comparison guide
- `RELATIONSHIP_TO_MAIN_REPO.md` - Architecture docs
- `CHANGELOG.md` - Version history
- `SETUP_COMPLETE.md` - Migration summary
- `benches/README.md` - Benchmarks reference
- `MIGRATION_GUIDE_FOR_MAIN_REPO.md` - Main repo guide
- `FILE_MANIFEST.md` - This file

### Benchmark Files

All benchmarks follow the same structure:
- Use Criterion for benchmarking
- Implement one or more benchmark functions
- Use `criterion_group!` and `criterion_main!` macros
- Follow naming convention: `benchmark_<framework>`

### Test Data Files

- Embedded using `include_bytes!` macro
- Same data as historical benchmarks
- Enable reproducible performance testing

### Tools

- `verify_setup.sh` - Automated verification script

## Version Information

- **Repository Version**: 0.1.0
- **Rust Edition**: 2024
- **License**: Apache-2.0
- **Created**: November 22, 2025

## Maintenance Notes

### Adding New Files

When adding new files, update:
1. This manifest (FILE_MANIFEST.md)
2. README.md if user-facing
3. verify_setup.sh if verification needed

### Modifying Files

When modifying files:
1. Update CHANGELOG.md
2. Increment version if necessary
3. Update related documentation

### Removing Files

When removing files:
1. Update this manifest
2. Update CHANGELOG.md
3. Update verify_setup.sh
4. Check documentation for references
