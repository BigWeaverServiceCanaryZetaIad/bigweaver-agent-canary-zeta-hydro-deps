# Benchmark Documentation

## Overview

This repository contains comprehensive benchmarks comparing DFIR (Hydro) performance against timely-dataflow and differential-dataflow frameworks. The benchmarks cover various common streaming computation patterns and operations.

## Benchmark Categories

### 1. Basic Operations

#### Identity (`identity.rs`)
Tests the overhead of basic dataflow operations without computation.
- **DFIR variant**: Simple pass-through using `map` and `for_each`
- **Timely variant**: Direct stream processing
- **Differential variant**: Collection-based processing
- **Metrics**: Throughput, latency

#### Arithmetic (`arithmetic.rs`)
Tests computational performance with arithmetic operations.
- **Operations**: Addition, multiplication, division
- **DFIR variant**: Using `map` operators
- **Timely variant**: Stream transformations
- **Differential variant**: Collection arithmetic
- **Metrics**: Operations per second

#### Upcase (`upcase.rs`)
Tests string manipulation performance.
- **Operation**: String to uppercase conversion
- **Use case**: Text processing pipelines
- **Metrics**: Characters processed per second

### 2. Dataflow Patterns

#### Fan-in (`fan_in.rs`)
Tests merging multiple streams into one.
- **Pattern**: Multiple sources → single destination
- **DFIR variant**: Using `union` operator
- **Timely variant**: Stream concatenation
- **Metrics**: Merge throughput, ordering guarantees

#### Fan-out (`fan_out.rs`)
Tests splitting one stream into multiple.
- **Pattern**: Single source → multiple destinations
- **DFIR variant**: Using `tee` operator
- **Timely variant**: Stream replication
- **Metrics**: Distribution overhead

#### Fork-Join (`fork_join.rs`)
Tests parallel processing and synchronization.
- **Pattern**: Split → Process → Rejoin
- **Complexity**: 20 levels of forking
- **Generated code**: Uses build script to create test cases
- **Metrics**: Parallelization efficiency

#### Diamond (`words_diamond.rs`)
Tests complex dataflow graph patterns.
- **Pattern**: Split → Transform → Join
- **Use case**: Word processing with multiple transformations
- **Data**: Uses `words_alpha.txt` (370k+ words)
- **Metrics**: Graph execution overhead

### 3. Join Operations

#### Join (`join.rs`)
Tests basic join operations.
- **Operation**: Equi-join on key
- **DFIR variant**: Using `join` operator
- **Timely variant**: Time-based join
- **Differential variant**: Collection join
- **Metrics**: Join throughput, memory usage

#### Symmetric Hash Join (`symmetric_hash_join.rs`)
Tests symmetric hash join implementation.
- **Algorithm**: Hash-based join without sort
- **Use case**: Stream-stream joins
- **Metrics**: Hash table performance, memory efficiency

### 4. Graph Algorithms

#### Reachability (`reachability.rs`)
Tests graph reachability computation.
- **Algorithm**: Transitive closure computation
- **Data files**:
  - `reachability_edges.txt`: Graph edges (55k+ edges)
  - `reachability_reachable.txt`: Expected results (7k+ nodes)
- **DFIR variant**: Iterative computation
- **Differential variant**: Incremental computation
- **Metrics**: Convergence time, iterations required

### 5. Micro-benchmarks

#### Micro-ops (`micro_ops.rs`)
Fine-grained performance tests for individual operations.
- **Operations tested**:
  - `map`: Transformation operations
  - `filter`: Filtering operations
  - `flat_map`: Flattening operations
  - `fold`: Aggregation operations
- **Metrics**: Operation overhead, CPU cycles

### 6. Async Operations

#### Futures (`futures.rs`)
Tests asynchronous operation handling.
- **Pattern**: Future resolution in dataflow
- **DFIR variant**: Using `resolve_futures` operators
- **Metrics**: Async overhead, task scheduling

## Data Files

### words_alpha.txt (3.7 MB)
- **Source**: https://github.com/dwyl/english-words
- **Content**: 370,000+ English words
- **Usage**: Text processing benchmarks
- **Format**: One word per line

### reachability_edges.txt (521 KB)
- **Content**: Graph edges for reachability test
- **Format**: `source target` pairs
- **Size**: 55,000+ edges

### reachability_reachable.txt (38 KB)
- **Content**: Expected reachability results
- **Format**: Node IDs
- **Size**: 7,800+ reachable nodes

## Running Benchmarks

### All Benchmarks
```bash
cargo bench -p benches
```

### Specific Framework
```bash
# Run only DFIR benchmarks
cargo bench -p benches -- dfir

# Run only Timely benchmarks
cargo bench -p benches -- timely

# Run only Differential benchmarks
cargo bench -p benches -- differential
```

### Individual Benchmark
```bash
cargo bench -p benches --bench identity
cargo bench -p benches --bench reachability
```

### With Filters
```bash
# Run specific variants
cargo bench -p benches -- identity/dfir
cargo bench -p benches -- identity/timely

# Run micro-ops only
cargo bench -p benches -- micro/ops/
```

## Benchmark Configuration

### Criterion Settings
- **Warm-up time**: 3 seconds
- **Measurement time**: 5 seconds
- **Sample size**: 100 iterations
- **Output formats**: 
  - HTML reports in `target/criterion/`
  - Bencher format for CI integration

### Build Configuration
The `build.rs` script generates code for:
- Fork-join benchmarks with configurable depth
- Template-based benchmark variations

## Interpreting Results

### Throughput Metrics
- **Higher is better**: More items processed per second
- **Units**: items/sec, operations/sec

### Latency Metrics
- **Lower is better**: Time per operation
- **Units**: µs, ms

### Memory Metrics
- **Lower is better**: Memory footprint
- **Units**: MB, allocations/sec

### Comparison Guidelines
When comparing frameworks:
1. **Overhead**: Compare identity benchmark for baseline overhead
2. **Scalability**: Compare with varying data sizes
3. **Complexity**: Compare on complex patterns (diamond, fork-join)
4. **Specialization**: Each framework has strengths in different areas

## CI/CD Integration

### GitHub Actions Workflow
Location: `.github/workflows/benchmark.yml`

Features:
- Automated benchmark execution
- Result tracking over time
- GitHub Pages deployment
- Artifact upload

### Triggering Benchmarks
1. **Schedule**: Daily at 8:35 PM PDT
2. **Manual**: GitHub Actions → Run workflow
3. **Commit**: Include `[ci-bench]` in message
4. **PR**: Include `[ci-bench]` in title or body

### Viewing Results
- **GitHub Pages**: https://[org].github.io/[repo]/bench/
- **Artifacts**: Download from GitHub Actions runs
- **Local**: `target/criterion/report/index.html`

## Performance Considerations

### DFIR Strengths
- Low overhead for simple pipelines
- Efficient memory usage
- Good single-threaded performance

### Timely Strengths
- Excellent streaming performance
- Low-latency message passing
- Time-based computation model

### Differential Strengths
- Incremental computation
- Efficient updates
- Complex query optimization

## Extending Benchmarks

### Adding New Benchmarks
1. Create new file in `benches/benches/`
2. Add benchmark entry in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "new_benchmark"
   harness = false
   ```
3. Follow existing structure:
   - DFIR variant
   - Timely variant (optional)
   - Differential variant (optional)

### Benchmark Template
```rust
use criterion::{criterion_group, criterion_main, Criterion, BenchmarkId};

fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("my_benchmark/dfir", |b| {
        b.iter(|| {
            // Your DFIR code here
        });
    });
}

criterion_group!(benches, benchmark_dfir);
criterion_main!(benches);
```

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Ensure Rust toolchain is up to date
   - Check `rust-toolchain.toml` for required version

2. **Missing Data Files**
   - Data files should be in `benches/benches/`
   - Check `.gitignore` for exclusions

3. **Timeout Issues**
   - Adjust timeout in workflow: `timeout-minutes: 30`
   - Reduce benchmark iterations for testing

4. **Memory Issues**
   - Some benchmarks use large datasets
   - May require 4GB+ RAM for full suite

## References

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [DFIR Documentation](https://hydro.run/)
