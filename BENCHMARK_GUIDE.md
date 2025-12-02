# Benchmark Guide

This guide provides detailed information about running and interpreting benchmarks in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Overview

The benchmarks in this repository compare Hydro implementations with timely-dataflow and differential-dataflow implementations across various computational patterns and workloads.

## Benchmark Categories

### Micro-Benchmarks

Small, focused benchmarks that test specific operations:

- **arithmetic** - Basic arithmetic operations (addition, multiplication, etc.)
- **identity** - Pass-through operations with no transformation
- **upcase** - Simple string transformation operations

### Pattern Benchmarks

Test common dataflow patterns:

- **fan_in** - Multiple sources merging into a single destination
- **fan_out** - Single source splitting to multiple destinations
- **fork_join** - Parallel processing with synchronization
- **join** - Relational join operations
- **symmetric_hash_join** - Optimized join using hash-based approach

### Application Benchmarks

More complex, realistic workloads:

- **reachability** - Graph reachability computation
- **words_diamond** - Complex diamond-shaped dataflow pattern
- **futures** - Async/await pattern benchmarks

### Protocol Benchmarks

Distributed protocol implementations (in `hydro_test_benches/`):

- **paxos_bench** - Paxos consensus protocol performance
- **two_pc_bench** - Two-phase commit protocol performance

## Running Benchmarks

### Basic Usage

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench arithmetic

# Run benchmarks with verbose output
cargo bench -p benches -- --verbose
```

### Advanced Options

```bash
# Save baseline for comparison
cargo bench -p benches -- --save-baseline my-baseline

# Compare against baseline
cargo bench -p benches -- --baseline my-baseline

# Run only specific tests within a benchmark
cargo bench -p benches --bench arithmetic -- filter_pattern

# Profile a benchmark
cargo bench -p benches --bench arithmetic -- --profile-time=10
```

## Interpreting Results

### Output Format

Criterion produces output in the following format:

```
benchmark_name          time:   [123.45 µs 125.67 µs 127.89 µs]
                        thrpt:  [7.82 Melem/s 7.96 Melem/s 8.10 Melem/s]
```

- **time** shows the measured execution time (lower bound, estimate, upper bound)
- **thrpt** shows throughput when applicable (higher is better)

### Statistical Significance

Criterion uses statistical analysis to determine if performance changes are significant:

- **No change** - Performance is within noise margins
- **Improved/Regressed** - Statistically significant change detected
- The confidence intervals (95% by default) help determine reliability

### Comparison Mode

When comparing against a baseline:

```
benchmark_name          time:   [125.67 µs 127.89 µs 130.12 µs]
                        change: [-5.2% -2.3% +0.8%]
```

The **change** line shows the percentage difference from the baseline.

## Benchmark-Specific Notes

### Reachability

The reachability benchmark uses graph data files:
- `benches/reachability_edges.txt` - Graph edge list
- `benches/reachability_reachable.txt` - Expected reachable nodes

Modify these files to test different graph sizes and structures.

### Words Diamond

Uses a word list from `benches/words_alpha.txt`. The diamond pattern:
1. Splits the word stream
2. Applies different transformations in parallel
3. Joins the results back together

### Protocol Benchmarks

Paxos and Two-PC benchmarks are reference implementations showing:
- Throughput under normal operation
- Latency characteristics
- Scalability with number of replicas/participants

## Performance Optimization Tips

### Before Benchmarking

1. **Disable CPU frequency scaling:**
   ```bash
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```

2. **Close unnecessary applications** to reduce noise

3. **Run on a quiet system** without competing workloads

### Analyzing Variance

High variance in results may indicate:
- System load from other processes
- Thermal throttling
- Non-deterministic behavior in the code

Use `--sample-size` and `--measurement-time` to adjust statistical confidence.

## Creating New Benchmarks

### Template

```rust
use criterion::{criterion_group, criterion_main, Criterion, BenchmarkId};

fn my_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("my_group");
    
    for size in [100, 1000, 10000] {
        group.bench_with_input(
            BenchmarkId::new("my_test", size),
            &size,
            |b, &size| {
                b.iter(|| {
                    // Benchmark code here
                });
            }
        );
    }
    
    group.finish();
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

### Adding to Cargo.toml

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

## Comparing with Main Repository

### Cross-Repository Performance Comparison

This repository exists specifically to enable comparisons between Hydro implementations and timely/differential-dataflow implementations. Here's how to perform systematic comparisons:

#### 1. Set Up Comparison Environment

Ensure both repositories are cloned as siblings and up-to-date:

```bash
cd /path/to/parent-directory
git -C bigweaver-agent-canary-hydro-zeta pull
git -C bigweaver-agent-canary-zeta-hydro-deps pull
```

#### 2. Capture Timely/Differential Baselines

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks and save baseline
cargo bench -p benches -- --save-baseline timely-baseline

# Or run specific categories
cargo bench -p benches --bench arithmetic -- --save-baseline timely-baseline
cargo bench -p benches --bench reachability -- --save-baseline timely-baseline
cargo bench -p benches --bench join -- --save-baseline timely-baseline
```

#### 3. Run Hydro Benchmarks

```bash
cd ../bigweaver-agent-canary-hydro-zeta

# Check what benchmarks are available
cargo bench --help

# Run comparable Hydro benchmarks
cargo bench -p dfir_rs
cargo bench -p hydro_lang
```

#### 4. Analyze Comparison Results

**Automated Comparison:**
Criterion stores results in `target/criterion/<benchmark-name>/`. Compare HTML reports:
- Timely/Differential: `bigweaver-agent-canary-zeta-hydro-deps/target/criterion/<bench>/report/index.html`
- Hydro: `bigweaver-agent-canary-hydro-zeta/target/criterion/<bench>/report/index.html`

**Manual Comparison:**
Create a comparison table:

| Benchmark | Timely/DD Time | Hydro Time | Difference | Notes |
|-----------|---------------|-----------|-----------|-------|
| arithmetic | 125 µs | 130 µs | +4% | Similar performance |
| reachability | 45 ms | 42 ms | -7% | Hydro faster |
| join | 890 µs | 920 µs | +3% | Within margin |

**Statistical Analysis:**
- Compare confidence intervals (95% by default)
- Check for overlapping confidence intervals (indicates no significant difference)
- Note variance levels (high variance may indicate unstable benchmarks)

#### 5. Key Metrics to Compare

- **Execution Time**: Raw wall-clock time for operations
- **Throughput**: Elements processed per second
- **Memory Usage**: Heap allocations and peak memory
- **Scalability**: Performance trends as input size increases
- **Latency Distribution**: p50, p95, p99 percentiles

#### 6. Understanding Performance Differences

**When Timely/Differential is Faster:**
- Lower-level optimizations in the dataflow engine
- Highly optimized differential computation
- Mature compiler optimizations

**When Hydro is Faster:**
- Higher-level abstractions reduce overhead
- Better optimization for specific patterns
- Reduced coordination in distributed scenarios

**When Performance is Similar:**
- Both implementations are effectively optimized
- Bottleneck is in external factors (I/O, network)
- Similar underlying algorithms

#### 7. Documenting Comparison Results

Create a performance comparison report with:

```markdown
# Performance Comparison: Hydro vs Timely/Differential

**Date**: YYYY-MM-DD
**Environment**: [CPU model, RAM, OS, Rust version]
**Repository Commits**: 
- Hydro: [commit hash]
- Hydro-deps: [commit hash]

## Results Summary

[Overall findings]

## Detailed Results

### Benchmark: [Name]

**Configuration**: [Input size, parameters]

**Timely/Differential**:
- Time: X µs ± Y µs
- Throughput: Z ops/sec

**Hydro**:
- Time: X µs ± Y µs
- Throughput: Z ops/sec

**Analysis**: [Explanation of differences]

## Conclusions

[Key takeaways for performance optimization]
```

### Example: Comparing Reachability Benchmark

```bash
# Run timely/differential version
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches --bench reachability -- --save-baseline timely

# Run Hydro version (if available)
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p dfir_rs --bench reachability_hydro -- --save-baseline hydro

# Compare results
# Check both target/criterion/reachability directories
# Note: Graph structure from reachability_edges.txt affects results

# Document findings
echo "Reachability (10K edges):"
echo "  Timely: See bigweaver-agent-canary-zeta-hydro-deps/target/criterion/..."
echo "  Hydro: See bigweaver-agent-canary-hydro-zeta/target/criterion/..."
```

## Continuous Performance Testing

### Baseline Management

Create baselines for tracking performance over time:

```bash
# Create baseline before changes
cargo bench -p benches -- --save-baseline before

# Make code changes...

# Compare after changes
cargo bench -p benches -- --baseline before
```

### CI Integration

Recommended CI workflow:
1. Run benchmarks on stable baseline
2. Run benchmarks on PR branch
3. Compare results
4. Flag significant regressions

### Cross-Repository CI Comparisons

For comprehensive performance monitoring:
1. Schedule periodic runs of benchmarks in both repositories
2. Store results in a centralized location
3. Generate trend reports showing performance over time
4. Alert on regressions that exceed threshold (e.g., >10% slowdown)

## Troubleshooting

### "Could not find dfir_rs"

Ensure the main repository is cloned as a sibling:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Compilation Errors

1. Check that the main repository is on a compatible commit
2. Verify rust-toolchain version matches
3. Clean and rebuild: `cargo clean && cargo bench`

### Inconsistent Results

1. Check for system load
2. Increase sample size: `cargo bench -- --sample-size 200`
3. Increase warmup: `cargo bench -- --warm-up-time 5`

## Resources

- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- Main Repository Documentation

## Contributing

When adding new benchmarks:
1. Follow existing naming conventions
2. Include documentation in comments
3. Add entry to this guide
4. Provide baseline results for reference
5. Consider statistical significance of the benchmark

## Contact

For questions about benchmarks:
- Check this guide and benches/README.md
- Review the main repository's CONTRIBUTING.md
- Consult with the Performance Engineering team
