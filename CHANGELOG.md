# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- Initial repository setup for isolated timely and differential-dataflow dependencies
- Migrated performance comparison benchmarks from bigweaver-agent-canary-hydro-zeta repository
  - arithmetic: Arithmetic operations pipeline comparison
  - fan_in: Fan-in pattern performance
  - fan_out: Fan-out pattern performance
  - fork_join: Fork-join pattern performance
  - identity: Identity transformation performance
  - join: Join operations comparison
  - reachability: Graph reachability algorithms
  - upcase: String uppercase transformation
- Created comprehensive benchmark documentation and README
- Configured Cargo workspace for benchmark execution

### Purpose
This repository isolates dependencies on timely and differential-dataflow packages, which allows:
- Cleaner dependency tree in the main Hydro repository
- Faster compilation times for the main project
- Maintained ability to run performance comparisons between Hydro, Timely, and Differential Dataflow
- Better dependency management and technical debt reduction
