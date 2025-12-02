# Migration Guide: Timely/Differential Benchmarks

## What Was Moved

All benchmarks that depend on `timely-dataflow` and `differential-dataflow` have been moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to this dedicated repository.

### Files Moved

- `benches/` directory containing all benchmark code
- `benches/Cargo.toml` - Benchmark package configuration
- `benches/README.md` - Benchmark documentation
- `benches/build.rs` - Build script
- `benches/benches/*.rs` - All benchmark implementations
- `benches/benches/*.txt` - Benchmark test data files
- `.github/workflows/benchmark.yml` - CI workflow for running benchmarks

### Benchmarks Included

- `arithmetic` - Basic arithmetic operations performance
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Futures-based operation benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercasing benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

## Why Were They Moved

The benchmarks were moved to this separate repository for several important reasons:

1. **Reduce Dependency Bloat**: The main repository no longer needs to depend on the heavyweight `timely-dataflow` and `differential-dataflow` crates
2. **Improve Build Times**: Isolating these dependencies significantly reduces compile time for the main repository
3. **Maintain Separation of Concerns**: Performance comparison benchmarks are architecturally separate from the core Hydro implementation
4. **Preserve Performance Comparison Capability**: The ability to run performance comparisons against timely/differential implementations is retained and remains accessible

## How to Use the Relocated Benchmarks

### Prerequisites

Ensure you have Rust installed with the appropriate toolchain:
```bash
rustup install 1.91.1
```

### Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Running Benchmarks

**Run all benchmarks:**
```bash
cargo bench -p benches
```

**Run a specific benchmark:**
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

**Run benchmarks with output format:**
```bash
cargo bench -p benches -- dfir --output-format bencher
cargo bench -p benches -- micro/ops/ --output-format bencher
```

### Viewing Results

Benchmark results are generated in the `target/criterion/` directory. Open `target/criterion/report/index.html` in a browser to view detailed results with graphs and statistics.

### CI Integration

The repository includes GitHub Actions workflow (`.github/workflows/benchmark.yml`) that automatically runs benchmarks on:
- Scheduled runs (daily)
- Manual workflow dispatch with `should_bench: true`
- Commits/PRs tagged with `[ci-bench]`

Results are published to the `gh-pages` branch and available at the repository's GitHub Pages site.

## Impact on Development Workflow

### For Core Hydro Development

Developers working on the main Hydro repository no longer need to worry about timely/differential dependencies. The build process is faster and the dependency tree is cleaner.

### For Performance Engineering

Performance engineers can focus on this dedicated repository for:
- Running comparative benchmarks
- Performance regression testing
- Optimization experiments comparing Hydro vs timely/differential implementations

### For CI/CD

- Main repository CI runs faster without heavyweight benchmark dependencies
- Benchmark CI runs independently in this repository
- Performance tracking remains available through this repository's GitHub Pages

## Dependencies

The benchmarks in this repository depend on:

- **dfir_rs** (^0.14.0): The core DFIR runtime, pulled from crates.io
- **sinktools** (^0.0.1): Utilities for stream operations
- **timely-master** (0.13.0-dev.1): Timely dataflow for comparison
- **differential-dataflow-master** (0.13.0-dev.1): Differential dataflow for comparison
- **criterion** (0.5.0): Benchmarking framework

These are now isolated from the main repository's dependency tree.

## Related Changes

This migration is part of a coordinated effort to improve the Hydro project's build and dependency management. Related PRs:

- Main repository: Removal of timely/differential dependencies and benchmark code
- This repository: Addition of benchmarks and performance testing infrastructure

## Questions or Issues?

For questions about:
- **Benchmark usage**: See the [README.md](README.md) in this repository
- **Core Hydro development**: See the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Performance results**: Check the [benchmark results page](https://bigweaverservicecanaryzetaiad.github.io/bigweaver-agent-canary-zeta-hydro-deps/bench/)
