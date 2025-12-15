# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to isolate timely and differential-dataflow dependencies.

## Purpose

The main purpose of this repository is to:

1. **Isolate Dependencies**: Keep timely and differential-dataflow dependencies separate from the main codebase to reduce build times and dependency complexity
2. **Performance Comparisons**: Enable performance comparisons between Hydro implementations and Timely/Differential-Dataflow implementations
3. **Maintain Benchmark History**: Preserve the ability to run historical performance benchmarks

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks that compare Hydro/DFIR implementations with Timely and Differential-Dataflow implementations:

- Arithmetic operations
- Fan-in/fan-out patterns
- Fork-join patterns
- Identity operations
- Join operations
- Graph reachability
- String transformations

See [benches/README.md](benches/README.md) for detailed information about running benchmarks.

## Usage

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Viewing Results

Benchmark results are generated using criterion and stored in `target/criterion/` with HTML reports. Open the HTML files in your browser to view detailed performance metrics and comparison graphs.

## Dependencies

This repository depends on:

- **timely** (timely-master) - Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master) - Differential dataflow framework
- **dfir_rs** - Hydro DFIR runtime
- **criterion** - Benchmarking framework

## Relationship to Main Repository

This repository was created to separate benchmarks with external dependencies from the main bigweaver-agent-canary-hydro-zeta repository. The main repository contains:

- Core Hydro framework code
- Hydro-native benchmarks (without external dependencies)
- Documentation and examples

This separation improves:
- **Build Performance**: Faster builds in the main repository without timely/differential dependencies
- **Maintainability**: Clearer separation of concerns
- **Dependency Management**: Isolated external dependencies
- **Development Workflow**: Developers can work on the main codebase without needing timely/differential dependencies

## Contributing

When adding new benchmarks that require timely or differential-dataflow dependencies, they should be added to this repository rather than the main repository.

## License

Apache-2.0