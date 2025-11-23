# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with Cargo workspace configuration
- Complete benchmark suite migrated from bigweaver-agent-canary-hydro-zeta:
  - `arithmetic.rs` - Arithmetic operations comparison across frameworks
  - `fan_in.rs` - Fan-in pattern benchmarks
  - `fan_out.rs` - Fan-out pattern benchmarks
  - `fork_join.rs` - Fork-join pattern benchmarks
  - `identity.rs` - Identity operation benchmarks (framework overhead measurement)
  - `join.rs` - Join operation benchmarks
  - `reachability.rs` - Graph reachability benchmarks using differential-dataflow
  - `upcase.rs` - String uppercase transformation benchmarks
- Data files for reachability benchmark:
  - `reachability_edges.txt` (524KB)
  - `reachability_reachable.txt` (40KB)
- Dependencies on timely and differential-dataflow frameworks:
  - timely-master v0.13.0-dev.1
  - differential-dataflow-master v0.13.0-dev.1
- Dependencies on Hydroflow components (via git):
  - dfir_rs with debugging features
  - sinktools utilities
- Comprehensive documentation:
  - Root README.md with repository overview and quick start guide
  - benches/README.md with detailed benchmark documentation
  - Performance comparison guidelines
  - Contribution guidelines
- Benchmark infrastructure:
  - Criterion v0.5.0 with async_tokio and html_reports features
  - Proper Cargo.toml configuration with all benchmark entries
  - Support for both compiled and interpreted Hydroflow implementations

### Purpose
This repository was created to maintain performance comparison capabilities between Hydroflow/dfir_rs and timely/differential-dataflow frameworks while keeping these dependencies isolated from the main bigweaver-agent-canary-hydro-zeta repository.

### Benefits
- ✅ Reduced dependency complexity in main repository
- ✅ Maintained performance comparison functionality
- ✅ Cleaner separation of concerns
- ✅ Independent evolution of benchmark code
- ✅ Faster builds for main repository
- ✅ Dedicated space for comprehensive performance testing

### Migration Details
- **Source Repository**: bigweaver-agent-canary-hydro-zeta
- **Migration Date**: 2024-11-23
- **Files Migrated**: 8 benchmark files + 2 data files
- **Dependencies Added**: timely, differential-dataflow, dfir_rs, sinktools
- **Documentation**: Complete benchmark documentation and usage guides

---

**Date**: 2024-11-23  
**Milestone**: Initial repository setup with complete benchmark suite