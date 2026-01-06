# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that were migrated from the bigweaver-agent-canary-hydro-zeta repository.

## Contents

- **benches/**: Performance benchmarks comparing DFIR operations against timely and differential-dataflow implementations

## Purpose

This repository isolates the timely and differential-dataflow dependencies and their associated benchmarks from the main bigweaver-agent-canary-hydro-zeta repository. This separation:

1. Reduces complexity in the main repository
2. Keeps benchmark-specific dependencies isolated
3. Maintains full benchmark capabilities for performance comparison
4. Allows independent versioning and updates of benchmark dependencies

## Running Benchmarks

To run the benchmarks:

```bash
cargo bench --workspace
```

Individual benchmarks can be run with:

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- arithmetic
- fan_in
- fan_out
- fork_join
- identity
- upcase
- join
- reachability
- micro_ops
- symmetric_hash_join
- words_diamond
- futures

## Dependencies

The benchmarks depend on:
- `dfir_rs` - Referenced from the main bigweaver-agent-canary-hydro-zeta repository via git
- `sinktools` - Referenced from the main bigweaver-agent-canary-hydro-zeta repository via git
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow framework
- `criterion` - Benchmarking framework
