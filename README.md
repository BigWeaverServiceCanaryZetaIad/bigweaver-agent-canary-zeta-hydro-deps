# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark and performance testing code for the Hydro project, separated from the main repository to maintain clean dependency management.

## Contents

### hydro_benches

Performance benchmarks and examples for distributed systems algorithms implemented using Hydro:

- **Paxos Benchmarks**: Performance testing for consensus protocols
  - Core Paxos implementation benchmarks
  - Compartmentalized Paxos benchmarks
  
- **Two-Phase Commit Benchmarks**: Performance testing for distributed transaction protocols

#### Examples

The repository includes runnable examples that demonstrate the benchmarking infrastructure:

- `paxos` - Runs a Paxos benchmark with configurable parameters
- `two_pc` - Runs a Two-Phase Commit benchmark
- `compartmentalized_paxos` - Runs a compartmentalized Paxos benchmark

Run examples with:
```bash
cargo run --example paxos
cargo run --example two_pc
cargo run --example compartmentalized_paxos
```

## Purpose

This repository structure allows the main Hydro repository to avoid unnecessary dependencies while maintaining the ability to run performance comparisons and benchmarks. The benchmarks depend on the core Hydro libraries but are maintained separately for better organization and dependency isolation.
