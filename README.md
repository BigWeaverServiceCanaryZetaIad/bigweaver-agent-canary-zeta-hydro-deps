# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow that were moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid unnecessary dependencies.

## Purpose

This repository maintains performance benchmarks for:
- **Timely dataflow** operations
- **Differential dataflow** operations
- Performance comparisons with dfir_rs implementations

These benchmarks allow for performance comparison and regression testing without requiring timely/differential-dataflow dependencies in the main repository.

## Available Benchmarks

### Timely Dataflow Benchmarks
- `arithmetic.rs` - Arithmetic operations pipeline
- `fan_in.rs` - Fan-in dataflow pattern
- `fan_out.rs` - Fan-out dataflow pattern
- `fork_join.rs` - Fork-join pattern
- `identity.rs` - Identity transformation
- `upcase.rs` - String uppercase transformation

### Differential Dataflow Benchmarks
- `join.rs` - Join operations (uses timely + differential-dataflow)
- `reachability.rs` - Graph reachability computation

## Running the Benchmarks

### Prerequisites

Ensure you have Rust installed and the bigweaver-agent-canary-hydro-zeta repository available as a sibling directory, as the benchmarks depend on `dfir_rs` and `sinktools` from that repository.

### Run All Benchmarks

```bash
cargo bench
```

### Run a Specific Benchmark

```bash
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

### Run Benchmarks with Filters

To run specific tests within a benchmark:

```bash
cargo bench --bench arithmetic -- timely
cargo bench --bench join -- dfir_rs
```

## Benchmark Results

Benchmark results are stored in the `target/criterion` directory and include:
- HTML reports with visualizations
- Historical performance data for comparison
- Statistical analysis of performance metrics

To view HTML reports, open `target/criterion/report/index.html` in a web browser.

## Dependencies

The benchmarks use the following key dependencies:
- `timely-master` (0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow framework
- `criterion` (0.5.0) - Benchmarking framework with async support
- `dfir_rs` - From the main bigweaver-agent-canary-hydro-zeta repository
- `sinktools` - From the main bigweaver-agent-canary-hydro-zeta repository

## Integration with Main Repository

These benchmarks are maintained separately to:
1. Avoid dependency bloat in the main repository
2. Allow independent performance testing
3. Maintain historical performance comparisons
4. Enable CI/CD performance regression testing

When making changes to dfir_rs that might affect performance, run these benchmarks to verify there are no regressions compared to timely/differential-dataflow implementations.