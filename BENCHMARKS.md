# Available Benchmarks

This document provides a detailed overview of all available benchmarks in this repository.

## Benchmark List

### 1. Arithmetic (`arithmetic.rs`)
**Purpose**: Tests arithmetic operations performance  
**Operations**: Addition operations on stream elements  
**Frameworks**: Pipeline, Hydro (dfir), Timely, Differential  
**Data Size**: 1,000,000 integers, 20 operations  
**Use Case**: Baseline for computational overhead

### 2. Fan-In (`fan_in.rs`)
**Purpose**: Tests multiple input streams merging into one output  
**Pattern**: Multiple producers → Single consumer  
**Frameworks**: Pipeline, Hydro (dfir), Timely, Differential  
**Data Size**: 1,000,000 integers split across streams  
**Use Case**: Measuring merge/union performance

### 3. Fan-Out (`fan_out.rs`)
**Purpose**: Tests single input stream splitting to multiple outputs  
**Pattern**: Single producer → Multiple consumers  
**Frameworks**: Pipeline, Hydro (dfir), Timely, Differential  
**Data Size**: 1,000,000 integers distributed to multiple streams  
**Use Case**: Measuring broadcast/tee performance

### 4. Fork-Join (`fork_join.rs`)
**Purpose**: Tests fork-join parallelism pattern  
**Pattern**: Split → Process in parallel → Merge  
**Frameworks**: Hydro (dfir), Timely, Differential  
**Data Size**: Configurable, 20 operations (generated at build time)  
**Use Case**: Parallel computation with synchronization  
**Note**: Uses generated code from `build.rs`

### 5. Futures (`futures.rs`)
**Purpose**: Tests async/await and futures handling  
**Operations**: Asynchronous stream processing with tokio  
**Frameworks**: Hydro (dfir), Raw async  
**Data Size**: 1,000,000 integers  
**Use Case**: Async runtime overhead comparison

### 6. Identity (`identity.rs`)
**Purpose**: Tests identity transformations (no-op)  
**Operations**: Pass-through operations without modification  
**Frameworks**: Pipeline, Raw copy, Hydro (dfir), Timely, Differential  
**Data Size**: 1,000,000 integers, 20 operations  
**Use Case**: Baseline overhead measurement - theoretical minimum

### 7. Join (`join.rs`)
**Purpose**: Tests two-way stream join operations  
**Operations**: Joining two streams on a key  
**Frameworks**: Hydro (dfir), Timely, Differential  
**Data Size**: 1,000,000 elements per stream  
**Use Case**: Measuring join performance and memory usage

### 8. Micro-Operations (`micro_ops.rs`)
**Purpose**: Tests low-level operation performance  
**Operations**: Map, filter, fold, join, group_by, etc.  
**Frameworks**: Hydro (dfir), Timely  
**Data Size**: Varies by operation  
**Use Case**: Detailed operation-specific performance analysis

### 9. Reachability (`reachability.rs`)
**Purpose**: Tests graph reachability algorithms  
**Algorithm**: Iterative graph traversal to find reachable nodes  
**Frameworks**: Hydro (dfir), Timely, Differential  
**Data**: Real graph data from files  
  - `reachability_edges.txt` (521KB) - Graph edges
  - `reachability_reachable.txt` (38KB) - Expected results  
**Use Case**: Iterative computation and fixed-point algorithms

### 10. Symmetric Hash Join (`symmetric_hash_join.rs`)
**Purpose**: Tests symmetric hash join implementation  
**Operations**: Hash-based join with symmetric processing  
**Frameworks**: Hydro (dfir compiled), Hydro (dfir scheduled)  
**Data Size**: 1,000,000 elements per stream  
**Use Case**: Comparing compiled vs scheduled execution

### 11. Upcase (`upcase.rs`)
**Purpose**: Tests string transformation operations  
**Operations**: Converting strings to uppercase  
**Frameworks**: Pipeline, Hydro (dfir), Timely  
**Data Size**: 1,000,000 string operations  
**Use Case**: String processing and memory allocation overhead

### 12. Words Diamond (`words_diamond.rs`)
**Purpose**: Tests complex diamond-shaped pipeline  
**Pattern**: Split → Multiple processing paths → Merge  
**Frameworks**: Hydro (dfir), Timely, Differential  
**Data**: `words_alpha.txt` (3.7MB) - English word list  
**Operations**: Word filtering, transformation, and aggregation  
**Use Case**: Complex multi-stage pipeline performance

## Framework Comparison Matrix

| Benchmark | Pipeline | Raw | Hydro | Timely | Differential |
|-----------|----------|-----|-------|--------|--------------|
| arithmetic | ✓ | ✗ | ✓ | ✓ | ✓ |
| fan_in | ✓ | ✗ | ✓ | ✓ | ✓ |
| fan_out | ✓ | ✗ | ✓ | ✓ | ✓ |
| fork_join | ✗ | ✗ | ✓ | ✓ | ✓ |
| futures | ✗ | ✓ | ✓ | ✗ | ✗ |
| identity | ✓ | ✓ | ✓ | ✓ | ✓ |
| join | ✗ | ✗ | ✓ | ✓ | ✓ |
| micro_ops | ✗ | ✗ | ✓ | ✓ | ✗ |
| reachability | ✗ | ✗ | ✓ | ✓ | ✓ |
| symmetric_hash_join | ✗ | ✗ | ✓ | ✗ | ✗ |
| upcase | ✓ | ✗ | ✓ | ✓ | ✗ |
| words_diamond | ✗ | ✗ | ✓ | ✓ | ✓ |

## Data Files

### reachability_edges.txt (521KB)
- Format: Edge list for graph
- Used by: `reachability.rs`
- Purpose: Real-world graph data for reachability testing

### reachability_reachable.txt (38KB)
- Format: List of reachable node IDs
- Used by: `reachability.rs`
- Purpose: Expected results for verification

### words_alpha.txt (3.7MB)
- Format: List of English words (one per line)
- Source: https://github.com/dwyl/english-words
- Used by: `words_diamond.rs`
- Purpose: Text processing workload

## Running Specific Benchmarks

```bash
# All benchmarks
cargo bench -p benches

# Single benchmark
cargo bench -p benches --bench identity

# Specific framework within benchmark
cargo bench -p benches --bench identity -- dfir
cargo bench -p benches --bench identity -- timely
cargo bench -p benches --bench identity -- differential

# Multiple related benchmarks
cargo bench -p benches -- join
```

## Performance Metrics

All benchmarks use Criterion which provides:
- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Statistical Analysis**: Mean, standard deviation, outliers
- **Regression Detection**: Comparison with previous runs
- **HTML Reports**: Detailed graphs and visualizations

## Interpreting Results

- **Lower is better** for timing measurements
- **Higher is better** for throughput measurements
- Check the variance - high variance indicates inconsistent performance
- Compare across frameworks to identify performance characteristics
- Review HTML reports in `target/criterion/` for detailed analysis

## Adding New Benchmarks

To add a new benchmark:

1. Create `benches/benches/your_benchmark.rs`
2. Follow the criterion benchmark structure
3. Add `[[bench]]` entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
4. Update this documentation
5. Run to verify: `cargo bench -p benches --bench your_benchmark`
