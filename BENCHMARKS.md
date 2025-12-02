# Benchmark Documentation

This document provides detailed information about running and interpreting the performance benchmarks for Hydro, Timely Dataflow, and Differential Dataflow.

## Overview

The benchmarks in this repository compare the performance of three dataflow systems:
- **Hydro (dfir_rs)**: The Hydro dataflow runtime
- **Timely Dataflow**: A low-latency cyclic dataflow computational model
- **Differential Dataflow**: An implementation of differential dataflow over Timely Dataflow

## Prerequisites

1. **Rust toolchain**: Ensure you have Rust 1.91.1 or later installed
   ```bash
   rustc --version
   ```

2. **Adjacent repository**: The benchmarks depend on `dfir_rs` and `sinktools` from the main Hydro repository, which should be located at `../bigweaver-agent-canary-hydro-zeta/`

## Running Benchmarks

### Run All Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

This will execute all benchmark suites and generate HTML reports in `target/criterion/`.

### Run Specific Benchmarks

To run a specific benchmark suite:
```bash
cargo bench -p benches --bench <benchmark-name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in dataflow pattern
- `fan_out` - Fan-out dataflow pattern
- `fork_join` - Fork-join pattern
- `futures` - Async futures handling
- `identity` - Identity/pass-through operations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercase transformation
- `words_diamond` - Word processing diamond pattern

### Run Specific Test Cases

To run specific test cases within a benchmark:
```bash
cargo bench -p benches --bench identity -- dfir
cargo bench -p benches --bench micro_ops -- micro/ops/
```

## Benchmark Descriptions

### arithmetic.rs
Compares the performance of arithmetic operations (addition) across different dataflow systems. Tests throughput with 1 million integers and 20 operations.

### fan_in.rs
Benchmarks fan-in patterns where multiple streams converge into a single stream. Tests the efficiency of stream merging operations.

### fan_out.rs
Benchmarks fan-out patterns where a single stream is split into multiple output streams. Tests the efficiency of stream splitting operations.

### fork_join.rs
Tests fork-join patterns with alternating filter operations. Generated using a build script that creates a complex dataflow graph with multiple branches and joins.

### futures.rs
Benchmarks async/await patterns and future resolution in dataflow contexts. Tests the efficiency of asynchronous operations.

### identity.rs
Benchmarks the overhead of passing data through the system without transformations. Includes:
- Raw copy operations (baseline)
- Pipeline threading
- Iterator operations
- Timely Dataflow
- Hydro (compiled and surface syntax)

### join.rs
Benchmarks join operations between two streams. Tests the efficiency of data correlation between streams.

### micro_ops.rs
A comprehensive suite of micro-benchmarks testing individual operators:
- Source operations
- Map transformations
- Filter operations
- Flat map
- Fold aggregations
- And many more...

### reachability.rs
Benchmarks graph reachability algorithms using:
- `reachability_edges.txt`: Graph edges (55,008 edges)
- `reachability_reachable.txt`: Expected reachable nodes (7,855 nodes)

Tests iterative computation patterns common in graph algorithms.

### symmetric_hash_join.rs
Benchmarks symmetric hash join operations, which maintain hash tables on both sides of the join.

### upcase.rs
Benchmarks string transformation operations using:
- `words_alpha.txt`: English word list (370,104 words)

Tests the efficiency of map operations on string data.

### words_diamond.rs
Benchmarks diamond-shaped dataflow patterns using word processing operations. Tests complex dataflow graphs with multiple paths and joins.

## Performance Comparison

### Reading Results

Benchmark results are reported in the console and saved as HTML reports in `target/criterion/`. Each benchmark reports:
- **Time**: Mean execution time with confidence intervals
- **Throughput**: Operations per second (when applicable)
- **Change**: Performance change compared to previous runs

### Comparing Implementations

Most benchmarks test multiple implementations of the same operation:
- `*_raw` or `*_pipeline`: Baseline implementations using standard Rust
- `*_timely`: Timely Dataflow implementation
- `*_hydroflow_*`: Hydro implementations (compiled, surface syntax, etc.)

### Interpreting Results

- **Lower times are better**: Benchmarks measure execution time
- **Consistency matters**: Look at standard deviation to assess consistency
- **Context is important**: Consider the benchmark's workload size and complexity
- **Relative performance**: Compare implementations on the same benchmark to understand trade-offs

## Continuous Integration

The `.github/workflows/benchmark.yml` workflow runs benchmarks automatically:
- **Schedule**: Daily at 8:35 PM PDT / 7:35 PM PST
- **Manual trigger**: Via workflow_dispatch with `should_bench: true`
- **On push**: When commit message contains `[ci-bench]`
- **On pull request**: When PR title or body contains `[ci-bench]`

Results are published to GitHub Pages for historical tracking.

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Check dependencies**: Ensure the main Hydro repository is at the correct location:
   ```bash
   ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
   ls ../bigweaver-agent-canary-hydro-zeta/sinktools
   ```

2. **Update dependencies**: Try updating Cargo.lock:
   ```bash
   cargo update
   ```

3. **Clean build**: Remove cached artifacts:
   ```bash
   cargo clean
   cargo bench -p benches
   ```

### Performance Issues

If benchmarks run slowly or produce inconsistent results:

1. **Close unnecessary applications**: Free up system resources
2. **Disable CPU frequency scaling**: For more consistent results
3. **Use release mode**: Benchmarks automatically use release mode via criterion
4. **Increase sample size**: Edit individual benchmark files to increase iteration count

## Data Files

### words_alpha.txt
Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- 370,104 English words
- Used by: `upcase.rs`, `words_diamond.rs`

### reachability_edges.txt & reachability_reachable.txt
- Graph data for reachability benchmarks
- 55,008 edges, 7,855 reachable nodes
- Used by: `reachability.rs`

## Development

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Follow the pattern from existing benchmarks using criterion
4. Document the benchmark in this file

### Modifying Benchmarks

When modifying benchmarks:
1. Ensure the modification is applied consistently across all implementations
2. Update documentation to reflect changes
3. Consider backward compatibility for historical comparisons
4. Test that all variants still compile and run

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydro Project](https://hydro.run)
