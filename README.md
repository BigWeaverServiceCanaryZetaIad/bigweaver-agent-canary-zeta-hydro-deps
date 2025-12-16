# BigWeaver Agent Canary Zeta Hydro Dependencies

This repository contains benchmarks and dependencies for comparing Hydro performance with Timely Dataflow and Differential Dataflow implementations.

## Purpose

This repository was created to isolate `timely` and `differential-dataflow` dependencies from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository. By separating these dependencies, we:

- **Reduce build times** for the main repository
- **Minimize dependency bloat** in the core Hydro codebase
- **Preserve benchmarking capabilities** for performance comparisons
- **Maintain clean separation** between Hydro and comparative frameworks

## Repository Contents

### Benchmarks

The `benches/` directory contains performance benchmarks that compare Hydro (DFIR) implementations with Timely Dataflow and Differential Dataflow:

| Benchmark | Description | Implementations Compared | Key Metrics |
|-----------|-------------|-------------------------|-------------|
| **arithmetic** | Pipeline of arithmetic operations (20 map operations) | Timely, Hydro (compiled & surface), Raw iterators, Thread pipeline | Throughput, latency |
| **fan_in** | Multiple input streams merging into one | Timely, Hydro | Stream concatenation performance |
| **fan_out** | Single stream splitting to multiple outputs | Timely, Hydro | Stream branching efficiency |
| **fork_join** | Fork-join dataflow pattern with filtering | Timely, Hydro | Pattern composition overhead |
| **identity** | Identity operations (no-op transformations) | Timely, Hydro | Baseline framework overhead |
| **join** | Join operations between two streams | Timely, Hydro | Join algorithm performance |
| **reachability** | Graph reachability computation (iterative) | Timely, Differential Dataflow, Hydro | Iterative dataflow performance |
| **upcase** | String uppercase transformations | Timely, Hydro | String processing efficiency |

See [benches/README.md](benches/README.md) for detailed information about running benchmarks.

## Quick Start

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` for version)
- Cargo

### Running Benchmarks

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability
```

### Viewing Results

Benchmark results are generated in `target/criterion/` with HTML reports including:
- Performance metrics
- Statistical analysis
- Historical comparisons

## Documentation

- **[BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md)**: Complete guide to the benchmark migration from the main repository
- **[benches/README.md](benches/README.md)**: Detailed benchmark documentation

## Relationship to Main Repository

This repository complements the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository:

| Repository | Contains | Dependencies |
|------------|----------|--------------|
| **bigweaver-agent-canary-hydro-zeta** (main) | Hydro framework, DFIR runtime, core benchmarks | Hydro-specific dependencies |
| **bigweaver-agent-canary-zeta-hydro-deps** (this) | Comparative benchmarks | Timely, Differential Dataflow, Hydro |

## For Different Teams

### Performance Engineering Team

Use this repository to:
- Run comparative benchmarks between Hydro and Timely/Differential implementations
- Analyze performance characteristics
- Generate performance reports

### Development Team

- The main repository no longer requires Timely/Differential dependencies
- Refer to this repository only when conducting performance comparisons
- Faster build times for day-to-day development

### CI/CD Team

Consider separate CI workflows:
- Main repository: Run on every commit
- This repository: Run weekly or on-demand for performance analysis

## Performance Comparison Workflow

This repository enables comprehensive performance comparisons between Hydro, Timely Dataflow, and Differential Dataflow implementations.

### Running Performance Comparisons

#### Option 1: Compare within this repository (recommended)

Each benchmark in this repository includes multiple implementations, allowing direct comparisons:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks (compares all implementations)
cargo bench

# Run specific benchmark to compare implementations
cargo bench --bench arithmetic    # Compares Timely vs Hydro vs baselines
cargo bench --bench reachability  # Compares Timely vs Differential vs Hydro
cargo bench --bench join          # Compares Timely vs Hydro for joins

# View detailed results
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

#### Option 2: Cross-repository comparison

If you need to compare with benchmarks from the main repository:

1. **Run benchmarks in this repository** (Timely/Differential baseline):
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

2. **Run benchmarks in main repository** (Hydro implementation):
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench
   ```

3. **Compare results** from both `target/criterion/` directories

### Understanding Benchmark Results

Criterion generates detailed performance reports including:

- **Performance Metrics**: Mean, median, standard deviation
- **Visualizations**: Violin plots, iteration time distributions
- **Historical Comparisons**: Trends over time (after multiple runs)
- **Statistical Analysis**: Regression detection, outlier identification

Results are available in `target/criterion/<benchmark_name>/report/index.html`

### Performance Analysis Tips

1. **Run multiple times**: Execute `cargo bench` 2-3 times to warm up the system and stabilize results
2. **Isolate runs**: Close other applications to minimize system noise
3. **Compare similar workloads**: Benchmarks are designed to test equivalent functionality across frameworks
4. **Look for patterns**: Focus on relative performance differences rather than absolute numbers
5. **Check implementation details**: Review benchmark source code to understand what's being measured

## Dependencies

This repository depends on:

- **timely-master** (v0.13.0-dev.1): Timely Dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1): Differential Dataflow framework
- **dfir_rs**: Hydro's DFIR runtime (from [hydro-project/hydro](https://github.com/hydro-project/hydro) via git)
- **criterion**: Benchmarking framework with statistical analysis
- Supporting utilities: futures, tokio, rand, sinktools

### Standalone Execution

**This repository is designed for standalone execution** and does not require the main `bigweaver-agent-canary-hydro-zeta` repository to be cloned or present locally. Key characteristics:

- ✅ **Self-contained**: All benchmarks and dependencies are in this repository
- ✅ **Git dependencies**: Hydro components (dfir_rs, sinktools) are fetched directly from GitHub
- ✅ **Independent builds**: Can be built and run without any local path dependencies
- ✅ **Isolated workspace**: Has its own Cargo workspace configuration

This design allows:
- Performance engineers to benchmark Timely/Differential without the full Hydro codebase
- CI/CD pipelines to run comparative benchmarks independently
- Easy distribution and sharing of performance comparison tools

## Contributing

For benchmark-related contributions:

1. Add new Timely/Differential benchmarks to this repository
2. Add new Hydro-only benchmarks to the main repository
3. Follow existing benchmark patterns and naming conventions
4. Update documentation accordingly

## License

Apache-2.0 (same as main Hydro repository)

## Questions and Support

- For benchmark usage: See [benches/README.md](benches/README.md)
- For migration details: See [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md)
- For Hydro framework: See the main repository documentation

## History

This repository was created to separate Timely and Differential Dataflow benchmark dependencies from the main Hydro repository, maintaining performance comparison capabilities while improving the development experience.