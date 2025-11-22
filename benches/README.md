# Timely and Differential-Dataflow Benchmarks

This directory contains comparative benchmarks for timely and differential-dataflow frameworks. These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean separation of dependencies.

## Purpose

These benchmarks enable performance comparison between different dataflow implementations:
- Timely dataflow operations
- Differential-dataflow operations
- DFIR (if comparative benchmarks are added)

## Available Benchmarks

### Core Pattern Benchmarks

1. **arithmetic.rs** - Arithmetic operation benchmarks comparing different implementations
2. **fan_in.rs** - Fan-in pattern benchmarks testing data convergence patterns
3. **fan_out.rs** - Fan-out pattern benchmarks testing data distribution patterns
4. **fork_join.rs** - Fork-join pattern benchmarks testing parallel execution and merging
5. **identity.rs** - Identity operation benchmarks testing basic data passing overhead
6. **join.rs** - Join operation benchmarks using timely operators
7. **upcase.rs** - String uppercase transformation benchmarks

### Complex Benchmarks

8. **reachability.rs** - Graph reachability benchmarks comparing multiple implementations
   - Uses `reachability_edges.txt` (533KB) - Graph edge data
   - Uses `reachability_reachable.txt` (38KB) - Expected reachable nodes for verification

## Running Benchmarks

### Quick Run (All Benchmarks)
```bash
cargo bench
```

### Run Specific Benchmark
```bash
# Run a single benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench fan_in

# Run with specific criterion options
cargo bench --bench reachability -- --warm-up-time 5 --measurement-time 10
```

### Run Only Quick Benchmarks
```bash
# Run benchmarks with shorter execution times for rapid testing
cargo bench -- --quick
```

### Generate Reports
```bash
# Benchmarks automatically generate HTML reports in target/criterion/
cargo bench
# Open target/criterion/report/index.html to view results
```

## Performance Comparison Methodology

These benchmarks are designed to enable fair comparisons:

1. **Consistent Input Sizes**: All implementations use the same input data sizes
2. **Warm-up Period**: Criterion handles warm-up automatically to ensure JIT compilation
3. **Statistical Analysis**: Multiple iterations with statistical analysis of results
4. **Reproducible**: Fixed seeds for random data generation where applicable

## Comparing with DFIR

To compare these benchmarks with DFIR implementations:

1. Run these benchmarks and note the results:
   ```bash
   cargo bench > timely_results.txt
   ```

2. Run equivalent DFIR benchmarks in the main repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches > dfir_results.txt
   ```

3. Compare the results manually or using the criterion report comparisons

## Data Files

- **reachability_edges.txt** - Graph data for reachability benchmarks (533KB)
- **reachability_reachable.txt** - Expected results for verification (38KB)

These files are included in the repository for reproducibility.

## Dependencies

Key dependencies for these benchmarks:

- **timely** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (v0.13.0-dev.1) - Differential dataflow framework
- **criterion** (v0.5.0) - Benchmarking framework with statistical analysis
- **tokio** - Async runtime for async benchmarks
- **rand** - Random number generation for test data

## Adding New Benchmarks

To add a new comparative benchmark:

1. Create a new file in `benches/benches/your_benchmark.rs`
2. Implement using criterion:
   ```rust
   use criterion::{black_box, criterion_group, criterion_main, Criterion};
   
   fn benchmark_name(c: &mut Criterion) {
       c.bench_function("your_benchmark", |b| {
           b.iter(|| {
               // Your benchmark code
               black_box(result);
           });
       });
   }
   
   criterion_group!(benches, benchmark_name);
   criterion_main!(benches);
   ```
3. Add a `[[bench]]` entry in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```

## Build Script

The `build.rs` script generates code for some benchmarks (e.g., fork_join). It runs automatically during `cargo build`.

## Troubleshooting

### Build Errors

If you encounter build errors:
```bash
# Clean and rebuild
cargo clean
cargo build

# Check dependency versions
cargo tree
```

### Performance Issues

If benchmarks run slowly:
- Ensure you're building in release mode (criterion does this automatically)
- Close other applications to reduce system noise
- Use `--measurement-time` to extend measurement period for more accurate results

### Missing Data Files

If data files are missing:
```bash
# Verify data files exist
ls -lh benches/benches/*.txt

# Re-clone if needed
git checkout benches/benches/reachability*.txt
```

## Notes

- These benchmarks use development versions of timely and differential-dataflow
- Results may vary between runs due to system load and other factors
- Criterion provides statistical analysis to account for variance
- HTML reports provide detailed performance analysis and graphs

## Related Documentation

- See repository root `MIGRATION_NOTES.md` for migration details
- See repository root `QUICK_START.md` for setup instructions
- See main Hydro repository for DFIR benchmark documentation
