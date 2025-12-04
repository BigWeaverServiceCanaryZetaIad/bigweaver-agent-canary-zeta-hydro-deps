# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on `timely-dataflow` and `differential-dataflow`. These have been separated from the main repository to reduce dependency bloat.

## Repository Structure

- `benches/` - Microbenchmarks for Hydro and comparison with timely/differential-dataflow implementations

## Benchmarks

The benchmarks in this repository compare Hydro implementations against baseline implementations using timely-dataflow and differential-dataflow.

### Running Benchmarks

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

### Available Benchmarks

- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in data flow patterns
- `fan_out` - Fan-out data flow patterns  
- `fork_join` - Fork-join patterns
- `futures` - Futures-based operations
- `identity` - Identity operations (baseline)
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability computation
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String uppercase transformation
- `words_diamond` - Diamond-shaped word processing

## Relationship to Main Repository

This repository benchmarks code from the main Hydro repository:
- Repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)

The benchmarks reference `dfir_rs` and `sinktools` from the main repository via git dependencies.

## Running Performance Comparisons

To compare performance between the main Hydro implementation and these benchmarks:

1. Run benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

2. Review the HTML reports generated in `target/criterion/`

3. Compare against baseline implementations (timely/differential-dataflow)

The criterion benchmarks will generate detailed performance reports including:
- Throughput measurements
- Latency distributions
- Performance trends over time
- Statistical analysis of results

## Dependencies

This repository depends on:
- `timely-dataflow` (timely-master package)
- `differential-dataflow` (differential-dataflow-master package)
- `dfir_rs` from the main Hydro repository
- `sinktools` from the main Hydro repository
- `criterion` for benchmarking

## Migration Note

These benchmarks were moved from the main Hydro repository to reduce the dependency footprint of the core project. The timely and differential-dataflow dependencies are only needed for comparative benchmarking and are not required for normal Hydro usage.