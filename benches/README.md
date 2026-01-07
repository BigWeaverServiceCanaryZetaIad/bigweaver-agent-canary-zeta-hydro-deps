# Timely and Differential Dataflow Benchmarks

Benchmarks comparing Hydro with Timely and Differential Dataflow frameworks.

## Prerequisites

These benchmarks require the main bigweaver-agent-canary-hydro-zeta repository to be located at `../../bigweaver-agent-canary-hydro-zeta` relative to this repository, as they depend on `dfir_rs` and `sinktools` from the main repository.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-deps-benches
```

Run specific benchmarks:
```bash
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench arithmetic
cargo bench -p hydro-deps-benches --bench join
```

## Available Benchmarks

- **arithmetic**: Arithmetic operations comparison
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance  
- **fork_join**: Fork-join pattern performance
- **identity**: Identity transformation performance
- **upcase**: String uppercasing performance
- **join**: Join operation performance
- **reachability**: Graph reachability computation (uses differential dataflow)

## Data Files

- `reachability_edges.txt`: Graph edges for reachability benchmark
- `reachability_reachable.txt`: Expected reachable nodes for reachability benchmark
