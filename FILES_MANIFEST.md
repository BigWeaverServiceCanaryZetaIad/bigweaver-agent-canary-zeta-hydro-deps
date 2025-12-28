# Repository Files Manifest

This document lists all files in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Root Directory

### Documentation
- **README.md** (8.4K) - Repository overview, quick start guide, and usage instructions
- **CONTRIBUTING.md** (16K) - Comprehensive contribution guidelines and development workflow
- **MIGRATION_SUMMARY.md** (11K) - Complete overview of benchmark migration from main repository
- **FILES_MANIFEST.md** (this file) - Complete list of all repository files

### Configuration
- **Cargo.toml** (696 bytes) - Workspace configuration

### Helper Scripts
- **QUICKSTART.sh** (4.5K) - Quick reference guide with common commands
- **verify_setup.sh** (4.8K) - Automated setup verification script

## benches/ Directory

### Configuration and Build
- **Cargo.toml** (1.3K) - Package configuration, dependencies, benchmark declarations
- **build.rs** (1.0K) - Build script for generating benchmark code at compile time
- **README.md** (NEW) - Comprehensive benchmark documentation with detailed descriptions

### benches/benches/ Directory - Benchmark Implementations

#### Benchmark Source Files (8 total)
1. **arithmetic.rs** (7.6K) - Sequential arithmetic operations comparing multiple frameworks
2. **fan_in.rs** (3.5K) - Multiple input stream merging patterns
3. **fan_out.rs** (3.6K) - Single stream splitting to multiple outputs
4. **fork_join.rs** (4.3K) - Fork-join patterns with filtering operations
5. **identity.rs** (6.8K) - Identity/no-op transformations for overhead measurement
6. **join.rs** (4.4K) - Hash join operations with various value types
7. **reachability.rs** (14K) - Graph reachability using differential-dataflow
8. **upcase.rs** (3.1K) - String uppercase transformations

#### Data Files (3 total)
1. **reachability_edges.txt** (521K) - Graph edge list for reachability benchmark
2. **reachability_reachable.txt** (38K) - Expected reachable nodes for validation
3. **words_alpha.txt** (3.7M) - English word list for upcase benchmark

## File Summary by Type

### Documentation (5 files, ~40K total)
- README.md
- CONTRIBUTING.md
- MIGRATION_SUMMARY.md
- FILES_MANIFEST.md
- benches/README.md

### Configuration (2 files, ~2K total)
- Cargo.toml (workspace)
- benches/Cargo.toml (package)

### Source Code (9 files, ~47K total)
- 8 benchmark files (*.rs)
- 1 build script (build.rs)

### Data Files (3 files, ~4.4M total)
- reachability_edges.txt
- reachability_reachable.txt
- words_alpha.txt

### Helper Scripts (2 files, ~9K total)
- QUICKSTART.sh
- verify_setup.sh

## Total Repository Contents

- **21 files** (excluding .git directory)
- **~4.5 MB** total size
- **8 benchmarks** all properly configured
- **3 data files** for benchmark inputs
- **5 documentation files** providing comprehensive guidance

## File Purposes

### For End Users
- **README.md** - Start here for overview and basic usage
- **QUICKSTART.sh** - Quick reference for common commands
- **benches/README.md** - Detailed benchmark information

### For Contributors
- **CONTRIBUTING.md** - Development guidelines and workflow
- **MIGRATION_SUMMARY.md** - Historical context and migration details
- **verify_setup.sh** - Verify development environment setup

### For Build System
- **Cargo.toml** (both) - Dependency and package configuration
- **build.rs** - Compile-time code generation

### For Benchmarks
- **benches/benches/*.rs** - Benchmark implementations
- **benches/benches/*.txt** - Benchmark data files

---

**Last Updated:** 2025-12-28  
**Status:** Complete - All files documented
