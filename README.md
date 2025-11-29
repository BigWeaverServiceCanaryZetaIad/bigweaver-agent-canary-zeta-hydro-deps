# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on `timely` and `differential-dataflow` packages.

## Purpose

The benchmarks have been moved to this separate repository to:
- Keep the main `bigweaver-agent-canary-hydro-zeta` repository free from `timely` and `differential-dataflow` dependencies
- Maintain the ability to run performance comparisons between Hydro and other dataflow systems
- Provide a cleaner dependency structure for the main project

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro implementations with `timely` and `differential-dataflow` implementations. These benchmarks test various operations including:
- Graph reachability
- Arithmetic operations
- Join operations
- Fan-in/Fan-out patterns
- And more

See [benches/README.md](benches/README.md) for details on running the benchmarks.

## Quick Start

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run benchmarks for timely implementations
cargo bench -p benches -- timely
```

See [QUICK_START.md](QUICK_START.md) for more examples and common tasks.

## Documentation

- **[QUICK_START.md](QUICK_START.md)** - Get started quickly with common commands
- **[BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)** - Comprehensive benchmarking guide
- **[VERIFICATION_CHECKLIST.md](VERIFICATION_CHECKLIST.md)** - Integration verification status
- **[benches/README.md](benches/README.md)** - Benchmark-specific documentation

## Dependencies

This repository references the main `bigweaver-agent-canary-hydro-zeta` repository as a sibling directory for accessing `dfir_rs` and `sinktools` packages.

### Required Structure

```bash
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Benchmark Implementations

### Timely Dataflow
8 benchmarks include Timely implementations for performance comparison:
- arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase

### Differential Dataflow  
1 benchmark includes Differential Dataflow implementation:
- reachability (incremental graph computation)

### DFIR/Hydro
All 12 benchmarks include DFIR implementations as the primary framework being tested.

## Contributing

When adding new benchmarks:
1. Add `.rs` file to `benches/benches/`
2. Update `benches/Cargo.toml` with `[[bench]]` entry
3. Include implementations for DFIR and comparison frameworks (timely/differential)
4. Update documentation

## Performance Tracking

Benchmarks use [Criterion](https://github.com/bheisler/criterion.rs) which:
- Generates detailed HTML reports in `target/criterion/`
- Tracks performance over time
- Detects regressions automatically
- Provides statistical analysis

## License

Apache-2.0