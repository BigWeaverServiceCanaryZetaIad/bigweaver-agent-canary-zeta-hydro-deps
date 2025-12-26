# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing DFIR (Hydroflow) performance against Timely Dataflow and Differential Dataflow frameworks.

## Purpose

This repository was created to isolate timely and differential-dataflow dependencies from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository while retaining the ability to run performance comparisons.

## Structure

- `benches/`: Contains benchmark implementations comparing DFIR with Timely and Differential Dataflow

## Running Performance Comparisons

### Prerequisites

Ensure you have Rust installed with cargo.

### Running Benchmarks

To run all benchmarks:

```bash
cd benches
cargo bench
```

To run a specific benchmark:

```bash
cd benches
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern
- `fork_join` - Fork-join pattern
- `identity` - Identity operation
- `join` - Join operations with different value types
- `reachability` - Graph reachability algorithms
- `upcase` - String transformation operations

### Benchmark Output

Benchmarks use Criterion, which provides:
- Statistical analysis of performance
- HTML reports in `benches/target/criterion/`
- Comparison with previous runs

### Comparing with Main Repository

To compare DFIR performance against these Timely/Differential benchmarks:

1. Run benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench
   ```

2. Review the results in the Criterion HTML reports or console output

3. The benchmarks include multiple implementations (Timely, Differential, and DFIR) for direct comparison

## Dependencies

This repository maintains dependencies on:
- `timely-master` (0.13.0-dev.1)
- `differential-dataflow-master` (0.13.0-dev.1)
- `dfir_rs` (from main hydro repository)
- `criterion` for benchmarking

These dependencies are kept separate from the main repository to avoid dependency pollution while maintaining performance comparison capabilities.