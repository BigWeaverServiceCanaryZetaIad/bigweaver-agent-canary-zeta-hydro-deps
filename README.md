# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow` packages, which have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## 📋 Overview

The benchmarks in this repository measure the performance of Hydro (DFIR) dataflow operations and compare them with timely-dataflow and differential-dataflow implementations. This separation allows for:

- **Cleaner dependency management** in the main repository
- **Reduced compilation time** for developers who don't need to run benchmarks
- **Independent benchmark development** without affecting the core codebase
- **Easier maintenance** of performance testing infrastructure

## 🎯 Contents

### Benchmarks (`benches/`)

The repository contains microbenchmarks comparing Hydro's DFIR implementation with timely-dataflow:

- **arithmetic.rs**: Chain of arithmetic operations benchmarks
- **fan_in.rs**: Multiple input streams merging into one
- **fan_out.rs**: Single stream splitting into multiple outputs
- **fork_join.rs**: Fork and join patterns
- **futures.rs**: Async/futures-based dataflow operations
- **identity.rs**: Identity/passthrough operations
- **join.rs**: Join operations between streams
- **micro_ops.rs**: Various micro-operation benchmarks
- **reachability.rs**: Graph reachability computation
- **symmetric_hash_join.rs**: Symmetric hash join operations
- **upcase.rs**: String transformation benchmarks
- **words_diamond.rs**: Diamond-shaped dataflow with word processing

## 🚀 Running Benchmarks

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in the main repository)
- Cargo (comes with Rust)
- Git access to the main bigweaver-agent-canary-hydro-zeta repository

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench <benchmark_name>
```

For example:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Benchmark Output

Benchmarks use [Criterion](https://github.com/bheisler/criterion.rs) and generate:
- Console output with timing statistics
- HTML reports in `target/criterion/` directory
- Comparison with previous runs (if available)

### View HTML Reports

After running benchmarks:
```bash
open target/criterion/report/index.html
# or on Linux:
xdg-open target/criterion/report/index.html
```

## 🔧 Performance Comparison

These benchmarks allow you to:

1. **Compare Hydro/DFIR with timely-dataflow**: Most benchmarks include multiple implementations
2. **Track performance over time**: Criterion automatically tracks and compares results
3. **Identify regressions**: Compare benchmark results before and after changes
4. **Optimize implementations**: Use results to guide optimization efforts

### Example: Comparing Implementations

Many benchmarks include multiple variants:
```bash
# Run arithmetic benchmarks which include pipeline, raw, dfir, and timely variants
cargo bench -p benches --bench arithmetic
```

This will show relative performance of different approaches.

## 📦 Dependencies

The benchmarks depend on:

- **timely** (timely-master 0.13.0-dev.1): Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1): Differential dataflow framework
- **dfir_rs**: Core DFIR runtime (from main repository via git)
- **sinktools**: Utility tools (from main repository via git)
- **criterion**: Benchmarking framework

Dependencies on `dfir_rs` and `sinktools` reference the main repository via git, ensuring benchmarks always test against the latest code.

## 🔄 Integration with Main Repository

### For Main Repository Developers

If you're working on the main repository and need to verify benchmark compatibility:

1. Make your changes in the main repository
2. Clone this repository
3. Run the benchmarks - they will automatically pull your latest changes from git
4. Verify no performance regressions

### For Benchmark Developers

If you're adding or modifying benchmarks:

1. Clone this repository
2. Create your new benchmark in `benches/benches/`
3. Add the benchmark configuration to `benches/Cargo.toml`
4. Test your benchmark
5. Submit a pull request

### Updating Benchmarks After Main Repository Changes

The git dependencies ensure benchmarks automatically use the latest code from the main repository. To update:

```bash
# Update dependencies from main repository
cargo update

# Run benchmarks to verify
cargo bench
```

## 📝 Benchmark Structure

Each benchmark follows this pattern:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

fn benchmark_dfir_impl(c: &mut Criterion) {
    c.bench_function("name/dfir", |b| {
        b.iter(|| {
            // DFIR implementation
        });
    });
}

fn benchmark_timely_impl(c: &mut Criterion) {
    c.bench_function("name/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

criterion_group!(benches, benchmark_dfir_impl, benchmark_timely_impl);
criterion_main!(benches);
```

## 🐛 Troubleshooting

### Compilation Issues

If you encounter compilation errors:
```bash
# Clean and rebuild
cargo clean
cargo bench
```

### Git Dependency Issues

If git dependencies fail to resolve:
```bash
# Update Cargo.lock
cargo update
# Or force re-fetch
rm -rf ~/.cargo/git/checkouts/bigweaver-agent-canary-hydro-zeta-*
cargo bench
```

### Permission Issues

Ensure you have git access to the main repository:
```bash
git ls-remote https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
```

## 📚 Additional Resources

- [Main Repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Hydro Documentation](https://hydro.run)
- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## 🤝 Contributing

Contributions are welcome! Please:

1. Follow the existing benchmark structure
2. Include both DFIR and timely/differential implementations when applicable
3. Document what the benchmark measures
4. Ensure benchmarks run successfully before submitting

## 📄 License

Apache-2.0 (same as main repository)