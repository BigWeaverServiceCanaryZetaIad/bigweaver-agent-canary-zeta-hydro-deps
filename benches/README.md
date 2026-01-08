# Hydro Benchmarks

Benchmarks for Hydro and related dataflow systems, including performance testing and comparison capabilities.

## Overview

This directory contains benchmarks migrated from the main Hydro repository. These benchmarks test core dataflow operations and can be used for performance analysis and cross-implementation comparisons.

## Available Benchmarks

### 1. micro_ops
Micro-operations benchmark testing fundamental dataflow operations:
- Identity transformations
- Unique filtering  
- Map operations
- Filter operations
- Fold operations
- And more basic operations

### 2. symmetric_hash_join
Symmetric hash join implementation benchmark:
- Tests join performance
- Evaluates hash-based join strategies
- Measures throughput and latency

### 3. words_diamond
Word processing using diamond pattern dataflow:
- Complex dataflow pattern testing
- Uses real-world data (370K English words)
- Tests multi-path data flows

### 4. futures
Asynchronous futures-based operations benchmark:
- Immediately available futures
- Delayed futures with manual waking
- Async operation overhead measurement

## Running Benchmarks

### Basic Usage

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
```

### Using the Benchmark Runner Script

For organized results with timestamps:
```bash
cd ..
./scripts/run_benchmarks.sh
```

This generates:
- Timestamped results directory
- Summary reports
- JSON output for programmatic analysis
- Links to detailed HTML reports

### Quick Test Run

For faster iterations during development:
```bash
cargo bench -- --quick
```

## Understanding Results

Criterion (the benchmark framework) provides detailed output including:
- **Time per iteration**: Average execution time
- **Throughput**: Operations per second  
- **Standard deviation**: Result consistency
- **Change detection**: Automatic comparison with previous runs

### HTML Reports

Detailed HTML reports with graphs are generated automatically:
```bash
# View reports (after running benchmarks)
firefox ../target/criterion/report/index.html
```

## Performance Comparison

See `../COMPARISON_GUIDE.md` for detailed information about:
- Running comparative benchmarks
- Interpreting results
- Tracking performance over time
- Comparing different implementations

## Data Files

### words_alpha.txt
English word list (3.7MB, 370,000+ words)
- Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Used by: `words_diamond` benchmark
- Format: One word per line, alphabetically sorted

## Dependencies

### Required
- `criterion` - Benchmarking framework with statistical analysis
- `dfir_rs` - Hydro's DFIR implementation (path dependency)
- `sinktools` - Utility tools (path dependency)

### Supporting
- `futures`, `tokio` - Async runtime support
- `rand`, `rand_distr` - Random data generation
- `nameof`, `seq-macro`, `static_assertions` - Utilities

### Path Dependencies Note

This package references local path dependencies:
- `dfir_rs` at `../dfir_rs`  
- `sinktools` at `../sinktools`

These need to be available in your workspace. See `../MIGRATION.md` for setup instructions.

## Repository Structure

```
benches/
├── Cargo.toml              # This package configuration
├── README.md               # This file
└── benches/                # Benchmark implementations
    ├── micro_ops.rs
    ├── symmetric_hash_join.rs
    ├── words_diamond.rs
    ├── futures.rs
    ├── words_alpha.txt     # Test data
    └── .gitignore
```

## Future Enhancements

Planned additions to this benchmark suite:
- Timely dataflow equivalent implementations
- Differential-dataflow comparison benchmarks
- Memory usage profiling
- Scalability tests
- Cross-implementation validation

## Troubleshooting

### Path Dependencies Not Found
```bash
# Ensure dfir_rs and sinktools are in parent directory
# Or adjust paths in Cargo.toml
```

### Benchmarks Take Too Long
```bash
# Use quick mode for faster iterations
cargo bench -- --quick

# Or run specific benchmarks only
cargo bench --bench micro_ops
```

### Inconsistent Results
- Close background applications
- Ensure system isn't thermal throttling
- Run multiple times for averages
- See COMPARISON_GUIDE.md for best practices

## Related Documentation

- `../README.md` - Repository overview
- `../MIGRATION.md` - Migration details from main repository
- `../COMPARISON_GUIDE.md` - Detailed performance comparison guide
- `../scripts/run_benchmarks.sh` - Automated benchmark runner

## Notes

- All benchmarks use Hydro's native DFIR implementation
- Results are automatically compared with previous runs
- HTML reports provide detailed visualizations
- This is the official home for all Hydro benchmarks
