# Benchmark Setup and Migration Guide

## Overview

This repository now contains the complete timely and differential-dataflow benchmarks that were previously part of the `bigweaver-agent-canary-hydro-zeta` main repository. The benchmarks have been successfully migrated to enable performance comparisons without cluttering the main repository.

## Migration Completed

### What Was Migrated

The entire `benches/` directory from the main repository has been copied here, including:

#### Benchmark Files (benches/benches/)
1. **arithmetic.rs** - Arithmetic pipeline benchmarks comparing pipeline, copy, iterator, Hydroflow, and Timely implementations
2. **fan_in.rs** - Fan-in pattern benchmarks
3. **fan_out.rs** - Fan-out pattern benchmarks  
4. **fork_join.rs** - Fork-join pattern benchmarks
5. **futures.rs** - Futures-based async benchmarks
6. **identity.rs** - Identity transformation benchmarks
7. **join.rs** - Join operation benchmarks
8. **micro_ops.rs** - Micro-operation benchmarks
9. **reachability.rs** - Graph reachability benchmarks
10. **symmetric_hash_join.rs** - Symmetric hash join benchmarks
11. **upcase.rs** - String transformation benchmarks
12. **words_diamond.rs** - Diamond pattern word processing benchmarks

#### Data Files
- **reachability_edges.txt** (524KB) - Graph edge data for reachability tests
- **reachability_reachable.txt** (40KB) - Reachable nodes data
- **words_alpha.txt** (3.7MB) - English word list from [dwyl/english-words](https://github.com/dwyl/english-words)

#### Configuration Files
- **Cargo.toml** - Benchmark package configuration with all dependencies
- **README.md** - Basic benchmark usage instructions
- **build.rs** - Build script that generates fork_join benchmark code
- **.gitignore** - Ignores generated fork_join_*.hf files

### Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Workspace configuration
├── README.md               # Repository overview
├── BENCHMARKS_INFO.md      # Benchmark documentation
├── SETUP.md               # This file - setup and migration guide
└── benches/               # Benchmark package
    ├── Cargo.toml         # Benchmark dependencies and configurations
    ├── README.md          # Benchmark usage instructions
    ├── build.rs           # Build script for generating code
    └── benches/           # Individual benchmark implementations
        ├── .gitignore
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_alpha.txt
        └── words_diamond.rs
```

## Dependencies

### Key Dependencies

The benchmarks use the following major dependencies:

- **timely** (timely-master v0.13.0-dev.1) - Timely dataflow framework for performance comparison
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1) - Differential dataflow for comparisons
- **criterion** (v0.5.0) - Benchmarking framework with async_tokio and html_reports features
- **dfir_rs** - From main repository via git dependency
- **sinktools** - From main repository via git dependency

### Full Dependency List

See `benches/Cargo.toml` for the complete list of dependencies:
- criterion
- dfir_rs (git dependency)
- differential-dataflow
- futures
- nameof
- rand
- rand_distr
- seq-macro
- sinktools (git dependency)
- static_assertions
- timely
- tokio

## Running Benchmarks

### Prerequisites

- Rust toolchain (see rust-toolchain.toml in main repository for version)
- Cargo
- Internet connection (first build will fetch dependencies)

### Running All Benchmarks

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Running Specific Benchmarks

```bash
# Run a specific benchmark
cargo bench --bench reachability

# Run benchmarks matching a pattern
cargo bench --bench arithmetic

# List available benchmarks
cargo bench --help
```

### Available Benchmarks

The following benchmark targets are configured:

- `arithmetic` - Arithmetic pipeline operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity transformations
- `upcase` - String case transformations
- `join` - Join operations
- `reachability` - Graph reachability
- `micro_ops` - Micro-operations
- `symmetric_hash_join` - Symmetric hash joins
- `words_diamond` - Word processing with diamond pattern
- `futures` - Futures-based async operations

### Benchmark Output

Criterion generates detailed reports including:
- Statistical analysis of performance
- Comparison with previous runs
- HTML reports in `target/criterion/`
- Console output with timing information

## Configuration Details

### Workspace Configuration

The repository now has a proper Cargo workspace (`Cargo.toml` at root) with:
- Workspace members: `benches`
- Edition: 2024
- License: Apache-2.0
- Optimized release profiles for performance testing

### Git Dependencies

The benchmarks reference `dfir_rs` and `sinktools` from the main repository:

```toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", version = "^0.0.1" }
```

This ensures benchmarks always use the latest version from the main repository.

### Build Script

The `build.rs` script generates `fork_join_*.hf` files at build time:
- Generates code for fork-join benchmarks
- Creates files in `benches/benches/`
- Generated files are gitignored

## Performance Comparison Capabilities

These benchmarks enable comprehensive performance comparisons:

### Hydroflow vs Timely Dataflow
Most benchmarks include implementations in both frameworks for direct comparison.

### Different Implementation Strategies
- Pipeline-based approaches
- Iterator-based approaches
- Raw Rust baselines
- Compiled vs surface syntax

### Metrics Measured
- Throughput (operations per second)
- Latency (time per operation)
- Memory usage patterns
- Scaling characteristics

## Maintaining the Benchmarks

### Updating Dependencies

To update timely/differential-dataflow versions:

```bash
cd benches
cargo update -p timely-master
cargo update -p differential-dataflow-master
```

To update dfir_rs/sinktools from main repository:

```bash
cargo update -p dfir_rs
cargo update -p sinktools
```

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Follow the existing patterns using criterion
3. Add a `[[bench]]` section to `benches/Cargo.toml`
4. Document what the benchmark measures

Example:
```toml
[[bench]]
name = "new_benchmark"
harness = false
```

### Modifying Existing Benchmarks

When modifying benchmarks:
1. Maintain backward compatibility where possible
2. Update documentation
3. Run benchmarks before and after to compare
4. Consider creating a new benchmark instead of modifying if comparing different approaches

## Benefits of This Separation

### For Main Repository
- Cleaner codebase focused on core functionality
- Faster build times
- Reduced repository size
- Easier navigation for contributors

### For This Repository
- Independent benchmark development
- Dedicated performance testing environment
- Separate dependency management
- Can update benchmark frameworks independently
- Comprehensive performance comparison capabilities preserved

## Troubleshooting

### Build Issues

If you encounter build errors:

```bash
# Clean and rebuild
cargo clean
cargo build

# Update dependencies
cargo update

# Check Rust version
rustc --version
```

### Git Dependency Issues

If git dependencies fail to fetch:
- Check internet connection
- Verify repository URLs are accessible
- Try clearing cargo cache: `rm -rf ~/.cargo/registry`

### Benchmark Failures

If benchmarks fail to run:
- Ensure all data files are present
- Check that build.rs executed successfully
- Verify criterion is properly configured
- Look for errors in console output

## Migration History

- **Migration Date**: November 21, 2025
- **Source Commit**: 484e6fdd (last commit with benchmarks in main repository)
- **Files Migrated**: 19 files (12 benchmark implementations, 3 data files, 4 configuration files)
- **Total Size**: ~4.4MB (primarily data files)

## Related Documentation

- **README.md** - Repository overview
- **BENCHMARKS_INFO.md** - Detailed benchmark information
- **benches/README.md** - Quick usage guide
- **Main Repository BENCHMARK_REMOVAL.md** - Context for why benchmarks were removed

## Questions and Support

For questions about:
- **Benchmark Usage**: See benches/README.md and this file
- **Performance Issues**: Contact main repository maintainers
- **Adding Benchmarks**: Follow existing patterns and document thoroughly
- **Main Repository**: See bigweaver-agent-canary-hydro-zeta documentation

## Future Enhancements

Potential improvements for this repository:

1. **CI/CD Integration**: Automated benchmark runs on commits
2. **Performance Tracking**: Historical performance data storage
3. **Comparison Reports**: Automated comparison between versions
4. **Additional Benchmarks**: More comprehensive coverage
5. **Documentation**: More detailed analysis of benchmark results
6. **Optimization**: Benchmark-specific optimizations

## License

Same license as the main Hydro project: Apache-2.0

## Verification

To verify everything is set up correctly:

```bash
# Build the benchmarks
cargo build --release

# Run a quick benchmark
cargo bench --bench identity

# Check workspace structure
cargo metadata --format-version 1 | jq '.workspace_members'
```

If all commands complete successfully, the migration is complete and benchmarks are ready to use!
