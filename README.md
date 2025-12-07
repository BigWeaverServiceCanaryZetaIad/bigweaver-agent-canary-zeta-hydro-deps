# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for Hydro that require external dataflow libraries (timely-dataflow and differential-dataflow). These have been separated from the main hydro repository to avoid including heavy dependencies in the core project.

## Contents

### Benchmarks (`/benches`)

Performance comparison benchmarks between Hydro/DFIR and:
- **Timely Dataflow** - A low-latency data-parallel dataflow system
- **Differential Dataflow** - An incremental computation framework built on Timely

These benchmarks help us track Hydro's performance relative to established dataflow systems and retain the ability to run performance comparisons.

## Purpose

By maintaining these benchmarks in a separate repository, we:

1. **Reduce build times** - The main Hydro repository doesn't need to compile timely and differential-dataflow dependencies
2. **Minimize dependency overhead** - Production users of Hydro don't download unnecessary dependencies
3. **Maintain performance testing** - We can still benchmark against these systems when needed
4. **Organize by dependency** - Code is separated based on external dependencies

## Usage

See the [benches/README.md](benches/README.md) for instructions on running the benchmarks.

## Related Repositories

- **Main Hydro Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Contains the core Hydro framework and non-comparative benchmarks