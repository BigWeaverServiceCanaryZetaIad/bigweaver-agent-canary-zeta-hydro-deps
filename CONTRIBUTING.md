# Contributing to Hydro Dependencies Repository

This repository contains benchmarks and code with dependencies on `timely` and `differential-dataflow` that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository.

## Repository Purpose

This repository isolates dependencies that are only needed for specific functionality like benchmarking and performance comparisons. This keeps the main repository cleaner and more maintainable.

## Setup for Development

### Prerequisites

1. **Main Repository**: Clone the main Hydro repository alongside this one:
   ```bash
   cd /projects/sandbox
   git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
   git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Rust**: Use the same Rust toolchain as the main repository (see main repo's `rust-toolchain.toml`)

3. **Cargo**: Standard Cargo installation

### Directory Structure

Your workspace should look like:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/      # Main Hydro repository
│   ├── dfir_rs/
│   ├── sinktools/
│   └── ...
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
    ├── benches/                            # Benchmarks with timely/differential deps
    └── ...
```

## Running Benchmarks

### Using the Helper Script

```bash
# Run all benchmarks
./run_benchmarks.sh

# Run a specific benchmark
./run_benchmarks.sh reachability

# List available benchmarks
./run_benchmarks.sh --list

# Show help
./run_benchmarks.sh --help
```

### Using Cargo Directly

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic

# Run with specific options
cargo bench -p benches --bench reachability -- --sample-size 10
```

## Understanding the Benchmarks

### Benchmark Categories

1. **Micro Operations** (`micro_ops.rs`)
   - Tests basic operations and patterns
   - Useful for identifying performance regressions in core functionality

2. **Graph Operations**
   - `reachability.rs` - Graph reachability algorithms
   - `join.rs`, `symmetric_hash_join.rs` - Join operations

3. **Data Flow Patterns**
   - `fan_in.rs`, `fan_out.rs` - Fan patterns
   - `fork_join.rs` - Fork-join patterns
   - `identity.rs` - Pass-through operations

4. **Real-world Scenarios**
   - `words_diamond.rs` - Word processing with diamond pattern
   - `upcase.rs` - String transformations

5. **Async Operations**
   - `futures.rs` - Futures-based benchmarks

### Benchmark Results

Results are generated in `target/criterion/`:
- **Console output**: Summary statistics
- **HTML reports**: `target/criterion/report/index.html`
- **Detailed data**: Individual benchmark directories in `target/criterion/`

## Making Changes

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
3. Use the `criterion` framework for consistent results
4. Document the benchmark purpose in comments

### Modifying Existing Benchmarks

1. Edit the relevant `.rs` file in `benches/benches/`
2. Test your changes:
   ```bash
   cargo bench -p benches --bench your_benchmark_name
   ```
3. Review the results to ensure changes are intentional
4. Update documentation if benchmark behavior changes significantly

### Updating Dependencies

Dependencies are specified in `benches/Cargo.toml`:
- `timely` and `differential-dataflow` - Core dependencies for comparison benchmarks
- `dfir_rs` and `sinktools` - Path dependencies to main repository
- `criterion` - Benchmarking framework

To update versions:
1. Edit `benches/Cargo.toml`
2. Test that benchmarks still compile and run:
   ```bash
   cargo check -p benches
   cargo bench -p benches
   ```

## Testing

### Compilation Check
```bash
cargo check --workspace
```

### Running Tests
```bash
cargo test --workspace
```

### Benchmark Validation
```bash
# Quick validation run with reduced sample size
cargo bench -p benches -- --sample-size 10
```

## Performance Comparison Workflow

### Comparing Implementations

These benchmarks allow comparison between:
- DFIR implementations
- Timely/differential-dataflow implementations
- Different algorithm approaches

### Tracking Performance

1. **Baseline**: Run benchmarks on main branch
2. **Changes**: Run benchmarks on your branch
3. **Compare**: Use Criterion's comparison features or manually compare results

Example:
```bash
# Save baseline
git checkout main
cargo bench -p benches --bench reachability -- --save-baseline main

# Test changes
git checkout feature-branch
cargo bench -p benches --bench reachability -- --baseline main
```

## Submitting Changes

### Pull Requests

Follow the same PR conventions as the main repository:
- Use [Conventional Commits](https://www.conventionalcommits.org/) format
- Include benchmark results if performance is affected
- Document rationale for benchmark changes

### Coordinating with Main Repository

If changes depend on modifications to the main repository:
1. Create PRs in both repositories
2. Reference the related PR in descriptions
3. Coordinate merging (main repo first, then deps repo)

## Documentation

### Keeping Documentation Updated

When making changes:
- Update `README.md` if setup instructions change
- Update `benches/README.md` if benchmark usage changes
- Add comments to complex benchmark code
- Document any new dependencies or requirements

## Questions or Issues

If you encounter problems:
1. Check that the main repository is cloned alongside this one
2. Verify Rust toolchain matches main repository
3. Check `target/criterion/` for detailed error reports
4. Refer to main repository's `BENCHMARK_REMOVAL.md` for migration details

## Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Main Hydro Repository](https://github.com/hydro-project/hydro)
- [Benchmark Migration Details](https://github.com/hydro-project/hydro/blob/main/BENCHMARK_REMOVAL.md)
