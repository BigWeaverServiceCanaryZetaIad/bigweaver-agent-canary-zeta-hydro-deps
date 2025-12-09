# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on external frameworks like Timely Dataflow and Differential Dataflow. These have been separated from the main Hydro repository to avoid including these dependencies in the core codebase.

## Contents

### Benchmarks

Performance comparison benchmarks between Hydro and other dataflow frameworks.

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Purpose

This repository maintains the ability to run performance comparisons while keeping the main Hydro repository focused on core functionality without transitive dependencies on external frameworks.