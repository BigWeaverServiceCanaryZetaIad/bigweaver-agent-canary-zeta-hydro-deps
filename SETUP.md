# Setup Instructions for Hydro Benchmarks

This guide explains how to set up and run the Hydro performance benchmarks that compare against timely-dataflow and differential-dataflow.

## Quick Setup

### Option 1: Clone Repositories Side-by-Side (Recommended)

```bash
cd /projects
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <this-repo-url> bigweaver-agent-canary-zeta-hydro-deps
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

This setup uses path dependencies that expect both repositories to be in the same parent directory.

### Option 2: Adjust Path Dependencies

If you have the repositories in different locations, edit `benches/Cargo.toml` and update the paths:

```toml
[dev-dependencies]
dfir_rs = { path = "/path/to/bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "/path/to/bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## System Requirements

- Rust 2021 edition or later
- Sufficient memory for running benchmarks (recommended: 8GB+)
- Multi-core CPU recommended for accurate parallel benchmark results

## Building

Build all benchmarks:
```bash
cargo build --release
```

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p benches
```

### Run Specific Benchmarks
```bash
# Run a single benchmark
cargo bench -p benches --bench reachability

# Run benchmarks matching a pattern
cargo bench -p benches --bench 'join*'
```

### Benchmark Output

Benchmarks generate:
- Console output with timing results
- HTML reports in `target/criterion/` directory
- Statistical analysis of performance

View HTML reports:
```bash
# Open in browser
firefox target/criterion/report/index.html
```

## Troubleshooting

### Issue: Path dependencies not found

**Error:** `package `dfir_rs` cannot be found in path`

**Solution:** Ensure the main repository is cloned in the expected location, or update the paths in `benches/Cargo.toml`.

### Issue: Compilation errors in dependencies

**Solution:** Ensure you're using compatible versions:
```bash
# Update dependencies
cargo update

# Check Rust version
rustc --version
```

### Issue: Out of memory during benchmarks

**Solution:** Run benchmarks individually rather than all at once:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
# etc.
```

## Development Workflow

### Adding New Benchmarks

1. Create benchmark file in `benches/benches/`:
   ```rust
   // benches/benches/my_benchmark.rs
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       // benchmark implementation
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

2. Register in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. Run your new benchmark:
   ```bash
   cargo bench -p benches --bench my_benchmark
   ```

### Updating Dependencies

Update timely/differential-dataflow versions:
```bash
cd benches
# Edit Cargo.toml to update versions
cargo update
```

## Performance Testing Best Practices

1. **Consistent Environment:** Run benchmarks on the same machine with minimal background processes
2. **Multiple Runs:** Criterion automatically runs benchmarks multiple times for statistical significance
3. **Baseline Comparisons:** Use criterion's baseline feature to track performance over time
4. **Resource Isolation:** Close unnecessary applications when benchmarking

## CI/CD Integration

To integrate these benchmarks into CI:

```yaml
# Example GitHub Actions workflow
- name: Run benchmarks
  run: |
    cargo bench -p benches --no-fail-fast
    
- name: Upload benchmark results
  uses: actions/upload-artifact@v2
  with:
    name: benchmark-results
    path: target/criterion
```

## Further Information

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- Main Hydro repository: bigweaver-agent-canary-hydro-zeta
