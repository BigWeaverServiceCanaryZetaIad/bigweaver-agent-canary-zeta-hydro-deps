# Changelog

All notable changes to the bigweaver-agent-canary-zeta-hydro-deps repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-11-22

### Added

- Initial repository setup with Timely and Differential-Dataflow benchmarks
- Workspace Cargo.toml configuration with Rust 2024 edition
- Eight benchmark implementations:
  - `identity.rs` - Identity transformation benchmark (Timely)
  - `arithmetic.rs` - Arithmetic operations benchmark (Timely)
  - `fan_in.rs` - Stream fan-in pattern benchmark (Timely)
  - `fan_out.rs` - Stream fan-out pattern benchmark (Timely)
  - `fork_join.rs` - Fork-join pattern benchmark (Timely)
  - `join.rs` - Relational join benchmark (Timely)
  - `upcase.rs` - String manipulation benchmark (Timely)
  - `reachability.rs` - Graph reachability benchmark (Timely + Differential)
  
- Test data files:
  - `reachability_edges.txt` - Graph edges for reachability tests
  - `reachability_reachable.txt` - Expected reachability results
  - `words_alpha.txt` - Word list for string operation tests
  
- Comprehensive documentation:
  - `README.md` - Repository overview and quick reference
  - `GETTING_STARTED.md` - Detailed setup and usage guide
  - `PERFORMANCE_COMPARISON.md` - Guide for comparing with Hydroflow/DFIR benchmarks
  - `RELATIONSHIP_TO_MAIN_REPO.md` - Explanation of repository architecture
  - `CHANGELOG.md` - This file
  
- Dependencies:
  - `timely-master` v0.13.0-dev.1 - Timely Dataflow framework
  - `differential-dataflow-master` v0.13.0-dev.1 - Differential computation
  - `criterion` v0.5.0 - Benchmarking framework
  - Supporting dependencies: rand, rand_distr, static_assertions

- Build configuration:
  - `build.rs` - Build script for benchmark preparation
  - Workspace lints configuration for code quality
  - Release profile optimization settings

### Repository Context

This repository was created to house Timely and Differential-Dataflow benchmarks that were previously part of the main `bigweaver-agent-canary-hydro-zeta` repository. The separation was done to:

1. Reduce dependency footprint in the main repository
2. Maintain clean separation of concerns
3. Enable independent performance evaluation
4. Facilitate performance comparisons while keeping repositories decoupled

### Migration Notes

Benchmarks were extracted from the main repository at commit `484e6fdd` which contained the last version with timely and differential implementations integrated with Hydroflow benchmarks. The extraction process:

1. Isolated timely and differential benchmark functions
2. Removed dependencies on main repository code (dfir_rs, sinktools, etc.)
3. Created standalone implementations for each benchmark
4. Preserved test data files for reproducibility
5. Added comprehensive documentation for independent usage

### Technical Details

- **Rust Edition**: 2024
- **License**: Apache-2.0
- **Repository**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps

### Benchmark Characteristics

| Benchmark     | Framework(s)           | Data Size       | Focus Area              |
|---------------|------------------------|-----------------|-------------------------|
| identity      | Timely                 | 1M items        | Pure throughput         |
| arithmetic    | Timely                 | 1M items        | Computation             |
| fan_in        | Timely                 | 20M items       | Stream merging          |
| fan_out       | Timely                 | 1M items        | Stream broadcasting     |
| fork_join     | Timely                 | 1M items        | Parallel patterns       |
| join          | Timely                 | 100K items      | Relational operations   |
| upcase        | Timely                 | 100K words      | String manipulation     |
| reachability  | Timely + Differential  | ~500KB graph    | Iterative computation   |

### Future Roadmap

Potential future enhancements:

- [ ] Add more complex benchmarks (windowing, aggregation)
- [ ] Include memory usage profiling
- [ ] Add automated comparison scripts
- [ ] Create visualization tools for results
- [ ] Add CI/CD pipeline for automated benchmarking
- [ ] Include more differential-dataflow benchmarks
- [ ] Add benchmarks for streaming scenarios
- [ ] Create performance regression testing

### Acknowledgments

- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential-Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion.rs: https://github.com/bheisler/criterion.rs
- Main Hydroflow/DFIR project: https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta
