# Hydro Dependencies Repository

This repository contains benchmarks and code that depend on Timely Dataflow and Differential Dataflow. These have been separated from the main Hydro repository to reduce compilation overhead and maintain a cleaner dependency structure in the core codebase.

## Purpose

The primary purpose of this repository is to:
- **Maintain performance benchmarks** comparing Timely, Differential, and Hydroflow implementations
- **Enable performance comparisons** without adding heavyweight dependencies to the main repository
- **Preserve benchmark history** and allow independent evolution of benchmark code
- **Support performance regression testing** for Hydroflow against established frameworks

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                      # Benchmark package
│   ├── benches/                  # Benchmark source files
│   │   ├── arithmetic.rs         # Arithmetic operations benchmark
│   │   ├── fan_in.rs            # Fan-in pattern benchmark
│   │   ├── fan_out.rs           # Fan-out pattern benchmark
│   │   ├── fork_join.rs         # Fork-join pattern benchmark
│   │   ├── identity.rs          # Identity operations benchmark
│   │   ├── join.rs              # Join operations benchmark
│   │   ├── reachability.rs      # Graph reachability benchmark
│   │   ├── upcase.rs            # String transformation benchmark
│   │   ├── reachability_edges.txt      # Test data for reachability
│   │   └── reachability_reachable.txt  # Test data for reachability
│   ├── build.rs                 # Build script for code generation
│   ├── Cargo.toml               # Benchmark package manifest
│   └── README.md                # Detailed benchmark documentation
└── README.md                    # This file
```

## Getting Started

### Prerequisites

- Rust toolchain (edition 2021 or later)
- Cargo package manager
- Git

### Clone and Build

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
cd benches
cargo build --release
```

### Running Benchmarks

Run all benchmarks:
```bash
cd benches
cargo bench
```

Run specific benchmarks:
```bash
# Arithmetic operations
cargo bench --bench arithmetic

# Dataflow patterns
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join

# Operations benchmarks
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

Filter by implementation:
```bash
# Only Timely benchmarks
cargo bench -- timely

# Only Hydroflow benchmarks
cargo bench -- dfir_rs

# Only pipeline benchmarks
cargo bench -- pipeline
```

## Benchmarks Overview

### Dataflow Patterns

- **Arithmetic**: Tests pipeline operations with arithmetic transformations
- **Fan-In**: Multiple streams merging into one
- **Fan-Out**: One stream splitting into multiple
- **Fork-Join**: Splitting and rejoining with filters
- **Identity**: Minimal transformation to measure overhead
- **Join**: Stream joining operations
- **Reachability**: Graph algorithms on dataflow
- **Upcase**: String transformation operations

### Implementations Compared

Each benchmark typically compares:
1. **Timely Dataflow** - Established stream processing framework
2. **Differential Dataflow** - Incremental computation on streams
3. **Hydroflow** - Modern dataflow with compiled and surface syntax
4. **Baseline** - Raw Rust implementations (channels, iterators)

## Performance Comparison Guide

### Viewing Results

After running benchmarks, view detailed HTML reports:
```bash
open benches/target/criterion/report/index.html
```

The reports include:
- Execution time comparisons
- Statistical analysis
- Throughput measurements
- Performance trends over time
- Regression detection

### Interpreting Results

- **Lower is better** for execution time
- **Higher is better** for throughput
- Check confidence intervals for statistical significance
- Compare against baseline implementations for overhead assessment

## Development

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Follow the existing pattern using Criterion
3. Add a `[[bench]]` entry in `benches/Cargo.toml`
4. Update `benches/README.md` with benchmark description
5. Test locally before committing

Example benchmark structure:
```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};

fn benchmark_name(c: &mut Criterion) {
    c.bench_function("group/name", |b| {
        b.iter(|| {
            // benchmark code
            black_box(result);
        });
    });
}

criterion_group!(benches, benchmark_name);
criterion_main!(benches);
```

### Dependencies

The benchmarks depend on:
- **timely** (package: timely-master) - Timely dataflow
- **differential-dataflow** (package: differential-dataflow-master) - Differential dataflow
- **dfir_rs** - Hydroflow core (from main hydro repository)
- **sinktools** - Hydroflow utilities (from main hydro repository)
- **criterion** - Benchmarking framework
- **tokio** - Async runtime

### Updating Dependencies

To use local versions of Hydroflow packages during development:

```toml
[dev-dependencies]
dfir_rs = { path = "../../path/to/hydro/dfir_rs", features = ["debugging"] }
sinktools = { path = "../../path/to/hydro/sinktools", version = "^0.0.1" }
```

To use git dependencies (default):
```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = ["debugging"] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

## Integration with Main Repository

### Referencing from Main Hydro Repository

The main Hydro repository references these benchmarks in documentation:

```markdown
**Note:** Timely and differential-dataflow benchmarks have been moved to the 
[hydro-deps repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps) 
to reduce unnecessary dependencies in the main codebase.
```

### Cross-Repository Workflow

1. Make changes in main Hydro repository
2. Test performance impact using benchmarks in this repository
3. Update benchmarks if API changes affect them
4. Document performance changes in both repositories

## CI/CD Integration

### Running in CI

Add to your CI configuration:

```yaml
- name: Run benchmarks
  run: |
    cd benches
    cargo bench --no-fail-fast
```

### Performance Regression Testing

Use Criterion's baseline comparison:

```bash
# Save current performance as baseline
cargo bench -- --save-baseline main

# After changes, compare against baseline
cargo bench -- --baseline main
```

## Troubleshooting

### Common Issues

**Build failures with dfir_rs or sinktools:**
- Ensure git dependencies point to correct repository
- Check that you have internet access for git dependencies
- Try using local path dependencies for development

**Benchmark results inconsistent:**
- Close other applications
- Disable CPU frequency scaling
- Run multiple times for statistical significance
- Use `taskset` to pin to specific CPU cores

**Out of memory during benchmarks:**
- Reduce data sizes (NUM_INTS, etc.) in benchmark files
- Run benchmarks individually rather than all at once
- Increase available system memory

### Getting Help

For issues related to:
- **Benchmarks**: Open an issue in this repository
- **Hydroflow API**: Check the main Hydro repository
- **Timely/Differential**: Refer to their respective repositories

## Migration History

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to reduce dependency overhead. The migration preserved:
- All benchmark source code
- Test data files
- Performance comparison functionality
- Historical context and documentation

### Files Migrated

- 8 benchmark source files (.rs)
- 2 data files (.txt)
- Build script (build.rs)
- Documentation and README

### Benefits of Separation

1. **Reduced compilation time** in main repository
2. **Cleaner dependency tree** for core Hydroflow
3. **Independent evolution** of benchmarks
4. **Easier maintenance** of performance testing infrastructure
5. **Better separation of concerns** between core code and testing

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Add tests/benchmarks as appropriate
4. Update documentation
5. Submit a pull request

Follow the existing code style and conventions.

## License

This repository is licensed under Apache-2.0, consistent with the Hydro project.

## Related Projects

- [Hydro Project](https://github.com/hydro-project/hydro) - Main Hydroflow repository
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) - Timely dataflow framework
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow) - Differential dataflow framework

## Acknowledgments

These benchmarks build upon the excellent work of:
- The Hydro Project team
- The Timely Dataflow developers
- The Differential Dataflow developers
- The Rust community

---

For detailed benchmark documentation, see [benches/README.md](benches/README.md).