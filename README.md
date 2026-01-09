# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for the Hydro project that were moved from the `bigweaver-agent-canary-hydro-zeta` repository.

## Benchmarks

This repository contains the following benchmarks:

- **Paxos Benchmark** (`paxos_bench.rs`): Performance benchmarks for the Paxos consensus protocol implementation
- **Two-Phase Commit Benchmark** (`two_pc_bench.rs`): Performance benchmarks for two-phase commit protocol

## Running Benchmarks

To run the benchmarks:

```bash
cargo test --release
```

For performance testing with throughput measurements:

```bash
cargo test --release paxos_some_throughput
cargo test --release two_pc_some_throughput
```

## Running Examples

The repository includes example deployment programs:

```bash
# Run Paxos benchmark example
cargo run --example paxos

# Run Two-Phase Commit benchmark example
cargo run --example two_pc

# Run Compartmentalized Paxos benchmark example
cargo run --example compartmentalized_paxos

# Run with GCP deployment (requires GCP credentials)
cargo run --example paxos -- --gcp <project-name>
```

## Dependencies

The benchmarks depend on:
- `paxos.rs` - Core Paxos protocol implementation
- `paxos_with_client.rs` - Paxos with client interface
- `two_pc.rs` - Two-phase commit protocol implementation
- `kv_replica.rs` - Key-value replica for testing
- `kv_replica/sequence_payloads.rs` - Payload sequencing utilities
- `compartmentalized_paxos.rs` - Compartmentalized Paxos implementation

## Cross-Repository References

These benchmarks reference the main `bigweaver-agent-canary-hydro-zeta` repository for core dependencies:
- `hydro_lang` - Core Hydro language support
- `hydro_std` - Standard library for Hydro
- `dfir_lang` - Dataflow IR language support
- `hydro_deploy` - Deployment infrastructure
- `hydro_build_utils` - Build utilities

The relative path references in `Cargo.toml` ensure proper cross-repository integration.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup and contribution guidelines.