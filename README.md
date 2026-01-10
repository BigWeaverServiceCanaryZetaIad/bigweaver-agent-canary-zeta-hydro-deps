# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for Hydro that rely on external dataflow frameworks like Timely Dataflow and Differential Dataflow.

## Purpose

This repository is designed to isolate benchmarks that require dependencies on:
- `timely` (Timely Dataflow)
- `differential-dataflow` (Differential Dataflow)

By separating these benchmarks into a dedicated repository, we reduce the dependency footprint of the main bigweaver-agent-canary-hydro-zeta repository while retaining the ability to run performance comparisons between Hydroflow and other dataflow systems.

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks comparing Hydroflow implementations with Timely Dataflow and Differential Dataflow:

- **join.rs**: Join operation benchmarks comparing Timely and Hydroflow implementations
- **fan_in.rs**: Fan-in operation benchmarks for Timely Dataflow
- **reachability.rs**: Graph reachability benchmarks using Differential Dataflow
- Additional benchmarks for various dataflow patterns

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench join
cargo bench --bench fan_in
cargo bench --bench reachability
```

## Dependencies

This repository depends on:
- `dfir_rs`: Core Hydroflow functionality (from main repository)
- `sinktools`: Utility tools (from main repository)
- `timely-master`: Timely Dataflow framework
- `differential-dataflow-master`: Differential Dataflow framework
- `criterion`: Benchmarking framework

## Development

The benchmarks in this repository help maintain performance parity and provide comparative analysis between Hydroflow and other established dataflow systems. When adding new benchmarks, ensure they:

1. Include both Hydroflow and comparison implementations
2. Use representative workloads
3. Follow the existing benchmark structure
4. Document any specific setup or data requirements