# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code that depends on `timely` and `differential-dataflow` packages, separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain clean dependency management.

## Contents

This repository includes:

- **benches/**: Benchmark code comparing different dataflow implementations
  - Performance benchmarks for operations like fan-in, fan-out, fork-join, identity, arithmetic, and upcase
  - Benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) for robust performance measurements
  
- **babyflow/**: A custom dataflow library implementation
  
- **spinachflow/**: Another dataflow library implementation

## Purpose

These benchmarks were moved to this separate repository to:
- Remove `timely` and `differential-dataflow` dependencies from the main repository
- Maintain cleaner code organization
- Allow for focused development and dependency management
- Preserve the ability to run performance comparisons

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench upcase
```

## Benchmark Descriptions

- **arithmetic**: Tests arithmetic operations across dataflow implementations
- **fan_in**: Tests merging multiple data sources into one stream
- **fan_out**: Tests splitting one data source into multiple consumers
- **fork_join**: Tests splitting data into branches, filtering, and merging back
- **identity**: Tests pure data passing without transformations
- **upcase**: Tests string transformation operations

## Performance Comparison

Each benchmark compares multiple implementations:
- **babyflow**: Custom lightweight dataflow implementation
- **timely**: Industry-standard timely dataflow
- **spinachflow**: Alternative dataflow implementation
- **raw**: Direct Rust implementation for baseline comparison

## Dependencies

This repository depends on:
- `timely` - Timely dataflow library
- `differential-dataflow` - Differential dataflow library (if used)
- `criterion` - Benchmarking framework
- `tokio` - Async runtime
- Local packages: `babyflow`, `spinachflow`

## Cross-Repository Performance Comparison

To compare performance results with the main repository:

1. Run benchmarks in this repository: `cargo bench`
2. Results are stored in `target/criterion/`
3. Compare with reference benchmarks from `bigweaver-agent-canary-hydro-zeta` if available
4. Use Criterion's HTML reports for detailed analysis: `target/criterion/report/index.html`

## Development

### Prerequisites

- Rust toolchain (stable or nightly)
- Cargo

### Building

```bash
cargo build
```

### Testing

```bash
cargo test
```

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta): Main repository without timely/differential-dataflow dependencies