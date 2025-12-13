# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing DFIR with timely-dataflow and differential-dataflow.

## Overview

This repository was created to maintain a clean separation of concerns in the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. By moving comparison benchmarks that require external dataflow framework dependencies here, we keep the main repository focused on DFIR's core functionality without unnecessary dependencies.

## Contents

- **benches/** - Comparison benchmarks for DFIR vs timely-dataflow vs differential-dataflow

## Getting Started

### Prerequisites

1. Clone both repositories in the same parent directory:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. Ensure you have Rust installed (the version specified in `rust-toolchain.toml`)

### Running Benchmarks

```bash
# Run all comparison benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench arithmetic

# Run benchmarks matching a pattern
cargo bench -p benches -- dfir_rs
```

See [benches/README.md](benches/README.md) for detailed benchmark documentation.

## Relationship with Main Repository

This repository depends on the main repository via path dependencies. The benchmarks use DFIR implementations from the main repository while adding timely-dataflow and differential-dataflow implementations for comparison.

This structure provides several benefits:
1. **Clean Dependencies**: Main repository doesn't carry external framework dependencies
2. **Faster Builds**: Users who don't need comparison benchmarks get faster builds
3. **Maintained Functionality**: All performance comparison capabilities are preserved
4. **Easy Development**: Changes to DFIR are automatically reflected in comparison benchmarks

## Documentation

For more information about the benchmark migration and organization:
- See [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository
- See [benches/README.md](benches/README.md) for benchmark-specific documentation

## Contributing

When adding new comparison benchmarks:
1. Implement DFIR, timely-dataflow, and differential-dataflow versions
2. Use criterion for consistent benchmarking
3. Follow existing benchmark structure and naming conventions
4. Update this README and benches/README.md as needed

## License

Apache-2.0