# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that depend on timely and differential-dataflow. These benchmarks have been moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies.

## Benchmarks

### Timely Benchmarks

- **arithmetic.rs** - Pipeline benchmark with arithmetic operations using timely
- **fan_in.rs** - Fan-in pattern benchmark using timely
- **fan_out.rs** - Fan-out pattern benchmark using timely
- **fork_join.rs** - Fork-join pattern benchmark using timely
- **identity.rs** - Identity/passthrough benchmark using timely
- **join.rs** - Join operation benchmark using timely
- **upcase.rs** - String manipulation benchmark using timely

### Differential-Dataflow Benchmarks

- **reachability.rs** - Graph reachability benchmark using differential-dataflow
  - Uses `reachability_edges.txt` - Graph edges data
  - Uses `reachability_reachable.txt` - Expected reachable nodes

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:

```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

## Benchmark Results

Benchmark results are stored in `target/criterion/` and include:
- HTML reports with detailed performance metrics
- Historical comparison data for tracking performance over time
- Statistical analysis of benchmark runs

## Performance Comparisons

To compare performance with the main repository's benchmarks (which use dfir_rs):

1. Run benchmarks in this repository: `cargo bench`
2. Run benchmarks in bigweaver-agent-canary-hydro-zeta: `cd ../bigweaver-agent-canary-hydro-zeta && cargo bench -p benches`
3. Compare results from `target/criterion/` in each repository
4. Use criterion's HTML reports for detailed comparisons

Both repositories use the same criterion version and configuration for consistency.

## Dependencies

This benchmark suite depends on:

- **timely** (timely-master v0.13.0-dev.1) - Dataflow framework
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1) - Incremental computation framework
- **criterion** (v0.5.0) - Benchmarking framework
- **dfir_rs** - From the main repository (for comparison purposes)

## Related

For benchmarks that don't depend on timely or differential-dataflow, see the main repository's benches package.
