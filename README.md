# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on external dataflow dependencies (`timely` and `differential-dataflow`), separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository to maintain a cleaner dependency structure.

## Purpose

The main purpose of this repository is to:
- Isolate dependencies on `timely` and `differential-dataflow` packages
- Maintain performance comparison capabilities between Hydro and these dataflow systems
- Keep the main repository lean and focused
- Provide a dedicated space for benchmarks that require these specific dependencies

## Contents

### Benchmarks (`/benches`)

Performance benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow:
- **Timely benchmarks**: arithmetic, fan_in, fan_out, fork_join, identity, join, upcase
- **Differential benchmarks**: reachability (graph algorithms)

See the [benches/README.md](benches/README.md) for detailed information on running benchmarks.

## Getting Started

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in main repository)
- Cargo

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability
```

## Relationship to Main Repository

This repository is a companion to `bigweaver-agent-canary-hydro-zeta` and shares its license and contribution guidelines. The benchmarks here use `dfir_rs` and other components from the main repository via git dependencies.

## Documentation

- [Benchmark README](benches/README.md) - Detailed benchmark documentation
- [Migration Documentation](BENCHMARK_MIGRATION.md) - Details about the benchmark migration

## License

Apache-2.0 (same as main repository)