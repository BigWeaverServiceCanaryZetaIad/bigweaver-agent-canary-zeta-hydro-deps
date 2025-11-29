# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that are isolated from the main bigweaver-agent-canary-hydro-zeta repository. This separation helps manage technical debt by keeping these specialized dependencies separate from the main codebase.

## Benchmarks

The `benches` directory contains performance benchmarks that compare Hydro with timely-dataflow and differential-dataflow implementations.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
```

### Available Benchmarks

- **arithmetic**: Pipeline arithmetic operations benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark  
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity transformation benchmark
- **join**: Join operations benchmark
- **reachability**: Graph reachability benchmark
- **upcase**: String uppercase transformation benchmark

Each benchmark compares the performance of Hydro implementations against timely-dataflow and differential-dataflow equivalents.