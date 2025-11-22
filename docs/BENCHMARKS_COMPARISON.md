# Performance Benchmarks Comparison Guide

## Overview

This guide provides detailed instructions for running and interpreting performance comparisons between Hydroflow/DFIR and other dataflow systems (timely, differential-dataflow).

## Purpose

These benchmarks allow you to:
- Compare Hydroflow/DFIR performance against established dataflow frameworks
- Detect performance regressions when making changes
- Validate optimization improvements
- Make data-driven decisions about implementation choices

## Benchmark Suite Overview

### Identity Benchmarks (`identity`)

**Purpose:** Tests basic data flow and transformation performance with minimal computation overhead.

**What it tests:**
- Raw pipeline performance (baseline)
- Iterator-based processing
- Timely dataflow implementation
- Hydroflow implementations (compiled, surface syntax, internal API)

**Use cases:**
- Understanding baseline dataflow overhead
- Comparing framework initialization and scheduling costs
- Testing pure data movement without computation

**Command:**
```bash
cargo bench --bench identity
```

### Arithmetic Benchmarks (`arithmetic`)

**Purpose:** Tests computational operations within dataflow pipelines.

**What it tests:**
- Arithmetic operations (add, multiply, etc.) across frameworks
- Computational overhead in different implementations

**Use cases:**
- Evaluating computational efficiency
- Testing operator fusion and optimization

**Command:**
```bash
cargo bench --bench arithmetic
```

### Join Benchmarks (`join`)

**Purpose:** Tests relational join operations, a fundamental dataflow primitive.

**What it tests:**
- Two-way join performance
- State management overhead
- Join algorithm efficiency

**Use cases:**
- Comparing join implementations
- Testing stateful operators
- Evaluating memory usage patterns

**Command:**
```bash
cargo bench --bench join
```

### Reachability Benchmarks (`reachability`)

**Purpose:** Tests graph reachability algorithms with real graph data.

**What it tests:**
- Iterative computation (fixed-point algorithms)
- Timely dataflow implementation
- Differential-dataflow implementation
- Hydroflow implementation

**Data:** Uses real graph edge data from `reachability_edges.txt`

**Use cases:**
- Testing iterative algorithms
- Comparing incremental computation approaches
- Evaluating performance on graph workloads

**Command:**
```bash
cargo bench --bench reachability
```

### Pattern Benchmarks

#### Fan-In (`fan_in`)
**Purpose:** Tests multiple input streams merging into one.

**What it tests:**
- Union/merge operations
- Multi-input coordination
- Scheduling with multiple sources

**Command:**
```bash
cargo bench --bench fan_in
```

#### Fan-Out (`fan_out`)
**Purpose:** Tests splitting one stream into multiple outputs.

**What it tests:**
- Tee/split operations
- Multi-output coordination
- Data duplication overhead

**Command:**
```bash
cargo bench --bench fan_out
```

#### Fork-Join (`fork_join`)
**Purpose:** Tests parallel computation patterns with synchronization.

**What it tests:**
- Parallel branch execution
- Synchronization overhead
- Load balancing

**Command:**
```bash
cargo bench --bench fork_join
```

### Specialized Benchmarks

#### Micro Operations (`micro_ops`)
**Purpose:** Fine-grained performance testing of individual operations.

**What it tests:**
- Individual operator performance
- Operator composition overhead
- Low-level implementation efficiency

**Command:**
```bash
cargo bench --bench micro_ops
```

#### Upcase (`upcase`)
**Purpose:** String transformation benchmarks.

**What it tests:**
- String processing in dataflow
- Map operations
- Data transformation overhead

**Command:**
```bash
cargo bench --bench upcase
```

#### Symmetric Hash Join (`symmetric_hash_join`)
**Purpose:** Tests symmetric hash join implementation.

**What it tests:**
- Hash-based join algorithms
- Bidirectional joins
- Hash table performance

**Command:**
```bash
cargo bench --bench symmetric_hash_join
```

#### Words Diamond (`words_diamond`)
**Purpose:** Diamond-pattern dataflow with text processing.

**What it tests:**
- Complex dataflow patterns
- Text processing operations
- Multi-path execution

**Data:** Uses `words_alpha.txt` English word list

**Command:**
```bash
cargo bench --bench words_diamond
```

## Running Comparative Analysis

### Baseline Establishment

Before making changes, establish a performance baseline:

```bash
# 1. Ensure you're on a clean, known-good commit
cd ../bigweaver-agent-canary-hydro-zeta
git checkout main
git pull

# 2. Run benchmarks and save as baseline
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --save-baseline main

# 3. Results are saved in target/criterion/<benchmark>/main/
```

### Testing Changes

After making changes to the main repository:

```bash
# 1. Switch to your feature branch
cd ../bigweaver-agent-canary-hydro-zeta
git checkout feature-branch

# 2. Run benchmarks with baseline comparison
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --baseline main

# 3. Criterion will show percentage changes for each test
```

### Interpreting Results

#### Performance Improvement
```
identity/hydroflow/surface
                        time:   [10.123 ms 10.234 ms 10.345 ms]
                        change: [-12.345% -10.234% -8.123%] (p = 0.00 < 0.05)
                        Performance has improved.
```
- Negative percentage = faster execution (improvement)
- p < 0.05 = statistically significant change
- All three percentage values are negative = consistent improvement

#### Performance Regression
```
reachability/hydroflow
                        time:   [123.45 ms 125.67 ms 127.89 ms]
                        change: [+8.123% +10.456% +12.789%] (p = 0.00 < 0.05)
                        Performance has regressed.
```
- Positive percentage = slower execution (regression)
- p < 0.05 = statistically significant change
- Investigate the cause before merging

#### No Significant Change
```
join/hydroflow
                        time:   [45.678 ms 46.123 ms 46.567 ms]
                        change: [-1.234% +0.123% +1.456%] (p = 0.45 > 0.05)
                        No change in performance detected.
```
- Mixed positive/negative percentages
- p > 0.05 = not statistically significant
- Changes are within normal variance

### Comparing Across Frameworks

Each benchmark typically includes implementations for:
- **Raw/Pipeline**: Baseline Rust implementation (no framework)
- **Iterator**: Standard Rust iterator chains
- **Timely**: Timely dataflow framework
- **Differential**: Differential dataflow framework
- **Hydroflow/Surface**: Hydroflow surface syntax (macro-based)
- **Hydroflow/Compiled**: Compiled Hydroflow code
- **Hydroflow/Internal**: Direct use of internal Hydroflow APIs

Example output comparing frameworks:

```
identity/raw                    time:   [8.123 ms ...]
identity/iter                   time:   [9.234 ms ...]
identity/timely                 time:   [12.345 ms ...]
identity/hydroflow/surface      time:   [10.456 ms ...]
identity/hydroflow/compiled     time:   [10.123 ms ...]
```

This allows you to see:
- How close Hydroflow is to raw Rust performance
- How it compares to established frameworks like Timely
- Which Hydroflow API has the best performance

## Advanced Comparison Techniques

### Multiple Baselines

Save multiple baselines for different scenarios:

```bash
# Save baseline for main branch
git checkout main
cargo bench -- --save-baseline main

# Save baseline for optimization work
git checkout optimization-branch
cargo bench -- --save-baseline optimization

# Save baseline for different feature
git checkout feature-x
cargo bench -- --save-baseline feature-x

# Compare between baselines
cargo bench -- --baseline main
cargo bench -- --baseline optimization
```

### Filtering Comparisons

Run specific comparisons:

```bash
# Compare only hydroflow implementations
cargo bench hydroflow -- --baseline main

# Compare only timely implementations
cargo bench timely -- --baseline main

# Compare specific test
cargo bench identity/hydroflow/surface -- --baseline main
```

### Statistical Analysis

Criterion provides detailed statistical analysis:

```bash
# Generate detailed reports
cargo bench -- --verbose

# Increase sample size for more accurate results
cargo bench -- --sample-size 100

# Adjust measurement time
cargo bench -- --measurement-time 10
```

## Cross-Repository Performance Testing

### Testing Against Different Versions

```bash
# Test against a specific commit of main repo
cd ../bigweaver-agent-canary-hydro-zeta
git checkout <commit-hash>
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --save-baseline version-1

# Test against another commit
cd ../bigweaver-agent-canary-hydro-zeta
git checkout <another-commit>
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --baseline version-1
```

### Using Git Worktrees for Parallel Testing

```bash
# Create a worktree for comparison
cd ../bigweaver-agent-canary-hydro-zeta
git worktree add ../bigweaver-agent-canary-hydro-zeta-baseline main

# Update path in benches/Cargo.toml temporarily to point to baseline
# Then run comparative tests
```

## Performance Regression Detection Workflow

### 1. Pre-commit Workflow

Before committing changes:

```bash
# Save current state
cargo bench -- --save-baseline before-changes

# Make your changes
# ... edit code ...

# Test for regressions
cargo bench -- --baseline before-changes

# Review any regressions before committing
```

### 2. Pull Request Workflow

For code review:

```bash
# On main branch
git checkout main
cargo bench -- --save-baseline pr-baseline

# On PR branch
git checkout pr-branch
cargo bench -- --baseline pr-baseline > pr-benchmark-results.txt

# Include pr-benchmark-results.txt in PR description
```

### 3. Continuous Integration

Example CI workflow:

```yaml
# .github/workflows/benchmark.yml
name: Benchmark
on: [pull_request]
jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run benchmarks
        run: |
          cargo bench -- --save-baseline pr
          # Compare and report results
```

## Analyzing HTML Reports

Criterion generates comprehensive HTML reports in `target/criterion/`.

### Report Structure

```
target/criterion/
├── report/
│   └── index.html              # Main report index
├── identity/
│   ├── report/
│   │   └── index.html          # Identity benchmark report
│   ├── base/                   # Latest run data
│   ├── main/                   # Baseline data (if saved)
│   └── change/                 # Comparison data
└── [other benchmarks]/
```

### Key Report Features

1. **Violin Plots** - Show distribution of execution times
2. **Change Summaries** - Highlight significant changes
3. **Iteration Times** - Raw data for each iteration
4. **PDF Exports** - Distribution probability density
5. **Historical Data** - Track performance over time

### Viewing Reports

```bash
# View main report
open target/criterion/report/index.html

# View specific benchmark
open target/criterion/identity/report/index.html

# View comparison report
open target/criterion/identity/change/report/index.html
```

## Best Practices

### For Reliable Measurements

1. **Consistent Environment**
   - Use the same hardware for comparisons
   - Close unnecessary applications
   - Disable CPU frequency scaling if possible
   - Run benchmarks multiple times

2. **Baseline Management**
   - Save baselines from known-good commits
   - Document what each baseline represents
   - Clean old baselines periodically

3. **Statistical Significance**
   - Pay attention to p-values (< 0.05 = significant)
   - Look for consistent changes across multiple runs
   - Don't over-interpret small changes

### For Accurate Comparisons

1. **Ensure Fair Comparison**
   - Compare equivalent operations
   - Use same data sizes and characteristics
   - Account for framework overhead

2. **Document Context**
   - Record hardware specifications
   - Note system conditions
   - Document any configuration changes

3. **Iterative Testing**
   - Test early and often during development
   - Track performance trends over time
   - Investigate unexpected changes promptly

## Troubleshooting

### High Variance

If results show high variance:
```
time:   [10.123 ms 15.456 ms 20.789 ms]  # Large range
```

Solutions:
- Close background applications
- Increase sample size: `--sample-size 200`
- Check for thermal throttling
- Use dedicated benchmark hardware

### Inconsistent Results

If consecutive runs show different results:
- Check for background processes
- Verify stable power/thermal conditions
- Consider using `--warm-up-time` to stabilize
- Run longer measurements: `--measurement-time 30`

### Memory Issues

For benchmarks that use large datasets:
- Monitor memory usage
- Ensure sufficient RAM available
- Check for memory leaks
- Consider reducing dataset size for quick tests

## Contributing Benchmarks

When adding new benchmarks:

1. **Follow Existing Patterns**
   - Use similar structure to existing benchmarks
   - Include framework comparisons where applicable
   - Add appropriate documentation

2. **Document the Benchmark**
   - Explain what it tests
   - Describe expected results
   - Note any special data requirements

3. **Test Thoroughly**
   - Verify benchmark runs successfully
   - Check that results are consistent
   - Ensure comparisons are fair

## References

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/) - Comprehensive benchmarking guide
- [Timely Dataflow](https://timelydataflow.github.io/timely-dataflow/) - Timely framework documentation
- [Differential Dataflow](https://timelydataflow.github.io/differential-dataflow/) - Differential framework documentation
- Main repository: `bigweaver-agent-canary-hydro-zeta`

## Summary

This benchmarking infrastructure provides comprehensive tools for:
- Comparing Hydroflow/DFIR against established frameworks
- Detecting performance regressions early
- Making data-driven optimization decisions
- Tracking performance trends over time

Use these benchmarks regularly during development to ensure performance goals are met and regressions are caught before merging.
