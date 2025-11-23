# bigweaver-agent-canary-zeta-hydro-deps

A dedicated repository for timely and differential-dataflow benchmarks, isolated from the main Hydroflow repository to maintain clean dependency boundaries.

## Overview

This repository contains performance benchmarks that compare Hydroflow/dfir_rs implementations with timely and differential-dataflow frameworks. By maintaining these benchmarks in a separate repository, we avoid including timely and differential-dataflow as dependencies in the main bigweaver-agent-canary-hydro-zeta codebase.

## Purpose

The primary goals of this repository are to:

1. **Maintain Performance Comparison Capability**: Enable direct performance comparisons between Hydroflow and other dataflow frameworks
2. **Reduce Dependency Complexity**: Keep the main repository free from timely/differential-dataflow dependencies
3. **Enable Independent Evolution**: Allow benchmark code to evolve independently from core functionality
4. **Facilitate Performance Tracking**: Provide a dedicated space for comprehensive performance testing

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                 # Workspace configuration
├── README.md                  # This file
└── benches/                   # Benchmark package
    ├── Cargo.toml            # Benchmark dependencies
    ├── README.md             # Detailed benchmark documentation
    └── benches/              # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── upcase.rs
        ├── reachability_edges.txt
        └── reachability_reachable.txt
```

## Quick Start

### Prerequisites

- Rust toolchain (1.75+)
- Cargo

### Installation

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build the benchmarks
cargo build --release
```

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench arithmetic

# Run a specific test within a benchmark
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"
```

## Benchmark Suite

This repository includes 8 comprehensive benchmarks:

| Benchmark | Description | Frameworks Compared |
|-----------|-------------|---------------------|
| `arithmetic` | Arithmetic operations pipeline | Hydroflow, Timely, Baseline |
| `fan_in` | Multiple streams merging to one | Hydroflow, Timely |
| `fan_out` | One stream splitting to multiple | Hydroflow, Timely |
| `fork_join` | Parallel fork-join pattern | Hydroflow, Timely |
| `identity` | No-op passthrough (overhead measurement) | Hydroflow, Timely |
| `join` | Stream join operations | Hydroflow, Timely |
| `reachability` | Graph reachability algorithms | Hydroflow, Differential-Dataflow |
| `upcase` | String transformation | Hydroflow, Timely |

For detailed information about each benchmark, see [benches/README.md](benches/README.md).

## Performance Comparison

### Framework Implementations

Each benchmark typically includes implementations for:

1. **Hydroflow (Compiled)**: Ahead-of-time compiled dfir_rs code
2. **Hydroflow (Interpreted)**: Runtime interpreted dfir_rs code
3. **Timely**: Timely dataflow framework
4. **Differential-Dataflow**: Incremental computation (where applicable)

### Viewing Results

After running benchmarks, detailed reports are available:

```bash
# HTML reports with graphs and statistics
open target/criterion/report/index.html
```

Results include:
- Mean execution time with confidence intervals
- Throughput measurements
- Historical comparisons across runs
- Statistical significance analysis

## Dependencies

### Core Frameworks

- **timely** (v0.13.0-dev.1): Timely dataflow framework
- **differential-dataflow** (v0.13.0-dev.1): Differential/incremental dataflow
- **dfir_rs**: Hydroflow dataflow language (from hydro-project/hydro)

### Benchmark Infrastructure

- **criterion** (v0.5.0): Statistical benchmarking framework
- **tokio** (v1.29.0): Async runtime for async benchmarks

### Utilities

- **sinktools**: Hydroflow utilities (from hydro-project/hydro)
- **rand** (v0.8.0): Random data generation
- **futures** (v0.3): Async utilities

## Performance Testing Best Practices

### Running Reliable Benchmarks

For accurate and reproducible results:

1. **Close unnecessary applications** to reduce system noise
2. **Disable CPU frequency scaling** if possible
3. **Run multiple times** to establish stable baselines
4. **Use consistent hardware** for longitudinal comparisons

### Comparing Performance

```bash
# Establish baseline
cargo bench -p benches --save-baseline main

# After making changes
cargo bench -p benches --baseline main
```

This will show percentage differences from the baseline.

### Interpreting Results

- **Identity benchmarks**: Show pure framework overhead
- **Arithmetic/Upcase**: Show computational overhead
- **Fan-in/Fan-out**: Show multi-stream handling
- **Join/Reachability**: Show realistic workload performance

## Integration with Main Repository

This repository complements the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository:

- **Main Repository**: Core Hydroflow development, non-timely benchmarks
- **This Repository**: Timely/differential-dataflow comparative benchmarks

### Why Separate?

The separation provides several benefits:

1. **Cleaner Dependencies**: Main repo doesn't require timely/differential-dataflow
2. **Faster Builds**: Main repo builds faster without extra dependencies
3. **Focused Testing**: Each repo can test independently
4. **Clear Boundaries**: Explicit separation of concerns

## Development

### Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Implement benchmark following the Criterion pattern
3. Add `[[bench]]` entry to `benches/Cargo.toml`
4. Document the benchmark in `benches/README.md`
5. Test with `cargo bench -p benches --bench <name>`

### Example Benchmark Structure

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("mybench/hydroflow", |b| {
        b.iter(|| {
            // Setup and execution
            black_box(result);
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("mybench/timely", |b| {
        b.iter(|| {
            // Setup and execution
            black_box(result);
        });
    });
}

criterion_group!(benches, benchmark_hydroflow, benchmark_timely);
criterion_main!(benches);
```

## Migration History

This repository was created on **2024-11-23** as part of a strategic effort to reduce dependency complexity in the main Hydroflow repository. The benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches/` to maintain the ability to run performance comparisons while keeping the main codebase clean.

### What Was Moved

- 8 benchmark files comparing Hydroflow with timely/differential-dataflow
- 2 data files for the reachability benchmark (~564KB)
- Complete benchmark infrastructure and configuration

### Related Documentation

- See `TIMELY_REMOVAL_SUMMARY.md` in bigweaver-agent-canary-hydro-zeta for removal details
- See `benches/README.md` for detailed benchmark documentation

## Contributing

We welcome contributions! When contributing:

1. Follow existing code style and patterns
2. Add tests for new functionality
3. Update documentation for any changes
4. Ensure all benchmarks pass before submitting

## CI/CD

Continuous integration can include:

```yaml
# Example GitHub Actions workflow
- name: Run benchmarks
  run: cargo bench -p benches --no-fail-fast

- name: Check performance regression
  run: cargo bench -p benches --baseline main
```

## Troubleshooting

### Build Failures

```bash
# Clean and rebuild
cargo clean
cargo build --release
```

### Dependency Issues

```bash
# Update dependencies
cargo update

# Check for conflicts
cargo tree
```

### Missing Data Files

Ensure data files are present:
- `benches/benches/reachability_edges.txt`
- `benches/benches/reachability_reachable.txt`

## Resources

- **Criterion Documentation**: https://bheisler.github.io/criterion.rs/book/
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow
- **Hydroflow**: https://github.com/hydro-project/hydro

## License

Apache-2.0

## Contact

For questions or issues:
- Open an issue in this repository
- Contact the BigWeaverServiceCanaryZetaIad team

---

**Repository**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps  
**Created**: 2024-11-23  
**Maintained by**: BigWeaverServiceCanaryZetaIad Team