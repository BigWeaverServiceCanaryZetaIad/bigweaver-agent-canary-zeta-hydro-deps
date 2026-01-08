# Benchmark Migration Documentation

## Overview

This document explains the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated dependencies repository (`bigweaver-agent-canary-zeta-hydro-deps`).

## Migration Date

December 19, 2025

## Reason for Migration

The benchmarks were separated to achieve:

1. **Clean Dependency Management**: Remove `timely` and `differential-dataflow` dependencies from the main repository
2. **Improved Code Organization**: Separate performance testing code from production code
3. **Focused Development**: Allow each repository to evolve independently
4. **Reduced Build Times**: Main repository no longer needs to compile external dataflow libraries
5. **Clear Separation of Concerns**: Production code vs. performance comparison code

## What Was Migrated

### Benchmark Files

All benchmark files that depend on timely dataflow:

- `benches/benches/arithmetic.rs` - Arithmetic operations benchmark
- `benches/benches/fan_in.rs` - Fan-in pattern benchmark
- `benches/benches/fan_out.rs` - Fan-out pattern benchmark
- `benches/benches/fork_join.rs` - Fork-join pattern benchmark
- `benches/benches/identity.rs` - Identity/passthrough benchmark
- `benches/benches/upcase.rs` - String transformation benchmark

### Supporting Code

- `babyflow/` - Custom dataflow implementation used in benchmarks
- `spinachflow/` - Alternative dataflow implementation used in benchmarks
- `benches/Cargo.toml` - Benchmark configuration with timely dependency
- `benches/src/lib.rs` - Benchmark library code

### Configuration Files

- Root `Cargo.toml` - Workspace configuration
- `.gitignore` - Build artifact exclusions

## Directory Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                      # Workspace configuration
├── README.md                        # Repository documentation
├── BENCHMARK_MIGRATION.md          # This file
├── .gitignore                       # Git ignore patterns
├── babyflow/                        # Custom dataflow library
│   ├── Cargo.toml
│   └── src/
├── spinachflow/                     # Alternative dataflow library
│   ├── Cargo.toml
│   └── src/
└── benches/                         # Benchmark code
    ├── Cargo.toml                   # Benchmark dependencies (includes timely)
    ├── src/
    │   └── lib.rs
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        └── upcase.rs
```

## Changes Made to Migrated Code

### No Path Changes Required

Since `babyflow` and `spinachflow` were moved alongside the benchmarks, all relative path references in `benches/Cargo.toml` remain valid:

```toml
babyflow = { path = "../babyflow" }
spinachflow = { path = "../spinachflow" }
```

### Import Statements

No import statement changes were necessary as the benchmark code uses these packages as external dependencies.

## What Remains in Main Repository

The main `bigweaver-agent-canary-hydro-zeta` repository should contain:

- Production code without timely/differential-dataflow dependencies
- Any benchmarks that don't depend on external dataflow libraries
- Documentation explaining where timely-dependent benchmarks were moved
- Reference to this repository for performance comparison

## Running Benchmarks After Migration

### In This Repository (bigweaver-agent-canary-zeta-hydro-deps)

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
cargo bench --bench fan_in

# View results
open target/criterion/report/index.html
```

### Cross-Repository Comparison

To compare performance between implementations:

1. **Run benchmarks in this repository**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

2. **Results are in**: `target/criterion/`

3. **Compare with main repository** (if it has reference benchmarks):
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench
   ```

4. **Criterion automatically compares** with previous runs when available

## Performance Comparison Methodology

### Data Format Preservation

The benchmark results use Criterion's standard output format, which includes:
- JSON data in `target/criterion/<benchmark>/base/estimates.json`
- Statistical analysis (mean, median, std dev)
- Performance change detection
- HTML reports with graphs

### Benchmark Interface

All benchmarks follow the same interface:
```rust
fn benchmark_name(c: &mut Criterion) {
    c.bench_function("function_name", |b| {
        b.iter(|| {
            // Benchmark code
        })
    });
}
```

This ensures consistency across repositories and allows for valid comparisons.

## Maintenance Guidelines

### Updating Benchmarks

1. Make changes in this repository (`bigweaver-agent-canary-zeta-hydro-deps`)
2. Test locally: `cargo bench`
3. Commit and push changes
4. Update documentation if benchmark behavior changes

### Adding New Benchmarks

1. Add benchmark file to `benches/benches/`
2. Register in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "new_benchmark"
   harness = false
   ```
3. Ensure it follows the established pattern
4. Document in README.md

### Dependency Updates

To update timely or differential-dataflow:

```bash
cd benches
cargo update -p timely
cargo update -p differential-dataflow
cargo bench  # Verify benchmarks still work
```

## Communication Between Teams

### Performance Engineering Team
- Responsible for maintaining benchmarks in this repository
- Reviews performance changes
- Provides performance comparison reports

### Development Team (Main Repository)
- Can reference benchmark results from this repository
- Should notify Performance Engineering team of major changes
- Maintains non-timely-dependent code

## Future Considerations

### Potential Enhancements

1. **CI/CD Integration**: Automate benchmark runs on pull requests
2. **Performance Tracking**: Store historical benchmark data
3. **Automated Comparison**: Script to compare results between repositories
4. **Documentation**: Add more detailed analysis of benchmark results

### Version Compatibility

- Keep Rust toolchain version synchronized between repositories
- Update `babyflow` and `spinachflow` together in both repositories
- Document breaking changes in benchmark APIs

## Questions and Support

For questions about:
- **Benchmark methodology**: Contact Performance Engineering team
- **Migration issues**: Refer to this document or repository maintainers
- **Benchmark results interpretation**: See Criterion.rs documentation

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
