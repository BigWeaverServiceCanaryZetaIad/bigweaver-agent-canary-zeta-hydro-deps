# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that rely on timely-dataflow and differential-dataflow.

## Structure

- **benches/**: Performance benchmarks including timely-dataflow and differential-dataflow tests

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

## Available Benchmarks

The following benchmarks are available:
- `arithmetic`: Arithmetic operations benchmarks
- `fan_in`: Fan-in dataflow pattern
- `fan_out`: Fan-out dataflow pattern
- `fork_join`: Fork-join pattern
- `futures`: Futures-based operations
- `identity`: Identity transformation
- `join`: Join operations
- `micro_ops`: Micro-operation benchmarks
- `reachability`: Graph reachability algorithms
- `symmetric_hash_join`: Symmetric hash join operations
- `upcase`: String uppercasing
- `words_diamond`: Word processing in diamond pattern

## Dependencies

These benchmarks depend on:
- `dfir_rs`: Core Hydro dataflow runtime
- `sinktools`: Utility tools
- `timely-dataflow`: Timely dataflow framework
- `differential-dataflow`: Differential dataflow framework

Dependencies from the main Hydro repository are referenced via git.