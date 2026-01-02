# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that require Timely Dataflow and Differential Dataflow packages. These have been separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency separation and avoid adding these dependencies to the core Hydro/DFIR codebase.

## Contents

- **Benchmarks**: Performance comparison benchmarks between Hydro/DFIR and Timely/Differential Dataflow implementations
  - See [BENCHMARKS.md](BENCHMARKS.md) for detailed information on running and interpreting the benchmarks

## Purpose

By maintaining these benchmarks in a separate repository, we:
- Keep the main Hydro repository free from unnecessary dependencies
- Maintain the ability to compare performance with established dataflow frameworks
- Support continuous performance validation
- Provide clear separation of concerns between core functionality and external comparisons