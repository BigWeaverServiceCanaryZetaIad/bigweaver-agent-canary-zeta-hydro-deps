# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance comparison benchmarks between DFIR (Dataflow Intermediate Representation) and timely-dataflow/differential-dataflow. These benchmarks were migrated from the `bigweaver-agent-canary-hydro-zeta` repository to isolate the timely and differential-dataflow dependencies.

## Purpose

The benchmarks in this repository enable performance comparisons between:
- **DFIR**: The dataflow runtime used by Hydro
- **Timely Dataflow**: A low-latency cyclic dataflow computational model
- **Differential Dataflow**: An implementation of differential computation on timely dataflow

## Repository Structure

```
benches/
├── Cargo.toml          # Benchmark dependencies and configuration
└── benches/            # Benchmark implementations
    ├── arithmetic.rs   # Arithmetic operation benchmarks
    ├── fan_in.rs       # Fan-in pattern benchmarks
    ├── fan_out.rs      # Fan-out pattern benchmarks
    ├── fork_join.rs    # Fork-join pattern benchmarks
    ├── identity.rs     # Identity operation benchmarks
    ├── join.rs         # Join operation benchmarks
    ├── reachability.rs # Graph reachability benchmarks
    └── upcase.rs       # String uppercase transformation benchmarks
```

## Quick Start

### Prerequisites

- Rust toolchain (latest stable)
- Cargo

### Run All Benchmarks

```bash
cargo bench -p hydro-benches-comparison
```

For detailed usage instructions, troubleshooting, and advanced features, see [BENCHMARK_USAGE.md](BENCHMARK_USAGE.md).

### Verify Setup

To verify all benchmarks are properly configured:

```bash
bash scripts/verify_benchmarks.sh
```

### Run Specific Benchmarks

```bash
# Arithmetic operations
cargo bench -p hydro-benches-comparison --bench arithmetic

# Graph reachability
cargo bench -p hydro-benches-comparison --bench reachability

# Join operations
cargo bench -p hydro-benches-comparison --bench join

# Fan-in/Fan-out patterns
cargo bench -p hydro-benches-comparison --bench fan_in
cargo bench -p hydro-benches-comparison --bench fan_out

# Fork-join pattern
cargo bench -p hydro-benches-comparison --bench fork_join

# Identity and upcase operations
cargo bench -p hydro-benches-comparison --bench identity
cargo bench -p hydro-benches-comparison --bench upcase
```

## Benchmark Descriptions

### Arithmetic Benchmarks
Tests basic arithmetic operations across different dataflow implementations:
- Pipeline-based processing
- Raw iteration
- Compiled DFIR
- Timely dataflow
- Differential dataflow

### Reachability Benchmarks
Graph reachability analysis comparing:
- DFIR implementations
- Differential dataflow implementations
Tests transitive closure computation on graph data.

### Join Benchmarks
Compares join operation performance:
- Symmetric hash joins
- Timely dataflow joins
- Differential dataflow joins

### Pattern Benchmarks
Tests common dataflow patterns:
- **Fan-in**: Multiple streams merging into one
- **Fan-out**: One stream splitting into multiple
- **Fork-join**: Parallel processing with synchronization

### Transformation Benchmarks
Simple data transformation operations:
- **Identity**: Pass-through operations
- **Upcase**: String transformations

## Migration Context

These benchmarks were previously part of the main `bigweaver-agent-canary-hydro-zeta` repository. They were moved to this separate repository to:

1. **Isolate dependencies**: Remove timely-dataflow and differential-dataflow from the main codebase
2. **Maintain comparisons**: Preserve the ability to benchmark DFIR against alternative dataflow systems
3. **Improve build times**: Reduce compilation overhead for the main repository
4. **Clarify purpose**: Separate reference implementations from core functionality

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main Hydro repository with DFIR-native benchmarks
- **hydro-project/hydro**: Upstream Hydro project

## Dependencies

Key dependencies:
- `dfir_rs`: DFIR runtime and syntax
- `timely`: Timely dataflow framework
- `differential-dataflow`: Differential computation library
- `criterion`: Benchmarking framework
- `sinktools`: DFIR sink utilities

## Performance Comparison

To compare DFIR performance with timely/differential-dataflow:

1. Run benchmarks in this repository for reference implementations
2. Run DFIR-native benchmarks in the main repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```
3. Compare results using criterion's HTML reports in `target/criterion/`

**Automated Comparison**: Use the provided script to run benchmarks in both repositories:

```bash
bash scripts/compare_with_main.sh
```

This script will:
- Run benchmarks in both repositories
- Update DFIR dependencies to latest version
- Generate comparison summary
- Open HTML reports

For detailed instructions on cross-repository benchmarking, see [BENCHMARK_USAGE.md](BENCHMARK_USAGE.md).

## Contributing

When adding new comparison benchmarks:

1. Implement both DFIR and timely/differential versions in the same file
2. Use meaningful benchmark names that clearly indicate the implementation
3. Document any non-obvious performance characteristics
4. Update this README with benchmark descriptions
5. Add the benchmark entry to `benches/Cargo.toml`

See [BENCHMARK_USAGE.md](BENCHMARK_USAGE.md) for detailed contribution guidelines.

## Documentation

- **[BENCHMARK_USAGE.md](BENCHMARK_USAGE.md)** - Comprehensive guide to using, running, and interpreting benchmarks
- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Quick reference for common commands and patterns
- **[SETUP_VERIFICATION.md](SETUP_VERIFICATION.md)** - Checklist to verify proper benchmark setup
- **[MIGRATION.md](MIGRATION.md)** - Details about the benchmark migration from the main repository
- **[benches/README.md](benches/README.md)** - Quick reference for benchmark operations

## Scripts

- **[scripts/compare_with_main.sh](scripts/compare_with_main.sh)** - Run benchmarks in both repositories and compare results
- **[scripts/verify_benchmarks.sh](scripts/verify_benchmarks.sh)** - Verify all benchmarks are properly configured

## License

Apache-2.0