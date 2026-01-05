# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and tests that depend on external dataflow frameworks (Timely Dataflow and Differential Dataflow).

These components were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain a clean separation of dependencies and avoid including external dataflow frameworks in the main codebase.

## Contents

- `benches/` - Performance benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow

## Usage

See the README in each subdirectory for specific usage instructions.

To run benchmarks:
```bash
cargo bench -p benches
```