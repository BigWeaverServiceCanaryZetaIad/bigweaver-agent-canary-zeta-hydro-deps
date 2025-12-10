# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that depend on timely and differential-dataflow. These were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid unnecessary dependencies.

## Benchmarks

### Timely Benchmarks
- **arithmetic.rs** - Benchmark for arithmetic operations using timely dataflow
- **fan_in.rs** - Benchmark for fan-in patterns (multiple inputs converging)
- **fan_out.rs** - Benchmark for fan-out patterns (single input to multiple outputs)
- **fork_join.rs** - Benchmark for fork-join parallel patterns
- **identity.rs** - Benchmark for identity/passthrough operations
- **join.rs** - Benchmark for join operations
- **upcase.rs** - Benchmark for string uppercase transformations

### Differential Dataflow Benchmarks
- **reachability.rs** - Graph reachability computation benchmark
  - Data files:
    - `reachability_edges.txt` - Graph edges for the benchmark
    - `reachability_reachable.txt` - Expected reachable nodes

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

Run benchmarks with filtering:
```bash
cargo bench -- <filter>
```

## Viewing Results

After running benchmarks, results are available in:
- `../target/criterion/` - Raw benchmark data
- `../target/criterion/report/index.html` - HTML report (open in browser)

## Performance Comparison

To compare with benchmarks in the main repository:

1. Run these benchmarks and note the results
2. Run the main repository benchmarks:
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```
3. Both use criterion with the same configuration for consistent comparisons
