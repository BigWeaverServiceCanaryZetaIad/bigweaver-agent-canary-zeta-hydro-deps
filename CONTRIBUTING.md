# Contributing to Hydro Benchmarks

This repository contains benchmarks that have been moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a cleaner dependency structure.

## Repository Structure

```
.
├── src/
│   ├── lib.rs                     # Library root
│   └── cluster/                   # Cluster benchmarks
│       ├── mod.rs                 # Module exports
│       ├── paxos_bench.rs        # Paxos performance benchmarks
│       ├── two_pc_bench.rs       # Two-phase commit benchmarks
│       ├── paxos.rs              # Paxos protocol implementation
│       ├── paxos_with_client.rs  # Paxos with client interface
│       ├── two_pc.rs             # Two-phase commit protocol
│       ├── kv_replica.rs         # Key-value replica
│       ├── kv_replica/
│       │   └── sequence_payloads.rs
│       ├── snapshots/             # Test snapshots
│       └── snapshots-nightly/     # Nightly test snapshots
├── Cargo.toml                     # Package configuration
├── build.rs                       # Build script
├── rust-toolchain.toml           # Rust toolchain specification
├── rustfmt.toml                  # Formatting configuration
├── clippy.toml                   # Linting configuration
└── README.md                     # This file
```

## Running Tests and Benchmarks

### Prerequisites

You need to have the main `bigweaver-agent-canary-hydro-zeta` repository available at the relative path `../bigweaver-agent-canary-hydro-zeta/` because this benchmark repository depends on several crates from that repository.

### Running Tests

```bash
# Run all tests
cargo test

# Run specific benchmark tests
cargo test paxos_ir
cargo test two_pc_ir

# Run performance tests
cargo test --release paxos_some_throughput
cargo test --release two_pc_some_throughput
```

### Code Quality

Before submitting changes, ensure your code passes formatting and linting:

```bash
# Format code
cargo fmt

# Check formatting
cargo fmt --check

# Run clippy
cargo clippy --all-targets
```

## Cross-Repository Integration

This repository maintains references to the main `bigweaver-agent-canary-hydro-zeta` repository through path dependencies in `Cargo.toml`. This allows the benchmarks to use the latest versions of core Hydro components while keeping the dependency graph clean in the main repository.

### Key Dependencies

- `hydro_lang` - Core Hydro language support
- `hydro_std` - Standard library for Hydro
- `hydro_deploy` - Deployment infrastructure
- `dfir_lang` - Dataflow IR language support
- `hydro_build_utils` - Build utilities

## Making Changes

1. Ensure your changes maintain compatibility with the main repository
2. Update tests if you modify benchmark behavior
3. Update snapshots if test output changes (using `cargo insta review`)
4. Verify that performance characteristics remain reasonable
5. Update documentation as needed

## Performance Comparison

The benchmarks in this repository can be used to compare performance across different implementations or optimizations. When making changes to the main Hydro codebase, you can run these benchmarks to ensure performance regressions are caught early.
