# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on Timely Dataflow and Differential Dataflow packages. These components were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain performance comparison capabilities while reducing dependency complexity in the primary codebase.

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks that compare Hydro implementations against Timely Dataflow and Differential Dataflow. These benchmarks enable ongoing performance tracking and validation against established dataflow systems.

Available benchmarks include:
- Graph reachability algorithms
- Join operations (with various data types)
- Arithmetic operations
- Fan-in/fan-out patterns
- Fork-join patterns
- Identity transformations
- String transformations

See [benches/README.md](benches/README.md) for detailed instructions on running the benchmarks.

## Usage

To run all benchmarks:
```bash
cargo bench
```

To run specific benchmark suites:
```bash
cargo bench -p hydro-deps-benches --bench reachability
```

## Relationship to Main Repository

This repository maintains dependencies on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)

While also depending on Hydro components from the main repository:
- `dfir_rs` - Core Hydro dataflow functionality
- `sinktools` - Utility tools for dataflow operations

This separation allows the main repository to avoid these dependencies while retaining the ability to run performance comparisons.