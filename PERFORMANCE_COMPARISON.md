# Performance Comparison Methodology

This document describes how to perform meaningful performance comparisons between DFIR/Hydro and Timely/Differential Dataflow using the benchmarks in this repository.

## Overview

The benchmarks in this repository are designed to provide fair and meaningful comparisons between:
- **DFIR (Dataflow Intermediate Representation)**: The core dataflow engine in Hydro
- **Hydro**: The high-level dataflow language built on DFIR
- **Timely Dataflow**: An established dataflow framework for data-parallel computation
- **Differential Dataflow**: An incremental computation framework built on Timely

## Benchmark Design Principles

### 1. Apples-to-Apples Comparisons

Each benchmark implements the same logical computation across all frameworks:
- Identical input data
- Equivalent algorithms
- Same output validation
- Comparable optimization levels

### 2. Multiple Performance Dimensions

Benchmarks measure different aspects:
- **Throughput**: Items processed per second
- **Latency**: Time to process a batch
- **Memory usage**: Peak memory consumption (via profiling)
- **Scalability**: Performance with varying data sizes

### 3. Baseline Comparisons

Most benchmarks include baseline implementations:
- **Raw iteration**: Direct Rust iterators
- **Pipeline channels**: Simple thread + channel implementation
- **Raw copy**: Minimal overhead baseline

These baselines help interpret framework overhead.

## Benchmark Categories

### Stream Processing Benchmarks

#### Arithmetic (`arithmetic.rs`)
**What it tests**: Pipeline of map operations
**Frameworks compared**: Timely, DFIR surface syntax, Rust iterators
**Key metric**: Throughput for 1M integers through 20 operations
**Purpose**: Measures operator fusion and pipeline efficiency

```bash
cargo bench --bench arithmetic
```

**Interpreting results**:
- `arithmetic/iter`: Best-case Rust iterator performance
- `arithmetic/timely`: Timely Dataflow overhead
- `arithmetic/dfir_rs/surface`: DFIR with surface syntax
- Lower is better for execution time

#### Identity (`identity.rs`)
**What it tests**: Passthrough operations (no transformation)
**Purpose**: Measures minimum framework overhead
**Key insight**: Shows baseline cost of using each framework

```bash
cargo bench --bench identity
```

### Communication Pattern Benchmarks

#### Fan-In (`fan_in.rs`)
**What it tests**: Multiple inputs merging into one stream
**Frameworks**: Timely vs DFIR
**Purpose**: Tests merge/union efficiency

```bash
cargo bench --bench fan_in
```

#### Fan-Out (`fan_out.rs`)
**What it tests**: Broadcasting one stream to multiple outputs
**Purpose**: Tests tee/broadcast efficiency

```bash
cargo bench --bench fan_out
```

#### Fork-Join (`fork_join.rs`)
**What it tests**: Split computation and rejoin
**Purpose**: Measures parallelism and synchronization overhead

```bash
cargo bench --bench fork_join
```

### Stateful Operation Benchmarks

#### Join (`join.rs`)
**What it tests**: Stream join operations
**Purpose**: Measures state management and join performance
**Data**: Pairs of integer streams with various join cardinalities

```bash
cargo bench --bench join
```

**Interpreting results**:
- Compare setup cost vs. per-item cost
- Look at different join cardinalities (1:1, 1:N, N:M)

#### Symmetric Hash Join (`symmetric_hash_join.rs`)
**What it tests**: Hash-based symmetric join
**Purpose**: Alternative join implementation comparison

```bash
cargo bench --bench symmetric_hash_join
```

### Incremental Computation Benchmarks

#### Reachability (`reachability.rs`)
**What it tests**: Graph reachability computation
**Frameworks**: Differential Dataflow vs DFIR
**Purpose**: Tests incremental computation capabilities
**Data**: Real graph with 14,855 edges

```bash
cargo bench --bench reachability
```

**Interpreting results**:
- Initial computation time
- Incremental update performance (if supported)
- Memory overhead for maintaining state

**Key insights**:
- Differential Dataflow is optimized for incremental scenarios
- DFIR may excel at batch processing the same workload
- Compare both initial and update scenarios

### Text Processing Benchmarks

#### Upcase (`upcase.rs`)
**What it tests**: String transformation (uppercase)
**Purpose**: Non-numeric data processing overhead

```bash
cargo bench --bench upcase
```

#### Words Diamond (`words_diamond.rs`)
**What it tests**: Diamond-shaped dataflow with string data
**Data**: 370K word dictionary
**Purpose**: Complex dataflow pattern with realistic data

```bash
cargo bench --bench words_diamond
```

## Running Complete Performance Comparisons

### 1. Full Benchmark Suite

Run all benchmarks with detailed output:
```bash
cargo bench --benches 2>&1 | tee benchmark_results.txt
```

### 2. Generate Comparison Report

After running benchmarks, view the HTML report:
```bash
open target/criterion/report/index.html
# or on Linux:
xdg-open target/criterion/report/index.html
```

### 3. Historical Comparison

Criterion.rs automatically compares against previous runs:
```bash
# First run establishes baseline
cargo bench

# Make changes to DFIR/Hydro

# Second run compares
cargo bench
```

Look for lines like:
```
change: [-5.2345% -1.2345% +2.1234%] (p = 0.23 > 0.05)
```

## Performance Analysis Guidelines

### Statistical Significance

Criterion.rs provides:
- **Confidence intervals**: Range of likely true performance
- **P-values**: Statistical significance of changes
- **Outlier analysis**: Identifies anomalous measurements

**Rule of thumb**:
- Changes < 5% may be noise
- P-value > 0.05 means not statistically significant
- Run multiple times for consistency

### Environmental Factors

For reproducible results:

1. **Disable CPU frequency scaling**:
   ```bash
   # Linux
   sudo cpupower frequency-set --governor performance
   ```

2. **Close unnecessary applications**

3. **Run on idle machine**

4. **Use release builds**:
   ```bash
   cargo bench  # Already uses release profile
   ```

### Comparing Across Frameworks

When comparing DFIR vs Timely/Differential:

#### Consider:
- **Optimization levels**: Are both equally optimized?
- **API differences**: High-level vs low-level APIs
- **Use case fit**: Is the benchmark representative of target workloads?
- **Framework maturity**: Timely/Differential are more mature

#### Don't conclude:
- "Framework X is always faster" - depends on workload
- Small differences are meaningful without statistical backing
- Micro-benchmark results directly translate to real applications

## Interpreting Specific Benchmarks

### Arithmetic Pipeline

```
arithmetic/iter:          100 ns
arithmetic/timely:        250 ns  
arithmetic/dfir:          200 ns
```

**Analysis**: 
- Timely has 2.5x overhead vs raw iteration
- DFIR has 2x overhead vs raw iteration
- DFIR is 20% faster than Timely for this workload

**Why**: Pipeline operator fusion, less abstraction overhead

### Reachability (Incremental)

```
reachability/differential: 50 ms (initial), 5 ms (update)
reachability/dfir:        30 ms (initial), N/A (update)
```

**Analysis**:
- DFIR faster for one-shot batch processing
- Differential better for incremental scenarios
- 10x speedup for updates justifies differential's overhead

**When to use what**:
- Frequent updates → Differential Dataflow
- Batch processing → DFIR/Hydro

## Performance Tuning Tips

### For DFIR/Hydro

1. **Use surface syntax**: Often better optimized
2. **Enable debugging features selectively**: `features = ["debugging"]` only when needed
3. **Consider operator fusion**: Sequential operations may fuse

### For Timely

1. **Worker threads**: Adjust for your CPU
   ```rust
   timely::execute_from_args(std::env::args(), |worker| {
       // worker count from args
   })
   ```

2. **Batch sizes**: Larger batches amortize overhead

### For Differential Dataflow

1. **Arrangement tuning**: Choose appropriate indexes
2. **Consolidation**: Control when consolidation happens
3. **Garbage collection**: Tune for your data characteristics

## Benchmark Maintenance

### Adding New Benchmarks

1. **Define clear hypothesis**: What are you testing?
2. **Implement in all frameworks**: Fair comparison
3. **Include baselines**: Raw Rust for context
4. **Document expectations**: What should results show?
5. **Add to criterion group**: Register in `criterion_group!` macro

### Updating Benchmarks

When frameworks change:
1. **Preserve old implementations**: For historical comparison
2. **Document API changes**: Why code changed
3. **Re-establish baselines**: Old results may not be comparable
4. **Update this document**: Reflect new insights

## Common Pitfalls

### ❌ Micro-benchmark Fallacies

- **Black-boxing**: Always use `black_box()` for outputs
- **Inlining**: Compiler may optimize away work
- **Cold vs warm**: First run may be slower (compilation, caching)

### ❌ Comparison Mistakes

- **Different input sizes**: Must use same data
- **Debug vs release**: Always benchmark in release mode
- **Unfair optimizations**: Enable or disable consistently

### ✅ Best Practices

- **Multiple runs**: Validate consistency
- **Document machine specs**: Include in reports
- **Version control**: Track which versions are compared
- **Peer review**: Have others validate methodology

## Reporting Results

### Internal Reports

Include:
1. **Benchmark command**: Exact command run
2. **Machine specs**: CPU, RAM, OS
3. **Framework versions**: Git commits or version numbers
4. **Full results**: Not just summary statistics
5. **Analysis**: What the numbers mean

### External Publication

Consider:
1. **Representative workloads**: Not just micro-benchmarks
2. **Multiple data points**: Various sizes, patterns
3. **Statistical rigor**: Confidence intervals, significance
4. **Fair comparison**: Document any advantages/disadvantages
5. **Reproducibility**: Provide code and instructions

## Further Reading

- [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://docs.rs/timely/)
- [Differential Dataflow Documentation](https://docs.rs/differential-dataflow/)
- [Main DFIR/Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## Questions?

For questions about:
- **These benchmarks**: Open an issue in this repository
- **DFIR/Hydro performance**: Open an issue in the main repository
- **Methodology**: Consult the team's performance engineering guidelines
