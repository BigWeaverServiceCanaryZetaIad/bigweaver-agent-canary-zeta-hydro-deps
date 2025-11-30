# Benchmark Guide

This guide explains how to run benchmarks and compare performance between the main Hydro repository and the timely/differential-dataflow implementations.

## Setup

### Prerequisites
- Rust toolchain (see rust-toolchain.toml in main repository)
- Git access to both repositories
- Sufficient disk space for benchmark data files

### Clone Repositories
```bash
# Clone main repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git

# Clone benchmarks repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

## Running Benchmarks

### Individual Benchmarks

Run a specific benchmark:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench identity
```

### All Benchmarks

Run all benchmarks:
```bash
cargo bench
```

### Benchmark with Custom Parameters

Some benchmarks accept parameters. For example:
```bash
cargo bench --bench arithmetic -- --measurement-time 10
```

## Performance Comparison

### Step 1: Run Hydro Benchmarks

The main repository contains tests that can be used for comparison:
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo test --release --test '*' 
```

### Step 2: Run Timely/Differential Benchmarks

Run the corresponding benchmarks in this repository:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --release
```

### Step 3: Analyze Results

Benchmark results are saved in `target/criterion/`:
```bash
# View results
ls -la target/criterion/

# Each benchmark creates:
# - HTML reports in target/criterion/<bench_name>/report/
# - Raw data in target/criterion/<bench_name>/
```

### Step 4: Compare Results

You can use criterion's comparison features:
```bash
# Run baseline
cargo bench --bench identity -- --save-baseline baseline

# Make changes and compare
cargo bench --bench identity -- --baseline baseline
```

## Benchmark Descriptions

### arithmetic
Tests basic arithmetic operations in different dataflow systems.

### fan_in
Measures performance of merging multiple input streams.

### fan_out
Tests splitting a single stream to multiple outputs.

### fork_join
Measures fork-join parallelism patterns.

### futures
Tests integration with Rust async/await futures.

### identity
Simple throughput test with identity transformation.

### join
Measures join operation performance.

### micro_ops
Tests various micro-operations and their composition.

### reachability
Graph reachability analysis benchmark using large test data.

### symmetric_hash_join
Tests symmetric hash join implementation.

### upcase
String transformation benchmark (uppercase conversion).

### words_diamond
Diamond-shaped dataflow pattern with word processing.

## Troubleshooting

### Build Errors

If you encounter build errors:
```bash
# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Rebuild
cargo build --release
```

### Memory Issues

Some benchmarks (especially reachability) use large data files. Ensure you have sufficient RAM:
```bash
# Run with reduced parallelism
cargo bench --bench reachability -- --threads 2
```

### Git Dependency Issues

If git dependencies fail to resolve:
```bash
# Check git credentials
git config --list | grep credential

# Try manual fetch
cd /tmp
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
```

## Contributing

When adding new benchmarks:

1. Add the benchmark implementation to `benches/benches/<name>.rs`
2. Register it in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_bench_name"
   harness = false
   ```
3. Update this guide with benchmark description
4. Run baseline benchmarks to establish performance metrics

## CI/CD Integration

Benchmarks can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Run benchmarks
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench --no-fail-fast
    
- name: Upload benchmark results
  uses: actions/upload-artifact@v3
  with:
    name: benchmark-results
    path: target/criterion/
```

## Performance Regression Detection

To detect performance regressions:

1. Establish baseline:
   ```bash
   cargo bench -- --save-baseline main
   ```

2. Make changes

3. Compare against baseline:
   ```bash
   cargo bench -- --baseline main
   ```

4. Review the comparison report in `target/criterion/<bench>/report/index.html`

## Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
