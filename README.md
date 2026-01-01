# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependency tests for DFIR (DataFlow in Rust) comparing performance against timely-dataflow and differential-dataflow frameworks.

## Repository Structure

This repository is organized as a Cargo workspace containing:

* `benches/` - Performance benchmarks comparing DFIR against timely and differential-dataflow frameworks
  * Includes benchmark files: fork_join.rs, fan_in.rs, reachability.rs, symmetric_hash_join.rs, futures.rs, join.rs, and more
  * Contains supporting data files for benchmarks (e.g., reachability_edges.txt, words_alpha.txt)
  * Includes benches/Cargo.toml with dependencies on timely-master and differential-dataflow-master packages
  * Includes benches/build.rs for benchmark generation

## Purpose

This repository maintains benchmarks in a separate workspace to:
- Enable clean separation of benchmark dependencies from core DFIR dependencies
- Prevent technical debt accumulation through cleaner dependency boundaries
- Allow focused performance comparison testing between DFIR and other dataflow frameworks
- Maintain the ability to run performance comparisons without affecting the main repository

## Running Benchmarks

To run the benchmarks, ensure you have Rust installed and then execute:

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench fork_join
cargo bench --bench reachability
cargo bench --bench join
# etc.
```

Available benchmarks include:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity operation benchmark
- `upcase` - String uppercase transformation benchmark
- `join` - Join operations benchmark
- `reachability` - Graph reachability benchmark
- `micro_ops` - Micro-operations benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `words_diamond` - Words diamond pattern benchmark
- `futures` - Futures-based operations benchmark

## Dependencies

The benchmarks depend on:
- `dfir_rs` - The main DFIR runtime (from bigweaver-agent-canary-hydro-zeta repository)
- `sinktools` - Sink utilities (from bigweaver-agent-canary-hydro-zeta repository)
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow framework
- `criterion` - Statistics-driven benchmarking library

## Coordinated Changes

When making changes that affect both this repository and the main bigweaver-agent-canary-hydro-zeta repository, ensure:
1. Changes to DFIR APIs are reflected in benchmark code
2. Path dependencies remain correct
3. Benchmarks continue to run and provide valid performance comparisons

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main DFIR/Hydro repository containing the core runtime and language implementation