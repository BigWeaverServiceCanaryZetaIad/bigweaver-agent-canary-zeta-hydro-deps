# Hydro Dependencies Repository

This repository contains benchmarks and dependencies for the Hydro project that require heavy external dependencies like `timely` and `differential-dataflow`.

## Overview

The benchmarks in this repository were moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:
- Reduce dependency bloat in the main repository
- Improve build times for core Hydro development
- Maintain the ability to run performance comparisons with timely and differential-dataflow

## Structure

```
.
├── benches/              # Benchmark suite
│   ├── benches/         # Individual benchmark files
│   ├── Cargo.toml       # Benchmark dependencies
│   └── README.md        # Benchmark documentation
├── .github/
│   └── workflows/       # CI/CD for automated benchmarking
└── Cargo.toml           # Workspace configuration
```

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench --manifest-path benches/Cargo.toml
```

To run a specific benchmark:

```bash
cargo bench --manifest-path benches/Cargo.toml --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns
- `fork_join` - Fork-join patterns
- `futures` - Futures-based operations
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercase operations
- `words_diamond` - Words diamond pattern

## Performance Comparison

The benchmarks in this repository enable performance comparisons between:
- DFIR (Dataflow Intermediate Representation)
- Timely Dataflow
- Differential Dataflow

Results are automatically published via GitHub Actions and can be viewed on the GitHub Pages site for this repository.

## Migration Guide

### What was moved

All files from the `benches/` directory in the main repository, including:
- 12 benchmark test files (`.rs`)
- 3 test data files (`.txt`)
- Build configuration (`build.rs`)
- Dependencies configuration (`Cargo.toml`)
- Documentation (`README.md`)

### Why it was moved

1. **Dependency Management**: The main repository no longer needs to depend on `timely` and `differential-dataflow` packages
2. **Build Performance**: Removing these dependencies significantly improves build times
3. **Cleaner Architecture**: Separates performance testing from core functionality

### How to use

#### Running benchmarks locally

Clone this repository and run benchmarks as described above.

#### Comparing performance with previous versions

The CI/CD workflow automatically runs benchmarks and publishes results. Historical data is preserved for comparison.

#### Referencing from main repository

The main Hydro repository can reference this repository for performance regression testing and comparisons.

## Development

### Adding new benchmarks

1. Add your benchmark file to `benches/benches/`
2. Add a `[[bench]]` section to `benches/Cargo.toml`
3. Ensure the benchmark follows the existing patterns
4. Run locally to verify it works

### Updating dependencies

Dependencies are managed in `benches/Cargo.toml`. The main dependencies are:
- `dfir_rs` - Referenced from main repository via git
- `sinktools` - Referenced from main repository via git  
- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow framework
- `criterion` - Benchmarking framework

## CI/CD

The repository includes a GitHub Actions workflow (`.github/workflows/benchmark.yml`) that:
- Runs benchmarks on push to main
- Runs benchmarks on pull requests with `[ci-bench]` tag
- Publishes results to GitHub Pages
- Maintains historical performance data

## Contributing

For general Hydro contribution guidelines, see [CONTRIBUTING.md](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md) in the main repository.

For benchmark-specific contributions:
1. Ensure benchmarks are deterministic and repeatable
2. Include documentation for what the benchmark measures
3. Follow existing naming and structure conventions
4. Test locally before submitting

## License

Apache-2.0 (same as main Hydro repository)