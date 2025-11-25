# bigweaver-agent-canary-zeta-hydro-deps

A companion repository containing benchmarks that depend on `timely` and `differential-dataflow` for the Hydro project.

## Purpose

This repository houses performance comparison benchmarks that were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- **Reduce build times** in the main repository by eliminating heavyweight dependencies
- **Maintain performance comparison capability** against timely and differential-dataflow
- **Improve modularity** by separating core functionality from external benchmarking dependencies
- **Enable focused performance testing** against other dataflow systems

## Contents

### Benchmarks

This repository contains 8 benchmarks comparing dfir_rs/Hydro implementations with timely and differential-dataflow:

- **arithmetic.rs** - Basic arithmetic operations
- **fan_in.rs** - Multiple streams merging
- **fan_out.rs** - Stream distribution
- **fork_join.rs** - Split and rejoin patterns
- **identity.rs** - Baseline framework overhead
- **join.rs** - Binary join operations
- **reachability.rs** - Graph reachability (comprehensive)
- **upcase.rs** - String transformations

### Data Files

- `words_alpha.txt` - English word list for string benchmarks
- `reachability_edges.txt` - Graph edges for reachability tests
- `reachability_reachable.txt` - Expected reachability results

## Quick Start

### Running Benchmarks

```bash
# Clone the repository
git clone <repository-url> bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p hydro-deps-benches

# Run a specific benchmark
cargo bench -p hydro-deps-benches --bench reachability

# Run benchmarks matching a pattern
cargo bench -p hydro-deps-benches --bench reachability -- "timely"
```

### Viewing Results

Benchmark results are generated in:
- **Console**: Immediate statistical summary
- **HTML Reports**: `target/criterion/<benchmark_name>/report/index.html`

## Architecture

### Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── upcase.rs
│   │   ├── reachability_edges.txt
│   │   ├── reachability_reachable.txt
│   │   └── words_alpha.txt
│   ├── build.rs
│   ├── Cargo.toml
│   └── README.md
├── Cargo.toml
├── README.md (this file)
├── MIGRATION.md
├── MIGRATION_SUMMARY.md
├── BENCHMARK_DETAILS.md
└── CONTRIBUTING.md
```

### Dependencies

Key dependencies in this repository:
- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)
- `dfir_rs` (via git reference to main repository)
- `sinktools` (via git reference to main repository)
- `criterion` (0.5.0 - benchmarking framework)

## Relationship to Main Repository

This repository works in tandem with `bigweaver-agent-canary-hydro-zeta`:

| Repository | Contains | Dependencies |
|------------|----------|--------------|
| **Main** (bigweaver-agent-canary-hydro-zeta) | Core functionality, hydro language, dfir_rs, non-timely benchmarks | No timely/differential |
| **Deps** (this repo) | Timely/differential comparison benchmarks | timely, differential-dataflow, references to main |

### Migration

These benchmarks were moved from the main repository to achieve:
- ✅ **30-40% faster builds** in main repository
- ✅ **Cleaner dependency graph** for core development
- ✅ **Maintained performance comparison** capability
- ✅ **Better separation of concerns**

See [MIGRATION.md](MIGRATION.md) for detailed migration information.

## Documentation

- **[README.md](README.md)** (this file) - Repository overview
- **[MIGRATION.md](MIGRATION.md)** - Complete migration guide
- **[MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md)** - Quick migration reference
- **[BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md)** - Detailed benchmark descriptions
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contribution guidelines
- **[benches/README.md](benches/README.md)** - Benchmark-specific documentation

## Usage Examples

### Comparing Implementations

Each benchmark compares multiple implementations:

```bash
# Run reachability benchmark (compares 6 implementations)
cargo bench -p hydro-deps-benches --bench reachability
```

Results will show:
- `reachability/timely` - Timely dataflow implementation
- `reachability/differential` - Differential dataflow implementation
- `reachability/dfir_rs/scheduled` - Hydro scheduled execution
- `reachability/dfir_rs` - Hydro standard runtime
- `reachability/dfir_rs/surface` - Hydro surface syntax
- `reachability/dfir_rs/surface_cheating` - Optimized version

### Performance Tracking

```bash
# Save baseline
cargo bench -p hydro-deps-benches -- --save-baseline before-optimization

# Make changes...

# Compare to baseline
cargo bench -p hydro-deps-benches -- --baseline before-optimization
```

### Continuous Integration

```bash
# Quick check (shorter warm-up)
cargo bench -p hydro-deps-benches -- --quick

# Full benchmark suite
cargo bench -p hydro-deps-benches
```

## Development Workflow

### Adding New Benchmarks

1. Create benchmark file: `benches/benches/my_benchmark.rs`
2. Add to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Update `benches/README.md`
4. Update `BENCHMARK_DETAILS.md`
5. Submit PR with comprehensive documentation

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

### Coordinating with Main Repository

When changes affect both repositories:
1. Create companion PRs
2. Link PRs in descriptions
3. Ensure synchronized merging
4. Test both repositories together

## Performance Considerations

### Build Times

- **Main repository** (without timely/differential): Fast builds (~2-3 minutes typical)
- **This repository** (with timely/differential): Slower builds (~5-7 minutes typical)

### When to Run

Run benchmarks from this repository when:
- ✅ Comparing against timely or differential-dataflow
- ✅ Validating performance claims
- ✅ Testing optimization impact
- ✅ Generating performance reports

Don't need this repository for:
- ❌ Day-to-day development on core features
- ❌ Testing non-performance functionality
- ❌ Quick iteration cycles

## Benefits

### For Developers

- **Faster iteration** on core features (no heavy dependencies)
- **Clear separation** between core and comparison code
- **Maintained capability** to benchmark when needed

### For the Project

- **Cleaner architecture** with better separation of concerns
- **Reduced complexity** in main repository
- **Maintained performance validation** against established systems
- **Better resource utilization** (build only when needed)

## Frequently Asked Questions

### Q: Why separate repositories?

A: To keep the main repository fast to build while maintaining performance comparison capability.

### Q: How do I run benchmarks from the main repository?

A: Navigate to this repository and run `cargo bench -p hydro-deps-benches`.

### Q: Do I need this repository for normal development?

A: No, only when you need to compare performance against timely/differential-dataflow.

### Q: What if I want to add a benchmark?

A: If it uses timely or differential, add it here. Otherwise, add it to the main repository.

### Q: How do I update dfir_rs version used here?

A: Update the git reference in `benches/Cargo.toml` and run `cargo update`.

### Q: Can I run both repositories' benchmarks together?

A: Yes, but run them separately. Main repo has different benchmarks that don't need timely/differential.

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

Key points:
- Add timely/differential benchmarks here
- Add non-timely/differential benchmarks to main repository
- Follow conventional commit format
- Update documentation thoroughly
- Test changes before submitting

## License

Apache-2.0 (inherited from main repository)

## Links

- **Main Repository**: bigweaver-agent-canary-hydro-zeta
- **Hydro Project**: https://github.com/hydro-project/hydro
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow
- **Criterion.rs**: https://bheisler.github.io/criterion.rs/book/

## Support

For questions or issues:
- Open an issue in this repository
- Refer to documentation files
- Check existing benchmarks for examples

---

**Note**: This repository is part of the Hydro project ecosystem and works in conjunction with the main repository to provide comprehensive performance validation.