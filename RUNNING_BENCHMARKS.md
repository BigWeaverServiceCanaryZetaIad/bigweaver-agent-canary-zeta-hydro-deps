# Running Performance Comparisons

This guide explains how to run performance benchmarks and compare DFIR (Hydroflow) against Timely Dataflow and Differential Dataflow after the benchmark migration.

## Quick Start

### Running DFIR-Only Benchmarks

```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

### Running Comparison Benchmarks (DFIR vs Timely vs Differential)

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

## Detailed Instructions

### 1. DFIR-Only Benchmarks (bigweaver-agent-canary-hydro-zeta)

These benchmarks test DFIR/Hydroflow operations without comparison to other frameworks:

**Available Benchmarks:**
- `micro_ops` - Microbenchmarks for map, flat_map, union, tee, fold, sort, etc.
- `symmetric_hash_join` - Symmetric hash join operations
- `words_diamond` - Diamond pattern with word processing
- `futures` - Async/futures integration

**Running All Benchmarks:**
```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

**Running Specific Benchmark:**
```bash
cargo bench -p benches --bench micro_ops
```

**With Custom Options:**
```bash
# Increase sample size for more accurate results
cargo bench -p benches --bench micro_ops -- --sample-size 200

# Filter to specific test
cargo bench -p benches --bench micro_ops -- identity
```

### 2. Comparison Benchmarks (bigweaver-agent-canary-zeta-hydro-deps)

These benchmarks compare DFIR against Timely and Differential Dataflow:

**Available Benchmarks:**
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern  
- `fork_join` - Fork-join pattern
- `identity` - Identity operation
- `join` - Hash join with different value types
- `reachability` - Graph reachability (includes Timely, Differential, and DFIR implementations)
- `upcase` - String transformation operations

**Running All Benchmarks:**
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

**Running Specific Benchmark:**
```bash
cargo bench --bench reachability
```

**Running Specific Implementation:**
```bash
# Run only the Timely implementation of reachability
cargo bench --bench reachability -- timely

# Run only the Differential implementation
cargo bench --bench reachability -- differential

# Run only the DFIR implementation
cargo bench --bench reachability -- dfir_rs
```

### 3. Understanding Benchmark Results

Criterion generates detailed reports including:

**Console Output:**
```
reachability/timely     time:   [142.67 ms 143.89 ms 145.23 ms]
reachability/differential time: [89.234 ms 90.456 ms 91.789 ms]
reachability/dfir_rs    time:   [156.78 ms 158.12 ms 159.67 ms]
```

**HTML Reports:**
Located in `target/criterion/<benchmark_name>/report/index.html`

Open in browser to see:
- Detailed performance graphs
- Statistical analysis
- Performance regression detection
- Comparison with previous runs

### 4. Comparing Performance Between Repositories

To properly compare DFIR performance evolution:

**Step 1: Baseline Run (deps repository)**
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench --bench reachability
```

**Step 2: Save the Results**
```bash
# Results are automatically saved in target/criterion/
# Archive the criterion directory if needed
tar -czf criterion-baseline.tar.gz target/criterion/
```

**Step 3: After DFIR Changes**
```bash
# Make changes to DFIR in the main repository
cd bigweaver-agent-canary-hydro-zeta
# ... make changes ...

# Re-run comparison benchmarks (they'll use the updated DFIR via git)
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo update -p dfir_rs
cargo bench --bench reachability
```

**Step 4: Review Changes**
Criterion will automatically compare with the previous run and show:
- Performance improvement/regression percentages
- Statistical significance
- Detailed graphs in HTML reports

### 5. Best Practices for Accurate Benchmarking

**System Preparation:**
```bash
# Close unnecessary applications
# Disable CPU frequency scaling (if possible)
# Run on AC power (laptops)
# Ensure consistent thermal conditions
```

**Benchmark Options:**
```bash
# Increase sample size for stability
cargo bench -- --sample-size 200

# Increase warm-up time
cargo bench -- --warm-up-time 10

# Save baseline for future comparison
cargo bench -- --save-baseline my-baseline

# Compare against baseline
cargo bench -- --baseline my-baseline
```

**Multiple Runs:**
```bash
# Run benchmarks multiple times and average results
for i in {1..3}; do
  cargo bench --bench reachability
done
```

### 6. CI/CD Integration

**For GitHub Actions:**
```yaml
- name: Run DFIR Benchmarks
  run: |
    cd bigweaver-agent-canary-hydro-zeta
    cargo bench -p benches

- name: Run Comparison Benchmarks
  run: |
    cd bigweaver-agent-canary-zeta-hydro-deps/benches
    cargo bench

- name: Archive Benchmark Results
  uses: actions/upload-artifact@v3
  with:
    name: criterion-reports
    path: |
      bigweaver-agent-canary-zeta-hydro-deps/benches/target/criterion/
```

### 7. Troubleshooting

**Problem: "Cannot find dfir_rs in registry"**
- Expected for deps repository - uses git dependency
- Ensure network access to GitHub

**Problem: Benchmarks take too long**
```bash
# Reduce sample size for faster iteration
cargo bench -- --sample-size 10 --measurement-time 1
```

**Problem: Results are unstable**
```bash
# Increase sample size and warm-up
cargo bench -- --sample-size 500 --warm-up-time 10

# Check system load
top
# Close background applications
```

**Problem: Git dependency not updating**
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo clean
cargo update -p dfir_rs
cargo update -p sinktools
cargo bench
```

### 8. Benchmark Categories

#### Micro-Operations (micro_ops)
Tests individual operations: map, flat_map, filter, fold, sort, unique, union, tee

#### Data Flow Patterns
- **Identity**: Pass-through performance
- **Fan-in**: Multiple inputs to single output
- **Fan-out**: Single input to multiple outputs
- **Fork-join**: Split and rejoin patterns

#### Join Operations
- Hash joins with different value types (usize vs String)
- Symmetric hash join patterns

#### Real-World Algorithms
- **Reachability**: Graph traversal algorithms
- **Diamond**: Complex data flow patterns
- **Arithmetic**: Computational workloads

### 9. Performance Metrics

Key metrics to watch:
- **Time**: Wall-clock execution time
- **Throughput**: Operations per second (when applicable)
- **Variance**: Stability of performance
- **Memory**: Via profiling tools (not automatic)

### 10. Advanced Usage

**Profiling Integration:**
```bash
# Profile a specific benchmark
cargo bench --bench reachability --profile
# Then use perf or flamegraph tools
```

**Custom Criterion Configuration:**
Edit the benchmark file to adjust:
- Sample sizes
- Measurement time
- Warm-up time
- Statistical confidence levels

**Comparing Across Machines:**
Save Criterion baselines and share them:
```bash
# Export baseline
tar -czf baseline-$(hostname).tar.gz target/criterion/

# Import on another machine
tar -xzf baseline-hostname1.tar.gz
cargo bench -- --baseline <baseline-name>
```

## Summary

- **DFIR-only benchmarks**: Run in main repository
- **Comparison benchmarks**: Run in deps repository
- **Use Criterion HTML reports** for detailed analysis
- **Save baselines** for tracking performance over time
- **Update git dependencies** when testing DFIR changes
- **Control system load** for consistent results
