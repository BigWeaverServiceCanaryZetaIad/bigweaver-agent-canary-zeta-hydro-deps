# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance testing infrastructure for the Hydro project, specifically focused on comparing Hydroflow implementations with Timely and Differential Dataflow.

## Overview

This repository has been created to isolate benchmarks and their dependencies (particularly `timely` and `differential-dataflow`) from the main Hydro repository. This separation provides:

- **Cleaner Dependency Graph**: The main repository doesn't need to include timely/differential dependencies
- **Focused Performance Testing**: Dedicated space for benchmark development and maintenance
- **Better Isolation**: Changes to benchmark dependencies don't affect the main codebase

## Repository Structure

```
.
├── benches/              # Benchmark suite
│   ├── benches/          # Individual benchmark implementations
│   ├── Cargo.toml        # Benchmark dependencies
│   ├── README.md         # Benchmark usage guide
│   └── build.rs          # Build-time code generation
├── scripts/              # Utility scripts
│   ├── compare_benchmarks.sh   # Cross-repository benchmark comparison
│   └── verify_benchmarks.sh    # Benchmark verification tool
├── Cargo.toml            # Workspace configuration
├── README.md             # This file
├── BENCHMARK_DESCRIPTIONS.md   # Detailed benchmark documentation
└── MIGRATION_SUMMARY.md        # Migration history and details
```

## Benchmarks Included

The benchmark suite includes comparisons across different dataflow patterns:

- **arithmetic**: Pipeline operations with arithmetic transformations
- **fan_in**: Multiple inputs merging into one
- **fan_out**: One input splitting to multiple outputs
- **fork_join**: Fork-join parallelism patterns
- **identity**: Baseline identity operations
- **join**: Join operations comparison
- **reachability**: Graph reachability algorithms
- **upcase**: String transformation benchmarks
- **futures**: Async future handling
- **micro_ops**: Micro-operation benchmarks
- **symmetric_hash_join**: Hash join operations
- **words_diamond**: Diamond-shaped dataflow patterns

Each benchmark typically compares:
- Hydroflow (dfir_rs) implementations
- Timely Dataflow implementations
- Differential Dataflow implementations
- Raw/baseline implementations

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

### Run Benchmarks with Filters

```bash
# Run only timely-related benchmarks
cargo bench -p benches -- timely

# Run only hydroflow-related benchmarks
cargo bench -p benches -- dfir_rs
```

## Dependencies

The benchmarks depend on:

- **timely-master**: Timely Dataflow framework
- **differential-dataflow-master**: Differential Dataflow framework
- **dfir_rs**: Hydroflow runtime (from main Hydro repository)
- **sinktools**: Utilities from main Hydro repository
- **criterion**: Benchmarking framework

### Local Development

For local development with unpublished changes to the main Hydro repository, you can modify `benches/Cargo.toml` to use path dependencies:

```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## Performance Comparisons

### Verification Script

Before running benchmarks, verify that everything is set up correctly:

```bash
./scripts/verify_benchmarks.sh
```

This script will:
- Check that all benchmark files are present
- Verify data files exist
- Build the benchmarks
- Run quick tests of each benchmark

### Cross-Repository Comparisons

To compare performance between this repository and the main Hydro repository, use the provided comparison script:

```bash
./scripts/compare_benchmarks.sh
```

Options:
- `--baseline NAME` - Set baseline name (default: 'baseline')
- `--new NAME` - Set new benchmark name (default: 'current')
- `--filter PATTERN` - Only run benchmarks matching pattern
- `--main-repo PATH` - Path to main hydro repository

Examples:
```bash
# Run all benchmarks and save as 'current'
./scripts/compare_benchmarks.sh

# Run only arithmetic benchmarks
./scripts/compare_benchmarks.sh --filter arithmetic

# Compare with custom baseline names
./scripts/compare_benchmarks.sh --baseline old --new optimized
```

### Manual Comparison Process

If you prefer manual comparison:

1. Run benchmarks in this repository and save results:
   ```bash
   cargo bench -p benches -- --save-baseline current
   ```

2. Switch to the main Hydro repository and run historical benchmarks (if still present):
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches -- --save-baseline old
   ```

3. Compare results using criterion's comparison tools

### Continuous Integration

Benchmarks can be integrated into CI pipelines to:
- Track performance regressions
- Compare implementations
- Validate optimizations

See the scripts directory for automation examples.

## Documentation

For detailed information about each benchmark, see:
- `benches/README.md` - Benchmark usage and details
- `BENCHMARK_DESCRIPTIONS.md` - Detailed benchmark descriptions (if available)
- `MIGRATION_SUMMARY.md` - History of benchmark migration from main repository

## Contributing

When adding new benchmarks:

1. Add the benchmark file to `benches/benches/`
2. Register it in `benches/Cargo.toml` with:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Include comparisons with timely/differential when applicable
4. Update documentation

## Related Repositories

- **Main Hydro Repository**: `bigweaver-agent-canary-hydro-zeta` - Core Hydroflow implementation
- **This Repository**: `bigweaver-agent-canary-zeta-hydro-deps` - Benchmark and dependency isolation

## License

Apache-2.0