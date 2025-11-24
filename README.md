# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow performance comparisons with Hydroflow (dfir_rs).

## Overview

This repository was created to maintain timely and differential-dataflow benchmarks separately from the main bigweaver-agent-canary-hydro-zeta repository. This separation helps avoid unnecessary dependencies in the main codebase while preserving the ability to run performance comparisons between different dataflow frameworks.

## Benchmarks

The following benchmarks are included:

- **arithmetic** - Tests arithmetic operations using timely dataflow operators
- **fan_in** - Tests fan-in patterns using timely dataflow operators
- **fan_out** - Tests fan-out patterns using timely dataflow operators
- **fork_join** - Tests fork-join patterns using timely dataflow operators
- **identity** - Tests identity operations using timely dataflow operators
- **join** - Tests join operations using timely dataflow operators
- **upcase** - Tests uppercase transformation using timely dataflow operators
- **reachability** - Tests graph reachability using differential-dataflow operators

Each benchmark compares the performance of three implementations:
1. **dfir_rs (Hydroflow)** - The Hydro dataflow framework
2. **timely** - Timely dataflow framework
3. **differential-dataflow** - Differential dataflow framework (for reachability)

## Dependencies

This repository requires the following key dependencies:

- **dfir_rs** - Hydroflow dataflow framework from the hydro-project
- **timely** (timely-master) - Timely dataflow framework (v0.13.0-dev.1)
- **differential-dataflow** (differential-dataflow-master) - Differential dataflow framework (v0.13.0-dev.1)
- **criterion** - For benchmarking infrastructure
- **sinktools** - Utilities from the hydro-project

## Building

To build the benchmarks:

```bash
cargo build
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench upcase
cargo bench -p benches --bench reachability
```

Run quick benchmarks (reduced sample size):
```bash
cargo bench -p benches -- --quick
```

## Performance Comparison

The benchmarks provide comparative performance metrics between dfir_rs, timely, and differential-dataflow implementations. Results are generated using the Criterion benchmarking framework and include:

- Mean execution time
- Standard deviation
- Throughput measurements
- HTML reports in `target/criterion/`

## Repository Structure

```
.
├── Cargo.toml              # Workspace configuration
├── rust-toolchain.toml     # Rust toolchain specification
├── clippy.toml            # Clippy linting configuration
├── rustfmt.toml           # Rustfmt formatting configuration
├── README.md              # This file
└── benches/               # Benchmark package
    ├── Cargo.toml         # Benchmark dependencies
    ├── build.rs           # Build script for generated code
    └── benches/           # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── upcase.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        └── reachability_reachable.txt
```

## Relationship to Main Repository

These benchmarks were previously part of the bigweaver-agent-canary-hydro-zeta repository. They have been moved here to:

1. Avoid adding timely and differential-dataflow as dependencies to the main repository
2. Maintain a cleaner dependency tree in the main codebase
3. Allow independent development and testing of performance comparisons
4. Follow the team's practice of separating core functionality from complex dependencies

## Development

### Code Style

This repository follows the same code style and linting rules as the main Hydro project:

- Rust Edition 2024
- Clippy linting with strict rules
- Rustfmt for consistent formatting
- See `clippy.toml` and `rustfmt.toml` for specific configurations

### Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Implement comparisons between dfir_rs, timely, and/or differential-dataflow
3. Add a `[[bench]]` entry in `benches/Cargo.toml`
4. Follow the existing benchmark structure for consistency

## License

Apache-2.0

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main Hydro project repository
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) - Timely dataflow framework
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow) - Differential dataflow framework