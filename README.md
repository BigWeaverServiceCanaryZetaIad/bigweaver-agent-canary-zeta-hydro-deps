# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the timely and differential-dataflow crates that have been separated from the main bigweaver-agent-canary-hydro-zeta repository.

## Purpose

This repository serves several key purposes:

1. **Dependency Isolation** - Keeps the main Hydro repository free from timely and differential-dataflow dependencies
2. **Performance Comparison** - Maintains the ability to run performance comparisons between Hydro/DFIR, Timely, and Differential implementations
3. **Clean Architecture** - Separates concerns between core development and performance benchmarking
4. **Faster Builds** - Reduces build times for the main repository by isolating heavyweight dependencies

## Structure

- `benches/` - Microbenchmarks for Hydro using timely and differential-dataflow
  - `benches/benches/` - Individual benchmark implementations
  - `benches/Cargo.toml` - Benchmark dependencies configuration
  - `benches/build.rs` - Build-time code generation for parametric benchmarks
  - `benches/README.md` - Detailed benchmark documentation

## Quick Start

### Prerequisites

- Rust toolchain (see main Hydro repository for version requirements)
- Git access to the main bigweaver-agent-canary-hydro-zeta repository

### Clone and Build

```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build --package benches
```

### Run Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

View results:
```bash
# Open target/criterion/report/index.html in your browser
```

## Benchmarks Overview

The repository includes 12 comprehensive benchmarks organized into three categories:

### Dataflow Patterns
- **fan_in** - Multiple streams merging into one
- **fan_out** - One stream splitting into multiple
- **fork_join** - Combined splitting and merging patterns

### Core Operations
- **arithmetic** - Pipeline arithmetic operations
- **identity** - No-op transformations (baseline)
- **join** - Stream join operations
- **symmetric_hash_join** - Symmetric hash join comparisons
- **micro_ops** - Fine-grained operation benchmarks

### Applications
- **reachability** - Graph reachability computation
- **upcase** - String transformation operations
- **words_diamond** - Word processing with diamond patterns
- **futures** - Async stream processing

Each benchmark typically includes multiple implementations (Hydro/DFIR, Timely, Differential) for direct performance comparison.

## Performance Comparison

### Comparing Implementations

The benchmarks enable you to compare performance across different dataflow frameworks:

1. **Hydro/DFIR** - The main Hydro dataflow implementation
2. **Timely** - Direct timely-dataflow implementations
3. **Differential** - Differential-dataflow implementations

Example output:
```
reachability/hydro        time:   [45.234 ms 46.123 ms 47.012 ms]
reachability/differential time:   [52.456 ms 53.234 ms 54.012 ms]
reachability/timely       time:   [48.789 ms 49.567 ms 50.345 ms]
```

### Statistical Analysis

Criterion provides:
- **Confidence intervals** for execution time
- **Performance change tracking** across runs
- **HTML reports** with graphs and detailed statistics
- **Historical comparison** to detect regressions

### Tracking Performance Over Time

Save baseline measurements:
```bash
cargo bench --save-baseline main
```

Compare against baseline:
```bash
cargo bench --baseline main
```

## Dependencies

### Primary Dependencies

- **timely** (timely-master 0.13.0-dev.1) - Timely-dataflow framework
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1) - Differential-dataflow framework
- **dfir_rs** - Referenced from main Hydro repository via git
- **criterion** - Benchmarking framework with statistical analysis

### Why These Versions?

The benchmarks use development versions of timely and differential-dataflow to ensure compatibility with the latest features and to enable accurate performance comparisons with Hydro's implementation.

## Documentation

### Quick References

- **[BENCHMARKING.md](BENCHMARKING.md)** - Comprehensive benchmarking guide with detailed instructions, methodology, and best practices
- **[benches/README.md](benches/README.md)** - Benchmark suite overview and technical details

### Key Topics

For detailed information about:
- **Running benchmarks** - See [BENCHMARKING.md - Quick Start](BENCHMARKING.md#quick-start)
- **Understanding results** - See [BENCHMARKING.md - Understanding Benchmark Results](BENCHMARKING.md#understanding-benchmark-results)
- **Performance comparison** - See [BENCHMARKING.md - Performance Comparison Methodology](BENCHMARKING.md#performance-comparison-methodology)
- **Individual benchmarks** - See [BENCHMARKING.md - Benchmark Categories](BENCHMARKING.md#benchmark-categories)
- **Advanced usage** - See [BENCHMARKING.md - Advanced Usage](BENCHMARKING.md#advanced-usage)
- **Adding new benchmarks** - See [benches/README.md - Development](benches/README.md#development)

## Migration from Main Repository

This repository was created by moving benchmarks from the main bigweaver-agent-canary-hydro-zeta repository. For migration details, see the [migration guide](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/-/blob/main/docs/docs/benchmarks/migration.md) in the main repository.

## Development Workflow

### Adding New Benchmarks

1. Create benchmark file in `benches/benches/your_benchmark.rs`
2. Add `[[bench]]` entry to `benches/Cargo.toml`
3. Implement using Criterion framework
4. Include multiple implementations (Hydro, Timely, Differential) when possible
5. Update documentation

### Testing Changes

```bash
# Build to verify compilation
cargo build --package benches

# Run benchmarks
cargo bench -p benches

# Check for regressions
cargo bench --baseline previous
```

## Contributing

When contributing benchmarks:

1. **Multiple Implementations** - Include Hydro/DFIR, Timely, and Differential variants when applicable
2. **Statistical Rigor** - Use Criterion's features for reliable measurements
3. **Documentation** - Update README files with benchmark descriptions
4. **Data Files** - Include any required data files in the repository
5. **Reproducibility** - Ensure benchmarks produce consistent results

## Related Repositories

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Dependencies**: This repository references the main repository via git dependencies for dfir_rs and sinktools

## License

Apache-2.0 (inherited from workspace configuration)