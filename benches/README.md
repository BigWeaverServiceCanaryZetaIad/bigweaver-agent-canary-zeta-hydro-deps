# Timely and Differential-Dataflow Benchmarks

Comparative microbenchmarks for timely-dataflow and differential-dataflow implementations versus Hydro/DFIR implementations.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench upcase
```

## Benchmark Descriptions

### arithmetic
Tests arithmetic operation pipelines with multiple sequential operations. Compares:
- Timely dataflow
- Channel-based pipeline
- Iterator-based processing
- Raw vector operations
- Hydroflow compiled and surface syntax

### fan_in
Measures fan-in patterns where multiple input streams merge into one. Compares:
- Timely dataflow
- Hydroflow implementations

### fan_out
Measures fan-out patterns where one stream splits to multiple outputs. Compares:
- Timely dataflow  
- Hydroflow implementations

### fork_join
Tests fork-join parallelism patterns. Compares:
- Timely dataflow
- Hydroflow implementations

### identity
Simple passthrough/identity operations to measure overhead. Compares:
- Timely dataflow
- Channel-based pipeline
- Iterator processing
- Hydroflow implementations

### join
Stream join operations. Compares:
- Timely dataflow
- Hydroflow implementations

### reachability
Graph reachability computation using differential dataflow. Tests:
- Differential dataflow iterative computation
- Uses test data from reachability_edges.txt and reachability_reachable.txt

### upcase
String transformation benchmarks (uppercase conversion). Compares:
- Timely dataflow
- Hydroflow implementations

## Data Files

- **reachability_edges.txt** - Graph edge data for reachability benchmark
- **reachability_reachable.txt** - Expected reachability results for validation

## Dependencies

These benchmarks require:
- `timely` (timely-master) - Core timely dataflow
- `differential-dataflow` (differential-dataflow-master) - Differential dataflow
- `dfir_rs` - Hydroflow implementation (referenced from main repository)
- `criterion` - Benchmarking harness
- Various utility crates (static_assertions, rand, tokio, etc.)

## Understanding Results

Criterion will generate HTML reports in `target/criterion/` showing:
- Mean execution time with confidence intervals
- Performance comparison across implementations
- Historical performance trends (if run multiple times)
- Detailed statistical analysis

Lower execution times indicate better performance. Pay attention to the comparison percentages to understand relative performance differences between implementations.
