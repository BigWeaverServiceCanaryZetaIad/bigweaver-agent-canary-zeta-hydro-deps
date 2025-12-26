# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for performance comparisons with timely and differential-dataflow packages. These components were separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency boundaries.

## Contents

- **benches/**: Performance comparison benchmarks for Timely Dataflow, Differential Dataflow, and Hydroflow implementations

## Purpose

This repository serves to:
- Maintain benchmarks that require timely and differential-dataflow dependencies
- Enable performance comparison testing without adding these dependencies to the main repository
- Provide a dedicated space for performance-related tooling and data

## Usage

See the [benches/README.md](benches/README.md) for detailed instructions on running the benchmarks.