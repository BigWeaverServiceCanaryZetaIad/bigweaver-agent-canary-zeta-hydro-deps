# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to prevent dependency bloat in the core codebase.

## Contents

### Performance Comparison Benchmarks

The `benches/` directory contains benchmarks that compare Hydro/DFIR performance against established dataflow frameworks:
- Timely Dataflow
- Differential Dataflow

These benchmarks ensure competitive performance and help identify optimization opportunities, while keeping the heavyweight framework dependencies separate from the main repository.

See [benches/README.md](benches/README.md) for details on running benchmarks.

## Purpose

This separation allows:
- Keeping the main Hydro repository free from timely and differential-dataflow dependencies
- Maintaining performance comparison capabilities
- Preventing dependency bloat in the core codebase
- Cleaner architecture for long-term sustainability
