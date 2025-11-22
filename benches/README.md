# Timely and Differential-Dataflow Benchmarks

This directory contains benchmark implementations for Timely Dataflow and Differential-Dataflow frameworks.

## Structure

```
benches/
├── Cargo.toml              # Benchmark dependencies and configuration
├── build.rs                # Build script
├── README.md               # This file
└── benches/                # Benchmark implementations
    ├── arithmetic.rs       # Arithmetic operations (Timely)
    ├── fan_in.rs           # Fan-in pattern (Timely)
    ├── fan_out.rs          # Fan-out pattern (Timely)
    ├── fork_join.rs        # Fork-join pattern (Timely)
    ├── identity.rs         # Identity transformation (Timely)
    ├── join.rs             # Relational join (Timely)
    ├── upcase.rs           # String manipulation (Timely)
    ├── reachability.rs     # Graph reachability (Timely + Differential)
    ├── reachability_edges.txt      # Test data
    ├── reachability_reachable.txt  # Test data
    └── words_alpha.txt     # Test data
```

## Quick Start

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmark

```bash
# Run identity benchmark
cargo bench --bench identity

# Run reachability (includes both timely and differential)
cargo bench --bench reachability

# Run arithmetic benchmark
cargo bench --bench arithmetic
```

### Run Specific Test Within Benchmark

```bash
# Run only timely variant in reachability
cargo bench --bench reachability -- timely

# Run only differential variant in reachability
cargo bench --bench reachability -- differential
```

## Benchmarks

### 1. Identity (`identity.rs`)
**Framework**: Timely  
**Tests**: Data transformation through 20 map operations  
**Scale**: 1,000,000 items

### 2. Arithmetic (`arithmetic.rs`)
**Framework**: Timely  
**Tests**: Arithmetic computation on integers  
**Scale**: 1,000,000 random integers

### 3. Fan-In (`fan_in.rs`)
**Framework**: Timely  
**Tests**: Merging multiple streams  
**Scale**: 20 streams, 1,000,000 items each

### 4. Fan-Out (`fan_out.rs`)
**Framework**: Timely  
**Tests**: Broadcasting to multiple consumers  
**Scale**: 1 stream, 20 consumers, 1,000,000 items

### 5. Fork-Join (`fork_join.rs`)
**Framework**: Timely  
**Tests**: Parallel branch and merge pattern  
**Scale**: 1,000,000 items, 2 branches

### 6. Join (`join.rs`)
**Framework**: Timely  
**Tests**: Relational join operations  
**Scale**: 100,000 items per side

### 7. Upcase (`upcase.rs`)
**Framework**: Timely  
**Tests**: String transformation (uppercasing)  
**Scale**: 100,000 words

### 8. Reachability (`reachability.rs`)
**Frameworks**: Timely + Differential  
**Tests**: Graph reachability computation  
**Scale**: ~500KB graph data  
**Note**: Includes TWO implementations (timely and differential)

## Dependencies

Key dependencies defined in `Cargo.toml`:

- `timely-master` (0.13.0-dev.1) - Timely Dataflow
- `differential-dataflow-master` (0.13.0-dev.1) - Differential-Dataflow
- `criterion` (0.5.0) - Benchmarking framework

## Test Data

### Reachability Data
- **reachability_edges.txt**: Graph edges for reachability computation
- **reachability_reachable.txt**: Expected reachable nodes

### String Data
- **words_alpha.txt**: Word list for string manipulation benchmarks

## Viewing Results

Criterion generates HTML reports:

```bash
# After running benchmarks, view results
open target/criterion/report/index.html
```

Reports include:
- Statistical analysis
- Performance graphs
- Comparison with previous runs
- Outlier detection

## Development

### Adding a New Benchmark

1. Create a new `.rs` file in `benches/`:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   
   fn benchmark_my_test(c: &mut Criterion) {
       c.bench_function("my_test/timely", |b| {
           // benchmark code
       });
   }
   
   criterion_group!(my_group, benchmark_my_test);
   criterion_main!(my_group);
   ```

2. Add to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_test"
   harness = false
   ```

3. Run:
   ```bash
   cargo bench --bench my_test
   ```

### Modifying Benchmarks

- Edit the relevant `.rs` file in `benches/`
- Maintain consistent parameters for comparison
- Run benchmarks to verify changes
- Update documentation if behavior changes

## Advanced Usage

### Quick Test (Fast Mode)

```bash
cargo bench -- --quick
```

### Verbose Output

```bash
cargo bench -- --verbose
```

### Custom Sample Size

```bash
cargo bench -- --sample-size 20
```

### Save Baseline

```bash
cargo bench --save-baseline my-baseline
```

### Compare to Baseline

```bash
cargo bench --baseline my-baseline
```

## Tips

1. **Close other applications** before running benchmarks
2. **Run multiple times** to establish confidence
3. **Use baselines** for tracking performance changes
4. **Check HTML reports** for detailed analysis
5. **Monitor system temperature** to avoid thermal throttling

## Documentation

For more detailed information:

- **Main README**: `../README.md`
- **Getting Started**: `../GETTING_STARTED.md`
- **Performance Comparison**: `../PERFORMANCE_COMPARISON.md`
- **Repository Relationship**: `../RELATIONSHIP_TO_MAIN_REPO.md`

## License

Apache-2.0
