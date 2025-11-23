# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial repository setup with workspace configuration
- Complete suite of timely and differential-dataflow benchmarks:
  - `arithmetic` - Arithmetic pipeline operations comparison
  - `fan_in` - Fan-in pattern comparison
  - `fan_out` - Fan-out pattern comparison
  - `fork_join` - Fork-join pattern with dynamic code generation
  - `identity` - Identity operations baseline comparison
  - `join` - Hash join operations comparison
  - `reachability` - Graph reachability algorithms comparison
  - `upcase` - String uppercase operations comparison
- Comprehensive documentation:
  - Main README with repository overview and quick start
  - Detailed benchmark documentation in `benches/README.md`
  - Contributing guidelines in `CONTRIBUTING.md`
- Configuration files for consistent development:
  - `rust-toolchain.toml` - Rust version specification
  - `clippy.toml` - Linting configuration
  - `rustfmt.toml` - Code formatting rules
  - `.gitignore` - Git ignore patterns
- Build script (`build.rs`) for dynamic benchmark code generation
- Helper script (`run_benchmarks.sh`) for easy benchmark execution
- Test data files for benchmarks:
  - `reachability_edges.txt` - Graph edges for reachability testing
  - `reachability_reachable.txt` - Expected reachable nodes
  - `words_alpha.txt` - Word list for string processing tests
- Apache 2.0 License
- Cargo workspace configuration with proper dependency management

### Dependencies
- `criterion` (0.5.0) - Statistical benchmarking framework
- `timely-master` (0.13.0-dev.1) - Timely dataflow library
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow library
- `dfir_rs` (from git) - Hydroflow core library
- `sinktools` (from git) - Hydroflow utility tools
- Supporting libraries: `tokio`, `futures`, `rand`, and others

## Migration Notes

This repository contains benchmarks that were previously part of the main
`bigweaver-agent-canary-hydro-zeta` repository. They were moved here to:

1. Reduce dependency complexity in the main repository
2. Improve build times for the core library
3. Maintain clean separation of concerns
4. Enable independent performance testing

The benchmarks maintain full functionality and can be run independently from
this repository. For details about the migration, see
`BENCHMARK_REMOVAL_SUMMARY.md` in the main repository.

## Performance Comparison

These benchmarks enable comparative analysis between:
- **Hydroflow/dfir_rs**: The Hydro dataflow library
- **Timely Dataflow**: Low-latency cyclic dataflow computational model
- **Differential Dataflow**: Differential computation framework

Results are generated using Criterion.rs, providing statistical analysis,
HTML reports, and regression detection capabilities.
