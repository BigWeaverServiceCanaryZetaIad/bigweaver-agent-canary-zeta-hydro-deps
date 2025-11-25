# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2024-11-25

### Added
- Initial repository setup for dependency benchmarks
- Timely Dataflow benchmarks:
  - arithmetic.rs - Arithmetic pipeline operations
  - fan_in.rs - Fan-in pattern benchmarks
  - fan_out.rs - Fan-out pattern benchmarks
  - fork_join.rs - Fork-join pattern benchmarks
  - identity.rs - Identity transformation benchmarks
  - join.rs - Join operation benchmarks
  - upcase.rs - String transformation benchmarks
- Differential Dataflow benchmarks:
  - reachability.rs - Graph reachability computation
- Data files:
  - reachability_edges.txt - Graph edges test data
  - reachability_reachable.txt - Expected reachability results
- Build infrastructure:
  - Workspace Cargo.toml with proper configuration
  - timely-benchmarks package Cargo.toml
  - build.rs for code generation
  - .gitignore for build artifacts
- Documentation:
  - README.md - Repository overview
  - INDEX.md - Documentation navigation
  - MIGRATION.md - Migration history and details
  - MIGRATION_SUMMARY.md - Migration completion summary
  - QUICK_REFERENCE.md - Common commands guide
  - VERIFICATION_CHECKLIST.md - Testing procedures
  - ORIGINAL_REPO_UPDATES.md - Source repository update guide
  - timely-benchmarks/README.md - Benchmark documentation
  - CHANGELOG.md - This file

### Migration
- Migrated 8 benchmark files from bigweaver-agent-canary-hydro-zeta
- Migrated 2 data files from bigweaver-agent-canary-hydro-zeta
- Migrated build.rs from bigweaver-agent-canary-hydro-zeta
- Updated dependencies from local paths to git references

### Documentation
- Comprehensive migration documentation
- Testing and verification procedures
- Quick reference for common operations
- Integration guide for source repository

## Release Notes

### Version 0.1.0 (Initial Release)

This is the initial release of the bigweaver-agent-canary-zeta-hydro-deps repository, created to maintain dependency-specific benchmarks separately from the main Hydro repository.

**Key Features:**
- Complete set of Timely Dataflow benchmarks
- Differential Dataflow reachability benchmark
- Performance comparison infrastructure
- Criterion-based benchmarking with HTML reports
- Comprehensive documentation

**Purpose:**
- Separate dependency benchmarks from core functionality
- Enable independent development and versioning
- Improve build times for main repository
- Maintain clean separation of concerns

**Usage:**
```bash
# Run all benchmarks
cargo bench -p timely-benchmarks

# Run specific benchmark
cargo bench -p timely-benchmarks --bench reachability
```

See [README.md](./README.md) for complete usage instructions.

---

## Future Changes

Document future changes here following the format:

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New features

### Changed
- Changes to existing functionality

### Deprecated
- Features that will be removed

### Removed
- Removed features

### Fixed
- Bug fixes

### Security
- Security improvements
```

---

[Unreleased]: https://github.com/hydro-project/hydro-deps/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/hydro-project/hydro-deps/releases/tag/v0.1.0
