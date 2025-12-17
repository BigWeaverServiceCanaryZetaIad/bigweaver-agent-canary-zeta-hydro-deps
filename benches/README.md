# Timely and Differential Dataflow Benchmarks

This repository contains benchmarks for timely and differential-dataflow dependencies that were moved from the main bigweaver-agent-canary-hydro-zeta repository.

## Prerequisites

These benchmarks compare the performance of timely/differential-dataflow against dfir_rs (Hydroflow). To run them, you need both repositories checked out side-by-side:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

The benchmarks use relative path dependencies to access `dfir_rs` and `sinktools` from the main repository.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Available Benchmarks

### Timely Benchmarks
- `arithmetic` - Arithmetic operations pipeline
- `fan_in` - Fan-in operations
- `fan_out` - Fan-out operations  
- `fork_join` - Fork-join pattern
- `identity` - Identity operations
- `join` - Join operations
- `upcase` - Uppercase transformation

### Differential Dataflow Benchmarks
- `reachability` - Graph reachability computation

## Performance Comparisons

These benchmarks can be used to compare performance across different versions of timely and differential-dataflow, as well as compare them against dfir_rs (Hydroflow). The benchmark results are stored in `target/criterion/` directory.

Each benchmark typically includes multiple implementations:
- Pure timely/differential-dataflow implementations
- dfir_rs (Hydroflow) implementations for comparison
- Baseline implementations (raw Rust, iterators, etc.)
