# Maintenance Guide

This guide covers maintaining the benchmark repository and handling cross-repository coordination.

## Repository Coordination

### Dependency on Main Repository

These benchmarks depend on `dfir_rs` from the main repository via a path dependency. Changes to the main repository's API may require updates here.

### Merge Order for Related Changes

When changes affect both repositories:

**IMPORTANT - Merge Order:**
1. Merge changes to the main repository (bigweaver-agent-canary-hydro-zeta) FIRST
2. Then merge changes to this repository (bigweaver-agent-canary-zeta-hydro-deps)

This ensures the path dependency always points to a valid, working version of `dfir_rs`.

## Handling API Changes

### When Main Repository API Changes

If the main repository's `dfir_rs` API changes affect these benchmarks:

1. **Identify affected benchmarks**: Check which benchmarks use the changed APIs
2. **Update benchmark code**: Modify to use new API patterns
3. **Test locally**: Ensure benchmarks compile and run
4. **Document changes**: Update BENCHMARKS.md if benchmark behavior changes
5. **Create PR**: Link to the related PR in the main repository

### Common API Change Patterns

#### Renamed Modules or Functions

```rust
// Old
use dfir_rs::scheduled::graph::Hydroflow;

// New (if renamed)
use dfir_rs::scheduled::graph::Dfir;
```

Update all affected benchmarks consistently.

#### Changed Syntax Macros

```rust
// If dfir_syntax! changes, update all occurrences
// Keep the benchmark name consistent for historical comparison
```

#### New Features

When new features are added to dfir_rs:
- Consider adding new benchmarks to test performance
- Update existing benchmarks if new patterns are more idiomatic

## Updating External Dependencies

### Timely and Differential Dataflow

These dependencies may need periodic updates for:
- Security fixes
- API changes
- Performance improvements

To update:

```bash
cd benches
cargo update -p timely-master
cargo update -p differential-dataflow-master
cargo test  # Verify still works
cargo bench # Run benchmarks
```

Check for API changes that affect benchmark implementations.

### Criterion

Update the benchmark framework:

```bash
cargo update -p criterion
cargo bench # Verify all benchmarks still work
```

Note: Criterion tries to maintain backward compatibility, but check release notes.

## Adding New Benchmarks

### When to Add Benchmarks

Add new benchmarks when:
1. New DFIR operators or patterns need performance validation
2. Specific workloads need comparison against timely/differential
3. Performance regressions need reproduction cases

### Benchmark Template

```rust
use criterion::{criterion_group, criterion_main, Criterion};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;
use differential_dataflow::operators::*;

fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("benchmark_name/dfir", |b| {
        b.iter(|| {
            // DFIR implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("benchmark_name/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("benchmark_name/differential", |b| {
        b.iter(|| {
            // Differential implementation
        });
    });
}

criterion_group!(
    benchmark_group,
    benchmark_dfir,
    benchmark_timely,
    benchmark_differential
);
criterion_main!(benchmark_group);
```

### Adding to Cargo.toml

```toml
[[bench]]
name = "benchmark_name"
harness = false
```

### Documentation

Update BENCHMARKS.md with:
- Purpose of the benchmark
- Workload description
- Implementations included
- Key metrics measured

## Performance Regression Tracking

### Establishing Baselines

Save baselines for major releases:

```bash
# After main repo release
cargo bench --save-baseline v0.14.0
```

### Detecting Regressions

```bash
# Compare against previous baseline
cargo bench --baseline v0.14.0

# Look for significant performance changes
```

### Investigating Regressions

1. **Isolate the change**: Use git bisect in main repository
2. **Profile the benchmark**: Use profiling tools to identify bottlenecks
3. **Document findings**: Create issue with performance data
4. **Test fixes**: Verify improvements with benchmarks

## CI/CD Integration

### Benchmark in CI

Considerations for running benchmarks in CI:
- CI environments may have inconsistent performance
- Use relative comparisons rather than absolute numbers
- Focus on detecting large regressions (>10%)
- Consider separate benchmark server for stable results

### Automated Updates

When automating dependency updates:
1. Run full benchmark suite
2. Compare against saved baseline
3. Flag any regressions >5% for manual review
4. Auto-merge if no regressions detected

## Build Performance

### Caching Strategy

To minimize rebuild times:
- Use `cargo check` during development
- Keep `Cargo.lock` in version control
- Use incremental compilation (default)
- Consider `sccache` for distributed builds

### Reducing Compilation Time

```bash
# Build only specific benchmark
cargo build --bench arithmetic

# Check without building
cargo check --benches
```

## Testing Changes

### Before Submitting PR

Run checklist:
```bash
# 1. Format code
cargo fmt

# 2. Check for errors
cargo check --benches

# 3. Run all benchmarks
cargo bench

# 4. Verify results are reasonable
open target/criterion/report/index.html
```

### Smoke Testing

Quick test that benchmarks work:
```bash
# Run each benchmark for minimal iterations
cargo bench -- --quick
```

## Documentation Maintenance

### Keep Updated

When making changes, update:
- README.md: High-level changes
- BENCHMARKS.md: Benchmark-specific details
- QUICKSTART.md: User-facing instructions
- MAINTENANCE.md: Developer-facing processes

### Cross-References

Maintain links between:
- This repository ↔ Main repository
- Benchmark code ↔ Documentation
- Issues ↔ Related PRs

## Troubleshooting Common Issues

### Path Dependency Issues

If path dependency breaks:
```bash
# Check relative path
cd benches
cargo tree | grep dfir_rs

# Verify main repo location
ls ../../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

### Version Conflicts

If dependency versions conflict:
```bash
# Update Cargo.lock
cargo update

# Or clean and rebuild
cargo clean
cargo build --benches
```

### Benchmark Crashes

If benchmarks crash:
1. Run in debug mode: `cargo build --benches`
2. Use `RUST_BACKTRACE=1` for stack traces
3. Bisect to find breaking change
4. Check for API incompatibilities

## Release Coordination

### Version Alignment

While this repository doesn't have formal releases, coordinate with main repository:

1. Test against release candidates
2. Update benchmarks before main repo release
3. Tag commits that correspond to main repo releases
4. Document any breaking changes

### Communication

When coordinating changes:
- Tag related PRs with links
- Document merge order requirements
- Notify relevant teams (Performance Engineering, Development)
- Update documentation cross-references

## Contact Points

- **Benchmark questions**: This repository's issues
- **DFIR/Hydro questions**: Main repository's issues  
- **Performance Engineering**: Team-specific channels
- **CI/CD integration**: CI/CD team contacts
