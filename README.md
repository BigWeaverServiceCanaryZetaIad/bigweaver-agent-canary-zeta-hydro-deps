# Hydro Benchmarks Repository

This repository contains benchmarks for timely-dataflow and differential-dataflow implementations, originally part of the main Hydro project. These benchmarks have been isolated into a separate repository to maintain independence from the main codebase while preserving the ability to run performance comparisons.

## Overview

The benchmarks measure performance characteristics of various dataflow patterns and operations, including:

- **Arithmetic Operations**: Pipeline and dataflow arithmetic computations
- **Identity Operations**: Pass-through dataflow operations
- **Fan-in/Fan-out**: Multiple input/output stream handling
- **Fork-Join**: Parallel execution patterns
- **Join Operations**: Stream joining patterns including symmetric hash joins
- **Reachability**: Graph reachability algorithms
- **Micro Operations**: Fine-grained operation benchmarks
- **Futures**: Asynchronous operation benchmarks
- **Words Diamond**: Complex word processing pipelines

## Repository Structure

```
.
├── Cargo.toml              # Package configuration with all dependencies
├── build.rs                # Build script for generating benchmark code
├── benches/
│   ├── README.md           # Benchmark-specific documentation
│   ├── .gitignore          # Ignores generated benchmark files
│   └── benches/            # Benchmark source files and data
│       ├── arithmetic.rs
│       ├── fan_in.rs
│       ├── fan_out.rs
│       ├── fork_join.rs
│       ├── futures.rs
│       ├── identity.rs
│       ├── join.rs
│       ├── micro_ops.rs
│       ├── reachability.rs
│       ├── symmetric_hash_join.rs
│       ├── upcase.rs
│       ├── words_diamond.rs
│       ├── reachability_edges.txt      # Graph data for reachability benchmarks
│       ├── reachability_reachable.txt  # Expected results for reachability
│       └── words_alpha.txt             # English words dictionary
```

## Dependencies

This repository uses the following key dependencies:

- **dfir_rs** (v0.14.0): Core dataflow runtime with debugging features
- **timely-master** (v0.13.0-dev.1): Timely dataflow engine
- **differential-dataflow-master** (v0.13.0-dev.1): Differential dataflow computation
- **criterion** (v0.5.0): Benchmarking framework with async support and HTML reports

All dependencies are configured independently without requiring the main Hydro repository.

## Running Benchmarks

### Prerequisites

- Rust toolchain (recommended: stable or as specified in rust-toolchain.toml if present)
- Cargo

### Run All Benchmarks

```bash
cargo bench
```

This will execute all benchmarks and generate HTML reports in `target/criterion/`.

### Run Specific Benchmarks

Run a single benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
```

Run benchmarks matching a pattern:
```bash
cargo bench arithmetic
cargo bench join
```

### View Results

After running benchmarks, detailed HTML reports are available at:
```
target/criterion/report/index.html
```

Open this file in a web browser to view:
- Performance graphs
- Statistical analysis
- Historical comparisons
- Detailed timing information

## Performance Comparisons

This repository is specifically designed to enable performance comparisons between different implementations and versions:

### Baseline Establishment

1. Run benchmarks on the current version:
   ```bash
   cargo bench
   ```

2. Criterion automatically saves baseline results in `target/criterion/`.

### Comparing Changes

1. Make changes to implementations or dependencies
2. Run benchmarks again:
   ```bash
   cargo bench
   ```

3. Criterion will automatically compare against the baseline and show:
   - Performance differences (faster/slower)
   - Statistical significance
   - Confidence intervals

### Manual Baseline Management

Save a named baseline:
```bash
cargo bench --bench arithmetic -- --save-baseline my-baseline
```

Compare against a specific baseline:
```bash
cargo bench --bench arithmetic -- --baseline my-baseline
```

## Benchmark Descriptions

### arithmetic.rs
Tests arithmetic operations in both pipeline and dataflow patterns. Measures throughput of chained addition operations.

### identity.rs
Tests pass-through operations to measure dataflow overhead with minimal computation.

### fan_in.rs / fan_out.rs
Measures performance of merging multiple streams (fan-in) and splitting streams to multiple consumers (fan-out).

### fork_join.rs
Tests parallel execution patterns where streams fork into parallel paths and rejoin.

### join.rs / symmetric_hash_join.rs
Benchmarks stream join operations, including hash-based join implementations.

### reachability.rs
Tests graph reachability algorithms using dataflow patterns. Uses real graph data from included files.

### micro_ops.rs
Fine-grained benchmarks of individual dataflow operations.

### futures.rs
Benchmarks asynchronous operation handling in dataflow contexts.

### words_diamond.rs
Complex benchmark using word processing in diamond-shaped dataflow patterns.

### upcase.rs
String transformation benchmarks measuring throughput of simple operations on large datasets.

## Data Files

- **words_alpha.txt**: English words dictionary from https://github.com/dwyl/english-words/
- **reachability_edges.txt**: Graph edge data for reachability benchmarks
- **reachability_reachable.txt**: Expected reachable nodes for validation

## Build Process

The `build.rs` script generates additional benchmark code at build time. Currently, it generates fork-join benchmark variations with different operation counts.

## Independence from Main Repository

This repository is fully independent and does not require the main Hydro repository:

- ✅ Uses published version of dfir_rs (0.14.0)
- ✅ All dependencies specified with version numbers
- ✅ No path-based dependencies
- ✅ Self-contained benchmark code and data
- ✅ Can be cloned and run standalone

## Contributing

When adding new benchmarks:

1. Add the benchmark source file to `benches/benches/`
2. Register the benchmark in `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Follow existing patterns for criterion usage
4. Include descriptive comments explaining what is being measured
5. Add any required data files to `benches/benches/`

## License

Apache-2.0

## References

- Hydro Project: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion.rs: https://github.com/bheisler/criterion.rs