# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to maintain a cleaner dependency structure.

## Contents

### Benchmarks

The `benches/` directory contains microbenchmarks for Timely Dataflow and Differential Dataflow implementations. These benchmarks were moved here to avoid requiring the main Hydro repository to depend on `timely` and `differential-dataflow` packages.

See [benches/README.md](benches/README.md) for detailed information about running benchmarks and performance comparisons.

## Purpose

This repository serves as a companion to the main Hydro project, providing:

1. **Isolated Dependencies**: Dependencies on external frameworks (Timely, Differential Dataflow) that are not core to Hydro
2. **Performance Benchmarking**: Tools and benchmarks for comparing Hydro's performance against other dataflow systems
3. **Clean Architecture**: Maintains separation of concerns and keeps the main repository focused on Hydro's core functionality

## Quick Start

### Running Benchmarks

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

### Performance Comparison

To compare with Hydro implementations:

```bash
cargo bench -p benches --features compare_hydro
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/              # Timely/Differential Dataflow benchmarks
│   ├── benches/          # Individual benchmark implementations
│   ├── Cargo.toml        # Benchmark dependencies
│   └── README.md         # Detailed benchmark documentation
├── Cargo.toml            # Workspace configuration
└── README.md             # This file
```

## Relationship to Main Repository

This repository works in conjunction with [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta). When enabled with the `compare_hydro` feature, benchmarks can optionally pull in Hydro dependencies for direct performance comparisons.

## Contributing

Contributions are welcome! If you're adding benchmarks or dependencies:

1. Ensure they are truly separate from Hydro's core functionality
2. Document the purpose and usage clearly
3. Update this README with any new directories or components
4. Follow the existing code structure and conventions

## License

Apache-2.0

## Links

- Main Hydro Repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Documentation: See the main repository for comprehensive Hydro documentation