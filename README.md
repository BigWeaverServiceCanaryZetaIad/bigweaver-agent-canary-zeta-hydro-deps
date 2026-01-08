# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks for Hydro and related dataflow systems, including comparisons with timely and differential-dataflow implementations.

## Purpose

This repository serves as a dedicated space for:
- Performance benchmarks and comparisons
- Testing with timely and differential-dataflow dependencies
- Historical benchmark data and analysis
- Cross-implementation performance validation

## Repository Structure

```
benches/
├── Cargo.toml              # Benchmark dependencies configuration
├── README.md               # Benchmark usage documentation
└── benches/                # Benchmark implementations
    ├── futures.rs          # Futures-based operations benchmark
    ├── micro_ops.rs        # Micro-operations benchmark
    ├── symmetric_hash_join.rs  # Symmetric hash join benchmark
    ├── words_diamond.rs    # Word processing diamond pattern benchmark
    └── words_alpha.txt     # Test data for word processing benchmarks
```

## Benchmarks

### Available Benchmarks

1. **micro_ops** - Micro-operations benchmark testing basic dataflow operations
2. **symmetric_hash_join** - Symmetric hash join implementation benchmark
3. **words_diamond** - Word processing using diamond pattern dataflow
4. **futures** - Asynchronous futures-based operations benchmark

### Running Benchmarks

To run all benchmarks:
```bash
cd benches
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench micro_ops
cargo bench --bench symmetric_hash_join
cargo bench --bench words_diamond
cargo bench --bench futures
```

## Performance Comparison

This repository enables performance comparison between:
- Hydro-native DFIR implementations
- Timely/Differential-Dataflow implementations (when added)

Benchmark results can be compared across implementations to evaluate performance characteristics and optimization opportunities.

## Dependencies

The benchmarks in this repository may include dependencies on:
- `dfir_rs` - Hydro's DFIR implementation
- `timely` - Timely dataflow system
- `differential-dataflow` - Differential dataflow system
- `criterion` - Benchmarking framework

**Note:** Some benchmarks reference local path dependencies (e.g., `dfir_rs`, `sinktools`) that need to be available in the workspace or adjusted based on your setup.

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository without timely/differential-dataflow dependencies

## Data Files

- `words_alpha.txt` - English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Notes

- This repository is designed for performance testing and comparison purposes
- Benchmarks may require workspace setup or dependency path adjustments
- Results should be compared in consistent environments for accurate performance analysis