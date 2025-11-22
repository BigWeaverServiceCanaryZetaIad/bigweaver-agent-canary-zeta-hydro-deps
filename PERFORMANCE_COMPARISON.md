# Performance Comparison Guide

This guide explains how to compare performance between benchmarks in this repository and DFIR implementations in the main `bigweaver-agent-canary-hydro-zeta` repository.

## Overview

This repository contains benchmarks comparing:
- **Timely Dataflow** implementations
- **Differential Dataflow** implementations  
- **Baseline** implementations (raw Rust, iterators, etc.)

The main repository contains:
- **DFIR/Hydroflow** implementations
- **DFIR-focused** microbenchmarks

Together, these allow comprehensive cross-framework performance analysis.

## Quick Comparison Workflow

### 1. Run Benchmarks in This Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-deps-benchmarks
```

Results saved to: `target/criterion/`

### 2. Run Benchmarks in Main Repository

```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

Results saved to: `target/criterion/`

### 3. Compare Results

Both benchmark suites generate Criterion reports. Compare:
- Throughput (elements/second)
- Latency (time per operation)
- Memory characteristics

## Detailed Comparison Methodology

### Matching Benchmarks

Some benchmarks have equivalent implementations across repositories:

| This Repo (Timely/DD) | Main Repo (DFIR) | Comparable? |
|----------------------|------------------|-------------|
| `arithmetic` | `micro_ops` | Partially - similar map operations |
| `identity` | `micro_ops` | Yes - identity operator tests |
| `join` | `symmetric_hash_join` | Similar - join semantics |
| `upcase` | `words_diamond` | Partially - string operations |
| `reachability` | N/A | No direct equivalent |
| `fan_in` | N/A | No direct equivalent |
| `fan_out` | N/A | No direct equivalent |
| `fork_join` | N/A | No direct equivalent |

### Fair Comparison Guidelines

When comparing performance between frameworks:

#### 1. Ensure Equivalent Workloads

```bash
# Check data sizes match
# Check operation counts match
# Verify same computational work
```

**Example:** If `arithmetic` processes 1M elements with 20 operations, ensure DFIR equivalent does the same.

#### 2. Control Test Environment

- **Same hardware** - Run on same machine
- **Same system state** - Close unnecessary applications
- **Multiple runs** - Criterion handles this automatically
- **Same Rust version** - Check with `rustc --version`

#### 3. Understand Framework Differences

Different frameworks have different strengths:

**Timely Dataflow:**
- Optimized for streaming dataflow
- Low-level control
- Mature optimization

**DFIR/Hydroflow:**
- Higher-level abstractions
- More ergonomic
- Evolving performance characteristics

**Baseline implementations:**
- No framework overhead
- Theoretical performance limits

## Cross-Repository Comparison Script

Create a comparison script to automate the process:

```bash
#!/bin/bash
# compare_benchmarks.sh

echo "=== Running hydro-deps benchmarks ==="
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p hydro-deps-benchmarks --bench identity --bench arithmetic > /tmp/hydro-deps-results.txt

echo "=== Running main repository benchmarks ==="
cd ../bigweaver-agent-canary-hydro-zeta  
cargo bench -p benches --bench micro_ops > /tmp/main-repo-results.txt

echo "=== Results Comparison ==="
echo "Hydro-deps (Timely):"
grep "time:" /tmp/hydro-deps-results.txt | head -5

echo ""
echo "Main repo (DFIR):"
grep "time:" /tmp/main-repo-results.txt | head -5

echo ""
echo "Detailed reports:"
echo "Hydro-deps: file://$(pwd)/../bigweaver-agent-canary-zeta-hydro-deps/target/criterion/report/index.html"
echo "Main repo:  file://$(pwd)/target/criterion/report/index.html"
```

Save as `compare_benchmarks.sh` and make executable:

```bash
chmod +x compare_benchmarks.sh
./compare_benchmarks.sh
```

## Interpreting Comparison Results

### Reading Criterion Output

```
identity/timely         time:   [15.234 ms 15.567 ms 15.942 ms]
                        thrpt:  [62.73 Melem/s 64.23 Melem/s 65.64 Melem/s]

identity/dfir           time:   [18.123 ms 18.456 ms 18.834 ms]  
                        thrpt:  [53.09 Melem/s 54.18 Melem/s 55.19 Melem/s]
```

**Analysis:**
- Timely: ~15.6ms avg, ~64.2 Melem/s
- DFIR: ~18.5ms avg, ~54.2 Melem/s
- Timely is ~1.19x faster (18.5/15.6)
- DFIR throughput is ~84% of Timely (54.2/64.2)

### Statistical Significance

Criterion provides confidence intervals:

```
                        change: [-5.2341% -2.1234% +1.0123%] (p = 0.18 > 0.05)
```

- **p < 0.05**: Statistically significant difference
- **p > 0.05**: Difference might be noise
- Check confidence intervals (first/third values)

### Visualizing Comparisons

#### HTML Reports

Both repositories generate HTML reports:

```bash
# Open hydro-deps report
open bigweaver-agent-canary-zeta-hydro-deps/target/criterion/report/index.html

# Open main repo report  
open bigweaver-agent-canary-hydro-zeta/target/criterion/report/index.html
```

Compare:
- **Violin plots** - Distribution of measurements
- **Line charts** - Performance over time
- **Statistics tables** - Detailed metrics

#### Exporting Data

For custom analysis:

```bash
# Criterion saves JSON data
cat target/criterion/identity/base/estimates.json

# Extract specific metrics
jq '.mean.point_estimate' target/criterion/identity/base/estimates.json
```

## Performance Comparison Checklist

Before comparing benchmarks across repositories:

- [ ] Both repositories are up-to-date
- [ ] Same Rust toolchain version
- [ ] Dependencies are current
- [ ] System is in consistent state (no background jobs)
- [ ] Sufficient warmup iterations
- [ ] Multiple sample runs completed
- [ ] Confidence intervals are reasonable
- [ ] Workload parameters match
- [ ] Data sizes are equivalent

## Common Comparison Scenarios

### Scenario 1: Evaluating Framework Migration

**Question:** Should we use DFIR instead of Timely for a new pipeline?

**Process:**
1. Identify comparable benchmarks
2. Run both benchmark suites
3. Compare throughput and latency
4. Consider code complexity (not just performance)
5. Evaluate ecosystem and support

**Decision factors:**
- Performance requirements
- Development velocity needs
- Team expertise
- Long-term maintenance

### Scenario 2: Tracking Performance Over Time

**Question:** Is DFIR performance improving?

**Process:**
1. Save baseline for both repos:
   ```bash
   cargo bench -- --save-baseline v1.0
   ```
2. After changes, compare:
   ```bash
   cargo bench -- --baseline v1.0
   ```
3. Track trends in HTML reports

### Scenario 3: Optimization Validation

**Question:** Did my optimization work?

**Process:**
1. Run benchmark before optimization
2. Save baseline: `cargo bench -- --save-baseline before`
3. Apply optimization
4. Compare: `cargo bench -- --baseline before`
5. Check for statistically significant improvement

## Advanced Comparison Techniques

### Using Flamegraphs

Profile where time is spent:

```bash
# Install cargo-flamegraph
cargo install flamegraph

# Profile hydro-deps benchmark
cd bigweaver-agent-canary-zeta-hydro-deps
cargo flamegraph --bench identity

# Profile main repo benchmark  
cd ../bigweaver-agent-canary-hydro-zeta
cargo flamegraph --bench micro_ops
```

Compare flamegraphs to understand performance differences.

### Custom Benchmark Comparison

Create equivalent benchmarks for direct comparison:

```rust
// In hydro-deps
#[bench]
fn benchmark_timely_custom(b: &mut Bencher) {
    // Specific workload
}

// In main repo
#[bench]  
fn benchmark_dfir_custom(b: &mut Bencher) {
    // Same workload, different framework
}
```

### Memory Profiling

Compare memory usage:

```bash
# Using heaptrack
heaptrack cargo bench --bench identity --no-run
heaptrack ./target/release/deps/identity-*

# Using valgrind massif
valgrind --tool=massif cargo bench --bench identity --no-run
ms_print massif.out.*
```

## Benchmark Maintenance

### Keeping Benchmarks Synchronized

When benchmarks in the main repo change:

1. Review change in main repo
2. Determine if equivalent exists here
3. Update this repo's benchmark to match
4. Document differences in BENCHMARKS.md
5. Update comparison mappings in this guide

### Version Alignment

Track framework versions:

```toml
# bigweaver-agent-canary-zeta-hydro-deps/benchmarks/Cargo.toml
[dev-dependencies]
timely = { package = "timely-master", version = "0.13.0-dev.1" }

# bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml  
[dev-dependencies]
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
```

Document versions when reporting comparisons.

## Reporting Performance Comparisons

When sharing comparison results:

### Required Information

1. **Versions**
   - Rust version: `rustc --version`
   - Repository commits: `git rev-parse HEAD`
   - Framework versions: From `Cargo.lock`

2. **Environment**
   - Hardware: CPU model, core count, RAM
   - OS: `uname -a`
   - System load: Idle vs. loaded

3. **Results**
   - Full Criterion output
   - Links to HTML reports
   - Statistical significance notes

### Example Report Format

```markdown
## Performance Comparison: Identity Operations

**Date:** 2024-11-22
**Rust:** 1.70.0
**Hardware:** Intel i7-9750H (6 cores), 16GB RAM
**OS:** Linux 5.15

### Results

| Framework | Time (ms) | Throughput (Melem/s) | Relative |
|-----------|-----------|----------------------|----------|
| Timely    | 15.6      | 64.2                 | 1.00x    |
| DFIR      | 18.5      | 54.2                 | 0.84x    |
| Baseline  | 12.3      | 81.3                 | 1.27x    |

### Analysis

DFIR is currently ~16% slower than Timely for identity operations,
but both are within 50% of the theoretical baseline. This overhead
is acceptable given DFIR's higher-level abstractions...

[Detailed HTML reports attached]
```

## Frequently Asked Questions

### Q: Why are results different on my machine?

Hardware differences, OS scheduler, background processes all affect results. Focus on relative comparisons on the same machine.

### Q: Should I always choose the fastest framework?

No. Consider:
- Development velocity
- Code maintainability  
- Team expertise
- Ecosystem maturity
- Performance "fast enough" for your use case

### Q: How much faster is "significantly faster"?

Depends on context:
- **< 10% difference**: Probably not significant
- **10-50% difference**: Noticeable, evaluate trade-offs
- **> 50% difference**: Significant, investigate cause

### Q: Can I mix frameworks in one application?

Technically yes, but adds complexity. Usually better to choose one framework for consistency.

### Q: How often should I run comparisons?

- **Before major architectural decisions**
- **When performance is critical**
- **After significant optimizations**
- **Periodically to track trends**

## Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Statistical Benchmarking](https://easyperf.net/blog/2019/08/02/Perf-measurement-environment-on-Linux)
- [Timely Dataflow Performance](https://github.com/TimelyDataflow/timely-dataflow/tree/master/timely/examples)
- [Hydroflow Documentation](https://hydro.run/)

## Contributing

When adding new comparative benchmarks:

1. Ensure equivalent implementations in both repos
2. Document mapping in this guide
3. Validate results make sense
4. Update comparison scripts
5. Add to CI if applicable

---

**Note:** Performance characteristics evolve as frameworks mature. This guide reflects current state and should be updated as frameworks improve.
