# Hydro Performance Comparison Benchmarks

This repository contains benchmarks that compare Hydro's performance against Timely Dataflow and Differential Dataflow frameworks.

## Purpose

These benchmarks have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain a clean separation of concerns. The main Hydro repository avoids dependencies on timely and differential-dataflow packages, keeping the core codebase focused and minimizing external dependencies.

## Structure

- **benches/** - Performance comparison benchmarks

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench join
```

See the [benches README](benches/README.md) for more details on individual benchmarks.

## Contributing

When adding new performance comparison benchmarks against Timely or Differential Dataflow, they should be added to this repository rather than the main Hydro repository.