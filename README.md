# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository houses separated dependencies and benchmark code for the `bigweaver-agent-canary-hydro-zeta` project. It provides a dedicated space for performance benchmarks and dependencies that are not needed in the main repository.

## Purpose

This repository serves as:

1. **Benchmark Repository** - Contains performance comparison benchmarks for Hydroflow vs. Timely/Differential Dataflow
2. **Separated Dependencies** - Houses dependencies used only for benchmarking and testing
3. **Performance Testing** - Enables comprehensive performance comparisons without cluttering the main repository

## What's Here

### Benchmarks

The following performance benchmarks are now available in the `benches/` directory:

**Benchmark Implementations:**
- **arithmetic.rs** - Arithmetic pipeline benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Futures-based async benchmarks
- **identity.rs** - Identity transformation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **reachability.rs** - Graph reachability benchmarks (with edge data)
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String transformation benchmarks
- **words_diamond.rs** - Diamond pattern word processing benchmarks

Performance benchmarks comparing different dataflow frameworks:
- Hydroflow implementations
- Timely dataflow implementations
- Differential dataflow implementations
- Raw Rust baselines

All benchmarks compare:
- Throughput and latency characteristics
- Different implementation strategies
- Framework overhead vs baseline performance

### Dependencies

Key dependencies for benchmarking:
- `timely` (timely-master)
- `differential-dataflow` (differential-dataflow-master)
- `criterion` for benchmarking framework
- Supporting crates for performance testing

## Why Separated?

The main `bigweaver-agent-canary-hydro-zeta` repository focuses on core functionality. Separating benchmarks provides:

- **Cleaner Main Repository** - Faster builds and easier navigation
- **Better Dependency Management** - Benchmark dependencies don't affect main project
- **Independent Updates** - Benchmark framework versions can be updated independently
- **Focused Development** - Core development not slowed by benchmark compilation

## Getting Started

### Running Benchmarks

```bash
# Clone this repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Run benchmarks for a specific pattern
cargo bench --bench join
```

### Benchmark Results

Criterion generates detailed HTML reports in `target/criterion/` with:
- Performance metrics and statistics
- Comparison with previous runs
- Graphs and visualizations
- Outlier analysis

### Adding Benchmarks

See `SETUP.md` for detailed information about:
- Setting up benchmark code
- Required dependencies
- Benchmark structure
- Performance comparison methodology

## Documentation

- **SETUP.md** - Complete setup and migration guide with detailed instructions
- **BENCHMARKS_INFO.md** - Comprehensive guide to benchmarks in this repository
- **benches/README.md** - Quick reference for running benchmarks
- **Main Repository** - See `BENCHMARK_REMOVAL.md` in bigweaver-agent-canary-hydro-zeta for context

## Status

**Current Status**: ✅ Migration Complete - Benchmarks are fully operational

**Completed**:
- ✅ Copied all 12 benchmark implementations from main repository history
- ✅ Set up Cargo workspace configuration
- ✅ Added all required data files for benchmarks (reachability_edges.txt, reachability_reachable.txt, words_alpha.txt)
- ✅ Configured git dependencies for dfir_rs and sinktools
- ✅ Build script (build.rs) for code generation included
- ✅ All benchmark harness configurations in place

**To Do**:
- [ ] Configure CI/CD for automated benchmarking (optional)
- [ ] Set up performance tracking over time (optional)

## Related Projects

- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta) - Core Hydro/DFIR implementation
- **Hydro Project**: [hydro.run](https://hydro.run) - Official Hydro project website

## Contributing

When contributing benchmarks:
1. Follow existing benchmark patterns
2. Use criterion for consistent measurement
3. Document what each benchmark measures
4. Include comparison baselines where applicable

## Questions?

For questions about:
- Benchmark setup and usage - See `BENCHMARKS_INFO.md`
- Main project - See main repository documentation
- Performance issues - Contact repository maintainers

## License

Same license as the main Hydro project (Apache-2.0)