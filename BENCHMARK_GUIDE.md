# Benchmark Guide

This guide explains how to use the benchmarks in this repository for performance testing and comparison.

## Overview

This repository contains benchmarks that were migrated from the main Hydro repository to reduce compilation time for core development. The benchmarks use Criterion for performance measurement and compare Hydro implementations against timely-dataflow and differential-dataflow.

## Setup

### Prerequisites
1. Clone both repositories as siblings:
   ```bash
   parent-directory/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. Ensure you have the correct Rust toolchain installed (see main repository for version)

### Repository Dependencies
The benchmarks depend on crates from the main repository:
- `dfir_rs` - Hydro's dataflow runtime
- `sinktools` - Sink utilities

These are referenced via path dependencies in `benches/Cargo.toml`.

## Running Benchmarks

### Basic Usage

Run all benchmarks:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

### Benchmark Categories

#### 1. Micro-Operations (`micro_ops.rs`)
Tests basic operations like:
- Stream filtering
- Stream mapping
- Data aggregation

```bash
cargo bench -p benches --bench micro_ops
```

#### 2. Dataflow Patterns

**Fan-In Pattern** (`fan_in.rs`):
```bash
cargo bench -p benches --bench fan_in
```

**Fan-Out Pattern** (`fan_out.rs`):
```bash
cargo bench -p benches --bench fan_out
```

**Fork-Join Pattern** (`fork_join.rs`):
```bash
cargo bench -p benches --bench fork_join
```

**Diamond Pattern** (`words_diamond.rs`):
```bash
cargo bench -p benches --bench words_diamond
```

#### 3. Join Operations

**Basic Join** (`join.rs`):
```bash
cargo bench -p benches --bench join
```

**Symmetric Hash Join** (`symmetric_hash_join.rs`):
```bash
cargo bench -p benches --bench symmetric_hash_join
```

#### 4. Graph Algorithms

**Reachability** (`reachability.rs`):
Tests graph reachability computation using different approaches.
```bash
cargo bench -p benches --bench reachability
```

#### 5. Arithmetic Operations (`arithmetic.rs`)
Tests numerical computations and aggregations.
```bash
cargo bench -p benches --bench arithmetic
```

#### 6. String Operations (`upcase.rs`)
Tests string transformations.
```bash
cargo bench -p benches --bench upcase
```

#### 7. Identity Operations (`identity.rs`)
Baseline benchmarks for pass-through operations.
```bash
cargo bench -p benches --bench identity
```

#### 8. Async/Futures (`futures.rs`)
Tests async operations and future handling.
```bash
cargo bench -p benches --bench futures
```

## Understanding Results

### Criterion Output
Criterion provides:
- **Time measurements**: Mean, median, standard deviation
- **Throughput**: Operations per second
- **Regression detection**: Comparison with previous runs
- **HTML reports**: Located in `target/criterion/`

### Viewing HTML Reports
After running benchmarks, view detailed reports:
```bash
open target/criterion/report/index.html
```

### Comparing Results
Criterion automatically compares with baseline results from previous runs. To save a new baseline:
```bash
cargo bench -p benches -- --save-baseline my-baseline
```

To compare against a saved baseline:
```bash
cargo bench -p benches -- --baseline my-baseline
```

## Benchmark Data Files

Some benchmarks use data files located in `benches/benches/`:

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - English word list for text processing benchmarks (from https://github.com/dwyl/english-words)

## Performance Comparison

These benchmarks compare three implementations:
1. **Hydro (dfir_rs)** - Our optimized dataflow runtime
2. **Timely Dataflow** - Reference timely-dataflow implementation
3. **Differential Dataflow** - Reference differential-dataflow implementation

### Interpreting Comparisons
- Lower times indicate better performance
- Check throughput for data-intensive operations
- Consider memory usage alongside time measurements

## Troubleshooting

### Compilation Errors

**Missing dependencies**: Ensure the main repository is cloned as a sibling:
```bash
ls -l ../bigweaver-agent-canary-hydro-zeta
```

**Version mismatches**: Update both repositories to compatible versions.

### Performance Issues

**Noisy results**: Run benchmarks on a quiet system:
```bash
# Close other applications
# Disable CPU frequency scaling if possible
cargo bench -p benches
```

**Inconsistent results**: Increase sample size in benchmark code or run multiple times.

## Modifying Benchmarks

### Adding a New Benchmark

1. Create a new file in `benches/benches/`, e.g., `my_benchmark.rs`
2. Add benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Implement using Criterion:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_test", |b| {
           b.iter(|| {
               // Your benchmark code
           })
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

### Best Practices

1. **Use realistic data sizes**: Match production workloads
2. **Warm up properly**: Let JIT compilation stabilize
3. **Minimize noise**: Avoid I/O and system calls in hot paths
4. **Document assumptions**: Note any benchmark-specific optimizations
5. **Version control results**: Save baselines for important releases

## Hydro Test Benchmarks

The `hydro_test_benches/` directory contains cluster benchmarks:

- `paxos_bench.rs` - Paxos consensus protocol performance
- `two_pc_bench.rs` - Two-phase commit protocol performance

These benchmarks use `hydro_std::bench_client` and are designed for distributed testing scenarios.

## CI/CD Integration

To integrate these benchmarks into CI/CD:

1. Run benchmarks as part of performance testing pipeline
2. Compare against saved baselines
3. Fail builds if performance regresses beyond threshold
4. Archive HTML reports as artifacts

Example CI command:
```bash
cargo bench -p benches -- --save-baseline ci-baseline
```

## Contributing

When adding or modifying benchmarks:

1. Ensure benchmarks are reproducible
2. Document what is being measured
3. Include both Hydro and comparison implementations
4. Update this guide with new benchmarks
5. Run full benchmark suite before submitting PRs

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- Main Hydro repository documentation

## Migration History

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository on 2025-11-30 to:
- Reduce compilation time for core development
- Separate heavyweight dependencies (timely, differential-dataflow)
- Maintain clean separation between core functionality and performance testing

For migration details, see the main repository's documentation.
