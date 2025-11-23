# Hydro Dependencies - Benchmark Repository

This repository contains benchmarks and performance comparison code for the Hydro project (dfir_rs) that depend on external dataflow frameworks like timely and differential-dataflow.

## Overview

This repository was created to maintain clean separation of concerns by moving benchmark code that depends on timely and differential-dataflow out of the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. This approach:

- **Reduces dependency footprint** of the main repository
- **Improves build times** by isolating heavy dependencies
- **Maintains functionality** for performance comparisons
- **Separates concerns** between core functionality and benchmarking

## Contents

### Benchmarks

The repository contains comprehensive performance benchmarks comparing dfir_rs (Hydro) implementations with:
- **Timely Dataflow**: For dataflow pattern comparisons
- **Differential Dataflow**: For incremental computation comparisons
- **Raw implementations**: For theoretical performance baselines

**8 Benchmark Suites:**
1. **Arithmetic** - Pipeline arithmetic operations
2. **Fan-In** - Multiple sources to single sink pattern
3. **Fan-Out** - Single source to multiple sinks pattern
4. **Fork-Join** - Combined fan-out and fan-in pattern
5. **Identity** - Pass-through operations
6. **Join** - Two-stream join operations
7. **Reachability** - Graph reachability computation
8. **Upcase** - String transformation operations

See [benches/README.md](benches/README.md) for detailed documentation.

## Quick Start

### Prerequisites

- Rust toolchain (see rust-toolchain.toml if provided)
- Git for cloning dependencies

### Running Benchmarks

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p hydro-benchmarks

# Run specific benchmark
cargo bench -p hydro-benchmarks --bench arithmetic

# Generate and view HTML reports
cargo bench -p hydro-benchmarks
# Reports available in target/criterion/report/index.html
```

### Performance Comparison Workflow

```bash
# 1. Establish baseline
cargo bench -p hydro-benchmarks -- --save-baseline main

# 2. Make changes to dfir_rs (in main repository)

# 3. Compare performance
cargo bench -p hydro-benchmarks -- --baseline main
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # This file
└── benches/                      # Benchmark package
    ├── Cargo.toml                # Benchmark dependencies
    ├── README.md                 # Detailed benchmark documentation
    ├── build.rs                  # Build script
    └── benches/                  # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── upcase.rs
```

## Dependencies

### Main Dependencies
- **dfir_rs**: Referenced from main hydro repository
- **timely**: Timely dataflow framework (`timely-master` 0.13.0-dev.1)
- **differential-dataflow**: Differential dataflow framework (`differential-dataflow-master` 0.13.0-dev.1)
- **criterion**: Benchmarking framework with statistical analysis

### Supporting Dependencies
- **tokio**: Async runtime
- **rand**: Random data generation
- **futures**: Async primitives

See [benches/Cargo.toml](benches/Cargo.toml) for complete dependency list.

## Local Development

To work with local changes to dfir_rs:

1. Clone both repositories side-by-side:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. Modify `benches/Cargo.toml` to use local path:
   ```toml
   dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = ["debugging"] }
   sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

3. Run benchmarks:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p hydro-benchmarks
   ```

## Benchmark Methodology

All benchmarks use the Criterion framework which provides:
- **Statistical rigor**: Confidence intervals and outlier detection
- **Automatic iteration**: Adjusts sample size for statistical significance
- **HTML reports**: Detailed visualizations and comparisons
- **Baseline comparison**: Track performance over time

### Performance Metrics

Each benchmark measures:
- **Mean execution time**: Average time per iteration
- **Standard deviation**: Variability in measurements
- **Throughput**: Operations per second (where applicable)
- **Comparison**: Performance vs. baseline (if set)

## Integration with Main Repository

### Coordinated Development

This repository is designed to work in tandem with the main hydro repository:

1. **Development workflow**: Make changes in main repository
2. **Performance validation**: Run benchmarks from this repository
3. **Regression detection**: Compare against established baselines
4. **Documentation**: Results inform optimization decisions

### Dependency Management

The benchmarks reference dfir_rs via git URL, ensuring:
- **Consistency**: Always uses published versions
- **Flexibility**: Can switch to local paths for development
- **Independence**: This repository can be built standalone

## Use Cases

### Performance Regression Testing

Run benchmarks in CI to detect performance regressions:

```yaml
# .github/workflows/benchmark.yml
- name: Run performance benchmarks
  run: cargo bench -p hydro-benchmarks --no-fail-fast
```

### Optimization Validation

Before and after optimization comparisons:

```bash
# Before optimization
cargo bench -p hydro-benchmarks -- --save-baseline before

# After optimization (make changes to dfir_rs)
cargo bench -p hydro-benchmarks -- --baseline before
```

### Framework Comparison

Compare Hydro (dfir_rs) performance with other frameworks:
- Timely Dataflow
- Differential Dataflow
- Raw Rust implementations

### Algorithm Selection

Use benchmark results to inform algorithm and pattern choices in your applications.

## Historical Context

**Created**: November 2025  
**Rationale**: Separation of benchmark dependencies from main repository

These benchmarks were previously part of the main bigweaver-agent-canary-hydro-zeta repository. They were moved to this dedicated repository to:

1. **Reduce main repository complexity**: Remove heavy dependencies
2. **Improve build times**: Faster compilation for core development
3. **Maintain testing capability**: Preserve performance comparison functionality
4. **Follow best practices**: Separate concerns and dependencies

For more details, see the migration documentation in the main repository:
- REMOVAL_SUMMARY.md
- MIGRATION_NOTES.md
- CHANGES_README.md

## Documentation

- **[benches/README.md](benches/README.md)**: Comprehensive benchmark documentation
- **Main repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Criterion docs**: https://bheisler.github.io/criterion.rs/book/

## Contributing

### Adding New Benchmarks

1. Create benchmark file in `benches/benches/`
2. Add benchmark entry to `benches/Cargo.toml`
3. Document in `benches/README.md`
4. Test locally
5. Submit pull request

### Guidelines

- Use realistic workload sizes
- Compare multiple implementations (dfir_rs, timely, differential, raw)
- Document benchmark purpose and methodology
- Ensure reproducibility

See [benches/README.md](benches/README.md) for detailed contribution guidelines.

## Troubleshooting

### Build Issues

```bash
# Clean build
cargo clean
cargo build -p hydro-benchmarks

# Update dependencies
cargo update
```

### Performance Issues

- Disable CPU frequency scaling
- Close background applications
- Run multiple times for consistency
- Check system load

See [benches/README.md](benches/README.md) for detailed troubleshooting.

## License

Apache-2.0

## Related Projects

- **[Hydro Project](https://github.com/hydro-project/hydro)**: Main Hydro repository
- **[Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)**: Timely dataflow framework
- **[Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)**: Differential dataflow framework

## Support

For questions or issues:
1. Review documentation in this repository
2. Check main repository documentation
3. Review benchmark source code
4. Contact the team

## Team Practices

This repository exemplifies team practices:
- **Clean dependency management**: Separating concerns
- **Modular architecture**: Independent, focused repositories
- **Performance-driven development**: Comprehensive benchmarking
- **Documentation**: Clear, thorough documentation

---

**Note**: This is a specialized repository for benchmarking purposes. For general Hydro development, see the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).