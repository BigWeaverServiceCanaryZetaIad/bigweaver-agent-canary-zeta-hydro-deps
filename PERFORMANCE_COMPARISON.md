# Performance Comparison Guide

This guide explains how to run performance comparisons between the Timely/Differential-Dataflow benchmarks in this repository and the Hydroflow/DFIR benchmarks in the main repository.

## Overview

This repository contains benchmarks for **Timely Dataflow** and **Differential-Dataflow**, while the main `bigweaver-agent-canary-hydro-zeta` repository contains benchmarks for **Hydroflow/DFIR**. To perform meaningful performance comparisons, you need to run benchmarks in both repositories.

## Why Separate Repositories?

The benchmarks were separated to:

1. **Reduce dependency bloat** - Main repository doesn't need timely/differential dependencies
2. **Independent evolution** - Each codebase can evolve independently
3. **Clean architecture** - Maintains separation of concerns
4. **Flexible comparison** - Choose when and how to run comparisons

## Prerequisites

### Required Repositories

You need both repositories cloned:

```bash
# Clone this repository (if not already done)
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Clone main repository
git clone https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta.git
```

### Directory Structure

Recommended layout:

```
workspace/
├── bigweaver-agent-canary-zeta-hydro-deps/    # This repository
│   └── benches/                                # Timely/Differential benchmarks
└── bigweaver-agent-canary-hydro-zeta/          # Main repository
    └── benches/                                # Hydroflow/DFIR benchmarks
```

## Running Comparison Benchmarks

### Method 1: Sequential Execution (Recommended)

Run benchmarks in each repository sequentially for consistent results.

#### Step 1: Run Timely/Differential Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --save-baseline timely-differential
```

This creates a baseline named `timely-differential` with results saved in:
`target/criterion/<benchmark-name>/timely-differential/`

#### Step 2: Run Hydroflow/DFIR Benchmarks

```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --save-baseline hydroflow-dfir
```

This creates a baseline named `hydroflow-dfir` in the main repository.

#### Step 3: Compare Results

Open the HTML reports from both repositories:

```bash
# View Timely/Differential results
open bigweaver-agent-canary-zeta-hydro-deps/target/criterion/report/index.html

# View Hydroflow/DFIR results
open bigweaver-agent-canary-hydro-zeta/target/criterion/report/index.html
```

### Method 2: Side-by-Side Comparison Script

Create a comparison script for automated execution:

```bash
#!/bin/bash
# compare_benchmarks.sh

set -e

DEPS_REPO="bigweaver-agent-canary-zeta-hydro-deps"
MAIN_REPO="bigweaver-agent-canary-hydro-zeta"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "=== Running Timely/Differential Benchmarks ==="
cd "$DEPS_REPO"
cargo bench --save-baseline "timely_${TIMESTAMP}" | tee "../results_timely_${TIMESTAMP}.txt"

echo ""
echo "=== Running Hydroflow/DFIR Benchmarks ==="
cd "../$MAIN_REPO"
cargo bench -p benches --save-baseline "hydroflow_${TIMESTAMP}" | tee "../results_hydroflow_${TIMESTAMP}.txt"

echo ""
echo "=== Benchmark Comparison Complete ==="
echo "Timely/Differential results: results_timely_${TIMESTAMP}.txt"
echo "Hydroflow/DFIR results: results_hydroflow_${TIMESTAMP}.txt"
echo ""
echo "View reports:"
echo "  Timely/Differential: ${DEPS_REPO}/target/criterion/report/index.html"
echo "  Hydroflow/DFIR: ${MAIN_REPO}/target/criterion/report/index.html"
```

Make it executable and run:

```bash
chmod +x compare_benchmarks.sh
./compare_benchmarks.sh
```

### Method 3: Individual Benchmark Comparison

For focused comparison of specific benchmarks:

```bash
# Run identity benchmark in deps repo
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --bench identity -- --save-baseline timely

# Run identity benchmark in main repo  
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench identity -- --save-baseline hydroflow
```

## Interpreting Results

### Understanding Benchmark Output

Each benchmark reports three key metrics:

```
identity/timely         time:   [45.234 ms 45.987 ms 46.821 ms]
identity/hydroflow      time:   [42.123 ms 42.654 ms 43.234 ms]
```

- **Lower bound**: 2.5th percentile
- **Estimate**: 50th percentile (median)
- **Upper bound**: 97.5th percentile

### Fair Comparison Considerations

When comparing frameworks, consider:

#### 1. **Execution Model Differences**

- **Timely Dataflow**: Explicit timestamp-based coordination, fine-grained control
- **Differential-Dataflow**: Incremental computation, maintains state differences
- **Hydroflow/DFIR**: Different scheduling strategy, optimized for specific use cases

#### 2. **Workload Characteristics**

Different frameworks may excel at different workload types:

- **Streaming vs. Batch**: Some frameworks optimize for streaming
- **Stateful vs. Stateless**: State management strategies differ
- **Memory vs. CPU**: Different trade-offs in resource usage

#### 3. **Optimization Levels**

Ensure both repos are compiled with the same optimization:

```bash
# Both should use release mode for benchmarks
cargo bench  # Automatically uses release mode
```

#### 4. **Cold vs. Warm Runs**

Criterion handles this automatically by:
- Running warm-up iterations
- Taking multiple samples
- Computing statistical confidence intervals

### Benchmark-Specific Comparison Notes

#### Identity Benchmark

**What to compare**:
- Pure throughput with minimal computation
- Overhead of framework infrastructure
- Scaling with number of operations

**Expected behavior**:
- All frameworks should be fast (minimal work)
- Differences reflect infrastructure overhead

#### Arithmetic Benchmark

**What to compare**:
- Computational throughput
- Data movement efficiency

**Expected behavior**:
- More computation-bound than infrastructure-bound
- Frameworks should show similar performance

#### Fan-In / Fan-Out Benchmarks

**What to compare**:
- Stream merge/split efficiency
- Synchronization overhead

**Expected behavior**:
- Tests framework's handling of multiple streams

#### Join Benchmark

**What to compare**:
- Relational operator efficiency
- State management performance

**Expected behavior**:
- Significant differences possible due to join strategies

#### Reachability Benchmark

**What to compare**:
- Iterative computation performance
- State management for graph traversal

**Special note**: This benchmark has three implementations:
- `reachability/timely` - Timely Dataflow
- `reachability/differential` - Differential-Dataflow
- `reachability/hydroflow` - Hydroflow/DFIR

### Sample Comparison Analysis

Example output interpretation:

```
Repository: bigweaver-agent-canary-zeta-hydro-deps
identity/timely         time:   [45.234 ms 45.987 ms 46.821 ms]

Repository: bigweaver-agent-canary-hydro-zeta
identity/hydroflow      time:   [42.123 ms 42.654 ms 43.234 ms]
```

**Analysis**:
- Hydroflow is ~7.3% faster (42.654ms vs 45.987ms median)
- This difference is statistically significant
- For this specific workload, Hydroflow has lower overhead

## Creating Comparison Reports

### Manual Comparison Table

Create a spreadsheet or markdown table:

```markdown
| Benchmark     | Timely (ms) | Differential (ms) | Hydroflow (ms) | Winner     |
|---------------|-------------|-------------------|----------------|------------|
| identity      | 45.99       | N/A               | 42.65          | Hydroflow  |
| arithmetic    | 67.23       | N/A               | 65.12          | Hydroflow  |
| reachability  | 234.56      | 189.34            | 245.67         | Differential|
| join          | 123.45      | N/A               | 118.92         | Hydroflow  |
```

### Automated Comparison Script

Extract and compare results programmatically:

```python
#!/usr/bin/env python3
# compare_results.py

import json
import sys
from pathlib import Path

def load_benchmark_results(criterion_dir):
    """Load Criterion benchmark results"""
    results = {}
    base_dir = Path(criterion_dir)
    
    for bench_dir in base_dir.iterdir():
        if not bench_dir.is_dir():
            continue
            
        estimates_file = bench_dir / "base" / "estimates.json"
        if estimates_file.exists():
            with open(estimates_file) as f:
                data = json.load(f)
                # Extract median time in ms
                results[bench_dir.name] = data["mean"]["point_estimate"] / 1_000_000
    
    return results

def compare_results(timely_results, hydroflow_results):
    """Compare benchmark results"""
    print(f"{'Benchmark':<20} {'Timely (ms)':<15} {'Hydroflow (ms)':<15} {'Difference':<15}")
    print("-" * 65)
    
    for bench_name in sorted(set(timely_results.keys()) & set(hydroflow_results.keys())):
        timely_time = timely_results[bench_name]
        hydroflow_time = hydroflow_results[bench_name]
        diff_pct = ((hydroflow_time - timely_time) / timely_time) * 100
        
        print(f"{bench_name:<20} {timely_time:<15.2f} {hydroflow_time:<15.2f} {diff_pct:>+14.2f}%")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: compare_results.py <timely_criterion_dir> <hydroflow_criterion_dir>")
        sys.exit(1)
    
    timely_results = load_benchmark_results(sys.argv[1])
    hydroflow_results = load_benchmark_results(sys.argv[2])
    
    compare_results(timely_results, hydroflow_results)
```

Usage:

```bash
python3 compare_results.py \
    bigweaver-agent-canary-zeta-hydro-deps/target/criterion \
    bigweaver-agent-canary-hydro-zeta/target/criterion
```

## Best Practices for Performance Comparison

### 1. Consistent Environment

- **Same machine**: Run all benchmarks on the same hardware
- **Minimal load**: Close unnecessary applications
- **Stable state**: No background updates or tasks

### 2. Multiple Runs

Run benchmarks multiple times to ensure consistency:

```bash
# Run 3 times and compare
for i in 1 2 3; do
    echo "=== Run $i ==="
    cd bigweaver-agent-canary-zeta-hydro-deps
    cargo bench --save-baseline "timely_run$i"
    
    cd ../bigweaver-agent-canary-hydro-zeta  
    cargo bench -p benches --save-baseline "hydroflow_run$i"
done
```

### 3. Warm-Up

Ensure system is warmed up before critical measurements:

```bash
# Run once to warm up caches
cargo bench --quick

# Then run actual benchmark
cargo bench --save-baseline official
```

### 4. Document Conditions

Record environmental factors:

```bash
# Save system info with results
uname -a > system_info.txt
rustc --version >> system_info.txt
cargo --version >> system_info.txt
cat /proc/cpuinfo | grep "model name" | head -1 >> system_info.txt
free -h >> system_info.txt
```

## Troubleshooting Comparison Issues

### Results Don't Match

**Problem**: Benchmarks show unexpectedly large differences

**Possible causes**:
- Different optimization levels
- System load during execution
- Thermal throttling
- Background processes

**Solutions**:
- Ensure both use `cargo bench` (release mode)
- Monitor system load: `htop` or `top`
- Run at night or during low-activity periods
- Check temperature: `sensors` (Linux)

### Missing Benchmarks

**Problem**: Some benchmarks exist in one repo but not the other

**Explanation**: 
- Main repo has additional Hydroflow-specific benchmarks
- This repo only has timely/differential benchmarks
- Only compare benchmarks that exist in both

**Solution**: Focus on common benchmarks (identity, arithmetic, reachability, etc.)

## Conclusion

You should now be able to:
- ✅ Run benchmarks in both repositories
- ✅ Compare results effectively
- ✅ Understand performance differences
- ✅ Create comparison reports
- ✅ Apply best practices for fair comparison

## Additional Resources

- **Criterion.rs Guide**: https://bheisler.github.io/criterion.rs/book/
- **Statistical Analysis**: Understanding confidence intervals and p-values
- **Performance Engineering**: General principles for benchmark design

## Next Steps

- Review [RELATIONSHIP_TO_MAIN_REPO.md](RELATIONSHIP_TO_MAIN_REPO.md) for architectural context
- Experiment with different workload sizes
- Create custom comparison scripts for your use case
- Document findings and share with the team
