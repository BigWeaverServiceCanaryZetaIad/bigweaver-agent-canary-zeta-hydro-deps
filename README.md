# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for the BigWeaver Canary Zeta project that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency isolation.

## Purpose

This repository serves as a dedicated location for:
- Performance benchmarks comparing Hydroflow/DFIR against timely and differential-dataflow
- External dependencies (timely, differential-dataflow) that are not needed in the main codebase
- Performance comparison tools and test data
- Benchmark infrastructure and automation

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark package
│   ├── benches/                # Benchmark implementations
│   │   ├── arithmetic.rs       # Arithmetic operations benchmarking
│   │   ├── fan_in.rs          # Fan-in pattern benchmarking
│   │   ├── fan_out.rs         # Fan-out pattern benchmarking
│   │   ├── fork_join.rs       # Fork-join pattern benchmarking
│   │   ├── identity.rs        # Identity operation benchmarking
│   │   ├── join.rs            # Join operation benchmarking
│   │   ├── micro_ops.rs       # Micro-operations benchmarking
│   │   ├── reachability.rs    # Graph reachability benchmarking
│   │   ├── symmetric_hash_join.rs  # Symmetric hash join benchmarking
│   │   ├── upcase.rs          # Uppercase transformation benchmarking
│   │   ├── words_diamond.rs   # Word processing diamond pattern
│   │   ├── reachability_edges.txt         # Test data for reachability
│   │   ├── reachability_reachable.txt     # Expected results
│   │   └── words_alpha.txt                # Word list for text processing
│   ├── Cargo.toml             # Benchmark dependencies configuration
│   ├── README.md              # Benchmark documentation
│   └── build.rs               # Build script for generated code
├── docs/                      # Documentation
│   ├── QUICKSTART.md          # Quick start guide
│   ├── BENCHMARKS_COMPARISON.md  # Performance comparison guide
│   └── MIGRATION.md           # Migration notes from main repository
├── scripts/                   # Helper scripts
│   ├── run_benchmarks.sh      # Script to run all benchmarks
│   └── compare_performance.sh # Script to compare against main repo
├── Cargo.toml                 # Workspace configuration
├── rust-toolchain.toml        # Rust toolchain specification
└── README.md                  # This file
```

## Prerequisites

1. **Rust Toolchain**: This project requires Rust 1.91.1 or later (specified in `rust-toolchain.toml`)
2. **Main Repository**: The benchmarks depend on the main `bigweaver-agent-canary-hydro-zeta` repository
3. **Repository Layout**: Both repositories should be cloned as siblings:
   ```
   parent-directory/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

## Quick Start

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench identity

# Run with filtering
cargo bench identity

# Save baseline for comparison
cargo bench -- --save-baseline main
```

### Available Benchmarks

- **identity** - Basic data flow and transformation performance
- **arithmetic** - Arithmetic operations across different frameworks
- **join** - Join operation performance
- **reachability** - Graph reachability algorithms (uses real graph data)
- **fan_in** - Fan-in data flow patterns
- **fan_out** - Fan-out data flow patterns
- **fork_join** - Fork-join patterns
- **micro_ops** - Fine-grained operation benchmarks
- **upcase** - String transformation benchmarks
- **symmetric_hash_join** - Hash join operation benchmarks
- **words_diamond** - Diamond pattern with text processing

## Detailed Documentation

- [Quick Start Guide](docs/QUICKSTART.md) - Get up and running quickly
- [Benchmarks Comparison Guide](docs/BENCHMARKS_COMPARISON.md) - Detailed performance comparison instructions
- [Migration Notes](docs/MIGRATION.md) - Information about the move from main repository

## Dependencies

### External Dependencies
- **timely-master (0.13.0-dev.1)** - Timely dataflow framework for comparisons
- **differential-dataflow-master (0.13.0-dev.1)** - Differential dataflow framework for comparisons
- **criterion (0.5.0)** - Benchmarking framework with statistical analysis

### Main Repository Dependencies
- **dfir_rs** - Core Hydroflow/DFIR implementation (from main repository)
- **sinktools** - Utility tools (from main repository)

## Testing Against Local Changes

If you're making changes to the main repository and want to test performance:

1. Make changes in `bigweaver-agent-canary-hydro-zeta`
2. The benchmarks will automatically use the local version via path dependencies
3. Run benchmarks: `cargo bench`
4. Review results in `target/criterion/`

## Performance Comparison Workflow

```bash
# 1. Establish baseline on current main branch
cd ../bigweaver-agent-canary-hydro-zeta
git checkout main
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --save-baseline main

# 2. Test your changes
cd ../bigweaver-agent-canary-hydro-zeta
git checkout your-feature-branch
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --baseline main

# 3. Review results - Criterion will show performance differences
```

## Viewing Results

Benchmark results include:
- Console output with statistical analysis
- HTML reports in `target/criterion/`
- Historical comparison data

To view detailed HTML reports:
```bash
open target/criterion/report/index.html
```

## Relationship to Main Repository

This repository was created to:
1. **Isolate external dependencies** - Keep timely and differential-dataflow dependencies separate from the main codebase
2. **Maintain comparison capability** - Continue benchmarking against other dataflow frameworks
3. **Reduce main repository size** - Remove ~4.4 MB of benchmark code and data
4. **Improve dependency management** - Cleaner separation of concerns

The main repository (`bigweaver-agent-canary-hydro-zeta`) contains the core Hydroflow/DFIR implementation, while this repository provides the benchmarking infrastructure.

## Adding New Benchmarks

To add a new benchmark:

1. Create a new file in `benches/benches/<name>.rs`
2. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Implement using the Criterion framework
4. Include comparisons across relevant frameworks (Hydroflow, timely, differential-dataflow)
5. Document the benchmark purpose and expected results

See existing benchmarks for examples.

## Troubleshooting

### Build Failures

If benchmarks fail to build:
- Ensure the main repository is cloned in the correct location
- Verify Rust toolchain version matches `rust-toolchain.toml`
- Check that all dependencies are available: `cargo update`

### Path Issues

If you see path-related errors:
- Verify both repositories are cloned as siblings in the same parent directory
- Check the path specifications in `benches/Cargo.toml`
- Adjust paths if your directory structure differs

### Inconsistent Results

If benchmark results are inconsistent:
- Close other applications to reduce system load
- Run benchmarks multiple times and check variance
- Consider using a dedicated benchmark machine
- Check for thermal throttling or power management issues

## CI/CD Integration

Performance benchmarks can be integrated into CI/CD pipelines to track performance over time. Note that:
- Benchmark results can vary based on hardware and system load
- CI environments may not provide consistent performance characteristics
- Consider using dedicated benchmark infrastructure for reliable measurements

## Contributing

When contributing benchmarks:
1. Follow the existing code style and structure
2. Include documentation for new benchmarks
3. Ensure benchmarks run successfully
4. Add comments explaining the benchmark purpose
5. Include relevant test data if needed

## License

Apache-2.0 (same as main repository)

## Support and Resources

- Main repository: [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)

## Migration Date

These benchmarks were migrated from the main repository on November 22, 2024. See [docs/MIGRATION.md](docs/MIGRATION.md) for complete migration details.