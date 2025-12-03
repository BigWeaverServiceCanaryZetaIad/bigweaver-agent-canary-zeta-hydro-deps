# Hydro Benchmarks

This repository contains performance benchmarks for the Hydro distributed programming framework. These benchmarks have been separated from the main Hydro repository to maintain clean dependency management and reduce compilation time for the core framework.

## Overview

The benchmarks in this repository test the performance characteristics of various distributed protocols and patterns implemented in Hydro, including:

- **Paxos**: Consensus protocol benchmarks testing throughput and latency
- **Two-Phase Commit (2PC)**: Distributed transaction coordination benchmarks
- **Compartmentalized Paxos**: Modular Paxos implementation benchmarks

## Structure

- `src/cluster/`: Core benchmark implementations and protocol modules
  - `paxos_bench.rs`: Paxos consensus benchmarking infrastructure
  - `two_pc_bench.rs`: Two-phase commit benchmarking infrastructure
  - `paxos.rs`: Core Paxos protocol implementation
  - `two_pc.rs`: Two-phase commit protocol implementation
  - `kv_replica.rs`: Key-value store replica for benchmarking
  - `compartmentalized_paxos.rs`: Modular Paxos implementation
  
- `examples/`: Runnable benchmark programs
  - `paxos.rs`: Run Paxos consensus benchmarks
  - `two_pc.rs`: Run two-phase commit benchmarks
  - `compartmentalized_paxos.rs`: Run compartmentalized Paxos benchmarks

## Running Benchmarks

### Prerequisites

- Rust nightly toolchain
- Hydro framework dependencies

### Local Execution

Run a benchmark locally:

```bash
cargo run --example paxos
cargo run --example two_pc
cargo run --example compartmentalized_paxos
```

### Cloud Execution (GCP)

Run benchmarks on Google Cloud Platform:

```bash
cargo run --example paxos -- --gcp <YOUR_GCP_PROJECT>
cargo run --example two_pc -- --gcp <YOUR_GCP_PROJECT>
```

## Performance Comparisons

These benchmarks allow you to:

1. **Measure throughput**: Requests processed per second under various loads
2. **Measure latency**: Request completion time distribution
3. **Compare protocols**: Evaluate trade-offs between different distributed protocols
4. **Test scaling**: Understand performance characteristics with varying cluster sizes

## Dependencies

The benchmarks depend on the main Hydro repository for:
- `hydro_lang`: Core Hydro language and runtime
- `hydro_std`: Standard library including benchmark utilities
- `hydro_deploy`: Deployment infrastructure for local and cloud execution

## Migration from Main Repository

These benchmarks were previously part of the main Hydro repository (`hydro_test` module) and were moved to maintain:

- **Clean dependency management**: Separate benchmark dependencies from core framework
- **Faster build times**: Core Hydro can be built without benchmark dependencies
- **Clear separation of concerns**: Benchmarks are development/testing tools, not core functionality

## Contributing

When adding new benchmarks:

1. Place protocol implementations in `src/cluster/`
2. Add runnable examples in `examples/`
3. Use the `hydro_std::bench_client` utilities for consistent metrics
4. Document benchmark parameters and expected outputs
5. Include both local and GCP deployment configurations

## Related Repositories

- [Main Hydro Repository](https://github.com/hydro-project/hydro): Core framework implementation
- [Hydro Documentation](https://hydro.run): Official documentation and guides
