# Hydroflow, Timely, and Differential Dataflow Microbenchmarks

Comparative performance benchmarks of Hydroflow and other dataflow frameworks.

## Quick Start

Run all benchmarks:
```bash
cargo bench -p hydro-timely-differential-benchmarks
```

Run specific benchmarks:
```bash
cargo bench -p hydro-timely-differential-benchmarks --bench reachability
cargo bench -p hydro-timely-differential-benchmarks --bench arithmetic
cargo bench -p hydro-timely-differential-benchmarks --bench join
```

Run specific framework comparison:
```bash
cargo bench -p hydro-timely-differential-benchmarks --bench reachability -- differential
cargo bench -p hydro-timely-differential-benchmarks --bench arithmetic -- timely
cargo bench -p hydro-timely-differential-benchmarks --bench identity -- hydroflow
```

## Available Benchmarks

| Benchmark | Description | Frameworks Compared |
|-----------|-------------|---------------------|
| `arithmetic` | Basic arithmetic operations | Hydroflow, Timely |
| `fan_in` | Multiple inputs to one output | Hydroflow, Timely |
| `fan_out` | Single input to multiple outputs | Hydroflow, Timely |
| `fork_join` | Fork-join parallel patterns | Hydroflow, Timely |
| `futures` | Asynchronous operations | Hydroflow, Timely |
| `identity` | Identity/passthrough | Hydroflow, Timely |
| `join` | Join operations | Hydroflow, Timely, Differential |
| `micro_ops` | Micro-level operations | Hydroflow, Timely |
| `reachability` | Graph reachability | Hydroflow, Differential |
| `symmetric_hash_join` | Symmetric hash joins | Hydroflow, Timely |
| `upcase` | String transformations | Hydroflow, Timely |
| `words_diamond` | Diamond pattern processing | Hydroflow, Timely |

## Data Files

The benchmarks use the following data files (included in this repository):

- **reachability_edges.txt** (~521 KB) - Graph edges for reachability benchmark
- **reachability_reachable.txt** (~38 KB) - Expected reachable nodes for validation
- **words_alpha.txt** (~3.7 MB) - English word list for string processing benchmarks

Wordlist source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Viewing Results

After running benchmarks, HTML reports are generated in:
```
target/criterion/<benchmark_name>/report/index.html
```

Open these files in a web browser to see detailed performance comparisons, including:
- Mean execution time with confidence intervals
- Throughput measurements
- Performance trends over time
- Statistical analysis

## Performance Comparison

Each benchmark measures equivalent operations across different frameworks, allowing direct comparison of:
- **Execution time** - How long each operation takes
- **Throughput** - How many operations per second
- **Memory usage** - Resource consumption patterns
- **Scalability** - Performance with different data sizes

## Framework-Specific Notes

### Hydroflow
- Uses `dfir_syntax!` macro for dataflow graph definition
- Typically runs with `run_available_sync()` or `run_available()`
- Optimized for push-based execution

### Timely Dataflow
- Uses `timely::example()` or `timely::execute_directly()`
- Timestamp-based coordination
- Optimized for streaming data

### Differential Dataflow
- Built on top of Timely Dataflow
- Uses collections with efficient change propagation
- Best for iterative and incremental computations

## Tips for Accurate Benchmarking

1. **Minimize background processes** - Close unnecessary applications
2. **Consistent CPU state** - Consider disabling CPU frequency scaling
3. **Multiple runs** - Criterion automatically handles this
4. **Baseline comparison** - Use `--save-baseline` and `--baseline` flags
5. **Sample size** - Adjust with `--sample-size` for faster development iterations

Example:
```bash
# Save baseline
cargo bench -p hydro-timely-differential-benchmarks -- --save-baseline initial

# Compare against baseline
cargo bench -p hydro-timely-differential-benchmarks -- --baseline initial
```

## Adding New Benchmarks

See the main README.md for detailed instructions on adding new benchmarks to this suite.
