# Timely/Differential-Dataflow Benchmarks

This package contains performance benchmarks for dataflow systems that use timely-dataflow and differential-dataflow as comparison baselines.

## Benchmark Suite

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to isolate heavy dependencies while maintaining the ability to run performance comparisons.

### Included Benchmarks

| Benchmark | Description | Key Metrics |
|-----------|-------------|-------------|
| arithmetic | Basic arithmetic operations in dataflow | Throughput, latency |
| fan_in | Multiple streams merging to one | Merge performance |
| fan_out | Single stream splitting to multiple | Split performance |
| fork_join | Parallel processing with rejoin | Fork-join overhead |
| identity | Minimal transformation (baseline) | Raw throughput |
| join | Stream join operations | Join efficiency |
| reachability | Graph reachability queries | Complex dataflow |
| upcase | String transformation | String processing |

## Running

### All Benchmarks
```bash
cargo bench
```

### Specific Benchmark
```bash
cargo bench --bench arithmetic
```

### With Custom Parameters
```bash
# Increase sample size for more accurate results
cargo bench --bench identity -- --sample-size 100

# Save baseline for comparison
cargo bench --bench join -- --save-baseline before-optimization

# Compare against baseline
cargo bench --bench join -- --baseline before-optimization
```

## Configuration

### Path Dependencies

To run benchmarks that compare against implementations from the main repository, you must uncomment the path dependencies in `Cargo.toml`:

```toml
babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
# ... etc
```

This requires both repositories to be cloned side-by-side:
```
parent-directory/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```

### Without Path Dependencies

If you only want to run the timely/differential benchmarks without comparisons:
1. Keep path dependencies commented
2. Comment out any benchmark code that references babyflow, hydroflow, or spinachflow
3. Run: `cargo bench`

## Implementation Details

### Benchmark Structure

Each benchmark follows this pattern:

```rust
use criterion::{criterion_group, criterion_main, Criterion};

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("timely_variant", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("differential_variant", |b| {
        b.iter(|| {
            // Differential implementation
        });
    });
}

// Additional implementations when path dependencies are available
fn benchmark_hydroflow(c: &mut Criterion) { /* ... */ }
fn benchmark_babyflow(c: &mut Criterion) { /* ... */ }

criterion_group!(benches, 
    benchmark_timely,
    benchmark_differential,
    benchmark_hydroflow,
    benchmark_babyflow
);
criterion_main!(benches);
```

### Build Script

The `build.rs` script generates code for benchmarks that need it (e.g., fork_join creates a large pipeline).

## Interpreting Results

Criterion outputs:
- **Time**: Average execution time per iteration
- **Throughput**: Operations per second
- **Change**: Comparison with previous runs (if baseline exists)

Example output:
```
arithmetic/timely     time: [1.2345 ms 1.2567 ms 1.2789 ms]
                      thrpt: [810.23 Kelem/s 825.67 Kelem/s 840.11 Kelem/s]
```

HTML reports are generated in `target/criterion/`:
```bash
open ../target/criterion/report/index.html
```

## Data Files

Some benchmarks include data files:
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes

## Troubleshooting

### Missing Dependencies
If benchmarks fail to compile due to missing types/functions, the main repository may have breaking changes. Synchronize versions:
```bash
cd ../../bigweaver-agent-canary-hydro-zeta
git log --oneline | head -5
# Note the commit hash
cd ../bigweaver-agent-canary-zeta-hydro-deps
# Update this repository to match the interface
```

### Performance Regressions
If benchmarks show performance regressions:
1. Save baseline before changes: `cargo bench -- --save-baseline before`
2. Make changes
3. Compare: `cargo bench -- --baseline before`
4. Investigate using criterion's HTML reports

### Build.rs Issues
If the build script fails:
- Check that `benches/` directory exists
- Verify file permissions
- Clean and rebuild: `cargo clean && cargo bench`

## Contributing

When adding benchmarks:
1. Name files descriptively (e.g., `new_operator.rs`)
2. Add `[[bench]]` entry to Cargo.toml
3. Include all relevant implementations (timely, differential, hydroflow, etc.)
4. Document what the benchmark measures
5. Add data files to git if needed (keep them small)

## References

- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)
