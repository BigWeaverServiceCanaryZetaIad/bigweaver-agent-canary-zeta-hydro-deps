# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro/DFIR performance against external dataflow frameworks.

## Contents

### Benchmarks

The `benches/` directory contains performance comparison benchmarks for:
- **Timely Dataflow** - A low-latency cyclic dataflow computational model
- **Differential Dataflow** - An implementation of differential dataflow over Timely Dataflow

See [benches/README.md](benches/README.md) for details on running the benchmarks.

## Purpose

This repository is maintained separately from the main Hydro repository to:
1. Isolate external framework dependencies (Timely, Differential Dataflow) from core Hydro code
2. Maintain clean separation of concerns in the codebase
3. Enable independent performance comparison testing
4. Simplify dependency management for the main repository