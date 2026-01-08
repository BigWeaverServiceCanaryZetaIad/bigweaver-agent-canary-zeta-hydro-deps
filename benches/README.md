# Timely and Differential Dataflow Benchmarks

Benchmarks for timely and differential-dataflow dependencies.

## Prerequisites

These benchmarks depend on `dfir_rs` and `sinktools` from the main repository. Ensure that the bigweaver-agent-canary-hydro-zeta repository is available at the expected relative path.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench upcase
```

## Benchmarks

- **arithmetic.rs** - Arithmetic operations benchmark using timely
- **upcase.rs** - String manipulation benchmark using timely  
- **reachability.rs** - Graph reachability benchmark using differential-dataflow and timely
- **fan_in.rs** - Fan-in pattern benchmark using timely
- **fan_out.rs** - Fan-out pattern benchmark using timely
- **fork_join.rs** - Fork-join pattern benchmark using timely
- **identity.rs** - Identity operations benchmark using timely
- **join.rs** - Join operations benchmark using timely

## Data Files

- **reachability_edges.txt** - Graph edges for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for validation
