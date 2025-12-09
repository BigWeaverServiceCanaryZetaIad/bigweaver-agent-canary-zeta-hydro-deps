# Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks that compare Hydroflow performance with timely-dataflow and differential-dataflow implementations. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce build times and avoid unnecessary dependencies for users who don't need these comparisons.

## Benchmark Descriptions

### arithmetic
Compares the performance of arithmetic pipelines across different dataflow implementations:
- Pipeline pattern (multi-threaded channels)
- Raw copy (baseline)
- Timely dataflow
- Hydroflow (compiled and surface syntax)
- Hydroflow pusherator

### fan_in
Tests the performance of fan-in patterns where multiple input streams merge into a single output:
- Timely dataflow implementation
- Hydroflow scheduled implementation
- Hydroflow compiled implementation
- Hydroflow surface syntax

### fan_out
Benchmarks fan-out patterns where one input stream splits to multiple outputs:
- Timely dataflow implementation
- Hydroflow scheduled implementation
- Hydroflow compiled implementation
- Hydroflow surface syntax

### fork_join
Evaluates fork-join patterns with filtering and merging operations:
- Timely dataflow implementation
- Hydroflow scheduled implementation
- Hydroflow compiled implementation
- Hydroflow surface syntax (with generated code)

### identity
Tests the performance overhead of identity operations (no-op pass-through):
- Pipeline pattern
- Raw copy
- Timely dataflow
- Hydroflow (scheduled, compiled, surface, pusherator)

### join
Compares join operation implementations:
- Timely dataflow with custom operator
- Hydroflow implementations

### reachability
Graph reachability benchmarks using transitive closure:
- Differential-dataflow implementation
- Hydroflow scheduled implementation
- Hydroflow compiled implementation
- Hydroflow surface syntax
- Includes large test datasets (edges and reachable nodes)

### upcase
String uppercase transformation benchmarks:
- Pipeline pattern
- Timely dataflow
- Hydroflow implementations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

Run a specific test within a benchmark:
```bash
cargo bench -p benches --bench arithmetic -- arithmetic/timely
```

## Performance Tracking

These benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) which provides:

- Statistical analysis of performance
- HTML reports with graphs
- Baseline comparison for tracking performance changes

### Using Baselines

Save current performance as a baseline:
```bash
cargo bench -p benches -- --save-baseline my-baseline
```

Compare against a baseline:
```bash
cargo bench -p benches -- --baseline my-baseline
```

## Data Files

Some benchmarks include test data files:

- `reachability_edges.txt` - Graph edge data for reachability benchmarks
- `reachability_reachable.txt` - Expected reachable nodes for validation

## Build Configuration

The `build.rs` script generates Hydroflow code for some benchmarks (e.g., fork_join) at compile time.

## Dependencies

This repository depends on:

- **hydroflow**: The main Hydroflow framework (from git)
- **timely**: Timely dataflow (timely-master package)
- **differential-dataflow**: Differential dataflow (differential-dataflow-master package)
- **criterion**: Benchmarking framework

## Adding New Benchmarks

When adding new benchmarks that compare Hydroflow with timely/differential-dataflow:

1. Add the benchmark file to `benches/benches/`
2. Add a `[[bench]]` section to `benches/Cargo.toml`
3. Follow the existing patterns for comparing multiple implementations
4. Document the benchmark in this file

## See Also

- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
