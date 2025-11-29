# Running Performance Comparisons

This guide explains how to compare performance between Hydro implementations and timely/differential-dataflow implementations.

## Prerequisites

- Rust toolchain installed
- Both repositories cloned locally:
  - `bigweaver-agent-canary-hydro-zeta` (main Hydro repository)
  - `bigweaver-agent-canary-zeta-hydro-deps` (benchmarks repository)

## Running Benchmarks

### In This Repository (Timely/Differential-Dataflow Benchmarks)

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run with verbose output
cargo bench -p benches --bench join -- --verbose
```

### Benchmark Results Location

Results are saved in:
```
target/criterion/
├── <benchmark-name>/
│   ├── report/
│   │   └── index.html    # HTML report
│   └── base/
│       └── estimates.json # Raw data
```

Open the HTML reports in a browser for detailed analysis:
```bash
firefox target/criterion/reachability/report/index.html
```

## Understanding Benchmark Output

Each benchmark compares:
1. **Hydro (dfir_rs)** - Implementation using Hydro's DFIR runtime
2. **Timely-Dataflow** - Direct timely-dataflow implementation
3. **Differential-Dataflow** - Differential-dataflow implementation (where applicable)

### Example Output

```
reachability/hydro      time:   [10.234 ms 10.345 ms 10.456 ms]
reachability/timely     time:   [12.123 ms 12.234 ms 12.345 ms]
reachability/differential time: [15.456 ms 15.567 ms 15.678 ms]
```

## Comparison Methodology

### 1. Statistical Significance

Criterion uses statistical analysis to determine if performance differences are significant:
- **Green** = Performance improved
- **Red** = Performance degraded  
- **White** = No significant change

### 2. Multiple Runs

Each benchmark runs multiple iterations to get statistically valid results:
```bash
# Increase sample size for more accuracy
cargo bench -p benches --bench reachability -- --sample-size 1000
```

### 3. Baseline Comparisons

Save a baseline for future comparisons:
```bash
# Save current results as baseline
cargo bench -p benches --bench reachability -- --save-baseline my-baseline

# Compare against saved baseline
cargo bench -p benches --bench reachability -- --baseline my-baseline
```

## Interpreting Results

### Throughput Benchmarks

For benchmarks measuring throughput (e.g., micro_ops, arithmetic):
- **Higher is better**
- Look at "throughput" column in results
- Compare ops/sec or items/sec

### Latency Benchmarks

For benchmarks measuring latency (e.g., reachability, join):
- **Lower is better**
- Look at "time" column in results
- Compare milliseconds per operation

### Memory Usage

While Criterion doesn't measure memory directly, you can profile with:
```bash
# Using heaptrack
heaptrack cargo bench -p benches --bench reachability

# Using valgrind
valgrind --tool=massif cargo bench -p benches --bench reachability
```

## Benchmark Descriptions

| Benchmark | What It Measures | Best For |
|-----------|------------------|----------|
| arithmetic | Pipeline arithmetic operations | Sequential processing performance |
| fan_in | Merging multiple streams | Join/union performance |
| fan_out | Splitting streams | Broadcast performance |
| fork_join | Fork-join patterns | Parallel processing patterns |
| futures | Async operation handling | Async/await performance |
| identity | Minimal overhead | Baseline streaming overhead |
| join | Join operations | Join algorithm performance |
| micro_ops | Individual operators | Operator-level performance |
| reachability | Graph algorithms | Iterative computation |
| symmetric_hash_join | Hash join implementation | Join strategy comparison |
| upcase | String transformations | String processing |
| words_diamond | Diamond patterns | Complex dataflow patterns |

## Tips for Accurate Comparisons

1. **Consistent Environment**
   - Close other applications
   - Run on same hardware
   - Use release builds only

2. **Multiple Runs**
   - Run benchmarks multiple times
   - Average results across runs
   - Watch for variance

3. **Warm-up**
   - Criterion handles warm-up automatically
   - First run may be slower (JIT, caching)

4. **Configuration**
   ```bash
   # Custom configuration
   cargo bench -p benches --bench reachability -- \
     --sample-size 100 \
     --measurement-time 10 \
     --warm-up-time 3
   ```

## Troubleshooting

### Build Errors

If you encounter dependency resolution errors:
```bash
# Update dependencies
cargo update

# Clean and rebuild
cargo clean
cargo build --release
```

### Benchmark Failures

If specific benchmarks fail:
```bash
# Run with backtrace
RUST_BACKTRACE=1 cargo bench -p benches --bench <name>

# Check test data files exist
ls -lh benches/benches/*.txt
```

### Performance Anomalies

If results seem unusual:
1. Check system load: `top` or `htop`
2. Disable frequency scaling: `sudo cpupower frequency-set -g performance`
3. Pin to specific CPU cores
4. Check for thermal throttling

## Exporting Results

### CSV Export

```bash
# Criterion doesn't export CSV directly, but you can parse JSON
python3 -c "
import json
with open('target/criterion/reachability/base/estimates.json') as f:
    data = json.load(f)
    print(f\"Mean: {data['mean']['point_estimate']} ns\")
"
```

### Plotting Results

Use the HTML reports generated by Criterion, or extract data for custom plotting:
```python
import json
import matplotlib.pyplot as plt

# Load results
with open('target/criterion/reachability/base/estimates.json') as f:
    results = json.load(f)

# Create custom plots
# ... your plotting code ...
```

## Continuous Integration

To run benchmarks in CI:
```yaml
# .github/workflows/bench.yml
- name: Run benchmarks
  run: cargo bench -p benches --no-fail-fast
  
- name: Upload results
  uses: actions/upload-artifact@v2
  with:
    name: benchmark-results
    path: target/criterion/
```

## Further Reading

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- [Hydro Documentation](../bigweaver-agent-canary-hydro-zeta/README.md)
