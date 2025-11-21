# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks comparing Hydroflow with Timely Dataflow and Differential Dataflow.

## Overview

These benchmarks were originally part of the main Hydroflow repository but have been moved here to:
- Keep the main Hydroflow repository focused and lightweight
- Isolate comparative benchmark dependencies (timely, differential-dataflow)
- Allow independent updates of benchmark frameworks without affecting the core codebase
- Maintain performance comparison functionality

## Repository Structure

```
benches/
├── Cargo.toml              # Package configuration with dependencies
├── README.md               # Benchmark-specific documentation
├── build.rs                # Build script for generating benchmark code
└── benches/                # Benchmark source files
    ├── arithmetic.rs       # Arithmetic operations benchmark
    ├── fan_in.rs           # Fan-in pattern benchmark
    ├── fan_out.rs          # Fan-out pattern benchmark
    ├── fork_join.rs        # Fork-join pattern benchmark
    ├── futures.rs          # Futures/async benchmark
    ├── identity.rs         # Identity/passthrough benchmark
    ├── join.rs             # Join operations benchmark
    ├── micro_ops.rs        # Micro-operations benchmark
    ├── reachability.rs     # Graph reachability benchmark
    ├── symmetric_hash_join.rs  # Symmetric hash join benchmark
    ├── upcase.rs           # String transformation benchmark
    ├── words_diamond.rs    # Diamond pattern benchmark
    └── *.txt               # Data files for benchmarks
```

## Dependencies

### Hydroflow Dependencies
- `dfir_rs` - Core Hydroflow library (from git)
- `sinktools` - Sink utilities (from git)

### Comparison Framework Dependencies
- `timely` (v0.13.0-dev.1) - Timely Dataflow framework
- `differential-dataflow` (v0.13.0-dev.1) - Differential Dataflow framework

### Benchmarking Infrastructure
- `criterion` (v0.5.0) - Benchmarking framework with HTML reports
- Additional supporting libraries (futures, tokio, rand, etc.)

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p hydro-timely-differential-benchmarks
```

### Run Specific Benchmark File
```bash
cargo bench -p hydro-timely-differential-benchmarks --bench reachability
cargo bench -p hydro-timely-differential-benchmarks --bench arithmetic
cargo bench -p hydro-timely-differential-benchmarks --bench join
```

### Run Specific Test Within Benchmark
```bash
cargo bench -p hydro-timely-differential-benchmarks --bench arithmetic -- timely
cargo bench -p hydro-timely-differential-benchmarks --bench reachability -- differential
cargo bench -p hydro-timely-differential-benchmarks --bench identity -- hydroflow
```

### View Results
Benchmark results are generated in HTML format:
```bash
# Reports are located in: target/criterion/*/report/index.html
# Open in browser to view detailed performance comparisons
```

## Benchmark Categories

### 1. Basic Operations
- **arithmetic.rs** - Basic arithmetic operations across frameworks
- **identity.rs** - Passthrough/identity transformations
- **micro_ops.rs** - Micro-level operation benchmarks

### 2. Control Flow Patterns
- **fan_in.rs** - Multiple inputs converging to one
- **fan_out.rs** - Single input distributed to multiple outputs
- **fork_join.rs** - Fork-join parallel patterns

### 3. Data Operations
- **join.rs** - Standard join operations
- **symmetric_hash_join.rs** - Symmetric hash join implementations
- **reachability.rs** - Graph reachability computations

### 4. String Processing
- **upcase.rs** - String transformation operations
- **words_diamond.rs** - Diamond pattern with word processing

### 5. Async Operations
- **futures.rs** - Asynchronous operation benchmarks

## Performance Comparison Patterns

Each benchmark typically includes implementations for:
1. **Hydroflow** - Using `dfir_syntax!` and Hydroflow operators
2. **Timely Dataflow** - Using timely dataflow operators
3. **Differential Dataflow** - Using differential dataflow operators (where applicable)

This allows direct performance comparison between frameworks for equivalent operations.

## Data Files

The benchmarks use the following data files:
- `reachability_edges.txt` - Graph edges for reachability benchmark (~521 KB)
- `reachability_reachable.txt` - Expected reachable nodes (~38 KB)
- `words_alpha.txt` - English word list for string processing (~3.7 MB)
  - Source: https://github.com/dwyl/english-words

## Development

### Adding New Benchmarks

To add a new benchmark:

1. Create a new file in `benches/benches/`:
```rust
use criterion::{Criterion, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("example/hydroflow", |b| {
        b.iter(|| {
            // Hydroflow implementation
        })
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("example/timely", |b| {
        b.iter(|| {
            // Timely implementation
        })
    });
}

criterion_group!(benches, benchmark_hydroflow, benchmark_timely);
criterion_main!(benches);
```

2. Add to `benches/Cargo.toml`:
```toml
[[bench]]
name = "your_benchmark_name"
harness = false
```

3. Run your benchmark:
```bash
cargo bench -p hydro-timely-differential-benchmarks --bench your_benchmark_name
```

### Updating Dependencies

To update Hydroflow dependencies, update the git reference in `benches/Cargo.toml`:
```toml
dfir_rs = { git = "...", branch = "main", features = [ "debugging" ] }
```

To update Timely/Differential dependencies:
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

## CI/CD Integration

The benchmarks can be integrated into CI/CD pipelines for:
- Performance regression detection
- Framework comparison reports
- Release validation

Example GitHub Actions workflow:
```yaml
name: Benchmarks
on: [push, pull_request]
jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run benchmarks
        run: cargo bench -p hydro-timely-differential-benchmarks
      - name: Archive results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: target/criterion/
```

## Best Practices

1. **Baseline Comparisons** - Use criterion's baseline feature to track performance over time
2. **Consistent Environment** - Run benchmarks on consistent hardware/configuration
3. **Multiple Runs** - Criterion automatically handles multiple iterations for statistical validity
4. **Warm-up** - Criterion handles warm-up automatically
5. **Resource Monitoring** - Monitor CPU/memory during benchmark runs

## Troubleshooting

### Build Issues

**Error: Failed to resolve git dependency**
```bash
# Solution: Check network connectivity and git credentials
git ls-remote https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
```

**Error: Version conflict**
```bash
# Solution: Clean and rebuild
cargo clean
cargo build -p hydro-timely-differential-benchmarks
```

### Performance Issues

**Benchmarks are slow**
- Reduce dataset size for development
- Use `--bench <name> -- --sample-size 10` for faster iterations
- Check for background processes

**Inconsistent results**
- Ensure consistent CPU frequency (disable turbo boost)
- Close other applications
- Use `nice` to prioritize benchmark process

## Contributing

When contributing benchmarks:
1. Follow existing patterns and naming conventions
2. Include both Hydroflow and comparison implementations
3. Document any special data requirements
4. Add appropriate comments explaining the benchmark purpose
5. Test on multiple configurations if possible

## Resources

- [Hydroflow Documentation](https://hydro-project.github.io/hydro/)
- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

## License

Apache-2.0

## Related Documentation

For information about the benchmark removal from the main repository, see:
- BENCHMARK_REMOVAL_DOCUMENTATION.md (in main Hydroflow repository)
- BENCHMARK_RESTORATION_GUIDE.md (in main Hydroflow repository)