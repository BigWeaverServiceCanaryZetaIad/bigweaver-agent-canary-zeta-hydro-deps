# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with benchmark code migration
- Complete benchmark suite comparing DFIR/Hydroflow vs timely-dataflow vs differential-dataflow
- 12 benchmark implementations:
  * arithmetic.rs - Arithmetic operations benchmark
  * fan_in.rs - Fan-in dataflow pattern
  * fan_out.rs - Fan-out dataflow pattern
  * fork_join.rs - Fork-join pattern benchmark
  * futures.rs - Async futures handling benchmark
  * identity.rs - Identity transformation baseline
  * join.rs - Join operations benchmark
  * micro_ops.rs - Micro-operations benchmark suite
  * reachability.rs - Graph reachability computation
  * symmetric_hash_join.rs - Symmetric hash join benchmark
  * upcase.rs - String uppercase transformation
  * words_diamond.rs - Word processing diamond pattern
- Test data files:
  * reachability_edges.txt (521KB) - Graph edge list
  * reachability_reachable.txt (38KB) - Expected reachable nodes
  * words_alpha.txt (3.7MB) - English word list for text processing benchmarks
- Comprehensive README with usage instructions and benchmark descriptions
- Workspace configuration with Rust 2024 edition
- Cargo.toml with all necessary dependencies:
  * timely-master 0.13.0-dev.1
  * differential-dataflow-master 0.13.0-dev.1
  * dfir_rs from main Hydro repository
  * criterion for benchmarking framework
  * Supporting utilities (futures, rand, tokio, etc.)
- Build scripts for benchmark setup

### Changed
- Dependencies now reference main Hydro repository via git instead of local paths
- This enables independent repository management while maintaining functionality

## Migration Details

This repository was created to house benchmarks that were previously part of the main 
bigweaver-agent-canary-hydro-zeta repository. The migration:

1. **Maintains all functionality**: All performance comparison capabilities are preserved
2. **Reduces main repository complexity**: Removes heavy dependencies from core project
3. **Enables independent development**: Benchmarks can evolve separately from main codebase
4. **Follows team architecture patterns**: Separation of concerns across repositories
5. **Preserves performance testing**: Full benchmark suite remains functional

## Benefits

- ✅ Cleaner dependency tree in main repository
- ✅ Faster CI/CD builds for main project
- ✅ Independent benchmark versioning and releases
- ✅ Optional performance testing (clone only when needed)
- ✅ Reduced technical debt
- ✅ Better separation of concerns
- ✅ All performance comparison functionality intact
