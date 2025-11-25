# Hydro Performance Benchmarks

This directory contains performance benchmarks comparing Hydro (DFIR/Hydroflow) against Timely Dataflow and Differential Dataflow.

## Benchmark Files

### Core Benchmarks

Located in `benches/`:

- **arithmetic.rs** - Pipeline of arithmetic operations (+1 on integers)
  - Compares: Hydro vs. Timely vs. Raw pipeline
  - Measures: Pipeline efficiency and operator chaining overhead

- **fan_in.rs** - Multiple input streams merging into one
  - Compares: Hydro vs. Timely
  - Measures: Stream merging efficiency and multi-source coordination

- **fan_out.rs** - Single stream splitting into multiple outputs
  - Compares: Hydro vs. Timely
  - Measures: Stream splitting efficiency and broadcast performance

- **fork_join.rs** - Fork-join dataflow pattern
  - Compares: Hydro vs. Timely
  - Measures: Parallel computation and stream synchronization

- **identity.rs** - Identity transformation (no-op)
  - Compares: Hydro vs. Timely
  - Measures: Framework overhead and minimum latency

- **join.rs** - Stream join operations
  - Compares: Hydro vs. Timely
  - Measures: Join algorithm efficiency and state management

- **reachability.rs** - Graph reachability computation
  - Compares: Hydro vs. Timely vs. Differential
  - Measures: Iterative computation and fixed-point algorithms
  - Data files: `reachability_edges.txt`, `reachability_reachable.txt`

- **upcase.rs** - String uppercase transformation
  - Compares: Hydro vs. Timely
  - Measures: String processing and transformation overhead

### Data Files

- **reachability_edges.txt** (~520KB) - Graph edge list for reachability benchmark
- **reachability_reachable.txt** (~40KB) - Expected reachable nodes

## Running Benchmarks

### All Benchmarks

```bash
cargo bench -p hydro-deps-benches
```

### Individual Benchmarks

```bash
# Run specific benchmark
cargo bench -p hydro-deps-benches --bench arithmetic
cargo bench -p hydro-deps-benches --bench reachability

# Run specific variant
cargo bench -p hydro-deps-benches --bench arithmetic -- dfir
cargo bench -p hydro-deps-benches --bench reachability -- timely
```

### Quick Test Run

```bash
# Faster run with reduced accuracy
cargo bench -p hydro-deps-benches -- --measurement-time 5 --sample-size 20
```

## Results

Results are stored in `target/criterion/` with HTML reports:

```bash
# View results (example for arithmetic)
open target/criterion/arithmetic/report/index.html
```

## Adding New Benchmarks

1. Create new file in `benches/` (e.g., `my_benchmark.rs`)
2. Implement benchmark variants (dfir, timely, etc.)
3. Register in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
4. Update documentation
5. Run verification: `./verify_benchmarks.sh`

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines.

## Dependencies

- **criterion** - Benchmarking framework
- **dfir_rs** - Hydro DFIR implementation (from main repository)
- **timely** - Timely Dataflow
- **differential-dataflow** - Differential Dataflow
- **sinktools** - Sink utilities (from main repository)

## Documentation

- [Main README](../README.md) - Repository overview
- [BENCHMARK_GUIDE.md](../BENCHMARK_GUIDE.md) - Comprehensive benchmarking guide
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines

## Troubleshooting

### "Cannot find dfir_rs"

Ensure the main Hydro repository is cloned alongside this one:
```
workspace/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Build Errors

```bash
# Clean and rebuild
cargo clean
cargo build -p hydro-deps-benches --release
```

### Slow Benchmarks

```bash
# Reduce measurement parameters
cargo bench -p hydro-deps-benches -- --measurement-time 5
```

## Performance Characteristics

### Expected Patterns

- **Arithmetic**: Hydro should be competitive with Timely (~10-20% variance)
- **Fan-In/Out**: Should scale linearly with stream count
- **Fork-Join**: May have slight overhead vs. Timely (~5-15%)
- **Identity**: Minimal framework overhead (<5%)
- **Join**: Performance depends on data distribution
- **Reachability**: Differential should outperform for iterative workloads
- **Upcase**: Should match Timely for simple transformations

### Optimization Tips

1. Always use `--release` builds
2. Run on idle system for consistency
3. Increase sample size for statistical significance
4. Use HTML reports for detailed analysis
5. Compare against baseline measurements

## License

Same as main repository - Apache License 2.0
