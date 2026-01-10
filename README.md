# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies for the BigWeaver Agent Canary Zeta Hydro project. It isolates heavy dependencies like `timely` and `differential-dataflow` to maintain a clean dependency graph in the main repository.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro implementations with timely and differential-dataflow. These benchmarks enable performance comparisons across different dataflow implementations.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench join
```

#### Available Benchmarks

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Fan-in dataflow pattern
- **fan_out**: Fan-out dataflow pattern
- **fork_join**: Fork-join pattern
- **futures**: Futures-based operations
- **identity**: Identity transformation
- **join**: Join operations
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join
- **upcase**: String case conversion
- **words_diamond**: Diamond pattern with word processing

## Purpose

This repository serves as a dedicated location for benchmarks that require heavy dependencies (timely, differential-dataflow), following the team's best practice of separating dependencies to:

- Reduce compile times for the main repository
- Maintain cleaner dependency graphs
- Enable focused performance testing
- Support comparison benchmarks across different implementations

## Dependencies

The benchmarks depend on:
- **timely-master** (0.13.0-dev.1): Timely dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1): Differential dataflow
- **dfir_rs**: Referenced from the main hydro repository
- **sinktools**: Referenced from the main hydro repository
- **criterion**: For benchmark harness with async support

## Related Repositories

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
