# Usage Guide: Timely and Differential Dataflow Benchmarks

## Quick Start

### 1. Clone Required Repositories

The benchmarks require access to the Hydroflow source code. Clone both repositories as siblings:

```bash
cd /path/to/your/workspace
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
```

Expected directory structure:
```
workspace/
├── bigweaver-agent-canary-hydro-zeta/
│   └── hydroflow/
└── bigweaver-agent-canary-zeta-hydro-deps/
    ├── Cargo.toml
    └── benches/
```

### 2. Run All Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### 3. Run Specific Benchmark

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Multiple streams merging
- `fan_out` - Stream splitting
- `fork_join` - Fork/join with filtering
- `identity` - Pass-through operations
- `join` - Stream joins
- `micro_ops` - Micro-benchmarks
- `reachability` - Graph reachability
- `symmetric_hash_join` - Hash join implementation
- `upcase` - String transformations

## Understanding Benchmark Results

### Console Output

Criterion will display:
- Time per iteration (mean, median, standard deviation)
- Performance regression/improvement compared to previous runs
- Statistical confidence levels

Example output:
```
reachability/hydroflow  time:   [10.234 ms 10.456 ms 10.678 ms]
                        change: [-5.2314% -2.1234% +1.0123%] (p = 0.23 > 0.05)
                        No change in performance detected.
```

### HTML Reports

Detailed reports are generated in `target/criterion/<benchmark_name>/`:
- `report/index.html` - Comprehensive results with charts
- Performance comparison across runs
- Distribution plots and statistics

Open in your browser:
```bash
open target/criterion/report/index.html
```

## Configuration Options

### Using Git Dependency Instead of Local Path

If you prefer not to have both repositories cloned locally, edit `Cargo.toml`:

```toml
# Replace this:
hydroflow = { path = "../bigweaver-agent-canary-hydro-zeta/hydroflow" }

# With this:
hydroflow = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta" }
```

Or for a specific branch/tag:
```toml
hydroflow = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", branch = "main" }
```

### Custom Hydroflow Location

If your Hydroflow repository is in a different location:

```toml
hydroflow = { path = "/custom/path/to/bigweaver-agent-canary-hydro-zeta/hydroflow" }
```

## Benchmark Details

### What Gets Compared

Each benchmark typically includes:
1. **Hydroflow Implementation** - Using the Hydroflow dataflow framework
2. **Timely Implementation** - Using Timely Dataflow
3. **Differential Implementation** - Using Differential Dataflow (where applicable)
4. **Baseline** - Sometimes includes naive implementations for reference

### Performance Metrics

Benchmarks measure:
- **Throughput** - Operations per second
- **Latency** - Time per operation
- **Memory usage** - Via Criterion's sampling

### Test Data

Some benchmarks (like `reachability`) include test data files:
- `reachability_edges.txt` - Input graph edges
- `reachability_reachable.txt` - Expected reachable nodes

## Troubleshooting

### "hydroflow not found" Error

**Problem**: Cargo can't find the hydroflow crate.

**Solution**: Ensure the path in `Cargo.toml` is correct:
```bash
# From this repository, check if Hydroflow is accessible
ls ../bigweaver-agent-canary-hydro-zeta/hydroflow/Cargo.toml
```

### Compilation Errors

**Problem**: Timely/Differential dependencies fail to compile.

**Solution**: 
1. Update Rust toolchain: `rustup update`
2. Clean and rebuild: `cargo clean && cargo bench`
3. Check compatibility in `Cargo.toml` - versions should match

### Slow Benchmark Execution

**Problem**: Benchmarks take too long.

**Solution**: Run specific benchmarks instead of all:
```bash
# Just one benchmark
cargo bench --bench reachability

# Or limit iterations
cargo bench --bench reachability -- --sample-size 10
```

## Adding New Benchmarks

To add a new benchmark:

1. Create a new file in `benches/benches/`:
   ```bash
   touch benches/benches/my_benchmark.rs
   ```

2. Add benchmark registration in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. Structure your benchmark following existing patterns:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn benchmark_hydroflow(c: &mut Criterion) {
       c.bench_function("my_benchmark/hydroflow", |b| {
           // Your benchmark code
       });
   }
   
   criterion_group!(benches, benchmark_hydroflow);
   criterion_main!(benches);
   ```

## CI/CD Integration

### Running in CI

```yaml
- name: Run Benchmarks
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench --no-fail-fast
```

### Performance Regression Testing

Track performance over time:
```bash
# Baseline
cargo bench -- --save-baseline my-baseline

# After changes
cargo bench -- --baseline my-baseline
```

## Contributing

When contributing benchmarks:
1. Ensure all three implementations (Hydroflow, Timely, Differential) are included
2. Document what the benchmark measures
3. Use realistic data sizes
4. Follow existing code style
5. Update this documentation if adding new categories

## Support

For questions or issues:
- File an issue in this repository
- Reference the main Hydroflow repository for framework issues
- Check [MIGRATION_NOTES.md](../bigweaver-agent-canary-hydro-zeta/MIGRATION_NOTES.md) for migration context
