# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that depend on external packages like timely and differential-dataflow.

## Purpose

This repository was created to maintain clean dependency boundaries in the main Hydro repository. By separating benchmarks that depend on timely and differential-dataflow packages, we:

- Reduce technical debt in the main repository
- Simplify maintenance and dependency management
- Prevent potential dependency conflicts
- Maintain the ability to run performance comparisons

## Contents

- **benches/**: Performance benchmarks comparing Hydro implementations with timely and differential-dataflow

## Usage

See [benches/README.md](benches/README.md) for details on running benchmarks.