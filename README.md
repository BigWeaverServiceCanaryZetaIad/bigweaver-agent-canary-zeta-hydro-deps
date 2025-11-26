# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that have been moved from the main hydro repository to manage dependencies more effectively and maintain a clean codebase structure.

## Contents

### Timely Benchmarks

The `timely-benchmarks` package contains performance benchmarks for:
- **Timely Dataflow**: A low-latency data-parallel dataflow system
- **Differential Dataflow**: An incremental computation framework

These benchmarks measure the performance of various dataflow patterns and compare them against baseline Rust implementations.

## Purpose

This repository serves to:
1. Isolate timely and differential-dataflow dependencies from the main repository
2. Maintain performance testing infrastructure for these libraries
3. Enable performance comparisons without adding dependency overhead to the core project
4. Support strategic dependency management and technical debt reduction

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark package
cargo bench -p timely-benchmarks

# Run a specific benchmark
cargo bench -p timely-benchmarks --bench reachability
```

## Documentation

See the [timely-benchmarks README](timely-benchmarks/README.md) for detailed information about available benchmarks and how to use them.

## Repository Structure

```
.
├── timely-benchmarks/     # Timely and differential dataflow benchmarks
│   ├── benches/          # Benchmark implementations
│   └── README.md         # Detailed benchmark documentation
├── Cargo.toml            # Workspace configuration
├── rust-toolchain.toml   # Rust toolchain specification
├── rustfmt.toml          # Code formatting rules
└── clippy.toml           # Linting configuration
```

## Related Repositories

This repository is part of the Hydro project ecosystem. The benchmarks and functionality here complement the main bigweaver-agent-canary-hydro-zeta repository.