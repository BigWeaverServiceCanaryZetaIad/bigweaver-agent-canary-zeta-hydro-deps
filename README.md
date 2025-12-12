# Hydro External Framework Benchmarks

This repository contains benchmarks that compare Hydro/DFIR performance with external dataflow frameworks, specifically **timely-dataflow** and **differential-dataflow**. These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository to eliminate unnecessary dependencies.

## Overview

This repository provides:

- **Cross-framework benchmarks**: Compare Hydro/DFIR performance with timely and differential-dataflow
- **Performance analysis tools**: Run and compare execution times across frameworks
- **Reproducible results**: Standardized benchmark configurations for fair comparisons

## Why a Separate Repository?

The benchmarks in this repository depend on `timely-dataflow` and `differential-dataflow`, which are not required for Hydro development. Separating these benchmarks:

1. **Reduces dependencies** in the main Hydro repository
2. **Speeds up builds** for Hydro developers
3. **Maintains benchmark capability** for performance research
4. **Enables independent updates** of external framework versions

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/          # Benchmark implementations
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   ├── words_diamond.rs
│   │   ├── futures.rs
│   │   └── *.txt        # Test data files
│   ├── Cargo.toml       # Benchmark dependencies
│   └── README.md        # Benchmark details
├── Cargo.toml           # Workspace configuration
├── rust-toolchain.toml  # Rust version specification
└── README.md            # This file
```

## Getting Started

### Prerequisites

- Rust toolchain (version specified in `rust-toolchain.toml`)
- Git
- Sufficient system resources for benchmarking (recommended: 8GB+ RAM)

### Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Build the benchmarks:
   ```bash
   cargo build --release -p hydro-timely-benchmarks
   ```

## Running Benchmarks

### Run All Benchmarks

To execute all benchmarks:

```bash
cargo bench -p hydro-timely-benchmarks
```

This will run all benchmark suites and generate HTML reports in `target/criterion/`.

### Run Specific Benchmarks

Run individual benchmark categories:

```bash
# Performance comparison benchmarks
cargo bench -p hydro-timely-benchmarks --bench arithmetic
cargo bench -p hydro-timely-benchmarks --bench fan_in
cargo bench -p hydro-timely-benchmarks --bench fan_out
cargo bench -p hydro-timely-benchmarks --bench fork_join
cargo bench -p hydro-timely-benchmarks --bench identity
cargo bench -p hydro-timely-benchmarks --bench upcase

# Join operation benchmarks
cargo bench -p hydro-timely-benchmarks --bench join
cargo bench -p hydro-timely-benchmarks --bench symmetric_hash_join

# Graph algorithm benchmarks
cargo bench -p hydro-timely-benchmarks --bench reachability

# Complex workflow benchmarks
cargo bench -p hydro-timely-benchmarks --bench words_diamond
cargo bench -p hydro-timely-benchmarks --bench futures

# Micro-operation benchmarks
cargo bench -p hydro-timely-benchmarks --bench micro_ops
```

### Benchmark Parameters

Most benchmarks support customizable input sizes. By default, they use reasonable sizes for comparison. To modify parameters, edit the benchmark source files in `benches/benches/`.

## Performance Comparison

### Viewing Results

Benchmark results are saved in the `target/criterion/` directory:

```bash
# Open HTML reports in your browser
open target/criterion/report/index.html
```

Each benchmark generates:
- **Performance plots**: Execution time vs input size
- **Statistical summaries**: Mean, standard deviation, outliers
- **Comparison data**: Relative performance between runs

### Comparing Frameworks

The benchmarks compare three execution modes:

1. **DFIR (Hydro)**: Native Hydro execution model
2. **Timely**: Using timely-dataflow operators
3. **Differential**: Using differential-dataflow operators

Results show:
- Absolute execution times for each framework
- Relative performance ratios
- Throughput metrics where applicable

### Interpreting Results

When analyzing benchmark results:

- **Warm-up iterations**: Initial runs may be slower (excluded from measurements)
- **Sample size**: Each benchmark runs multiple iterations for statistical validity
- **System variance**: Background processes can affect results
- **Optimization level**: All benchmarks run with `--release` optimizations

## Best Practices for Benchmarking

### Environment Setup

For consistent benchmark results:

1. **Close unnecessary applications** to reduce system noise
2. **Disable CPU frequency scaling** if possible:
   ```bash
   # Linux example
   sudo cpupower frequency-set --governor performance
   ```
3. **Run multiple times** to account for variance
4. **Use a dedicated benchmark machine** for critical comparisons

### Fair Comparisons

To ensure fair framework comparisons:

- All benchmarks use **identical input data**
- **Same compiler optimizations** (`--release` mode)
- **Equivalent algorithmic implementations** across frameworks
- **Consistent measurement methodology** (Criterion.rs)

## Benchmark Descriptions

### Basic Operations

- **arithmetic**: Numerical computations and aggregations
- **identity**: Pass-through operations (baseline overhead)
- **upcase**: String transformation operations

### Data Flow Patterns

- **fan_in**: Multiple inputs converging to single output
- **fan_out**: Single input distributed to multiple outputs
- **fork_join**: Parallel processing with synchronization

### Join Operations

- **join**: Standard equi-join operations
- **symmetric_hash_join**: Hash-based join implementation

### Graph Algorithms

- **reachability**: Graph traversal and reachability analysis

### Complex Workflows

- **words_diamond**: Diamond-shaped dataflow pattern
- **futures**: Asynchronous operation handling
- **micro_ops**: Fine-grained operation benchmarks

## Troubleshooting

### Build Issues

**Problem**: Compilation errors with timely/differential dependencies

**Solution**: Ensure you have the latest Rust version:
```bash
rustup update
cargo clean
cargo build --release
```

**Problem**: Missing data files

**Solution**: Data files should be in `benches/benches/`. Check that `words_alpha.txt` and reachability data files exist.

### Benchmark Issues

**Problem**: Benchmarks take too long

**Solution**: Reduce iteration counts or input sizes in the benchmark source code.

**Problem**: Inconsistent results

**Solution**: 
- Close background applications
- Run benchmarks multiple times
- Check system resource usage (`htop`, `top`)

## Contributing

When adding new benchmarks:

1. **Follow existing patterns**: Use Criterion.rs for measurement
2. **Test all frameworks**: Include DFIR, Timely, and Differential variants
3. **Document parameters**: Explain input sizes and configurations
4. **Validate correctness**: Ensure all implementations produce identical results
5. **Update documentation**: Add benchmark descriptions to this README

## Performance Research

This repository is designed for:

- **Academic research**: Comparing dataflow system performance
- **Optimization validation**: Measuring impact of Hydro improvements
- **Regression testing**: Detecting performance regressions
- **Architecture evaluation**: Understanding trade-offs between frameworks

## Related Resources

- **Main Hydro Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)
- **Timely Dataflow**: [TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- **Differential Dataflow**: [TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- **Criterion.rs Documentation**: [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)

## Migration Notes

These benchmarks were migrated from the main Hydro repository in December 2025. For historical context, see:

- `BENCHMARK_MIGRATION.md` in the main Hydro repository
- Git history in bigweaver-agent-canary-hydro-zeta

## License

Apache-2.0 (consistent with the main Hydro project)

## Questions and Support

For questions about:

- **Benchmark methodology**: Open an issue in this repository
- **Hydro performance**: Refer to the main Hydro repository
- **Framework-specific issues**: Contact the respective framework maintainers

---

**Note**: This repository is specifically for cross-framework benchmarks. For Hydro-native benchmarks, see the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository.