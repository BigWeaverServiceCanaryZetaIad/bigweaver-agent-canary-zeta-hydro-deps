# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external dataflow frameworks (Timely Dataflow and Differential Dataflow).

## Contents

- **benches/**: Benchmarks comparing Hydro/DFIR with Timely Dataflow and Differential Dataflow

## Purpose

This repository keeps the main Hydro repository clean by separating benchmarks that require specialized dependencies. This allows:
- Faster builds of the main repository
- Cleaner dependency management
- Preservation of performance comparison capabilities

## Running Benchmarks

See [benches/README.md](benches/README.md) for instructions on running the benchmarks.