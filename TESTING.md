# Testing the Migrated Benchmarks

This document provides instructions for testing the migrated benchmarks to ensure they function correctly in the new repository.

## Prerequisites

- Rust toolchain (version specified in `rust-toolchain.toml`)
- Cargo package manager
- Git (for fetching dependencies from hydro-project/hydro repository)

## Quick Test

To verify all benchmarks compile correctly:

```bash
cargo check --benches
```

## Running Individual Benchmarks

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

## Running All Benchmarks

To run all benchmarks in the repository:

```bash
cargo bench
```

**Note**: Running all benchmarks may take significant time as each benchmark includes multiple implementations for performance comparison.

## Expected Behavior

Each benchmark should:
1. Compile without errors
2. Execute all test implementations (Timely, Differential, Hydro variants)
3. Generate performance comparison reports in `target/criterion/`
4. Complete with all assertions passing

## Performance Comparison

After running benchmarks, you can view detailed performance reports:

```bash
# Open the HTML report
open target/criterion/report/index.html
```

The reports will show side-by-side comparisons of:
- Timely Dataflow implementations
- Differential Dataflow implementations  
- Various Hydro (dfir_rs) implementations

## Troubleshooting

### Compilation Errors

If you encounter compilation errors:

1. Ensure you have the correct Rust toolchain:
   ```bash
   rustup show
   ```

2. Clean the build cache:
   ```bash
   cargo clean
   ```

3. Update dependencies:
   ```bash
   cargo update
   ```

### Missing Dependencies

If dfir_rs or sinktools dependencies fail to fetch:

1. Verify you have network access to GitHub
2. Check that the hydro repository is accessible:
   ```bash
   git ls-remote https://github.com/hydro-project/hydro
   ```

### Build Script Errors

The `benches/build.rs` script generates code for the fork_join benchmark. If this fails:

1. Check that the output directory is writable
2. Verify the generated file location: `benches/benches/fork_join_20.hf`

## Performance Testing Strategy

For meaningful performance comparisons:

1. **Run on consistent hardware**: Use the same machine for all comparisons
2. **Close other applications**: Minimize background processes
3. **Multiple runs**: Run benchmarks several times to account for variance
4. **Check system load**: Ensure system is idle during benchmarks
5. **Use release mode**: Benchmarks automatically use optimized builds

## Continuous Integration

If setting up CI for these benchmarks:

```yaml
# Example GitHub Actions workflow
- name: Check benchmarks compile
  run: cargo check --benches

# Note: Running full benchmarks in CI is optional and time-consuming
# - name: Run benchmarks
#   run: cargo bench --no-fail-fast
```

## Reporting Issues

If you encounter issues with the benchmarks:

1. Verify the issue exists in this repository
2. Check if it also occurs in the main hydro repository
3. Include full error output and system information
4. Note which specific benchmark(s) are affected

## Migration Verification

To verify the migration completed successfully, run:

```bash
/projects/sandbox/verify_benchmark_migration.sh
```

This script checks:
- All expected benchmarks exist in the hydro-deps repository
- Benchmarks were removed from the main repository
- Dependencies are correctly configured
- Documentation is up to date
- No timely/differential references remain in the main repo
