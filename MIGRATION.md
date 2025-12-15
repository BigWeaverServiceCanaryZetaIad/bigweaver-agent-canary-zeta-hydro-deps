# Benchmark Migration - Hydro-Deps Repository

## Purpose

This repository was created to host benchmarks that depend on `timely` and `differential-dataflow` packages, which were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Migration Summary

**Migration Date**: [Current]  
**Source Repository**: bigweaver-agent-canary-hydro-zeta  
**Target Repository**: bigweaver-agent-canary-zeta-hydro-deps  

### What Was Migrated

All performance benchmarks that depend on timely and differential-dataflow packages:

#### Timely Dataflow Benchmarks
- `fanout_bench.rs` - Tests fan-out operation performance
- `join_bench.rs` - Tests join operation performance  
- `reachability_bench.rs` - Tests graph reachability performance

#### Differential Dataflow Benchmarks
- `arrange_bench.rs` - Tests arrange operation performance
- `reduce_bench.rs` - Tests reduce operation performance
- `iterate_bench.rs` - Tests iterative computation performance

### Why The Migration

1. **Dependency Isolation**: Keeps heavyweight timely/differential dependencies separate from main codebase
2. **Build Performance**: Reduces build times for the main repository
3. **Clear Separation**: Maintains focus on core functionality in main repository
4. **Independent Testing**: Allows performance testing without affecting main development

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                          # Workspace configuration
├── README.md                            # Repository overview and usage
├── MIGRATION.md                         # This file
└── benches/
    ├── timely_benchmarks/
    │   ├── Cargo.toml                   # Package configuration
    │   ├── README.md                    # Timely benchmarks documentation
    │   ├── fanout_bench.rs             # Fan-out benchmark
    │   ├── join_bench.rs               # Join benchmark
    │   └── reachability_bench.rs       # Reachability benchmark
    └── differential_benchmarks/
        ├── Cargo.toml                   # Package configuration
        ├── README.md                    # Differential benchmarks documentation
        ├── arrange_bench.rs            # Arrange benchmark
        ├── reduce_bench.rs             # Reduce benchmark
        └── iterate_bench.rs            # Iterate benchmark
```

## Using This Repository

### Prerequisites

- Rust toolchain (cargo, rustc)
- Sufficient system resources for running dataflow benchmarks

### Quick Start

```bash
# Clone the repository
git clone https://github.com/hydro-project/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run a timely benchmark
cd benches/timely_benchmarks
cargo run --bin fanout_bench --release

# Run a differential benchmark
cd ../differential_benchmarks
cargo run --bin arrange_bench --release
```

### Running All Benchmarks

```bash
# From repository root
cd benches/timely_benchmarks
for bench in fanout_bench join_bench reachability_bench; do
    echo "Running $bench..."
    cargo run --bin $bench --release
done

cd ../differential_benchmarks
for bench in arrange_bench reduce_bench iterate_bench; do
    echo "Running $bench..."
    cargo run --bin $bench --release
done
```

### Multi-Worker Benchmarks

Many benchmarks support distributed execution with multiple workers:

```bash
# Run with 4 workers
cargo run --bin join_bench --release -- -w 4
```

## Development Guidelines

### Adding New Benchmarks

1. Create a new `.rs` file in the appropriate benchmark directory
2. Update the corresponding `Cargo.toml` to add a new `[[bin]]` section
3. Update the benchmark directory's README.md
4. Test the benchmark thoroughly
5. Submit a PR with your changes

### Modifying Existing Benchmarks

1. Make changes to the benchmark code
2. Test locally with `cargo run --release`
3. Verify performance characteristics are as expected
4. Update documentation if behavior changes
5. Submit a PR with your changes

### Dependencies

This repository maintains workspace dependencies:

- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow framework

To update dependency versions:

1. Edit the `[workspace.dependencies]` section in root `Cargo.toml`
2. Run `cargo update`
3. Test all benchmarks
4. Document any API changes required

## Performance Comparison

When comparing performance across versions:

1. Always use `--release` builds for accurate measurements
2. Run benchmarks multiple times to account for variance
3. Document system configuration (CPU, memory, etc.)
4. Use consistent worker counts for comparisons
5. Record and analyze results systematically

### Benchmark Output

Benchmarks typically output:
- Worker count and index information
- Progress indicators during execution
- Completion messages
- Performance-specific metrics (timing, throughput, etc.)

## Relationship to Main Repository

This repository is a companion to the main bigweaver-agent-canary-hydro-zeta repository:

- **Main Repository**: Core functionality, no timely/differential dependencies
- **This Repository**: Performance benchmarks with timely/differential dependencies

### Coordinating Changes

When changes span both repositories:

1. Create PRs in both repositories
2. Reference companion PRs in PR descriptions
3. Follow merge order: hydro-deps first, then main repository
4. Ensure CI passes in both repositories before merging

## CI/CD Integration

This repository can be integrated into CI/CD pipelines:

```bash
# Basic CI check
cargo check --workspace

# Build benchmarks
cargo build --workspace --release

# Run benchmarks (optional, may be time-consuming)
cargo test --workspace --release
```

## Troubleshooting

### Build Issues

**Problem**: Compilation errors in timely/differential code  
**Solution**: Ensure you're using a compatible Rust version (check `rust-toolchain.toml` if present)

**Problem**: Out of memory during compilation  
**Solution**: Build with fewer parallel jobs: `cargo build --release -j 2`

### Runtime Issues

**Problem**: Benchmark crashes or hangs  
**Solution**: Check system resources, reduce worker count, verify input data

**Problem**: Inconsistent performance results  
**Solution**: Ensure system is not under load, disable CPU frequency scaling, run multiple iterations

## Support and Contact

For questions or issues:

- **Main Repository**: See [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta)
- **Performance Questions**: Contact Performance Engineering team
- **Benchmark Issues**: Open an issue in this repository

## References

- [Main Repository README](https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta/blob/main/README.md)
- [Main Repository BENCHMARK_MIGRATION.md](https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md)
- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)
