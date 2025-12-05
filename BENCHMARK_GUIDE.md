# Hydro Benchmarks Guide

## Introduction

This repository contains performance benchmarks for Hydro, comparing it with timely-dataflow and differential-dataflow. The benchmarks help track performance improvements and identify optimization opportunities.

## Prerequisites

- Rust toolchain (specified by rust-toolchain.toml in the main Hydro repository)
- Access to the main Hydro repository at `../bigweaver-agent-canary-hydro-zeta`

## Quick Start

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench reachability
```

Run with verbose output:
```bash
cargo bench -- --verbose
```

## Available Benchmarks

### Core Operation Benchmarks

#### arithmetic
Tests basic arithmetic operations and numeric processing.
```bash
cargo bench --bench arithmetic
```

#### identity
Measures the overhead of identity operations (pass-through).
```bash
cargo bench --bench identity
```

#### micro_ops
Fine-grained micro-benchmarks of individual operations.
```bash
cargo bench --bench micro_ops
```

### Pattern Benchmarks

#### fan_in
Tests the fan-in pattern where multiple streams merge into one.
```bash
cargo bench --bench fan_in
```

#### fan_out
Tests the fan-out pattern where one stream splits into multiple.
```bash
cargo bench --bench fan_out
```

#### fork_join
Tests the fork-join pattern combining fan-out and fan-in.
```bash
cargo bench --bench fork_join
```

### Join Operation Benchmarks

#### join
Basic join operation benchmarks.
```bash
cargo bench --bench join
```

#### symmetric_hash_join
Symmetric hash join implementation benchmark.
```bash
cargo bench --bench symmetric_hash_join
```

### Graph and Complex Benchmarks

#### reachability
Graph reachability benchmark comparing Hydro with differential-dataflow.
This is one of the most important benchmarks as it directly compares performance with differential-dataflow.
```bash
cargo bench --bench reachability
```

#### words_diamond
Diamond pattern word processing benchmark using real word data.
```bash
cargo bench --bench words_diamond
```

### Async Benchmarks

#### futures
Tests futures-based asynchronous operations.
```bash
cargo bench --bench futures
```

#### upcase
String transformation benchmark with async operations.
```bash
cargo bench --bench upcase
```

## Understanding Results

Criterion produces detailed HTML reports in `target/criterion/`. After running benchmarks, open:
```bash
open target/criterion/report/index.html
```

### Key Metrics

- **Mean time**: Average execution time
- **Std dev**: Standard deviation of execution times
- **Median**: Median execution time
- **Throughput**: Operations per second (where applicable)

### Comparing with Baselines

Criterion automatically compares with previous runs. Look for:
- **Improvement**: Performance got better (lower times)
- **Regression**: Performance got worse (higher times)
- **No change**: Performance is similar

## Advanced Usage

### Running Specific Tests

Run tests matching a pattern:
```bash
cargo bench -- reachability/dfir
```

### Generating Flamegraphs

To generate flamegraphs for profiling:
```bash
cargo bench --bench reachability -- --profile-time=10
```

### Customizing Benchmark Duration

```bash
cargo bench -- --measurement-time=30
```

### Saving Baseline

Save current results as baseline:
```bash
cargo bench -- --save-baseline my-baseline
```

Compare with baseline:
```bash
cargo bench -- --baseline my-baseline
```

## Benchmark Data Files

### reachability_edges.txt
Graph edges for the reachability benchmark (532KB).

### reachability_reachable.txt
Expected reachable nodes for validation (39KB).

### words_alpha.txt
English word list from dwyl/english-words (3.7MB).
Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Continuous Integration

Benchmarks can be run in CI to track performance over time. The HTML reports can be published to track historical performance trends.

## Troubleshooting

### Build Errors

If you get build errors about missing dependencies:
1. Ensure the main Hydro repository is at `../bigweaver-agent-canary-hydro-zeta`
2. Check that dfir_rs and sinktools are available in the main repository

### Performance Variations

Benchmarks can be affected by:
- System load (close other applications)
- CPU frequency scaling (use performance governor)
- Background processes
- Thermal throttling

For consistent results:
```bash
# Linux: Set CPU governor to performance
sudo cpupower frequency-set -g performance

# Run benchmarks
cargo bench

# Restore previous governor
sudo cpupower frequency-set -g powersave
```

## Adding New Benchmarks

1. Create a new `.rs` file in `benches/`
2. Add a `[[bench]]` section to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Use criterion's benchmark macro:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_test", |b| b.iter(|| {
           // benchmark code
       }));
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Hydro Documentation](https://hydro.run)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
