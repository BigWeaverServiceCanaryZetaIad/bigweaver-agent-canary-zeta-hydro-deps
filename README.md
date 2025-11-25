# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains performance benchmarks for Hydro (DFIR/Hydroflow) that compare its performance against `timely-dataflow` and `differential-dataflow`. These benchmarks have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

- **Reduce dependency footprint** in the main repository
- **Improve build times** for users who don't need comparative benchmarks
- **Maintain cleaner separation of concerns** between core functionality and external comparisons
- **Enable independent versioning** of benchmark suites

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark workspace package
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs      # Arithmetic operation benchmarks
│   │   ├── fan_in.rs          # Fan-in pattern benchmarks
│   │   ├── fan_out.rs         # Fan-out pattern benchmarks
│   │   ├── fork_join.rs       # Fork-join pattern benchmarks
│   │   ├── identity.rs        # Identity operation benchmarks
│   │   ├── join.rs            # Join operation benchmarks
│   │   ├── reachability.rs    # Graph reachability benchmarks
│   │   ├── upcase.rs          # String uppercase benchmarks
│   │   ├── reachability_edges.txt         # Test data for reachability
│   │   └── reachability_reachable.txt     # Expected results for reachability
│   └── Cargo.toml             # Benchmark package configuration
├── Cargo.toml                 # Workspace configuration
├── README.md                  # This file
├── BENCHMARK_GUIDE.md         # Detailed benchmark usage guide
├── CONTRIBUTING.md            # Contribution guidelines
└── verify_benchmarks.sh       # Verification script

```

## Prerequisites

Before running these benchmarks, you need to have the main Hydro repository cloned alongside this one:

```bash
# Recommended directory structure
your-workspace/
├── bigweaver-agent-canary-hydro-zeta/          # Main Hydro repository
└── bigweaver-agent-canary-zeta-hydro-deps/     # This repository
```

### Clone the repositories:

```bash
# Clone main repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git

# Clone benchmarks repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

### System Requirements

- **Rust**: Latest stable toolchain (or nightly if required by dependencies)
- **Memory**: At least 4GB RAM recommended for building
- **Disk Space**: ~2GB for dependencies and build artifacts

## Quick Start

### 1. Build the benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build -p hydro-deps-benches --release
```

### 2. Run all benchmarks

```bash
cargo bench -p hydro-deps-benches
```

### 3. Run specific benchmarks

```bash
# Run only the arithmetic benchmark
cargo bench -p hydro-deps-benches --bench arithmetic

# Run only the reachability benchmark
cargo bench -p hydro-deps-benches --bench reachability

# Run only the join benchmark
cargo bench -p hydro-deps-benches --bench join
```

### 4. View results

Benchmark results are saved in `target/criterion/` with HTML reports for visualization:

```bash
# Open the HTML report (example for arithmetic benchmark)
open target/criterion/arithmetic/report/index.html
```

## Available Benchmarks

### Core Benchmarks

| Benchmark | Description | Compares |
|-----------|-------------|----------|
| **arithmetic** | Pipeline of arithmetic operations (+1) on integers | Hydro vs. Timely vs. Raw Pipeline |
| **fan_in** | Multiple input streams merging into one | Hydro vs. Timely |
| **fan_out** | Single stream splitting into multiple outputs | Hydro vs. Timely |
| **fork_join** | Fork-join dataflow pattern | Hydro vs. Timely |
| **identity** | Identity transformation (no-op) | Hydro vs. Timely |
| **join** | Stream join operations | Hydro vs. Timely |
| **reachability** | Graph reachability computation | Hydro vs. Timely vs. Differential |
| **upcase** | String uppercase transformation | Hydro vs. Timely |

### Performance Characteristics

Each benchmark measures:
- **Throughput**: Operations per second
- **Latency**: Time to process data
- **Memory usage**: Peak memory consumption (via Criterion)
- **Scalability**: Performance with varying data sizes

## Performance Comparison

These benchmarks enable comparing:

1. **Hydro (DFIR/Hydroflow)** - The new dataflow system
2. **Timely Dataflow** - Established low-latency dataflow system
3. **Differential Dataflow** - Incremental computation framework (for reachability)
4. **Raw implementations** - Baseline performance without frameworks (where applicable)

## Documentation

- **[BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)** - Comprehensive guide to running and understanding benchmarks
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Guidelines for contributing new benchmarks or improvements
- **Main Hydro Docs** - See the [main repository documentation](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Verification

To verify the benchmarks are correctly set up and can compile:

```bash
./verify_benchmarks.sh
```

This script checks:
- Repository structure is correct
- Dependencies are available
- All benchmarks compile successfully
- Test runs complete without errors

## Troubleshooting

### "Could not find dfir_rs"

**Problem**: The benchmark can't find the main Hydro repository.

**Solution**: Ensure both repositories are cloned side-by-side:
```bash
cd ..
ls -d bigweaver-agent-canary-hydro-zeta bigweaver-agent-canary-zeta-hydro-deps
```

### Build Failures

**Problem**: Dependencies fail to build.

**Solution**: 
1. Update Rust: `rustup update`
2. Clean build: `cargo clean`
3. Rebuild: `cargo build -p hydro-deps-benches`

### Benchmark Timeout

**Problem**: Benchmarks take too long or timeout.

**Solution**: Reduce the data size or iteration count in the specific benchmark file.

## Performance Tips

### For faster builds:
```bash
# Use more parallel jobs
cargo build -p hydro-deps-benches -j8

# Build in release mode
cargo build -p hydro-deps-benches --release
```

### For quicker benchmark runs:
```bash
# Reduce measurement time (less accurate)
cargo bench -p hydro-deps-benches -- --measurement-time 5

# Run specific benchmark variants
cargo bench -p hydro-deps-benches --bench arithmetic -- dfir
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for:
- How to add new benchmarks
- Coding standards and style guide
- Testing requirements
- Pull request process

## Related Documentation

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Benchmark Removal Documentation**: See `BENCHMARK_REMOVAL.md` in the main repository
- **Timely Dataflow**: [https://github.com/TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- **Differential Dataflow**: [https://github.com/TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## License

Licensed under the Apache License, Version 2.0. See the main repository for the full license text.

## Support

For questions or issues:
1. Check existing documentation in this repository and the main repository
2. Search existing issues in both repositories
3. Open a new issue with detailed information about your problem

## Changelog

### v0.1.0 - Initial Release
- Migrated 8 benchmarks from main repository
- Added comprehensive documentation
- Included verification scripts
- Preserved all performance comparison functionality