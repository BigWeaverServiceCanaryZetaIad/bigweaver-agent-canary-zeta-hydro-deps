# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code and dependencies for the BigWeaver Hydro project. It has been separated from the main repository to maintain a cleaner architecture.

## Contents

- **benches/**: Performance benchmarks comparing DFIR/Hydro with Timely Dataflow and Differential Dataflow
  - Includes benchmarks for graph reachability, arithmetic operations, join operations, and various micro-operations
  - Uses Criterion for statistics-driven benchmarking