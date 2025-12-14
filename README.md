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

The `benches/` directory contains performance benchmarks that compare Hydro (DFIR) implementations with Timely Dataflow and Differential Dataflow.

#### Primary Benchmarks Moved from Main Repository

These benchmarks with Timely and Differential Dataflow dependencies were migrated from `bigweaver-agent-canary-hydro-zeta`:

- **fan_out**: Fan-out dataflow pattern benchmark with Timely comparisons
- **fan_in**: Fan-in dataflow pattern benchmark with Timely comparisons
- **fork_join**: Fork-join pattern benchmark with Timely comparisons
- **reachability**: Graph reachability benchmark with Differential Dataflow comparisons
- **join**: Join operations benchmark

#### Additional Benchmarks

- **arithmetic**: Arithmetic operations pipeline benchmark
- **identity**: Identity operation benchmark
- **upcase**: String uppercase transformation benchmark

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

# Run specific benchmarks that were moved from main repository
cargo bench --bench fan_out
cargo bench --bench fan_in
cargo bench --bench fork_join
cargo bench --bench reachability
cargo bench --bench join
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

## Dependencies

This repository isolates the following dependencies that were removed from the main repository:

- **timely-master** (v0.13.0-dev.1): Timely Dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1): Differential Dataflow framework

Additional dependencies:
- **dfir_rs**: Hydro's DFIR runtime (from main repository)
- **criterion**: Benchmarking framework
- Supporting utilities from the Hydro ecosystem

The main repository (`bigweaver-agent-canary-hydro-zeta`) no longer has `timely` or `differential-dataflow` dependencies, resulting in faster build times for day-to-day development.

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