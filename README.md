# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow, isolated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This repository maintains performance benchmarks that depend on the `timely` and `differential-dataflow` packages. By isolating these dependencies in a separate repository, we:

- Reduce the dependency footprint of the main repository
- Simplify maintenance and dependency management
- Prevent potential dependency conflicts
- Enable independent benchmark development and execution

## Contents

### Benchmarks (`/benches`)

Performance comparison benchmarks for Hydro and other dataflow systems, including:
- Microbenchmarks for various operators (identity, map, filter, join, etc.)
- Graph algorithms (reachability)
- Stream processing patterns (fork-join, fan-in, fan-out)
- Symmetric hash join implementations
- Futures-based async operations

See [benches/README.md](benches/README.md) for details on running specific benchmarks.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

## Dependencies

This repository references the main hydro repository via git dependencies for:
- `dfir_rs`: Core Hydro dataflow runtime
- `sinktools`: Utility functions

The benchmarks compare Hydro implementations against:
- `timely-dataflow`: Low-level dataflow runtime
- `differential-dataflow`: Incremental computation framework

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/           # Performance benchmarks
│   ├── benches/       # Benchmark source files
│   ├── Cargo.toml     # Benchmark dependencies
│   └── README.md      # Benchmark documentation
├── Cargo.toml         # Workspace configuration
└── README.md          # This file
```

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main Hydro repository