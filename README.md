# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and testing infrastructure for Timely Dataflow and Differential Dataflow implementations, separated from the main [Hydro](https://github.com/hydro-project/hydro) repository to maintain clean dependency management.

## Purpose

The benchmarks in this repository enable performance comparisons between:
- Hydro (dfir_rs) implementations
- Timely Dataflow implementations
- Differential Dataflow implementations
- Baseline implementations (raw iterators, threads, etc.)

By separating these benchmarks into a dedicated repository, the main Hydro repository:
- Avoids heavy dependencies on timely-master and differential-dataflow-master
- Reduces build times for core contributors
- Maintains focus on core Hydro functionality
- Enables independent evolution of benchmarking infrastructure

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                 # Workspace configuration
├── rust-toolchain.toml        # Rust toolchain specification
├── README.md                  # This file
├── BENCHMARK_GUIDE.md         # Detailed benchmarking guide
└── benches/                   # Benchmark package
    ├── Cargo.toml             # Benchmark dependencies
    ├── README.md              # Benchmark-specific documentation
    ├── build.rs               # Build script
    └── benches/               # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_diamond.rs
        ├── reachability_edges.txt       # Test data (55,008 lines)
        ├── reachability_reachable.txt   # Test data (7,855 lines)
        └── words_alpha.txt              # Test data (370,104 lines)
```

## Quick Start

### Prerequisites

- Rust 1.91.1 (automatically installed via rust-toolchain.toml)
- Git

### Clone and Run

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability

# Run with custom sample size
cargo bench --bench arithmetic -- --sample-size 50
```

### View Results

Benchmark results are generated as HTML reports:

```bash
# After running benchmarks, open the report
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## Available Benchmarks

### Dataflow Patterns

- **arithmetic** - Arithmetic operations in pipelines
- **fan_in** - Multiple streams merging
- **fan_out** - Stream splitting patterns
- **fork_join** - Parallel fork-join execution
- **identity** - Identity transformations (baseline)
- **join** - Join operations between dataflows
- **symmetric_hash_join** - Symmetric hash join algorithms

### Applications

- **reachability** - Graph reachability algorithms
- **words_diamond** - Word processing in diamond patterns
- **upcase** - String transformations

### System Tests

- **futures** - Async futures-based operations
- **micro_ops** - Micro-level operation analysis

## Performance Comparison

### Comparing with Main Hydro Repository

To compare performance against the main Hydro repository:

1. **Document the baseline:**
   ```bash
   # In main Hydro repository
   git clone https://github.com/hydro-project/hydro
   cd hydro
   git log -1 --oneline  # Note the commit SHA
   ```

2. **Run benchmarks in hydro-deps:**
   ```bash
   cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench 2>&1 | tee benchmark_results.txt
   ```

3. **Compare implementations:**
   Each benchmark typically includes multiple variants (dfir_rs/compiled, dfir_rs/interpreted, timely, differential, baseline). Compare their relative performance in the HTML reports.

4. **Document findings:**
   - Commit SHAs of both repositories
   - Hardware specifications (CPU, RAM, OS)
   - Date and time of benchmarking
   - Key performance differences
   - Any anomalies or unexpected results

### Best Practices for Benchmarking

For reliable benchmark results:

1. **Minimize system load:**
   ```bash
   # Close unnecessary applications
   # Disable background services if possible
   ```

2. **Use consistent CPU frequency:**
   ```bash
   # Linux: Set to performance mode
   sudo cpupower frequency-set -g performance
   ```

3. **Run multiple times:**
   ```bash
   # Criterion runs multiple iterations by default
   # For critical comparisons, run the entire benchmark suite multiple times
   cargo bench
   cargo bench  # Run again to verify consistency
   ```

4. **Check for thermal throttling:**
   ```bash
   # Monitor CPU temperature during benchmarks
   # Ensure adequate cooling
   ```

## Development

### Adding New Benchmarks

See [benches/README.md](benches/README.md) for detailed instructions on adding and modifying benchmarks.

Quick steps:
1. Create `benches/benches/<name>.rs`
2. Add `[[bench]]` entry to `benches/Cargo.toml`
3. Implement using Criterion framework
4. Test with `cargo bench --bench <name>`

### Dependencies

This repository depends on:
- **criterion** - Statistical benchmarking framework
- **dfir_rs** - Hydro's dataflow library (via git)
- **timely-master** - Timely Dataflow framework
- **differential-dataflow-master** - Differential Dataflow library
- **sinktools** - Hydro's sink utilities (via git)

Note: dfir_rs and sinktools are referenced via git to maintain compatibility with the main Hydro repository.

### Updating Dependencies

To update to the latest Hydro version:

```bash
# Update Cargo.lock
cargo update -p dfir_rs
cargo update -p sinktools

# Verify benchmarks still compile and run
cargo bench
```

## CI/CD Integration

This repository can be integrated into CI/CD pipelines for continuous performance monitoring:

```yaml
# Example GitHub Actions workflow
name: Benchmarks
on: [push, pull_request]
jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions-rs/toolchain@v1
      - run: cargo bench
      - uses: actions/upload-artifact@v3
        with:
          name: benchmark-results
          path: target/criterion/
```

## Migration History

These benchmarks were migrated from the main Hydro repository on 2025-11-28 (commit b161bc10) to:
- Reduce the dependency footprint of the main repository
- Avoid unnecessary dependencies on timely-master and differential-dataflow-master
- Separate performance testing infrastructure from production code
- Improve build times for core contributors

For more details, see:
- [BENCHMARK_GUIDE.md](https://github.com/hydro-project/hydro/blob/main/BENCHMARK_GUIDE.md) in main Hydro repo
- [MIGRATION_SUMMARY.md](https://github.com/hydro-project/hydro/blob/main/MIGRATION_SUMMARY.md) in main Hydro repo

## Contributing

Contributions are welcome! When contributing:

1. Follow the existing code style and conventions
2. Add tests/benchmarks for new functionality
3. Document any changes to benchmark behavior
4. Ensure all benchmarks compile and run successfully
5. Consider backward compatibility for performance metrics

## Related Repositories

- **Main Hydro Repository**: https://github.com/hydro-project/hydro
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow

## Support

For questions or issues:
1. Check the [benches/README.md](benches/README.md) for benchmark-specific documentation
2. Review existing benchmark implementations for examples
3. Consult the main Hydro repository documentation
4. Open an issue in this repository

## License

Apache-2.0 (matching the main Hydro repository)

---

*Repository created: 2025-11-30*  
*Benchmarks migrated from: https://github.com/hydro-project/hydro (commit b161bc10)*