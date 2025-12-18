# Hydro Performance Benchmarks with Timely/Differential Dataflow Comparison

This directory contains benchmarks for performance comparison between Hydro-native implementations and Timely/Differential Dataflow implementations.

## Overview

These benchmarks enable performance comparison and validation by including dependencies on both:
- Hydro's DFIR implementation
- Timely Dataflow
- Differential Dataflow

## Available Benchmarks

### Current Hydro-Native Benchmarks

- **micro_ops** - Micro-operations benchmark testing basic Hydro operations (identity, unique, map, filter, etc.)
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark
- **futures** - Futures-based operations benchmark

### Future Comparison Benchmarks

Additional benchmarks comparing Hydro with Timely/Differential Dataflow implementations can be added:
- Arithmetic operations
- Fan-in/Fan-out patterns
- Fork-join patterns
- Graph reachability
- Join operations
- And more...

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro-deps-benches --bench micro_ops
cargo bench -p hydro-deps-benches --bench words_diamond
cargo bench -p hydro-deps-benches --bench symmetric_hash_join
cargo bench -p hydro-deps-benches --bench futures
```

## Performance Comparison Workflow

1. **Run Hydro-native benchmarks** - Execute the current implementations to establish baseline
2. **Add Timely/Differential implementations** - Implement equivalent benchmarks using Timely/Differential Dataflow
3. **Compare results** - Use Criterion's comparison features to analyze performance differences

## Adding New Comparison Benchmarks

To add a new benchmark with both Hydro and Timely/Differential implementations:

1. Create a new `.rs` file in `benches/benches/`
2. Implement both Hydro-native and Timely/Differential versions
3. Add a `[[bench]]` entry to `Cargo.toml`
4. Use Criterion's benchmarking groups to organize comparisons

Example structure:
```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn hydro_implementation(c: &mut Criterion) {
    c.bench_function("operation/hydro", |b| {
        // Hydro implementation
    });
}

fn timely_implementation(c: &mut Criterion) {
    c.bench_function("operation/timely", |b| {
        // Timely implementation
    });
}

criterion_group!(benches, hydro_implementation, timely_implementation);
criterion_main!(benches);
```

## Data Files

- **words_alpha.txt** - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Dependencies

This benchmark suite includes:
- `criterion` - Benchmarking framework with statistical analysis
- `differential-dataflow-master` (0.13.0-dev.1) - For differential dataflow implementations
- `timely-master` (0.13.0-dev.1) - For timely dataflow implementations
- `futures`, `tokio` - For async operations
- `rand`, `rand_distr` - For random data generation in benchmarks
- Additional utilities: `nameof`, `seq-macro`, `static_assertions`

**Note**: The current benchmarks require `dfir_rs` and `sinktools` dependencies. These need to be configured in `Cargo.toml` with the appropriate path or git reference to the Hydro implementation:

```toml
dfir_rs = { path = "../../path/to/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../path/to/sinktools", version = "^0.0.1" }
```

## Notes

- Benchmarks use Criterion's default measurement time of 5 seconds per benchmark
- HTML reports are generated in `target/criterion/` for detailed analysis
- Results can be compared across runs using Criterion's baseline feature
