# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-11-22

### Added

- Initial repository setup with Cargo workspace configuration
- Comprehensive benchmark suite for timely and differential-dataflow frameworks
  - `arithmetic.rs` - Pipeline arithmetic operations benchmark
  - `fan_in.rs` - Multiple input stream merging benchmark
  - `fan_out.rs` - Single stream broadcasting benchmark
  - `fork_join.rs` - Parallel fork/join pattern benchmark
  - `identity.rs` - Identity/passthrough operations benchmark
  - `join.rs` - Join operations benchmark
  - `reachability.rs` - Graph reachability iterative benchmark
  - `upcase.rs` - String transformation benchmark
- Test data files for reachability benchmark
  - `reachability_edges.txt` - Graph edges (532KB, 50k+ edges)
  - `reachability_reachable.txt` - Expected reachability results
- Comprehensive documentation
  - `README.md` - Repository overview and quick start guide
  - `BENCHMARKS.md` - Detailed benchmark documentation with usage instructions
  - `PERFORMANCE_COMPARISON.md` - Guide for comparing performance with main repository
  - `benchmarks/README.md` - Benchmark package documentation
  - `CHANGELOG.md` - This file
- Convenience tooling
  - `run_benchmarks.sh` - Bash script for easy benchmark execution
- Proper dependency configuration
  - timely-master v0.13.0-dev.1
  - differential-dataflow-master v0.13.0-dev.1
  - criterion v0.5.0 with async_tokio and html_reports features
  - lazy_static v1.4
  - rand v0.8.0 and rand_distr v0.4.3

### Features

- All benchmarks use Criterion for statistical analysis
- HTML reports with visualizations automatically generated
- Baseline comparison support for tracking performance over time
- Integration with main repository for cross-framework comparisons
- Performance comparison methodology documented

### Documentation

- Comprehensive README with repository structure and quick start
- Detailed benchmark documentation explaining each benchmark's purpose
- Performance comparison guide with methodology and best practices
- Inline documentation in benchmark files
- Migration notes explaining relationship to main repository

### Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # Main documentation
├── BENCHMARKS.md                 # Benchmark details
├── PERFORMANCE_COMPARISON.md     # Comparison guide
├── CHANGELOG.md                  # This file
├── run_benchmarks.sh             # Convenience script
└── benchmarks/                   # Benchmark package
    ├── Cargo.toml
    ├── README.md
    └── benches/
        ├── *.rs                  # 8 benchmark files
        └── data/                 # Test data
```

### Notes

This repository was created following the team's architectural pattern of isolating dependencies into dedicated repositories. The benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:

1. Reduce unnecessary dependencies in the main codebase
2. Maintain cleaner dependency management
3. Enable focused performance testing across multiple frameworks
4. Prevent technical debt accumulation

For historical context, see `MIGRATION_NOTES.md` in the main repository.

---

[0.1.0]: https://github.com/hydro-project/hydro-deps/releases/tag/v0.1.0
