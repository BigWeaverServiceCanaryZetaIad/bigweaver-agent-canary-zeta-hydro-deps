# Timely and Differential Dataflow Benchmarks

This directory contains comprehensive benchmarks comparing timely-dataflow and differential-dataflow with other dataflow frameworks used in the bigweaver-agent-canary ecosystem.

## Overview

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Separate timely and differential-dataflow dependencies from the core codebase
- Enable detailed performance comparisons between different dataflow implementations
- Maintain a focused benchmark suite for timely/differential-specific testing
- Reduce build times in the main repository

### What These Benchmarks Test

Each benchmark implements the same computational pattern across multiple frameworks to enable fair performance comparisons:

1. **Timely Dataflow**: Low-latency cyclic dataflow system
2. **Differential Dataflow**: Incremental computation based on Timely
3. **Hydroflow**: The main dataflow framework being evaluated
4. **Babyflow**: A simpler reference implementation
5. **Spinachflow**: Another dataflow variant
6. **Pipeline**: Basic multi-threaded baseline for comparison

## Running Benchmarks

### Run All Benchmarks

From the repository root:
```bash
cargo bench -p timely-differential-benches
```

Or from this directory:
```bash
cd timely-differential-benches
cargo bench
```

### Run Specific Benchmarks

Run individual benchmarks by name:
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

### Filter by Framework

Run benchmarks for a specific framework:
```bash
# Only timely-dataflow implementations
cargo bench -p timely-differential-benches -- timely

# Only differential-dataflow implementations
cargo bench -p timely-differential-benches -- differential

# Only hydroflow implementations
cargo bench -p timely-differential-benches -- hydroflow

# Only baseline pipeline implementations
cargo bench -p timely-differential-benches -- pipeline
```

### Performance Testing Tips

1. **Close unnecessary applications** to reduce system noise
2. **Disable CPU frequency scaling** for consistent results (if possible)
3. **Run benchmarks multiple times** to account for variance
4. **Check system load** before benchmarking
5. **Use consistent power settings** (especially on laptops)

## Benchmark Descriptions

### arithmetic
**Purpose**: Tests the overhead of chaining arithmetic operations through a dataflow graph.

**What it does**:
- Creates a stream of 1,000,000 integers
- Applies 20 sequential addition operations (+1 each)
- Measures total throughput and per-operation overhead

**Key insights**:
- Shows base overhead of each framework
- Tests pipeline efficiency for simple operations
- Reveals optimization effectiveness for operation chains

**Frameworks tested**: babyflow, timely, hydroflow, hydroflow+, pipeline

---

### identity
**Purpose**: Measures the minimum overhead of passing data through operators without transformations.

**What it does**:
- Streams 1,000,000 integers through 20 identity (pass-through) operations
- No actual computation, just data movement
- Purest test of framework overhead

**Key insights**:
- Baseline performance metric for any framework
- Shows minimum cost per operator
- Indicates memory allocation and copying overhead
- Critical for understanding more complex benchmarks

**Frameworks tested**: babyflow, timely, hydroflow, hydroflow+, pipeline

---

### fan_in
**Purpose**: Tests the efficiency of aggregating multiple input streams into one.

**What it does**:
- Creates multiple source streams (various input patterns)
- Merges/concatenates them into a single stream
- Measures aggregation overhead

**Key insights**:
- Important for scatter-gather patterns
- Tests synchronization mechanisms
- Shows how frameworks handle multiple producers

**Frameworks tested**: babyflow, timely, hydroflow, hydroflow+

---

### fan_out
**Purpose**: Tests the efficiency of distributing one stream to multiple downstream operators.

**What it does**:
- Creates a single source stream
- Broadcasts/splits to multiple consumers
- Measures distribution overhead

**Key insights**:
- Critical for parallel processing patterns
- Tests data replication efficiency
- Shows how frameworks handle multiple consumers

**Frameworks tested**: babyflow, timely, hydroflow, hydroflow+

---

### fork_join
**Purpose**: Tests parallel fork-join patterns where work is split, processed in parallel, and rejoined.

**What it does**:
- Splits a stream into parallel branches
- Applies transformations independently
- Rejoins results with various strategies (concatenate, zip, etc.)
- Tests multiple join patterns

**Key insights**:
- Essential pattern for parallel algorithms
- Tests both splitting and joining efficiency
- Shows coordination overhead between parallel branches
- Reveals synchronization costs

**Frameworks tested**: babyflow, timely, hydroflow, hydroflow+

---

### join
**Purpose**: Tests stream join operations (similar to database joins).

**What it does**:
- Creates two streams with matching keys
- Performs inner join on key values
- Tests with different data types (usize, String)
- Processes 100,000 elements per stream

**Key insights**:
- Critical operation for data processing
- Tests hash table or index efficiency
- Shows memory usage patterns
- Different performance for different data types

**Frameworks tested**: babyflow, timely, hydroflow, hydroflow+, differential

---

### reachability
**Purpose**: Computes graph reachability (which nodes are reachable from a start node).

**What it does**:
- Loads a real graph from `reachability_edges.txt`
- Implements iterative reachability algorithm with cycles
- Uses feedback loops to propagate reachability
- Verifies results against known correct output

**Key insights**:
- Tests cyclic dataflow (feedback loops)
- Real-world algorithm benchmark
- Shows iterative computation performance
- Tests convergence detection

**Data files**:
- `reachability_edges.txt`: Graph edges (532 KB, represents a complex graph)
- `reachability_reachable.txt`: Expected reachable nodes for verification

**Frameworks tested**: timely, hydroflow, hydroflow+, differential

---

### upcase
**Purpose**: Tests string transformation operations.

**What it does**:
- Streams strings through uppercase transformation
- Tests with different string types and patterns
- Measures string handling overhead

**Key insights**:
- Shows performance with heap-allocated data
- Tests memory allocation patterns
- Relevant for text processing workloads

**Frameworks tested**: babyflow, timely, hydroflow, hydroflow+

---

### zip
**Purpose**: Tests the zip operation (combining elements from two streams pairwise).

**What it does**:
- Creates two synchronized streams
- Pairs up elements (first with first, second with second, etc.)
- Measures synchronization and pairing overhead

**Key insights**:
- Tests stream synchronization
- Shows buffering behavior
- Important for correlated stream processing

**Frameworks tested**: babyflow, timely, hydroflow, hydroflow+

## Data Files

### reachability_edges.txt
- **Size**: 532 KB
- **Format**: Space-separated pairs of node IDs (one edge per line)
- **Purpose**: Graph edge list for reachability benchmark
- **Content**: Real graph data representing complex connectivity patterns
- **Usage**: Loaded by the reachability benchmark to test iterative graph algorithms

**Example format**:
```
1 2
1 3
2 4
3 4
...
```

### reachability_reachable.txt
- **Size**: 38 KB
- **Format**: One node ID per line
- **Purpose**: Expected set of reachable nodes for verification
- **Usage**: Used to verify correctness of reachability computation
- **Content**: All nodes that should be reachable from the starting node(s)

## Understanding Results

### Interpreting Benchmark Output

When you run benchmarks, Criterion provides detailed statistics:

```
identity/timely         time:   [45.234 ms 45.678 ms 46.123 ms]
                        change: [-2.5% -1.2% +0.3%] (p = 0.15 > 0.05)
                        Performance has improved.
```

**What this means**:
- **time**: `[lower_bound mean upper_bound]` - 95% confidence interval
- **change**: Percentage change from previous run
- **p-value**: Statistical significance (< 0.05 means significant change)

### Comparing Framework Performance

When comparing frameworks, look at:

1. **Absolute Performance**:
   - Which framework is fastest for this workload?
   - What's the performance difference (2x? 10x? negligible?)

2. **Scaling Behavior**:
   - How does performance change with data size?
   - Does the framework maintain consistent performance?

3. **Overhead Characteristics**:
   - Check `identity` benchmark for minimum overhead
   - Compare to `arithmetic` to see optimization effectiveness
   - Look at `fork_join` for parallelization overhead

4. **Specialized Operations**:
   - Some frameworks optimize certain patterns better
   - `join` performance varies significantly by implementation
   - `reachability` shows cyclic dataflow efficiency

### Typical Performance Patterns

**Expected relative performance** (varies by workload):

- **Pipeline**: Good baseline, high startup overhead
- **Timely**: Excellent for complex dataflows with cycles
- **Differential**: Best for incremental computation (when applicable)
- **Hydroflow**: Optimized for stream processing, low latency
- **Hydroflow+**: Enhanced version with additional optimizations
- **Babyflow**: Simpler model, useful for understanding concepts

## Cross-Repository Comparison

To compare performance between this repository and the main `bigweaver-agent-canary-hydro-zeta` repository, use the comparison script in the parent directory:

```bash
cd ..
./scripts/compare_benchmarks.sh
```

### What Gets Compared

The comparison script will:
1. Run all benchmarks in this repository (timely/differential implementations)
2. Run corresponding benchmarks in the main repository (hydroflow-only implementations)
3. Generate reports showing side-by-side performance

### Setting Up for Comparison

**Option 1: Default location**
```bash
# Ensure repositories are side-by-side
/projects/
  ├── bigweaver-agent-canary-zeta-hydro-deps/
  └── bigweaver-agent-canary-hydro-zeta/
```

**Option 2: Custom location**
```bash
export MAIN_REPO_DIR=/path/to/bigweaver-agent-canary-hydro-zeta
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
./scripts/compare_benchmarks.sh
```

### Analyzing Comparison Results

After running the comparison:

1. **Check terminal output** for high-level summary
2. **Open HTML reports**:
   - Deps repo: `target/criterion/report/index.html`
   - Main repo: `../bigweaver-agent-canary-hydro-zeta/target/criterion/report/index.html`
3. **Compare equivalent benchmarks**:
   - `identity/timely` vs `identity/hydroflow`
   - `join/timely/usize/usize` vs `join/hydroflow/usize/usize`
   - etc.

### Performance Comparison Methodology

For fair comparisons:

1. **Run on the same machine** with consistent conditions
2. **Close background applications** to reduce noise
3. **Run multiple times** and look at trends, not single runs
4. **Consider workload characteristics**:
   - Simple operations (identity, arithmetic): favor low-overhead frameworks
   - Complex operations (join, reachability): may favor specialized frameworks
   - Cyclic dataflows (reachability): timely excels here

5. **Look beyond raw speed**:
   - Memory usage (not directly measured, but affects performance)
   - Code complexity and maintainability
   - Feature set (incremental computation, windowing, etc.)
   - Ease of debugging and profiling

### Understanding Cross-Framework Differences

Different frameworks have different strengths:

**Timely Dataflow**:
- ✅ Excellent for cyclic dataflows (iterative algorithms)
- ✅ Low-latency message passing
- ✅ Mature and well-tested
- ❌ More complex API
- ❌ Heavier dependencies

**Differential Dataflow**:
- ✅ Incremental computation (recompute only what changed)
- ✅ Built on Timely's solid foundation
- ✅ Excellent for maintaining computations over changing data
- ❌ Higher overhead for non-incremental workloads
- ❌ Specialized use cases

**Hydroflow** (main repository):
- ✅ Optimized for stream processing
- ✅ Designed for this specific project's needs
- ✅ Simpler mental model
- ✅ Better integration with project architecture
- ❌ May have different trade-offs than Timely

## Migration History

These benchmarks were migrated from the main repository on **December 20, 2025** to reduce dependency bloat. For detailed migration information, see `MIGRATION.md` in the repository root.

### Why These Benchmarks Are Separated

1. **Dependency Management**: Timely and differential-dataflow are large dependencies
2. **Build Time**: Compiling these frameworks adds significant time to main repo builds
3. **Focus**: Main repository focuses on Hydroflow; these benchmarks provide comparison data
4. **Flexibility**: Allows updating timely/differential versions independently

### Related Documentation

- **Repository README**: `../README.md` - Overview and quick start
- **Migration Details**: `../MIGRATION.md` - Full migration history and process
- **Comparison Script**: `../scripts/compare_benchmarks.sh` - Automated cross-repo benchmarking
- **Main Repository**: `../bigweaver-agent-canary-hydro-zeta/README.md` - Information about the Hydroflow implementation
