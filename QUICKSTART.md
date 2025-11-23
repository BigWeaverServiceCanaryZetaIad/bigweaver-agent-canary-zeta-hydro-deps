# Quick Start Guide

This guide will help you get started with running benchmarks in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Prerequisites

- Rust toolchain (1.91.1 or later)
- Access to the main bigweaver-agent-canary-hydro-zeta repository (for dependency references)

## Repository Setup

The benchmarks in this repository depend on the main Hydro repository. Ensure both repositories are checked out as siblings:

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/    # Main repository
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
```

## Quick Commands

### Run All Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Using Helper Scripts

#### Run Benchmarks with Options
```bash
./run_benchmarks.sh              # Run all benchmarks
./run_benchmarks.sh quick        # Run quick subset
./run_benchmarks.sh reachability # Run specific benchmark
./run_benchmarks.sh list         # List available benchmarks
```

#### Compare Results
```bash
./compare_benchmarks.sh          # Show summary
./compare_benchmarks.sh reachability  # Show specific comparison
```

## Understanding the Benchmarks

### Benchmarks Using Timely-Dataflow
These benchmarks compare Hydro implementations with timely-dataflow:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in data flow patterns
- `fan_out` - Fan-out data flow patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity transformations
- `join` - Join operations
- `upcase` - String uppercase transformations

### Benchmarks Using Differential-Dataflow
These benchmarks compare Hydro with differential-dataflow:
- `reachability` - Graph reachability computations

### Other Benchmarks
- `futures` - Async futures operations
- `micro_ops` - Micro-level operations
- `symmetric_hash_join` - Symmetric hash join patterns
- `words_diamond` - Word processing with diamond patterns

## Viewing Results

### Command-Line Output
Benchmark results are displayed in the terminal with timing information and comparisons.

### HTML Reports
After running benchmarks, view detailed HTML reports:
```bash
# Open in browser
firefox target/criterion/reports/index.html
# or
open target/criterion/reports/index.html
```

### Result Location
All benchmark results are stored in:
```
target/criterion/
├── <benchmark_name>/
│   ├── <comparison_group>/
│   │   └── report/
│   │       └── index.html
│   └── report/
│       └── index.html
└── reports/
    └── index.html
```

## Common Workflows

### 1. Run Quick Validation
```bash
./run_benchmarks.sh quick
```

### 2. Run Full Benchmark Suite
```bash
./run_benchmarks.sh all
```

### 3. Run and Compare Specific Benchmark
```bash
cargo bench -p benches --bench reachability
./compare_benchmarks.sh reachability
```

### 4. Run Benchmark with Specific Iterations
```bash
cargo bench -p benches --bench arithmetic -- --sample-size 100
```

## Performance Comparison

Each benchmark compares implementations across:

1. **Hydro (dfir_rs)** - The Hydro framework implementation
2. **Timely-Dataflow** - Direct timely-dataflow implementation
3. **Differential-Dataflow** - Differential-dataflow implementation (for applicable benchmarks)

The benchmarks provide timing comparisons to help evaluate:
- Relative performance
- Overhead differences
- Scalability characteristics
- Optimization opportunities

## Troubleshooting

### Compilation Errors

If you encounter dependency resolution issues:

```bash
# Clean and rebuild
cargo clean
cargo check --workspace

# Verify main repository is accessible
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs
ls -la ../bigweaver-agent-canary-hydro-zeta/sinktools
```

### Missing Dependencies

Ensure the main Hydro repository is checked out and up to date:
```bash
cd ../bigweaver-agent-canary-hydro-zeta
git pull
cargo check
```

### Benchmark Failures

If a specific benchmark fails:
```bash
# Run with verbose output
cargo bench -p benches --bench <name> -- --verbose

# Check for data files
ls -la benches/benches/*.txt
```

## Advanced Usage

### Baseline Comparisons

Save a baseline for comparison:
```bash
cargo bench -p benches -- --save-baseline main
```

Compare against baseline:
```bash
cargo bench -p benches -- --baseline main
```

### Custom Benchmark Parameters

Some benchmarks accept custom parameters. See individual benchmark source files in `benches/benches/` for details.

### Profiling

Run benchmarks with profiling enabled:
```bash
cargo bench -p benches --profile profile --bench <name>
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/           # Benchmark implementations (.rs files)
│   ├── Cargo.toml         # Benchmark dependencies
│   ├── build.rs           # Build script for generated code
│   └── README.md          # Benchmark documentation
├── Cargo.toml             # Workspace configuration
├── README.md              # Repository documentation
├── QUICKSTART.md          # This file
├── run_benchmarks.sh      # Helper script for running benchmarks
├── compare_benchmarks.sh  # Helper script for comparing results
└── Configuration files
    ├── clippy.toml        # Linting configuration
    ├── rustfmt.toml       # Formatting configuration
    └── rust-toolchain.toml # Rust version specification
```

## Dependencies

This repository depends on:

- **dfir_rs** - From main repository (../../bigweaver-agent-canary-hydro-zeta/dfir_rs)
- **sinktools** - From main repository (../../bigweaver-agent-canary-hydro-zeta/sinktools)
- **timely** (timely-master v0.13.0-dev.1) - Timely-dataflow framework
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1) - Differential-dataflow framework
- **criterion** - Benchmarking framework

## Getting Help

- View README.md for comprehensive documentation
- Check individual benchmark source files for implementation details
- Run `./run_benchmarks.sh help` for script usage
- Run `./compare_benchmarks.sh help` for comparison tool usage

## Next Steps

1. Run quick benchmarks to verify setup: `./run_benchmarks.sh quick`
2. Explore individual benchmarks: `./run_benchmarks.sh list`
3. View HTML reports for detailed analysis
4. Compare performance across implementations
5. Contribute improvements or new benchmarks

## Related Documentation

- [Main Repository Benchmarks Documentation](../bigweaver-agent-canary-hydro-zeta/BENCHMARKS_MOVED.md)
- [Migration Summary](../MIGRATION_SUMMARY.md)
- [Repository README](README.md)
