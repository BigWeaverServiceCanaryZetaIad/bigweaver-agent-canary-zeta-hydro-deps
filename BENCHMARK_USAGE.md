# Benchmark Usage Guide

## Overview

This repository contains comprehensive benchmarks comparing DFIR (Dataflow Intermediate Representation) performance with timely-dataflow and differential-dataflow implementations. This guide explains how to run, interpret, and integrate these benchmarks with the main Hydro repository.

## Quick Start

### Running All Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Running Specific Benchmark Categories

```bash
# Arithmetic operations
cargo bench --bench arithmetic

# Graph algorithms
cargo bench --bench reachability

# Join operations
cargo bench --bench join

# Dataflow patterns
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join

# Simple transformations
cargo bench --bench identity
cargo bench --bench upcase
```

### Running Specific Benchmark Functions

```bash
# Run only DFIR variants of arithmetic benchmarks
cargo bench --bench arithmetic dfir

# Run only Timely variants
cargo bench --bench arithmetic timely

# Run only Differential variants
cargo bench --bench arithmetic differential
```

## Benchmark Details

### Arithmetic Benchmarks (`arithmetic.rs`)

**Purpose**: Compare basic arithmetic operation performance across different dataflow implementations.

**Implementations Compared**:
- `arithmetic/pipeline` - Multi-threaded channel-based pipeline
- `arithmetic/raw` - Raw single-threaded iteration (baseline)
- `arithmetic/dfir_compiled` - Compiled DFIR dataflow
- `arithmetic/timely` - Timely dataflow implementation
- `arithmetic/differential` - Differential dataflow implementation

**Parameters**:
- Operations: 20 sequential additions
- Input size: 1,000,000 integers

**What to Look For**:
- DFIR compiled performance vs. Timely
- Overhead comparison against raw iteration baseline
- Multi-threaded pipeline behavior

### Reachability Benchmarks (`reachability.rs`)

**Purpose**: Compare graph transitive closure computation performance.

**Implementations Compared**:
- `reachability/dfir/compiled` - DFIR implementation
- `reachability/differential` - Differential dataflow implementation

**Data**:
- Graph edges: `reachability_edges.txt` (5,394 edges)
- Expected results: `reachability_reachable.txt` (41,652 reachable pairs)

**What to Look For**:
- Iterative computation performance
- Fixed-point detection efficiency
- Memory usage patterns (not directly measured but observable)

### Join Benchmarks (`join.rs`)

**Purpose**: Compare relational join operation performance.

**Implementations Compared**:
- `join/dfir_symmetric_hash_join` - DFIR symmetric hash join
- `join/timely` - Timely dataflow join
- `join/differential` - Differential dataflow join

**Parameters**:
- LHS records: 1,000
- RHS records: 1,000
- Join result size varies based on key distribution

**What to Look For**:
- Join algorithm efficiency
- Hash table performance
- Stream synchronization overhead

### Fan-In Benchmarks (`fan_in.rs`)

**Purpose**: Test multiple-input stream merge performance.

**Implementations Compared**:
- `fan_in/dfir/1` through `fan_in/dfir/9` - DFIR with 1-9 input streams
- `fan_in/timely/1` through `fan_in/timely/9` - Timely with 1-9 input streams

**Parameters**:
- Stream count: 1, 3, 5, 7, 9
- Elements per stream: 100,000

**What to Look For**:
- Scaling behavior with increasing input streams
- Merge operation overhead
- Fairness in stream consumption

### Fan-Out Benchmarks (`fan_out.rs`)

**Purpose**: Test single-to-multiple stream distribution performance.

**Implementations Compared**:
- `fan_out/dfir/1` through `fan_out/dfir/9` - DFIR with 1-9 output streams
- `fan_out/timely/1` through `fan_out/timely/9` - Timely with 1-9 output streams

**Parameters**:
- Stream count: 1, 3, 5, 7, 9
- Total elements: 100,000

**What to Look For**:
- Broadcast/multicast efficiency
- Scaling behavior with increasing outputs
- Cloning overhead (if applicable)

### Fork-Join Benchmarks (`fork_join.rs`)

**Purpose**: Test parallel computation with synchronization patterns.

**Implementations Compared**:
- `fork_join/dfir/compiled` - DFIR fork-join pattern
- `fork_join/timely` - Timely dataflow fork-join

**Parameters**:
- Fork factor: Multiple parallel branches
- Synchronization point at join

**What to Look For**:
- Parallel execution efficiency
- Synchronization overhead
- Load balancing

### Identity Benchmarks (`identity.rs`)

**Purpose**: Measure minimal dataflow overhead with pass-through operations.

**Implementations Compared**:
- `identity/dfir_vec/1` through `identity/dfir_vec/64` - DFIR with varying depths
- `identity/timely/1` through `identity/timely/64` - Timely with varying depths

**Parameters**:
- Pipeline depth: 1, 4, 16, 32, 64 stages
- Total elements: 10,000

**What to Look For**:
- Per-stage overhead
- Scaling with pipeline depth
- Minimal operation performance baseline

### Upcase Benchmarks (`upcase.rs`)

**Purpose**: Test simple string transformation operations.

**Implementations Compared**:
- `upcase/dfir` - DFIR string uppercase transformation
- `upcase/timely` - Timely dataflow transformation

**Parameters**:
- Input: 10,000 strings
- Operation: Convert to uppercase

**What to Look For**:
- Map operation overhead
- String handling efficiency
- Data copying costs

## Interpreting Results

### Criterion Output

Criterion provides detailed statistical analysis:

```
arithmetic/dfir_compiled time:   [1.2345 ms 1.2456 ms 1.2567 ms]
                        change: [-5.2% -4.8% -4.4%] (p = 0.00 < 0.05)
                        Performance has improved.
```

**Key Metrics**:
- **Time range**: `[lower_bound estimate upper_bound]`
- **Change**: Comparison with previous run (if available)
- **p-value**: Statistical significance (< 0.05 is significant)

### Comparing Implementations

To compare DFIR vs. Timely/Differential:

1. Look at the central estimate (middle value in time range)
2. Compare equivalent operations (e.g., `arithmetic/dfir_compiled` vs. `arithmetic/timely`)
3. Consider confidence intervals - overlapping intervals suggest similar performance

### HTML Reports

After running benchmarks, open the HTML report:

```bash
# macOS
open target/criterion/report/index.html

# Linux
xdg-open target/criterion/report/index.html

# Windows
start target/criterion/report/index.html
```

**Report Features**:
- Violin plots showing distribution
- Line plots showing trends over time
- Statistical analysis details
- Comparison with baseline runs

## Integration with Main Repository

### Performance Comparison Workflow

To compare DFIR improvements against reference implementations:

#### 1. Establish Baseline

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --save-baseline before
```

#### 2. Update DFIR in Main Repository

```bash
cd ../bigweaver-agent-canary-hydro-zeta
# Make your DFIR changes
git commit -am "Optimize DFIR runtime"
```

#### 3. Update Dependencies and Re-benchmark

```bash
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo update  # Pulls latest DFIR from git
cargo bench --baseline before
```

This will show performance differences:
```
arithmetic/dfir_compiled time:   [1.1234 ms 1.1345 ms 1.1456 ms]
                        change: [-10.2% -9.8% -9.4%] (p = 0.00 < 0.05)
                        Performance has improved.
```

### Cross-Repository Testing

#### Testing DFIR Changes Impact

```bash
# 1. Run benchmarks in main repo (DFIR-native)
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# 2. Run comparison benchmarks
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo update  # Update to latest DFIR
cargo bench

# 3. Compare results
# Main repo: target/criterion/
# Deps repo: target/criterion/
```

#### Automated Comparison Script

Use the provided comparison script:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
./scripts/compare_with_main.sh
```

This script:
1. Runs benchmarks in both repositories
2. Aggregates results
3. Generates comparison report

### CI/CD Integration

#### GitHub Actions Example

```yaml
name: Cross-Repository Benchmark

on:
  push:
    branches: [main]
  pull_request:

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout main repository
        uses: actions/checkout@v3
        with:
          repository: hydro-project/hydro
          path: hydro
      
      - name: Checkout deps repository
        uses: actions/checkout@v3
        path: hydro-deps
      
      - name: Run main repo benchmarks
        run: |
          cd hydro
          cargo bench -p benches --no-fail-fast
      
      - name: Run comparison benchmarks
        run: |
          cd hydro-deps
          cargo update
          cargo bench --no-fail-fast
      
      - name: Upload results
        uses: actions/upload-artifact@v3
        with:
          name: benchmark-results
          path: |
            hydro/target/criterion/
            hydro-deps/target/criterion/
```

## Troubleshooting

### Common Issues

#### Benchmarks Take Too Long

**Solution**: Run specific benchmarks instead of all:
```bash
cargo bench --bench arithmetic --bench identity
```

#### Git Dependencies Fail to Update

**Problem**: Network issues or git credential errors

**Solution**:
```bash
# Clear cargo cache
rm -rf ~/.cargo/git/checkouts/hydro-*
cargo fetch
cargo update
```

#### Inconsistent Results

**Problem**: System load affecting benchmarks

**Solution**:
- Close other applications
- Run benchmarks multiple times
- Use `--sample-size` to increase samples:
  ```bash
  cargo bench -- --sample-size 200
  ```

#### Out of Memory

**Problem**: Large benchmarks (especially reachability) consuming too much memory

**Solution**:
- Run benchmarks individually
- Increase system swap space
- Reduce benchmark parameters (requires code changes)

### Performance Investigation

#### Profiling with perf

```bash
# Linux only
cargo bench --bench arithmetic --profile-time 10
perf record -g target/release/deps/arithmetic-*
perf report
```

#### Flamegraph Generation

```bash
# Install cargo-flamegraph
cargo install flamegraph

# Generate flamegraph for a benchmark
cargo flamegraph --bench arithmetic -- --bench
```

#### Memory Profiling with Valgrind

```bash
cargo bench --bench reachability --no-run
valgrind --tool=massif target/release/deps/reachability-*
ms_print massif.out.*
```

## Advanced Usage

### Custom Benchmark Parameters

Edit benchmark source files to adjust parameters:

```rust
// In arithmetic.rs
const NUM_OPS: usize = 20;      // Increase for longer pipelines
const NUM_INTS: usize = 1_000_000; // Increase for larger datasets
```

### Adding New Benchmarks

1. Create new benchmark file in `benches/benches/`:

```rust
use criterion::{criterion_group, criterion_main, Criterion};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_test", |b| {
        b.iter(|| {
            // Your benchmark code
        });
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

2. Add benchmark entry to `Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

3. Run the new benchmark:

```bash
cargo bench --bench my_benchmark
```

### Comparing with External Baselines

To compare with saved results from another machine:

```bash
# On machine A
cargo bench --save-baseline machine-a

# Copy target/criterion to machine B
scp -r target/criterion machine-b:/path/

# On machine B
cargo bench --baseline machine-a
```

## Best Practices

### Before Benchmarking

1. **System Setup**:
   - Close unnecessary applications
   - Disable CPU frequency scaling (Linux: `sudo cpupower frequency-set -g performance`)
   - Ensure adequate cooling

2. **Environment**:
   - Use release builds (cargo bench does this automatically)
   - Consistent system load
   - Same hardware configuration for comparisons

3. **Code State**:
   - Commit changes before benchmarking
   - Note any compiler flags or environment variables
   - Document system configuration

### During Benchmarking

1. **Consistency**:
   - Run multiple iterations
   - Use same parameters across runs
   - Avoid other CPU-intensive tasks

2. **Baseline Management**:
   - Save baselines before major changes
   - Name baselines descriptively
   - Keep baseline history

3. **Results**:
   - Save raw results
   - Document findings
   - Compare with known-good baselines

### After Benchmarking

1. **Analysis**:
   - Review HTML reports
   - Check for statistical significance
   - Investigate outliers

2. **Documentation**:
   - Update benchmark results in documentation
   - Note performance improvements/regressions
   - Explain unexpected results

3. **Action**:
   - File issues for regressions
   - Celebrate improvements
   - Plan optimization work

## Reference

### Dependencies Used

- **dfir_rs**: DFIR runtime and syntax (git dependency)
- **timely**: Timely dataflow framework (v0.13.0-dev.1)
- **differential-dataflow**: Differential computation library (v0.13.0-dev.1)
- **criterion**: Benchmarking framework (v0.5.0)
- **sinktools**: DFIR sink utilities (git dependency)

### Related Documentation

- Main repository README: `../bigweaver-agent-canary-hydro-zeta/README.md`
- Migration documentation: `MIGRATION.md`
- Main repository benchmark documentation: `../bigweaver-agent-canary-hydro-zeta/benches/README.md`

### External Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- [Hydro Project Documentation](https://hydro.run/)

## Getting Help

### Issues and Questions

- **DFIR performance issues**: File issue in `bigweaver-agent-canary-hydro-zeta`
- **Benchmark infrastructure issues**: File issue in this repository
- **Timely/Differential questions**: Refer to upstream documentation

### Contributing

When contributing new benchmarks:

1. Include both DFIR and reference implementations
2. Document benchmark purpose and parameters
3. Add usage instructions to this guide
4. Update Cargo.toml with benchmark entry
5. Test benchmarks run successfully

### Maintenance

This repository is maintained as a companion to the main Hydro repository. Updates to DFIR will automatically be pulled via git dependencies when running `cargo update`.

For questions or suggestions, please open an issue in the appropriate repository.
