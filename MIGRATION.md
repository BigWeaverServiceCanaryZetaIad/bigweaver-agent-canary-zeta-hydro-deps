# Benchmark Migration Guide

This document explains the migration of timely and differential-dataflow benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Background

The benchmarks were moved to maintain better separation of concerns and cleaner dependency management. The main Hydro repository no longer needs to carry dependencies on `timely` and `differential-dataflow` for users who don't need to run performance comparisons.

## What Was Moved

All benchmarks that depend on `timely` and `differential-dataflow` packages were moved, including:

### Benchmark Files
- `arithmetic.rs` - Arithmetic operation benchmarks
- `fan_in.rs` - Fan-in pattern benchmarks  
- `fan_out.rs` - Fan-out pattern benchmarks
- `fork_join.rs` - Fork-join pattern benchmarks
- `futures.rs` - Async futures benchmarks
- `identity.rs` - Identity operation benchmarks
- `join.rs` - Join operation benchmarks
- `micro_ops.rs` - Micro-operation benchmarks
- `reachability.rs` - Graph reachability benchmarks (with test data)
- `symmetric_hash_join.rs` - Symmetric hash join benchmarks
- `upcase.rs` - String uppercase benchmarks
- `words_diamond.rs` - Word processing diamond pattern benchmarks (with wordlist)

### Dependencies Moved
The following dependencies are now only in this repository:
- `timely` (timely-master v0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master v0.13.0-dev.1)

### Dependencies Updated
- `dfir_rs` - Changed from path dependency to version `0.14.0` from crates.io
- `sinktools` - Changed from path dependency to version `0.0.1` from crates.io

## Running Benchmarks

After this migration, benchmarks can still be run with the same commands:

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench identity
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

## Performance Comparison Functionality

The ability to run performance comparisons between Hydro's DFIR and timely/differential-dataflow implementations is fully preserved. The benchmarks continue to provide:

1. **Comparative Analysis** - Side-by-side performance measurements of:
   - Raw Rust implementations
   - Hydro DFIR implementations
   - Timely dataflow implementations
   - Differential dataflow implementations

2. **Comprehensive Metrics** - Using the Criterion benchmarking framework for:
   - Throughput measurements
   - Latency analysis
   - Statistical variance
   - HTML reports with visualizations

3. **Realistic Workloads** - Including:
   - Graph algorithms (reachability)
   - Join operations
   - Stream transformations
   - Complex dataflow patterns

## CI/CD Considerations

The benchmark CI workflow was removed from the main repository. To re-enable automated benchmarking:

1. Set up a CI workflow in this repository
2. Configure it to run benchmarks on:
   - Schedule (e.g., nightly)
   - Manual trigger
   - Pull requests with `[ci-bench]` tag
3. Store and compare results over time

## Development Workflow

### For Main Repository Development
Developers working on the main `bigweaver-agent-canary-hydro-zeta` repository no longer need to:
- Install timely/differential-dataflow dependencies
- Wait for benchmark compilation during regular builds
- Manage the additional dependencies in their development environment

### For Benchmark Development
Developers working on benchmarks should:
1. Clone this repository separately
2. Ensure they have access to the required dependencies
3. Run benchmarks locally before submitting changes
4. Update documentation if adding new benchmarks

## Integration Points

### Main Repository References
The main repository now includes documentation references to this benchmark repository in:
- `README.md` - In the "Learn More" section
- `CONTRIBUTING.md` - In the "Repository Structure" section

### Version Compatibility
The benchmarks depend on published versions of `dfir_rs` and `sinktools`. To ensure compatibility:
- Always use published versions that match the main repository's release
- Test benchmarks after updates to the main repository
- Update benchmark dependencies when new versions are published

## Troubleshooting

### Build Failures
If benchmarks fail to build:
1. Verify `dfir_rs` version matches the published version
2. Check that `timely` and `differential-dataflow` versions are compatible
3. Ensure all data files (wordlists, graph data) are present

### Performance Regressions
If benchmarks show unexpected performance changes:
1. Verify the `dfir_rs` version being tested
2. Check for changes in Rust compiler version
3. Review recent changes to the main repository
4. Compare with historical benchmark results

## Future Enhancements

Potential improvements for the benchmark infrastructure:
1. Automated performance tracking and regression detection
2. Benchmark result visualization dashboard
3. Cross-version performance comparison tools
4. Additional benchmark scenarios for new Hydro features
5. Integration with continuous benchmarking services

## Questions and Support

For questions about:
- **Running benchmarks**: See `benches/README.md`
- **Benchmark implementation**: Review the individual benchmark files
- **Main repository**: See the main repository's documentation
- **Performance issues**: Open an issue in the appropriate repository
