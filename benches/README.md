# Hydro Performance Comparison Benchmarks

This directory contains performance comparison benchmarks comparing Hydro/DFIR implementations against Timely Dataflow and Differential Dataflow.

## Purpose

These benchmarks were separated from the main Hydro repository to:
- Isolate external dependencies (timely-dataflow and differential-dataflow) from the core codebase
- Maintain performance comparison capabilities
- Reduce build times for developers working on Hydro core
- Allow independent versioning and CI/CD for benchmarks

## Benchmark Descriptions

### Core Operation Benchmarks

- **arithmetic.rs** - Arithmetic operations (addition, multiplication)
- **identity.rs** - Identity/pass-through operations
- **upcase.rs** - String transformation operations

### Data Flow Pattern Benchmarks

- **fan_in.rs** - Multiple inputs converging to single output
- **fan_out.rs** - Single input distributing to multiple outputs  
- **fork_join.rs** - Fork-join computation patterns

### Join Operation Benchmarks

- **join.rs** - Simple join operations between streams
- **reachability.rs** - Graph reachability using iterative joins (complex)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p hydro-benches-comparison
```

Run a specific benchmark:
```bash
cargo bench -p hydro-benches-comparison --bench arithmetic
cargo bench -p hydro-benches-comparison --bench reachability
```

## Benchmark Structure

Each benchmark file typically contains three implementations:
1. **DFIR/Hydroflow** - Native Hydro implementation
2. **Timely Dataflow** - Reference implementation using Timely
3. **Differential Dataflow** - Reference implementation using Differential (where applicable)

This allows direct performance comparisons between the frameworks.

## Test Data

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation

## Build Script

`build.rs` - Build-time code generation for benchmark infrastructure

## Adding New Benchmarks

To add a new comparison benchmark:

1. Create the benchmark file in `benches/`
2. Implement the three variants (DFIR, Timely, Differential as applicable)
3. Add a `[[bench]]` entry in `Cargo.toml`
4. Update this README with a description
5. Include any required test data files

## DFIR-Native Benchmarks

For benchmarks that only test DFIR/Hydro without external framework comparisons, see the main repository:
`bigweaver-agent-canary-hydro-zeta/benches/`

Those benchmarks include:
- `micro_ops` - Micro-operation performance tests
- `futures` - Async/futures performance
- `symmetric_hash_join` - Symmetric hash join implementation
- `words_diamond` - Word processing patterns
