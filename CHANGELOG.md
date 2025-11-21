# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0] - 2024-11-21

### Added
- Initial benchmark suite for Timely and Differential Dataflow
- **Timely Dataflow Benchmarks**:
  - Basic operations (map, filter, exchange, concatenate, chain)
  - Reachability computation (chain graphs, random graphs)
- **Differential Dataflow Benchmarks**:
  - Basic operations (map, filter, join, count, reduce)
  - Incremental updates demonstrating differential computation efficiency
  - Reachability computation with incremental updates
- **Performance Comparison Suite**:
  - Side-by-side comparisons of Timely vs Differential for equivalent operations
  - Map and filter operation comparisons
  - Aggregation pattern comparisons
  - Graph reachability comparisons
  - Incremental update showcase
- **Common Utilities**:
  - Graph generation (random, chain, complete)
  - Performance measurement and timing utilities
  - Comparison result analysis
- **Documentation**:
  - Comprehensive README with usage examples
  - Benchmark-specific README in benches directory
  - Quick start guide for getting started quickly
- **Examples**:
  - Simple standalone benchmark demonstrating both frameworks
  - Can be run independently: `cargo run --example simple_benchmark --release`
- **Scripts**:
  - `run_benchmarks.sh` for running all benchmarks with filtering support
  - Supports baseline comparisons and custom filters

### Features
- All benchmarks can be executed independently
- Performance comparison functionality retained across all benchmarks
- Criterion-based benchmarking with HTML reports
- Support for different workload sizes (1K, 10K, 100K elements)
- Graph algorithm benchmarks with various graph types
- Incremental computation demonstrations

### Testing
- Each benchmark suite is self-contained
- Can run specific benchmarks using Criterion filters
- Examples can be executed standalone for quick validation

### Dependencies
- timely: 0.12
- differential-dataflow: 0.12
- criterion: 0.5 (with HTML reports)
- rand: 0.8 (for test data generation)
- serde/serde_json: 1.0 (for data serialization)

### Project Structure
```
.
├── benches/
│   ├── Cargo.toml
│   ├── README.md
│   ├── benches/
│   │   ├── common/
│   │   │   └── mod.rs           # Shared utilities
│   │   ├── timely_basic_ops.rs
│   │   ├── timely_reachability.rs
│   │   ├── differential_basic_ops.rs
│   │   ├── differential_reachability.rs
│   │   └── comparison.rs
│   └── examples/
│       └── simple_benchmark.rs  # Standalone example
├── Cargo.toml
├── README.md
├── QUICKSTART.md
├── CHANGELOG.md
└── run_benchmarks.sh
```

### Usage
```bash
# Run all benchmarks
cargo bench -p timely-differential-benches

# Run specific benchmark suite
cargo bench -p timely-differential-benches --bench timely_basic_ops

# Run with filter
cargo bench -p timely-differential-benches -- map

# Run example
cargo run --example simple_benchmark --release

# Use convenience script
./run_benchmarks.sh
```

### Notes
- Benchmarks are designed to be reproducible
- Results are stored in `target/criterion/` with HTML visualizations
- Incremental update benchmarks showcase Differential Dataflow's strengths
- Graph reachability benchmarks demonstrate iterative computation patterns
