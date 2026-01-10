# Microbenchmarks

Benchmarks for timely and differential-dataflow operations with Hydro.

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to:
- Keep the main repository free from timely and differential-dataflow dependencies
- Preserve the ability to run performance comparisons
- Maintain a cleaner codebase organization

## Available Benchmarks

- **arithmetic.rs**: Arithmetic operations with timely dataflow
- **fan_in.rs**: Fan-in patterns with timely dataflow
- **fan_out.rs**: Fan-out patterns with timely dataflow
- **fork_join.rs**: Fork-join patterns with timely dataflow
- **identity.rs**: Identity operations with timely dataflow
- **join.rs**: Join operations with timely dataflow
- **reachability.rs**: Graph reachability with differential-dataflow
- **upcase.rs**: String transformation with timely dataflow

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Data Files

- `reachability_edges.txt`: Edge data for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes for reachability benchmark
