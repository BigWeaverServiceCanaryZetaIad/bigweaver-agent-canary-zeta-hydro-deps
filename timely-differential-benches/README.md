# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks that use timely-dataflow and differential-dataflow dependencies for performance comparison with the main bigweaver-agent-canary-hydro-zeta repository.

## Overview

These benchmarks were migrated from the main repository to separate the timely and differential-dataflow dependencies from the core codebase while maintaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench upcase
cargo bench -p timely-differential-benches --bench zip
```

## Benchmark Descriptions

- **arithmetic** - Arithmetic operations benchmark comparing different dataflow frameworks
- **fan_in** - Fan-in pattern benchmark for data aggregation
- **fan_out** - Fan-out pattern benchmark for data distribution
- **fork_join** - Fork-join pattern benchmark
- **identity** - Identity operation benchmark (data pass-through)
- **join** - Join operation benchmark
- **reachability** - Graph reachability computation benchmark
- **upcase** - String uppercase transformation benchmark
- **zip** - Zip operation benchmark

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for verification

## Performance Comparison with Original Hydro Implementation

### Overview

This repository maintains benchmarks using timely-dataflow and differential-dataflow, which were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository. The migration allows for:
- Isolating heavy dependencies from the main codebase
- Maintaining the ability to compare performance between different dataflow implementations
- Running benchmarks separately without affecting main repository build times

### Running Performance Comparisons

#### Option 1: Automated Cross-Repository Comparison

Use the provided comparison script to run benchmarks in both repositories automatically:

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
./scripts/compare_benchmarks.sh
```

**What this does:**
1. Runs all timely/differential-dataflow benchmarks in this repository
2. Checks for and runs any benchmarks in the main repository (if they exist)
3. Saves results in each repository's `target/criterion` directory
4. Generates HTML reports for detailed performance analysis

**Environment Variables:**
- `MAIN_REPO_DIR`: Path to the main repository (default: `../bigweaver-agent-canary-hydro-zeta`)

Example with custom path:
```bash
MAIN_REPO_DIR=/path/to/bigweaver-agent-canary-hydro-zeta ./scripts/compare_benchmarks.sh
```

#### Option 2: Manual Benchmark Execution

Run benchmarks in each repository separately for more control:

**Step 1: Run timely/differential benchmarks (this repository)**
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benches
```

**Step 2: Run hydro-native benchmarks (main repository)**
```bash
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
cargo bench -p benches  # If hydro-native benchmarks exist
```

**Step 3: Compare results**
- Open `target/criterion/report/index.html` in each repository
- Compare metrics for equivalent benchmarks (throughput, latency, etc.)
- Look for performance characteristics specific to each dataflow framework

#### Option 3: Targeted Benchmark Comparison

Run specific benchmarks for focused comparison:

```bash
# Run specific timely/differential benchmark
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benches --bench arithmetic

# Run equivalent hydro benchmark (if exists)
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --bench arithmetic
```

### Understanding Benchmark Results

#### Result Location
- **Criterion reports**: `target/criterion/report/index.html` in each repository
- **Raw data**: `target/criterion/<benchmark-name>/` directories
- **Historical data**: Criterion maintains historical comparisons across runs

#### Key Metrics to Compare
1. **Throughput**: Items processed per second
2. **Latency**: Time per operation
3. **Memory usage**: Can be profiled separately
4. **Scalability**: How performance changes with input size

#### Performance Considerations

**Timely/Differential-Dataflow benchmarks (this repository):**
- Leverage data-parallel computation model
- Efficient for streaming and incremental computation
- Strong performance on large-scale data processing
- Optimized for distributed scenarios

**Hydro-native benchmarks (main repository):**
- May use different dataflow paradigms
- Potentially different optimization strategies
- Performance characteristics specific to hydro's architecture

### Benchmark Structure

Each benchmark in this repository:
1. Uses Criterion for accurate performance measurement
2. Configured with `harness = false` in Cargo.toml for custom harness
3. Tests specific dataflow patterns (fan-in, fan-out, joins, etc.)
4. Provides consistent testing across different frameworks

### Adding New Benchmarks

To add a new benchmark for comparison:

1. **Add benchmark file**: Create `benches/new_benchmark.rs`
2. **Register in Cargo.toml**:
   ```toml
   [[bench]]
   name = "new_benchmark"
   harness = false
   ```
3. **Implement using Criterion**:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("benchmark_name", |b| {
           // benchmark code
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```
4. **Add equivalent benchmark** in main repository for comparison

### Troubleshooting

**Script fails to find main repository:**
```bash
export MAIN_REPO_DIR=/path/to/bigweaver-agent-canary-hydro-zeta
./scripts/compare_benchmarks.sh
```

**Benchmarks take too long:**
- Run specific benchmarks instead of full suite
- Adjust Criterion sample size in benchmark code
- Use `--profile-time` to set shorter runtime

**Results differ significantly:**
- Ensure both repositories are on comparable commits
- Check for different input data sizes
- Verify similar compiler optimization levels
- Consider framework-specific optimizations

### Maintenance Notes

- **Dependency updates**: Update timely and differential-dataflow versions in this repo's Cargo.toml
- **Synchronization**: Keep benchmark logic consistent across repositories when comparing
- **Documentation**: Update this file when adding new benchmarks or changing comparison methodology
