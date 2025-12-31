# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code with dependencies on Timely Dataflow and Differential Dataflow. These components are maintained separately from the main Hydro repository to avoid direct dependencies on these frameworks in the core codebase.

## Contents

### Benchmarks (`/benches`)

Performance benchmarks comparing Hydro/DFIR to Timely Dataflow and Differential Dataflow implementations. These benchmarks allow for independent performance comparisons while keeping the main Hydro repository free of these dependencies.

For more information on running benchmarks, see [benches/README.md](benches/README.md).

## Purpose

By isolating dependencies on timely and differential-dataflow in this separate repository, we:
- Keep the main Hydro repository dependency tree cleaner
- Preserve the ability to run performance comparisons
- Maintain benchmarking capabilities independently
- Enable flexible versioning of benchmark code without affecting the main codebase