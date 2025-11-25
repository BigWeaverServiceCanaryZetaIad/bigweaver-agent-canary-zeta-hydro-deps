# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a clean and focused main codebase.

## Contents

### Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and other dataflow frameworks, including:
- **timely**: Benchmarks using the Timely dataflow framework
- **differential-dataflow**: Benchmarks using Differential Dataflow

These benchmarks enable performance comparison between different dataflow implementations and patterns.

## Repository Structure

```
.
├── benches/          # Benchmark suite with timely and differential-dataflow dependencies
│   ├── benches/      # Individual benchmark files
│   └── Cargo.toml    # Benchmark dependencies configuration
├── Cargo.toml        # Workspace configuration
├── rustfmt.toml      # Rust formatting configuration
├── clippy.toml       # Clippy linting configuration
└── rust-toolchain.toml  # Rust toolchain specification
```

## Getting Started

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` for the specific version)
- Access to the main `bigweaver-agent-canary-hydro-zeta` repository (for dfir_rs and sinktools dependencies)

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

### Available Benchmarks

The benchmark suite includes:
- **arithmetic.rs** - Arithmetic operations benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Async futures benchmarks
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **reachability.rs** - Graph reachability benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String uppercase benchmarks
- **words_diamond.rs** - Words diamond pattern benchmarks

## Dependencies

### External Dependencies

This repository includes the following external dataflow dependencies:
- **timely** (timely-master 0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1) - Differential Dataflow framework

### Local Dependencies

The benchmarks depend on packages from the main repository:
- **dfir_rs** - DFIR runtime and implementation
- **sinktools** - Utility tools

Note: The paths to these dependencies are configured to point to the sibling `bigweaver-agent-canary-hydro-zeta` repository.

## Rationale

These benchmarks were moved to this separate repository to:
- Keep the main repository lean and focused on core functionality
- Reduce dependency complexity in the main codebase
- Follow the team's architectural pattern of separating concerns
- Isolate benchmarking dependencies that are not core to main functionality
- Maintain the ability to run performance comparisons independently

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta** - Main Hydro project repository

## License

Apache-2.0

## Contributing

See the main repository's `CONTRIBUTING.md` for contribution guidelines.