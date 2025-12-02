# Hydro Benchmarks - Timely & Differential Dataflow

This repository contains performance benchmarks for Hydro that depend on `timely` and `differential-dataflow` packages. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

✅ **Reduce build times** for the main repository  
✅ **Cleaner dependency management** without heavyweight dataflow dependencies  
✅ **Preserve performance testing** capability in dedicated repository  
✅ **Improve developer experience** for core codebase contributors  

## Quick Links

- **[Quick Start Guide](QUICKSTART.md)** - Get running in minutes
- **[Migration Summary](MIGRATION_SUMMARY.md)** - Details about the migration
- **[Benchmark Guide](benches/README.md)** - Benchmark-specific documentation

## Running Benchmarks

### Prerequisites

Make sure you have Rust and Cargo installed. The benchmarks use nightly Rust features.

```bash
rustup update
```

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run arithmetic benchmark
cargo bench -p benches --bench arithmetic

# Run identity benchmark
cargo bench -p benches --bench identity
```

### Available Benchmarks

The repository includes the following benchmarks:
- `arithmetic` - Arithmetic operation benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks  
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Futures-based benchmarks
- `identity` - Identity operation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase benchmarks
- `words_diamond` - Words diamond pattern benchmarks

## Performance Comparison with Main Repository

These benchmarks allow you to compare the performance of Hydro/DFIR implementations against timely and differential-dataflow. The benchmarks use the same workloads and measure:

- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Memory usage**: Resource consumption

Results are output as HTML reports in `target/criterion/` after running the benchmarks.

## Dependencies

This repository maintains dependencies on:
- **timely-master**: Core timely dataflow library
- **differential-dataflow-master**: Differential dataflow library
- **dfir_rs**: Hydro's DFIR implementation (from main repository)
- **criterion**: Benchmarking framework

## Contributing

For questions or contributions related to these benchmarks, please refer to the main [Hydro repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) for contribution guidelines.

## Structure

```
.
├── benches/
│   ├── benches/          # Individual benchmark files
│   ├── Cargo.toml        # Benchmark dependencies
│   └── README.md         # Benchmark-specific documentation
└── README.md             # This file
```

## Related Links

- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Hydro Documentation](https://hydro.run)
- [Benchmark Migration Guide](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/docs/docs/benchmarks/migration.md)