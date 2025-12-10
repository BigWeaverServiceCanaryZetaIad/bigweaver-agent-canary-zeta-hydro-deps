# Hydro Benchmarks

This repository contains benchmark implementations for the Hydro distributed programming framework, separated from the main Hydro repository to maintain clean dependency management.

## Contents

### hydro_benchmarks

A library crate containing benchmark implementations for distributed protocols:

- **Paxos Benchmark** (`paxos_bench.rs`): Performance benchmarking for the Paxos consensus protocol
- **Two-Phase Commit Benchmark** (`two_pc_bench.rs`): Performance benchmarking for the Two-Phase Commit protocol
- **Supporting modules**: KV replica implementation, Paxos client interface, and Two-PC protocol implementation

## Usage

This repository is intended to be used as a Git dependency in Hydro projects that need to run performance comparisons:

```toml
[dependencies]
hydro_benchmarks = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git" }
```

## Running Benchmarks

The benchmarks are designed to be run through the main Hydro repository's examples and test suites. See the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository for deployment examples and instructions.

## Performance Comparison

This separation allows:
- Independent versioning of benchmark code
- Cleaner dependency management in the main repository
- Ability to run performance comparisons against historical benchmarks
- Reduced compile times for non-benchmark workflows