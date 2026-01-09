# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that compare DFIR with external dataflow frameworks (timely-dataflow and differential-dataflow).

## Purpose

This repository serves as a companion to the main `bigweaver-agent-canary-hydro-zeta` repository, housing comparative benchmarks that require external dependencies. This separation provides several benefits:

- **Cleaner Dependencies**: Keeps timely-dataflow and differential-dataflow dependencies out of the main repository
- **Faster Builds**: Reduces compilation time for the main repository by removing external dependencies
- **Better Organization**: Clearly separates internal benchmarks from comparative analyses
- **Independent Evolution**: Allows comparative benchmarks to evolve independently

## Prerequisites

To run the benchmarks in this repository, you need both repositories cloned at the same level:

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

The benchmarks in this repository depend on crates from the main repository (dfir_rs, sinktools, etc.).

## Running Benchmarks

From this repository's root:

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability
```

## Repository Structure

- `benches/` - Comparative benchmarks for DFIR vs timely/differential-dataflow

For more details, see the [benchmarks README](benches/README.md).

## Contributing

Please follow the same contribution guidelines as the main repository. See the [CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md) in the main repository.