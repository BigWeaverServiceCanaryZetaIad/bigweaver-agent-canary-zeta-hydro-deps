# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for comparing Timely Dataflow and Differential Dataflow performance against other dataflow implementations.

## Structure

- `benches/` - Performance benchmarks for Timely and Differential Dataflow

## Getting Started

### Prerequisites

- Rust 1.91.1 or later (specified in `rust-toolchain.toml`)

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench fork_join
cargo bench --bench reachability
```

## Benchmarks

### fork_join
Benchmarks fork-join dataflow patterns using Timely Dataflow operators and raw Rust implementations.

### reachability
Graph reachability benchmarks comparing Timely Dataflow (with feedback loops) and Differential Dataflow (with iterative operators).

## License

Apache-2.0
