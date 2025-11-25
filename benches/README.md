# Timely and Differential-Dataflow Benchmarks

This directory contains performance benchmarks comparing timely, differential-dataflow, and hydro (dfir_rs) dataflow implementations.

## Overview

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a cleaner dependency structure. They provide performance comparisons between different dataflow processing frameworks.

## Benchmarks

### Timely Dataflow Benchmarks

#### arithmetic.rs
Compares arithmetic operation performance across different implementations:
- **Pipeline approach**: Using channels and threads
- **Raw copy**: Minimal overhead baseline
- **Timely dataflow**: Using timely's operators
- **Hydro (dfir_rs)**: Using hydro's dataflow implementation

Operations: Chain of 20 arithmetic operations on 1,000,000 integers

#### identity.rs
Tests identity (pass-through) operations to measure framework overhead:
- **Pipeline approach**: Channel-based communication
- **Raw copy**: Baseline with minimal overhead
- **Timely dataflow**: Identity operation in timely
- **Hydro (dfir_rs)**: Identity in hydro

Operations: 20 identity operations on 1,000,000 integers

#### fan_in.rs
Tests multiple input stream convergence patterns:
- **Timely dataflow**: Concatenate operator performance
- **Hydro (dfir_rs)**: Union operator performance

Pattern: Multiple streams merging into one

#### fan_out.rs
Tests single input to multiple output stream patterns:
- **Timely dataflow**: Broadcasting to multiple outputs
- **Hydro (dfir_rs)**: Tee operator for stream duplication

Pattern: One stream splitting into multiple outputs

#### fork_join.rs
Complex dataflow pattern with branching and joining:
- **Timely dataflow**: Filter and concatenate operations
- **Hydro (dfir_rs)**: Dynamic graph construction with filters

Pattern: Stream splits, filters, and rejoins multiple times

### Differential Dataflow Benchmarks

#### join.rs
Tests join operation performance:
- **Timely dataflow**: Using timely's join operator
- **Hydro (dfir_rs)**: Using hydro's join implementation

Operations: Joining two data streams with matching keys

#### upcase.rs
String transformation benchmarks:
- **Timely dataflow**: Map operator for string transformation
- **Hydro (dfir_rs)**: Map operator in hydro

Operations: Converting strings to uppercase

#### reachability.rs
Graph reachability analysis:
- **Differential dataflow**: Using iterate, join, and threshold operators
- **Hydro (dfir_rs)**: Recursive graph traversal

Data: Uses `reachability_edges.txt` and `reachability_reachable.txt`

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench
```

### Run a specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench identity
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench join
cargo bench --bench upcase
cargo bench --bench reachability
```

### Run with specific filters:
```bash
# Run only timely benchmarks
cargo bench --bench arithmetic -- timely

# Run only hydro benchmarks
cargo bench --bench arithmetic -- dfir
```

## Benchmark Results

Results are saved in `target/criterion/` directory with:
- HTML reports for visualization
- Detailed statistical analysis
- Historical comparisons (when run multiple times)

To view HTML reports:
```bash
open target/criterion/report/index.html
```

## Data Files

- **reachability_edges.txt** (521 KB): Edge list for graph reachability benchmark
- **reachability_reachable.txt** (38 KB): Expected reachable nodes for verification

## Dependencies

Key dependencies for these benchmarks:
- `timely = { package = "timely-master", version = "0.13.0-dev.1" }`
- `differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }`
- `dfir_rs` - Hydro dataflow implementation
- `criterion` - Benchmarking framework

## Build Configuration

A `build.rs` script generates optimized benchmark code for the fork_join benchmark, creating a dynamic graph structure based on the `NUM_OPS` constant.

## Performance Notes

- All benchmarks use `criterion` for accurate statistical measurement
- Benchmarks include warmup phases to ensure consistent results
- Results include confidence intervals and outlier detection
- Comparison between frameworks helps identify performance characteristics

## Migration Information

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta/benches` to improve:
1. Repository organization
2. Build times (by isolating external dependencies)
3. Dependency management
4. Separation of concerns

For detailed migration information, see the main repository's `BENCHMARK_REMOVAL_COMPLETED.md` file.

## Contributing

When adding new benchmarks:
1. Follow the existing naming conventions
2. Include multiple implementation comparisons when relevant
3. Add documentation describing the benchmark purpose
4. Update this README with benchmark details
5. Ensure benchmarks use `harness = false` in Cargo.toml

## Related Documentation

- Main repository: `bigweaver-agent-canary-hydro-zeta`
- Timely dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential dataflow: https://github.com/TimelyDataflow/differential-dataflow
