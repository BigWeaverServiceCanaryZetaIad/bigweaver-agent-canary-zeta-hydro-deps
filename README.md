# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external dependencies and benchmarks for the Hydro project that are kept separate from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Structure

### external-benchmarks/

Contains performance comparison benchmarks between Hydro/DFIR and external dataflow frameworks (Timely Dataflow and Differential Dataflow). These benchmarks were moved from the main repository to:
- Keep external framework dependencies separate from the core codebase
- Prevent unwanted dependencies from infiltrating the main repository
- Maintain performance comparison capabilities

See the [external-benchmarks README](external-benchmarks/README.md) for more information on running these benchmarks.