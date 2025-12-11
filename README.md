# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro/DFIR with other dataflow systems, specifically timely-dataflow and differential-dataflow.

## Purpose

This repository was created to separate benchmarks that depend on external dataflow systems from the main Hydro repository. This separation:

- Avoids adding unnecessary dependencies to the main repository
- Allows for independent performance comparisons
- Keeps the core Hydro project focused and maintainable
- Enables performance testing without polluting the main dependency tree

## Contents

### Benchmarks

The `benches/` directory contains performance comparison benchmarks between DFIR and timely-dataflow/differential-dataflow implementations. See [benches/README.md](benches/README.md) for details on available benchmarks and how to run them.

## Usage

To run benchmarks:

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench <benchmark_name>
```

## Relationship to Main Repository

These benchmarks were originally part of the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. They have been moved here to maintain a clean separation of concerns and avoid dependency bloat in the main project.

The benchmarks still depend on `dfir_rs` from the main repository (fetched via git) to enable performance comparisons.

## Contributing

When contributing benchmarks or updates to this repository, please ensure:

- Benchmarks remain focused on comparing different dataflow system implementations
- Dependencies are kept minimal and relevant
- Documentation is updated to reflect any changes
- Performance comparison results are reproducible

## License

Apache-2.0