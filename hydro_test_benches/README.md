# Hydro Test Benchmarks

This library crate contains benchmark implementations and all necessary supporting modules for testing Hydro consensus protocols. All dependencies are properly configured to enable independent execution of benchmarks.

## Structure

### Benchmark Implementations
- **paxos_bench.rs**: Paxos consensus protocol benchmark implementation
- **two_pc_bench.rs**: Two-phase commit protocol benchmark implementation

### Core Protocol Modules
- **paxos.rs**: Core Paxos consensus protocol implementation
- **two_pc.rs**: Two-phase commit protocol implementation
- **compartmentalized_paxos.rs**: Compartmentalized Paxos variant for improved scalability
- **paxos_with_client.rs**: Client integration for Paxos protocols
- **kv_replica.rs**: Key-value replica implementation with supporting modules

## Purpose

This crate was created to:
1. Separate heavy dependencies (timely and differential-dataflow) from the main codebase
2. Maintain the ability to run performance comparisons independently
3. Keep benchmark code organized and self-contained with all required dependencies
4. Enable standalone execution without requiring the main repository

## Running Benchmarks

### Using the Provided Examples

The crate includes standalone examples that demonstrate how to run each benchmark:

```bash
# Run Paxos benchmark
cargo run --example paxos

# Run Two-Phase Commit benchmark
cargo run --example two_pc

# Run Compartmentalized Paxos benchmark
cargo run --example compartmentalized_paxos
```

### Using as a Library

You can also use this crate as a library in your own projects:

```rust
use hydro_test_benches::paxos_bench::paxos_bench;
use hydro_test_benches::paxos::{CorePaxos, PaxosConfig};
// ... set up your clusters and run the benchmark
```

## Dependencies

The crate includes all necessary dependencies:
- **hydro_lang** and **hydro_std**: Core Hydro framework components
- **timely** and **differential-dataflow**: Dataflow processing engines
- **serde**, **bincode**, **tokio**: Supporting utilities
- **dfir_lang**, **hydro_deploy** (dev dependencies): For testing and deployment

All dependencies are automatically managed through Cargo.

## Original Location

These benchmarks and supporting modules were originally located in:
- `hydro_test/src/cluster/paxos_bench.rs`
- `hydro_test/src/cluster/two_pc_bench.rs`
- `hydro_test/src/cluster/paxos.rs`
- `hydro_test/src/cluster/two_pc.rs`
- `hydro_test/src/cluster/compartmentalized_paxos.rs`
- `hydro_test/src/cluster/paxos_with_client.rs`
- `hydro_test/src/cluster/kv_replica.rs`

in the bigweaver-agent-canary-hydro-zeta repository.
