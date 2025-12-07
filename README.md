# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and tests that depend on external libraries like timely and differential-dataflow. These have been moved from the main bigweaver-agent-canary-hydro-zeta repository to avoid adding these dependencies to the main codebase.

## Contents

- **benches/**: Microbenchmarks comparing Hydro performance with timely and differential-dataflow implementations

## Usage

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

- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns  
- `fork_join` - Fork-join patterns
- `futures` - Futures-based operations
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercasing
- `words_diamond` - Word processing diamond pattern

## Dependencies

This repository depends on:
- `timely-master` - Timely dataflow library
- `differential-dataflow-master` - Differential dataflow library
- `dfir_rs` - From the main bigweaver-agent-canary-hydro-zeta repository (via git dependency)
- `sinktools` - From the main bigweaver-agent-canary-hydro-zeta repository (via git dependency)

## Performance Comparisons

These benchmarks allow performance comparisons between Hydro and other dataflow frameworks to ensure Hydro remains competitive and to identify optimization opportunities.