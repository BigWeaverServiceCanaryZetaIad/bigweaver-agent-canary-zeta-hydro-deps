# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks comparing Hydro/DFIR performance against Timely Dataflow and Differential Dataflow.

## Benchmarks

### arithmetic.rs
Benchmarks arithmetic operations (repeated map operations) comparing:
- Timely Dataflow
- Hydroflow (compiled and surface syntax)
- Raw pipeline implementation
- Iterator-based approaches

### identity.rs
Benchmarks identity operations (repeated map with black_box) comparing:
- Timely Dataflow
- Hydroflow (scheduled, compiled, and surface syntax)
- Raw pipeline implementation
- Iterator-based approaches

### reachability.rs
Benchmarks graph reachability algorithms comparing:
- Timely Dataflow
- Differential Dataflow
- Hydroflow (scheduled and surface syntax)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench arithmetic
cargo bench --bench identity
cargo bench --bench reachability
```

## Dependencies

These benchmarks depend on:
- **timely-master**: Timely Dataflow framework
- **differential-dataflow-master**: Differential Dataflow framework
- **dfir_rs**: Hydroflow runtime (referenced from main repository)
- **criterion**: Benchmarking framework

The `dfir_rs` and `sinktools` dependencies are pulled from the main bigweaver-agent-canary-hydro-zeta repository via git dependencies.
