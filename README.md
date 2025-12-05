# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were moved from the main 
[bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) 
repository. This separation allows for:

- Reduced dependency footprint in the main repository
- Improved build times for the main project
- Better separation of concerns
- Independent execution of benchmarks
- Maintained ability to run performance comparisons

## Benchmarks

The repository includes timely and differential-dataflow benchmarks for performance testing. 
See [benches/README.md](benches/README.md) for details on running individual benchmarks.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

### Available Benchmarks

- `arithmetic` - Arithmetic operations benchmarks
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Futures-based benchmarks
- `identity` - Identity transformation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operations benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String uppercase transformation benchmarks
- `words_diamond` - Word processing diamond pattern benchmarks

## Performance Comparison

Benchmarks in this repository can be used to compare performance with the main repository. 
The benchmarks use [Criterion](https://github.com/bheisler/criterion.rs) for statistical 
analysis and HTML report generation.

## Dependencies

This repository includes dependencies on:
- `timely` (timely-master 0.13.0-dev.1) - Timely dataflow system
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1) - Differential dataflow computations
- `dfir_rs` - DFIR runtime for Rust (from main repository)
- `sinktools` - Utility tools (from main repository)
- `criterion` - Benchmarking framework

Dependencies from the main repository (dfir_rs, sinktools) are referenced via git to maintain 
compatibility while allowing independent execution.