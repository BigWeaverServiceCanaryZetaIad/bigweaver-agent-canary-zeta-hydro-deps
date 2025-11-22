# Hydro Benchmarks Repository

This repository contains performance benchmarks for Hydro, including comparative benchmarks with timely-dataflow and differential-dataflow frameworks.

## Overview

This repository was created to maintain a clean separation between Hydro's core functionality and its performance benchmarking infrastructure. By isolating benchmarks that require external dependencies (timely and differential-dataflow), we keep the main Hydro repository lightweight while retaining comprehensive performance testing capabilities.

## What's Included

### Benchmarks

The repository includes the following benchmarks:

- **arithmetic** - Arithmetic operations benchmark
- **fan_in** - Fan-in pattern benchmark (includes timely comparison)
- **fan_out** - Fan-out pattern benchmark (includes timely comparison)
- **fork_join** - Fork-join pattern benchmark
- **futures** - Futures-based benchmark
- **identity** - Identity transformation benchmark (includes timely comparison)
- **join** - Join operations benchmark
- **micro_ops** - Micro operations benchmark
- **reachability** - Graph reachability benchmark (includes differential-dataflow comparison)
- **symmetric_hash_join** - Symmetric hash join benchmark
- **upcase** - String uppercase transformation benchmark
- **words_diamond** - Words diamond pattern benchmark

### Test Data

The benchmarks include necessary test data files:
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - Word list for text processing benchmarks

## Getting Started

### Prerequisites

- Rust toolchain (rustc, cargo)
- Git

### Installation

1. Clone this repository:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

2. Build the benchmarks:
```bash
cargo build --release -p benches
```

## Running Benchmarks

### Run All Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

This will execute all benchmark suites and generate reports in `target/criterion/`.

### Run Specific Benchmarks

To run a specific benchmark:
```bash
cargo bench -p benches --bench <benchmark_name>
```

For example:
```bash
cargo bench -p benches --bench identity
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
```

### Quick Benchmark Run

For a faster run during development (fewer samples):
```bash
cargo bench -p benches -- --quick
```

### Viewing Results

Benchmark results are generated in HTML format and can be found in:
```
target/criterion/
```

Open the `index.html` files in your browser to view:
- Detailed performance metrics
- Performance graphs
- Statistical analysis
- Comparisons between runs

## Local Development

### Using Local Hydro Changes

To test benchmarks against local Hydro changes instead of the git repository:

1. Clone the main Hydro repository alongside this one:
```bash
cd ..
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
```

2. Update `benches/Cargo.toml` to use local paths:
```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

3. Run benchmarks as normal - they'll now use your local Hydro changes.

### Comparing Performance

To compare performance before and after changes:

1. Run benchmarks with the baseline version:
```bash
cargo bench -p benches -- --save-baseline before
```

2. Make your changes to Hydro (if using local paths).

3. Run benchmarks again and compare:
```bash
cargo bench -p benches -- --baseline before
```

Criterion will automatically show the performance differences.

### Targeting Specific Tests

To run benchmarks matching a pattern:
```bash
cargo bench -p benches -- <pattern>
```

For example, to run all benchmarks with "join" in the name:
```bash
cargo bench -p benches -- join
```

## Understanding Benchmark Results

### Comparative Benchmarks

Some benchmarks compare Hydro's performance against established frameworks:

1. **Timely Dataflow**: Benchmarks like `fan_in`, `fan_out`, and `identity` compare basic dataflow operations with timely's implementation.

2. **Differential-Dataflow**: The `reachability` benchmark compares incremental computation and graph algorithms with differential-dataflow.

### Metrics

Benchmarks measure various performance characteristics:
- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Scalability**: Performance across different input sizes
- **Statistical confidence**: Confidence intervals and variance

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Workspace configuration
├── README.md               # This file
├── PERFORMANCE_COMPARISON.md  # Detailed performance testing guide
├── CONTRIBUTING.md         # Contribution guidelines
└── benches/                # Benchmark package
    ├── Cargo.toml          # Benchmark dependencies and configuration
    ├── README.md           # Benchmark-specific documentation
    ├── build.rs            # Build script
    └── benches/            # Benchmark source files
        ├── *.rs            # Benchmark implementations
        └── *.txt           # Test data files
```

## Dependencies

### Core Dependencies

- **criterion**: Benchmarking framework with statistical analysis
- **timely**: Timely dataflow for comparative benchmarks
- **differential-dataflow**: Differential dataflow for comparative benchmarks
- **dfir_rs**: Hydro DFIR runtime (from main repository)

### Support Dependencies

- **futures**: Async programming
- **tokio**: Async runtime
- **rand**: Random number generation for benchmarks
- **sinktools**: Utility functions (from main repository)

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark configuration to `benches/Cargo.toml`:
```toml
[[bench]]
name = "your_benchmark"
harness = false
```
3. Implement your benchmark using Criterion
4. Submit a pull request

### Updating Benchmarks

When updating existing benchmarks:
- Ensure backward compatibility with baseline comparisons
- Document any changes to benchmark methodology
- Run full benchmark suite to verify no regressions

## Continuous Integration

The repository may include CI pipelines for:
- Running benchmarks on pull requests
- Tracking performance over time
- Detecting performance regressions
- Generating performance reports

Consult `.github/workflows/` for CI configuration details.

## Why a Separate Repository?

Benchmarks were moved to this separate repository to:

1. **Avoid Dependency Bloat**: Keep the main Hydro repository free of timely and differential-dataflow dependencies, which are only needed for comparative benchmarking.

2. **Faster Builds**: Reduce build times for developers working on core Hydro functionality.

3. **Focused Development**: Allow the main repository to focus on core functionality while maintaining comprehensive performance testing separately.

4. **Independent Versioning**: Benchmark dependencies can be updated independently of the main Hydro release cycle.

5. **Clean Architecture**: Maintain clear separation of concerns between production code and performance testing infrastructure.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository

## Support

For questions or issues:

- **Benchmark implementation issues**: Open an issue in this repository
- **Hydro performance questions**: Open an issue in the main Hydro repository
- **General questions**: Use GitHub Discussions

## Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/) - Comprehensive guide to the benchmarking framework
- [Hydro Documentation](https://hydro.run) - Main Hydro project documentation
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) - Information about timely framework
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow) - Information about differential-dataflow framework

## License

Apache-2.0 - See LICENSE file for details