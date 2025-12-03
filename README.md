# Hydro Benchmarks with Timely and Differential Dataflow

This repository contains performance benchmarks for Hydro that depend on `timely-dataflow` and `differential-dataflow` packages. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate heavy dependencies and improve build times.

## 📋 Overview

This repository provides comprehensive microbenchmarks for comparing Hydro's performance against other dataflow systems, particularly those using Timely Dataflow and Differential Dataflow.

## 🎯 Purpose

The benchmarks in this repository are designed to:
- Compare Hydro's performance with Timely and Differential Dataflow implementations
- Measure throughput and latency across various dataflow patterns
- Identify performance bottlenecks and optimization opportunities
- Track performance regression across releases

## 📁 Repository Structure

```
.
├── Cargo.toml              # Package configuration with timely/differential dependencies
├── build.rs                # Build script for generating benchmark code
├── README.md               # This file
├── BENCHMARKS_GUIDE.md     # Detailed guide for running and contributing benchmarks
└── benches/                # Individual benchmark implementations
    ├── README.md           # Benchmark-specific documentation
    ├── arithmetic.rs       # Arithmetic operation benchmarks
    ├── fan_in.rs           # Fan-in pattern benchmarks
    ├── fan_out.rs          # Fan-out pattern benchmarks
    ├── fork_join.rs        # Fork-join pattern benchmarks
    ├── futures.rs          # Async futures benchmarks
    ├── identity.rs         # Identity/passthrough benchmarks
    ├── join.rs             # Join operation benchmarks
    ├── micro_ops.rs        # Micro-operation benchmarks
    ├── reachability.rs     # Graph reachability benchmarks
    ├── reachability_edges.txt      # Test data for reachability benchmarks
    ├── reachability_reachable.txt  # Expected results for reachability
    ├── symmetric_hash_join.rs      # Hash join benchmarks
    ├── upcase.rs           # String transformation benchmarks
    ├── words_alpha.txt     # Word list for word processing benchmarks
    └── words_diamond.rs    # Word processing benchmarks
```

## 🚀 Running Benchmarks

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in main repository)
- Cargo

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmarks

Run a single benchmark:
```bash
cargo bench --bench <benchmark_name>
```

Examples:
```bash
cargo bench --bench reachability
cargo bench --bench identity
cargo bench --bench arithmetic
```

### Run Benchmarks with Filtering

Run benchmarks matching a pattern:
```bash
cargo bench --bench identity -- <filter>
```

## 📊 Performance Comparison

These benchmarks allow you to compare:
- **Hydro** implementations (using `dfir_rs`)
- **Timely Dataflow** implementations
- **Differential Dataflow** implementations

Each benchmark typically includes multiple implementations to facilitate direct performance comparisons.

## 🔧 Configuration

### Benchmark Parameters

Most benchmarks can be configured via:
- Number of iterations
- Data size
- Worker threads
- Batch sizes

See individual benchmark files for specific configuration options.

### Environment Variables

You can customize benchmark behavior using Criterion's environment variables:
- `CRITERION_SAMPLE_SIZE`: Number of samples (default: 100)
- `CRITERION_MEASUREMENT_TIME`: Measurement time in seconds (default: 5)
- `CRITERION_WARM_UP_TIME`: Warm-up time in seconds (default: 3)

Example:
```bash
CRITERION_SAMPLE_SIZE=1000 cargo bench --bench identity
```

## 📈 Interpreting Results

Benchmark results are saved to `target/criterion/` and include:
- HTML reports with graphs
- Statistical analysis (mean, median, standard deviation)
- Comparison with previous runs
- Regression analysis

Open the HTML reports in a browser:
```bash
open target/criterion/report/index.html
```

## 🔄 Continuous Integration

These benchmarks can be integrated into CI/CD pipelines to:
- Track performance over time
- Detect performance regressions
- Compare performance across branches

## 🤝 Contributing

When adding new benchmarks:
1. Create a new file in `benches/` following the naming convention `<benchmark_name>.rs`
2. Add the benchmark entry to `Cargo.toml` under `[[bench]]` sections
3. Follow existing naming conventions (e.g., `benchmark_name/dfir`, `benchmark_name/timely`)
4. Include multiple implementations (Hydro, Timely, Differential) where applicable
5. Document the benchmark purpose and expected behavior in code comments
6. Add appropriate test data files to `benches/` if needed
7. Update this README and BENCHMARKS_GUIDE.md to document the new benchmark

## 📚 Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main Hydro repository

## 🔗 Dependencies

This repository depends on:
- `timely-master`: Timely Dataflow implementation
- `differential-dataflow-master`: Differential Dataflow implementation
- `dfir_rs`: Hydro's DFIR runtime
- `criterion`: Benchmarking framework

## 📝 Notes

- These benchmarks are resource-intensive and may take significant time to complete
- For quick validation, consider running a subset of benchmarks
- Results may vary based on hardware and system configuration
- It's recommended to close other applications when running benchmarks for consistent results

## 📄 License

Apache-2.0

## 💡 Support

For questions or issues related to these benchmarks, please refer to the main Hydro repository's documentation and issue tracker.