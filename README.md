# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies for the Hydro project, specifically timely and differential-dataflow benchmarks that have been moved from the main bigweaver-agent-canary-hydro-zeta repository.

## Purpose

This repository serves to:
- Maintain clean separation of performance testing dependencies from the main codebase
- Preserve benchmark functionality and performance comparison capabilities
- Reduce the dependency footprint of the main repository
- Enable focused development and maintenance of benchmarking infrastructure

## Benchmarks

The repository includes comprehensive microbenchmarks for comparing Hydro (dfir_rs) performance against timely-dataflow and differential-dataflow implementations.

### Available Benchmarks

- **arithmetic** - Pipeline arithmetic operations
- **fan_in** - Fan-in dataflow patterns
- **fan_out** - Fan-out dataflow patterns
- **fork_join** - Fork-join patterns
- **futures** - Async futures processing
- **identity** - Identity operations
- **join** - Hash join operations
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability algorithms
- **symmetric_hash_join** - Symmetric hash join patterns
- **upcase** - String transformation operations
- **words_diamond** - Diamond pattern word processing

## Running Benchmarks

### Prerequisites

The benchmarks require access to the main bigweaver-agent-canary-hydro-zeta repository, as they depend on:
- `dfir_rs` - The Hydro dataflow framework
- `sinktools` - Utilities for sink operations

Ensure both repositories are cloned at the same directory level:
```
/projects/sandbox/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Benchmark Results

Benchmark results are generated in the `target/criterion` directory with HTML reports for detailed analysis.

## Dependencies

### External Dependencies
- **timely** (timely-master) - Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master) - Differential dataflow computations
- **criterion** - Benchmarking framework with statistical analysis

### Internal Dependencies (from main repository)
- **dfir_rs** - Hydro dataflow runtime
- **sinktools** - Sink utilities

## Data Files

The benchmarks include test data files:
- `words_alpha.txt` - English word list for word processing benchmarks (from https://github.com/dwyl/english-words)
- `reachability_edges.txt` - Graph edges for reachability benchmarks
- `reachability_reachable.txt` - Expected reachability results

## Performance Comparison

These benchmarks enable performance comparisons across different dataflow implementations:
- **dfir_rs (Hydro)** - Both compiled and surface syntax variants
- **timely-dataflow** - Low-level timely operators
- **differential-dataflow** - Incremental computation patterns
- **Baseline implementations** - Raw Rust implementations for reference

## Development

### Build Configuration

The benchmarks are configured to run without the standard Criterion harness to allow custom benchmark setups.

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` section to `benches/Cargo.toml`
3. Implement benchmark using the Criterion framework
4. Update this README with the new benchmark description

## Migration Notes

These benchmarks were migrated from the bigweaver-agent-canary-hydro-zeta repository to:
- Improve dependency management
- Maintain cleaner separation of concerns
- Focus the main repository on core functionality
- Preserve all performance testing capabilities

See `BENCHMARK_MIGRATION_SUMMARY.md` for detailed migration information.