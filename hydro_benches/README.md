# Hydro Benchmarks

Microbenchmarks for Hydro using timely and differential-dataflow dependencies.

## Overview

This crate contains performance benchmarks that measure Hydro's performance characteristics when working with timely dataflow and differential dataflow backends. These benchmarks were previously part of the main Hydro repository but have been moved here to reduce the dependency footprint of the core repository.

## Running Benchmarks

From the repository root, run all benchmarks:
```bash
cargo bench -p hydro_benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro_benches --bench reachability
cargo bench -p hydro_benches --bench arithmetic
cargo bench -p hydro_benches --bench join
```

## Available Benchmarks

### Data Processing Patterns

- **identity.rs** - Identity transformation benchmarks measuring basic data flow overhead
- **arithmetic.rs** - Arithmetic operations benchmarks testing computational operations
- **upcase.rs** - String uppercase transformation benchmarks

### Graph and Flow Patterns

- **fan_in.rs** - Fan-in pattern benchmarks (multiple inputs to single output)
- **fan_out.rs** - Fan-out pattern benchmarks (single input to multiple outputs)
- **fork_join.rs** - Fork-join pattern benchmarks (parallel processing with synchronization)
- **words_diamond.rs** - Diamond pattern with word processing

### Join Operations

- **join.rs** - Standard join operation benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks

### Complex Operations

- **reachability.rs** - Graph reachability benchmarks using real graph data
- **micro_ops.rs** - Collection of micro-operation benchmarks
- **futures.rs** - Futures-based asynchronous operations benchmarks

## Data Files

The `benches/` directory includes data files used by benchmarks:

- **words_alpha.txt** - English word list (370k+ words) from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
- **reachability_edges.txt** - Graph edges for reachability benchmarks
- **reachability_reachable.txt** - Expected reachable nodes for validation

## Performance Analysis

### Saving Baselines

To establish a performance baseline:
```bash
cargo bench -p hydro_benches -- --save-baseline my-baseline
```

### Comparing Against Baseline

After making changes, compare performance:
```bash
cargo bench -p hydro_benches -- --baseline my-baseline
```

### Interpreting Results

Criterion will display:
- Performance change percentage
- Statistical confidence intervals
- Regression/improvement indicators

Look for:
- **Improvements**: Faster execution times (negative % change)
- **Regressions**: Slower execution times (positive % change)
- **No change**: Changes within noise threshold

## Development

### Using Local Dependencies

For development, you can use local paths to the main Hydro repository. Edit `Cargo.toml`:

```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

### Adding New Benchmarks

1. Create a new `.rs` file in the `benches/` directory
2. Add a `[[bench]]` entry in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_new_benchmark"
   harness = false
   ```
3. Use the criterion framework to structure your benchmark
4. Document the benchmark purpose and interpretation

## Dependencies

- **criterion** - Benchmarking harness with statistical analysis
- **timely-master** - Timely dataflow framework
- **differential-dataflow-master** - Differential dataflow library
- **dfir_rs** - Hydro's dataflow intermediate representation
- **sinktools** - Utilities for data sinks
- **tokio** - Async runtime for async benchmarks

## See Also

- [Parent Repository README](../README.md) - Overview of the deps repository
- [Migration Guide](../BENCHMARK_MIGRATION.md) - Information about the benchmark migration
- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/) - Benchmarking framework docs
