# bigweaver-agent-canary-zeta-hydro-deps

This repository contains Hydro components and benchmarks that depend on Timely Dataflow and Differential Dataflow. These dependencies are kept separate from the main Hydro repository to maintain a clean dependency tree and prevent unnecessary dependencies for users who don't need performance comparisons with these systems.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow implementations. These benchmarks allow direct performance comparisons while keeping the heavy dependencies isolated.

See [benches/README.md](benches/README.md) for details on running and using the benchmarks.

## Purpose

This repository exists to:

1. **Isolate Dependencies**: Keep timely and differential-dataflow dependencies out of the main Hydro repository
2. **Enable Performance Comparisons**: Provide a way to benchmark Hydro against these well-established dataflow systems
3. **Maintain Clean Architecture**: Allow the main Hydro project to remain focused on its core functionality without heavyweight comparison dependencies

## Integration with Main Repository

This repository is designed to work alongside the main Hydro repository. The benchmarks reference Hydro components via git dependencies, allowing them to stay up-to-date with the latest Hydro developments while maintaining dependency separation.

## Running Benchmarks

```bash
cd benches
cargo bench
```

See the benchmarks README for more detailed instructions.