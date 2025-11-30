# Benchmark Guide

This guide explains how to run and interpret benchmarks in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Prerequisites

1. **Repository Structure**: Ensure both repositories are checked out as siblings:
   ```
   parent-directory/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. **Rust Toolchain**: The benchmarks use the same Rust toolchain as the main Hydro repository. Check the `rust-toolchain.toml` in the main repository for the required version.

3. **Dependencies**: The benchmarks depend on:
   - `timely-master` (0.13.0-dev.1)
   - `differential-dataflow-master` (0.13.0-dev.1)
   - Core Hydro crates from bigweaver-agent-canary-hydro-zeta

## Running Benchmarks

### All Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

### Specific Benchmarks

To run a specific benchmark:
```bash
cargo bench -p benches --bench <benchmark-name>
```

For example:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Tests basic arithmetic operations across Hydro, timely, and differential |
| `fan_in` | Measures performance of fan-in patterns (many-to-one) |
| `fan_out` | Measures performance of fan-out patterns (one-to-many) |
| `fork_join` | Tests fork-join parallelism patterns |
| `futures` | Benchmarks async/futures integration |
| `identity` | Baseline performance for identity operations |
| `join` | Tests join operations between streams |
| `micro_ops` | Fine-grained benchmarks of individual operators |
| `reachability` | Graph reachability computation (classic dataflow benchmark) |
| `symmetric_hash_join` | Symmetric hash join implementation |
| `upcase` | String transformation benchmarks |
| `words_diamond` | Diamond-shaped dataflow with word processing |

## Understanding Results

### Criterion Output

Benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) framework, which provides:
- **Throughput measurements** in operations per second
- **Statistical analysis** including median, mean, and standard deviation
- **Regression detection** to identify performance changes
- **HTML reports** with detailed visualizations

### Viewing Reports

After running benchmarks, detailed HTML reports are available at:
```
target/criterion/<benchmark-name>/report/index.html
```

Open these files in a web browser to see:
- Performance over time
- Distribution plots
- Comparison with previous runs

### Interpreting Comparisons

Many benchmarks compare three implementations:
1. **Hydro/dfir_rs**: Our high-level dataflow API
2. **Timely**: Low-level timely dataflow
3. **Differential**: Differential dataflow

Performance goals:
- Hydro should be **competitive** with timely/differential
- Small performance gaps are acceptable given Hydro's higher-level abstractions
- Large performance gaps (>2x) should be investigated

## Performance Comparison Workflow

To compare performance across versions:

1. **Baseline**: Run benchmarks on the current version:
   ```bash
   cargo bench -p benches --bench reachability
   ```

2. **Make Changes**: Modify code in the main repository

3. **Compare**: Run benchmarks again:
   ```bash
   cargo bench -p benches --bench reachability
   ```

4. **Review**: Check criterion's comparison output and HTML reports

## Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Add the benchmark definition to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Implement using Criterion:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_test", |b| {
           b.iter(|| {
               // benchmark code
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

## CI/CD Integration

Note: CI/CD workflows for benchmarks should be configured in the main repository or this repository as needed. Benchmark runs can be resource-intensive, so consider:
- Running benchmarks on a schedule rather than per-commit
- Using dedicated benchmark runners with consistent hardware
- Archiving results for historical comparison

## Troubleshooting

### Compilation Errors

If you see compilation errors related to path dependencies:
1. Verify the repository structure (both repos as siblings)
2. Ensure the main repository is on a compatible version
3. Run `cargo clean` and try again

### Benchmark Timeouts

Some benchmarks (especially `reachability`) can take significant time:
- This is normal for graph algorithms on large inputs
- Use `--bench <specific>` to run individual benchmarks
- Criterion has a default timeout that can be adjusted in code

### Inconsistent Results

For stable benchmarks:
- Ensure your system is not under heavy load
- Close unnecessary applications
- Consider disabling CPU frequency scaling for more consistent results

## Reference

- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
