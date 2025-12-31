# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project.

## Benchmarks

The `benches/` directory contains microbenchmarks for DFIR (Hydro) and other dataflow frameworks, including performance comparisons with Timely Dataflow and Differential Dataflow.

### Available Benchmarks

The following benchmarks are available:

- **Graph Algorithms**:
  - `reachability` - Graph reachability algorithms
  
- **Join Operations**:
  - `join` - Join operations with different data types
  - `symmetric_hash_join` - Symmetric hash join operations
  
- **Micro Operations**:
  - `micro_ops` - Core micro-operations (map, flat_map, union, tee, fold, sort, etc.)
  - `arithmetic` - Arithmetic operations
  - `fan_in` - Fan-in patterns
  - `fan_out` - Fan-out patterns
  - `fork_join` - Fork-join patterns
  - `identity` - Identity operations
  - `upcase` - String uppercase operations
  - `words_diamond` - Word processing diamond patterns
  - `futures` - Future-based operations

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

To run benchmarks from within the benches directory:
```bash
cd benches
cargo bench
```

### Benchmark Output

Benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) for statistics-driven benchmarking and generate HTML reports in `target/criterion/`.

### Dependencies

The benchmarks depend on the main Hydro repository (bigweaver-agent-canary-hydro-zeta) which should be located alongside this repository. The benchmarks use the following components:
- `dfir_rs` - DFIR runtime
- `sinktools` - Sink utilities
- Timely Dataflow and Differential Dataflow for performance comparisons