# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the bigweaver-agent-canary-hydro-zeta project.

## Benchmarks

The benchmarks compare Hydro with timely and differential-dataflow implementations to enable performance comparisons.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench arithmetic
```

### Available Benchmarks

- **arithmetic**: Arithmetic operations benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **futures**: Async futures benchmark
- **identity**: Identity transformation benchmark
- **join**: Join operations benchmark
- **micro_ops**: Micro-operations benchmark
- **reachability**: Graph reachability benchmark
- **symmetric_hash_join**: Symmetric hash join benchmark
- **upcase**: String uppercase transformation benchmark
- **words_diamond**: Diamond pattern with word processing benchmark

## Dependencies

This repository depends on:
- **dfir_rs** from bigweaver-agent-canary-hydro-zeta
- **sinktools** from bigweaver-agent-canary-hydro-zeta
- **timely** (timely-master 0.13.0-dev.1)
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1)

These dependencies enable performance comparisons between Hydro and timely/differential-dataflow implementations.