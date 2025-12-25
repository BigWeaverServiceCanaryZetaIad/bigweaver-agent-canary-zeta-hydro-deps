# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for DFIR and comparison frameworks including Timely Dataflow and Differential Dataflow.

## Contents

The `benches` directory contains microbenchmarks that compare DFIR's performance against other dataflow frameworks:

- **upcase.rs** - String case conversion benchmark
- **join.rs** - Join operation benchmark
- **reachability.rs** - Graph reachability benchmark
- **arithmetic.rs** - Basic arithmetic operations
- **fan_in.rs** - Fan-in pattern benchmark
- **fan_out.rs** - Fan-out pattern benchmark
- **fork_join.rs** - Fork-join pattern benchmark
- **identity.rs** - Identity operation benchmark
- **micro_ops.rs** - Micro-operation benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmark
- **words_diamond.rs** - Word processing diamond pattern
- **futures.rs** - Futures-based operations

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench
```

To run a specific benchmark:
```bash
cargo bench --bench <benchmark_name>
```

For example:
```bash
cargo bench --bench upcase
cargo bench --bench join
cargo bench --bench reachability
```

## Dependencies

The benchmarks use:
- **criterion** - For benchmark harness and reporting
- **dfir_rs** - The DFIR runtime (version 0.14.0)
- **timely** - Timely Dataflow framework
- **differential-dataflow** - Differential Dataflow framework
- Additional utilities: futures, rand, tokio, etc.