# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external dependency benchmarks for the Hydro project, specifically timely and differential-dataflow performance comparisons.

## Purpose

This repository was created to isolate benchmarks that depend on external dataflow frameworks (timely and differential-dataflow) from the main hydro repository. This separation provides several benefits:

1. **Dependency Isolation**: Keeps the main hydro repository lean by avoiding unnecessary dependencies
2. **Performance Comparisons**: Maintains the ability to run performance benchmarks comparing dfir_rs (Hydroflow) against timely and differential-dataflow
3. **Focused Development**: Allows the main repository to focus on core functionality while keeping comprehensive benchmarks accessible

## Contents

- **benches/**: Performance benchmarks comparing Hydroflow, timely, and differential-dataflow implementations

## Getting Started

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` for version)
- Access to the main bigweaver-agent-canary-hydro-zeta repository (for dfir_rs dependency)

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

See [benches/README.md](benches/README.md) for detailed information about individual benchmarks.

## Repository Structure

```
.
├── benches/              # Benchmark implementations
│   ├── benches/         # Individual benchmark files
│   ├── Cargo.toml       # Benchmark dependencies
│   └── README.md        # Detailed benchmark documentation
├── Cargo.toml           # Workspace configuration
├── rust-toolchain.toml  # Rust toolchain specification
├── clippy.toml          # Clippy configuration
└── rustfmt.toml         # Rustfmt configuration
```

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main Hydro/dfir_rs repository

## License

Apache-2.0