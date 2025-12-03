# Dataflow Benchmarks

Benchmarks comparing Hydro's dfir_rs with timely-dataflow and differential-dataflow implementations.

## Available Benchmarks

This directory contains 12 benchmarks organized by dataflow pattern:

### Basic Patterns
- **arithmetic.rs** - Basic arithmetic pipeline operations
- **identity.rs** - Identity function baseline measurement
- **upcase.rs** - String transformation operations

### Flow Patterns
- **fan_in.rs** - Multiple streams merging to one
- **fan_out.rs** - Single stream splitting to multiple
- **fork_join.rs** - Fork and join with filtering
- **words_diamond.rs** - Diamond pattern with word processing

### Join Operations
- **join.rs** - Hash join operations
- **symmetric_hash_join.rs** - Symmetric hash join

### Advanced Patterns
- **futures.rs** - Async futures-based processing
- **micro_ops.rs** - Individual operator micro-benchmarks
- **reachability.rs** - Graph reachability algorithm

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmark:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
```

Run specific test within a benchmark:
```bash
cargo bench --bench arithmetic -- arithmetic/dfir_rs
```

## Test Data

- **words_alpha.txt** - English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- **reachability_edges.txt** - Graph edges for reachability testing
- **reachability_reachable.txt** - Expected reachable nodes

## Results

Benchmark results are output in HTML format in `target/criterion/` directory.
Open `target/criterion/report/index.html` in a browser to view detailed results.

## More Information

See [BENCHMARKS_GUIDE.md](../BENCHMARKS_GUIDE.md) in the repository root for detailed documentation about each benchmark and how to interpret results.
