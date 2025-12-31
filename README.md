# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies for the BigWeaver project, specifically timely and differential-dataflow benchmarks that were moved from the main hydro repository.

## Benchmarks

The benchmarks in this repository compare the performance of DFIR/Hydro against established dataflow frameworks like Timely Dataflow and Differential Dataflow.

### Available Benchmarks

- **arithmetic.rs** - Tests arithmetic operations performance using timely dataflow
- **fan_in.rs** - Tests fan-in operations using timely dataflow
- **fan_out.rs** - Tests fan-out operations
- **fork_join.rs** - Tests fork-join patterns
- **futures.rs** - Tests async/futures performance
- **identity.rs** - Tests identity operations
- **join.rs** - Tests join operations
- **micro_ops.rs** - Tests micro-operations (map, flat_map, union, tee, fold, sort, etc.)
- **reachability.rs** - Tests graph reachability algorithms using differential-dataflow
- **symmetric_hash_join.rs** - Tests symmetric hash join operations
- **upcase.rs** - Tests case conversion operations
- **words_diamond.rs** - Tests word processing in diamond pattern

## Running Benchmarks

To run the benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
```

## Dependencies

The benchmarks use:
- **timely-master** (v0.13.0-dev.1) - For timely dataflow comparisons
- **differential-dataflow-master** (v0.13.0-dev.1) - For differential dataflow comparisons
- **criterion** (v0.5.0) - For benchmarking framework
- **dfir_rs** - The main DFIR/Hydro implementation (from git)
- **sinktools** - Sink utilities for DFIR/Hydro (from git)
