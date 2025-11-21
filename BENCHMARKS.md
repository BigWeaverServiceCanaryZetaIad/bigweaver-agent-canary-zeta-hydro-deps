# Benchmark Documentation

This document provides detailed information about each benchmark in this repository, including what they test, how to run them, and how to interpret the results.

## Overview

These benchmarks compare timely and differential-dataflow implementations against baseline implementations. They complement the Hydroflow benchmarks in the main `bigweaver-agent-canary-hydro-zeta` repository, enabling comprehensive performance comparisons.

## Benchmark Categories

### 1. Data Flow Patterns

These benchmarks test basic dataflow patterns that are common in stream processing systems.

#### arithmetic.rs

**Purpose**: Tests arithmetic operation pipelines with multiple sequential transformations.

**What it measures**:
- Timely dataflow performance for simple map operations
- Overhead of dataflow frameworks vs raw operations
- Iterator performance
- Pipeline threading performance

**Implementations**:
- `arithmetic/timely` - Timely dataflow implementation
- `arithmetic/raw` - Raw vector operations (baseline)
- `arithmetic/iter` - Iterator-based operations
- `arithmetic/iter-collect` - Iterator with collection
- `arithmetic/pipeline` - Multi-threaded pipeline

**Configuration**:
- Operations: 20 sequential additions
- Data size: 1,000,000 integers

**How to run**:
```bash
cargo bench --bench arithmetic
```

**Interpretation**:
- Lower times are better
- Compare `timely` against baselines to see framework overhead
- `raw` provides theoretical minimum time
- `iter` shows optimized iterator performance

#### identity.rs

**Purpose**: Tests the overhead of passing data through dataflow operators without transformation.

**What it measures**:
- Minimal dataflow overhead
- Memory allocation patterns
- Data movement costs

**Implementations**:
- `identity/timely` - Timely identity operation
- `identity/raw` - Direct data copying

**How to run**:
```bash
cargo bench --bench identity
```

#### upcase.rs

**Purpose**: Tests string transformation operations.

**What it measures**:
- String processing overhead
- Allocation-heavy operations
- Text transformation performance

**Implementations**:
- `upcase/timely` - Timely-based string transformation
- `upcase/raw` - Direct string operations

**How to run**:
```bash
cargo bench --bench upcase
```

### 2. Graph Patterns

These benchmarks test more complex dataflow graph structures.

#### fan_in.rs

**Purpose**: Tests multiple inputs converging to a single output (N→1 pattern).

**What it measures**:
- Union/merge operations
- Multi-source coordination
- Synchronization overhead

**Implementations**:
- `fan_in/timely` - Timely implementation with multiple inputs
- `fan_in/raw` - Raw channel-based implementation

**Configuration**:
- Number of inputs: Configurable (typically 4-8)
- Data size: 100,000 integers per input

**How to run**:
```bash
cargo bench --bench fan_in
```

**Interpretation**:
- Look for scalability with number of inputs
- Compare synchronization overhead vs raw channels

#### fan_out.rs

**Purpose**: Tests single input distributing to multiple outputs (1→N pattern).

**What it measures**:
- Broadcast/distribution operations
- Multi-consumer patterns
- Cloning overhead

**Implementations**:
- `fan_out/timely` - Timely broadcast implementation
- `fan_out/raw` - Raw multi-channel implementation

**Configuration**:
- Number of outputs: Configurable (typically 4-8)
- Data size: 100,000 integers

**How to run**:
```bash
cargo bench --bench fan_out
```

#### fork_join.rs

**Purpose**: Tests fork-join patterns where data splits, transforms, and merges.

**What it measures**:
- Complex graph patterns
- Parallel branch execution
- Join synchronization

**Implementations**:
- `fork_join/timely` - Timely fork-join implementation
- `fork_join/raw` - Raw thread-based implementation

**How to run**:
```bash
cargo bench --bench fork_join
```

### 3. Relational Operations

These benchmarks test database-style operations.

#### join.rs

**Purpose**: Tests join operations between two streams.

**What it measures**:
- Hash join performance
- State management overhead
- Memory efficiency for joins

**Implementations**:
- `join/timely` - Timely join implementation
- `join/raw` - Raw HashMap-based join

**Configuration**:
- Left input size: 10,000 tuples
- Right input size: 10,000 tuples
- Key space: 100 unique keys

**How to run**:
```bash
cargo bench --bench join
```

**Interpretation**:
- Pay attention to memory usage patterns
- Compare state management overhead
- Look at throughput vs data size scaling

### 4. Incremental Computation

These benchmarks test differential dataflow's incremental computation capabilities.

#### reachability.rs

**Purpose**: Tests graph reachability algorithms using both timely and differential dataflow.

**What it measures**:
- Iterative computation performance
- Differential dataflow incremental updates
- Fixed-point computation
- Graph algorithm efficiency

**Implementations**:
- `reachability/timely` - Timely implementation with explicit iteration
- `reachability/differential` - Differential dataflow with automatic incrementalization
- `reachability/raw` - Raw iterative algorithm

**Data files**:
- `reachability_edges.txt` - Graph edges
- `reachability_reachable.txt` - Expected reachable nodes

**Configuration**:
- Graph: Real-world graph structure from file
- Algorithm: Transitive closure computation

**How to run**:
```bash
cargo bench --bench reachability
```

**Interpretation**:
- This is the most complex benchmark
- Differential dataflow should excel at incremental updates
- Compare convergence time and memory usage
- Pay attention to iteration count and fixed-point detection

## Running All Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run with specific filters:

```bash
# Run only timely benchmarks
cargo bench timely

# Run only differential benchmarks
cargo bench differential

# Run only raw/baseline benchmarks
cargo bench raw
```

## Benchmark Output

Criterion generates detailed reports in `target/criterion/`:

- **HTML Reports**: `target/criterion/report/index.html`
- **JSON Data**: `target/criterion/<benchmark>/*/estimates.json`
- **CSV Data**: `target/criterion/<benchmark>/*/sample.json`

### Understanding the Output

Each benchmark shows:
- **Time**: Mean execution time with confidence intervals
- **Throughput**: Operations per second (if applicable)
- **Comparison**: Change from previous run (if available)

Example output:
```
arithmetic/timely       time:   [45.123 ms 45.456 ms 45.789 ms]
                        change: [-2.3% -1.8% -1.2%] (p = 0.00 < 0.05)
                        Performance has improved.
```

## Comparing with Hydroflow

To compare these benchmarks with Hydroflow implementations:

1. **Run benchmarks in this repository**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

2. **Run benchmarks in main repository**:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Compare results**:
   - View HTML reports side by side
   - Use the `compare_benchmarks.sh` script
   - Use critcmp tool: `cargo install critcmp`

### Benchmark Name Mappings

| Deps Repo (Timely/DD) | Main Repo (Hydroflow) | Notes |
|----------------------|----------------------|-------|
| arithmetic/timely | arithmetic/dfir_rs/compiled | Same operation pipeline |
| arithmetic/timely | arithmetic/dfir_rs/interpreted | Interpreted version |
| fan_in/timely | fan_in/dfir_rs/* | Fan-in pattern |
| fan_out/timely | fan_out/dfir_rs/* | Fan-out pattern |
| fork_join/timely | fork_join/dfir_rs/* | Fork-join pattern |
| identity/timely | identity/dfir_rs/* | Identity pass-through |
| join/timely | join/dfir_rs/* | Join operation |
| reachability/timely | reachability/dfir_rs/* | Iterative algorithm |
| reachability/differential | reachability/dfir_rs/* | Incremental algorithm |
| upcase/timely | upcase/dfir_rs/* | String transformation |

## Performance Analysis Tips

### What to Look For

1. **Absolute Performance**:
   - How fast is each implementation?
   - What is the overhead vs baseline?

2. **Scalability**:
   - How does performance change with data size?
   - How does it scale with parallelism?

3. **Memory Usage**:
   - How much memory does each approach use?
   - Are there memory leaks or unbounded growth?

4. **Consistency**:
   - Are results consistent across runs?
   - What is the variance/confidence interval?

### Common Patterns

- **Timely overhead**: Expect 2-5x overhead vs raw for simple operations
- **Differential gains**: Significant advantages for incremental updates
- **Batch size impact**: Larger batches often amortize overhead
- **Parallelism**: Benefits depend on workload characteristics

## Advanced Usage

### Custom Benchmark Runs

You can customize benchmark behavior using environment variables:

```bash
# Longer measurement time for more accurate results
CRITERION_MEASUREMENT_TIME=10 cargo bench

# Fewer samples for faster iteration
CRITERION_SAMPLE_SIZE=10 cargo bench

# Save baseline for future comparisons
cargo bench -- --save-baseline my-baseline

# Compare against saved baseline
cargo bench -- --baseline my-baseline
```

### Profiling

To profile benchmarks:

```bash
# With perf (Linux)
cargo bench --bench arithmetic --profile-time 10

# With flamegraph
cargo flamegraph --bench arithmetic

# With valgrind
valgrind --tool=callgrind cargo bench --bench arithmetic --profile-time 1
```

## Troubleshooting

### Benchmarks Taking Too Long

If benchmarks take too long:
1. Reduce sample size: `CRITERION_SAMPLE_SIZE=10 cargo bench`
2. Run specific benchmarks: `cargo bench --bench arithmetic`
3. Use `--quick` flag in criterion (if available)

### Inconsistent Results

If results vary significantly:
1. Close other applications
2. Disable CPU frequency scaling
3. Run on dedicated hardware
4. Increase measurement time: `CRITERION_MEASUREMENT_TIME=10`

### Compilation Errors

If benchmarks don't compile:
1. Update dependencies: `cargo update`
2. Check Rust version: `rustc --version` (should be 1.70+)
3. Clean build: `cargo clean && cargo build`

## Contributing

When adding new benchmarks:

1. Follow the existing naming pattern
2. Include baseline implementations for comparison
3. Document what the benchmark measures
4. Add appropriate configuration constants
5. Update this document with benchmark details
6. Test with various data sizes

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow Documentation](https://hydro.run/)

## Changelog

### Current Version
- Initial benchmark suite with 8 benchmarks
- Covers basic patterns, graph patterns, and incremental computation
- Full comparison documentation
