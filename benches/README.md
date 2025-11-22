# Timely and Differential-Dataflow Comparison Benchmarks

This directory contains benchmarks that compare Hydro (dfir_rs) performance with `timely` and `differential-dataflow`.

## Benchmarks

### Timely Dataflow Comparisons

- **arithmetic.rs** - Pipeline arithmetic operations comparing Hydro with timely's dataflow operators
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks  
- **fork_join.rs** - Fork-join pattern comparisons
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation implementations
- **upcase.rs** - String transformation operations

### Differential Dataflow Comparisons

- **reachability.rs** - Graph reachability algorithm comparing:
  - Hydro (dfir_rs) surface syntax
  - Hydro scheduled execution
  - Timely dataflow
  - Differential dataflow
  - Various optimization approaches

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches-timely-differential
```

Run a specific benchmark:
```bash
cargo bench -p benches-timely-differential --bench reachability
cargo bench -p benches-timely-differential --bench arithmetic
```

Run with specific filters:
```bash
# Run only timely benchmarks from reachability
cargo bench -p benches-timely-differential --bench reachability -- timely

# Run only differential benchmarks
cargo bench -p benches-timely-differential --bench reachability -- differential

# Run only dfir_rs benchmarks
cargo bench -p benches-timely-differential --bench reachability -- dfir
```

## Data Files

- **reachability_edges.txt** - Graph edge data for reachability benchmarks (532KB)
- **reachability_reachable.txt** - Expected reachable nodes for verification

## Dependencies

These benchmarks depend on:
- **timely** - Low-latency data-parallel dataflow
- **differential-dataflow** - Incremental computation framework
- **dfir_rs** - Hydro's dataflow implementation (from main repo via git)
- **sinktools** - Helper utilities (from main repo via git)
- **criterion** - Benchmark framework

## Purpose

These benchmarks serve multiple purposes:

1. **Performance Validation** - Ensure Hydro performs competitively with established systems
2. **Regression Detection** - Track performance over time
3. **Optimization Guidance** - Identify areas for improvement
4. **Design Validation** - Verify that Hydro's abstractions don't introduce excessive overhead

## Architecture

The benchmarks reference the main Hydro repository via git dependencies, ensuring comparisons are always against the latest code. This architecture allows:

- Independent execution without affecting the main repository
- Up-to-date comparisons with current Hydro code
- Isolation of external dependencies
- Flexible benchmark evolution

## Results

Benchmark results can be viewed using Criterion's HTML reports:
```bash
open target/criterion/report/index.html
```

Results show timing comparisons across implementations, helping identify performance characteristics of different approaches.

## Adding New Benchmarks

To add a new comparison benchmark:

1. Create a new `.rs` file in `benches/` directory
2. Implement benchmark functions using criterion
3. Add benchmark definition to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
4. Run with `cargo bench -p benches-timely-differential --bench your_benchmark_name`

## Notes

- These benchmarks were moved from the main Hydro repository to isolate dependencies
- They maintain full functionality while keeping the main codebase clean
- Performance comparison capabilities are fully preserved
- The separation supports independent evolution of both repositories
