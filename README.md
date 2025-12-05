# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow, separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This repository was created to:
- Maintain a cleaner dependency structure in the main hydro repository
- Isolate timely and differential-dataflow dependencies
- Improve build times for core development
- Preserve benchmark functionality and performance testing capabilities

## Contents

### Benchmarks (`benches/`)

Contains comprehensive benchmarks for Hydro that use timely and differential-dataflow:
- Performance benchmarks for various stream operations
- Graph algorithms (reachability)
- Pattern benchmarks (fan-in, fan-out, fork-join, diamond)
- Micro-operation benchmarks

See [benches/README.md](benches/README.md) for detailed documentation on running benchmarks.

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

## Documentation

- [Benchmark Migration Guide](BENCHMARK_MIGRATION.md) - Detailed information about the migration and how to use these benchmarks
- [Benchmarks README](benches/README.md) - Quick reference for running individual benchmarks

## Dependencies

This repository maintains dependencies on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- Core hydro crates via git dependencies from the main repository

## Contributing

When contributing to benchmarks:
1. Ensure benchmarks run successfully with `cargo bench -p benches --bench <name>`
2. Document any new benchmarks in the appropriate README files
3. Follow the existing benchmark patterns and naming conventions
4. Update this README if adding new categories of benchmarks

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository

## License

Apache-2.0