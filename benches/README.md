# Timely and Differential-Dataflow Benchmarks

Performance comparison benchmarks for DFIR/Hydroflow vs timely-dataflow vs differential-dataflow.

## Overview

This repository contains microbenchmarks that compare the performance of:
- **DFIR/Hydroflow**: The Hydro dataflow framework
- **Timely Dataflow**: A low-latency data-parallel dataflow system
- **Differential Dataflow**: An incremental computation framework built on Timely

These benchmarks were separated from the main Hydro repository to:
- ✅ Reduce dependency footprint in the main repository
- ✅ Enable independent benchmark development and versioning
- ✅ Make performance testing optional (clone only when needed)
- ✅ Maintain cleaner separation of concerns

## Available Benchmarks

1. **arithmetic.rs** - Chain of arithmetic operations (map operations)
2. **fan_in.rs** - Multiple inputs converging to a single operator
3. **fan_out.rs** - Single input splitting to multiple operators
4. **fork_join.rs** - Parallel processing with fork and join patterns
5. **futures.rs** - Async futures-based processing
6. **identity.rs** - Identity transformation (passthrough)
7. **join.rs** - Join operations between streams
8. **micro_ops.rs** - Micro-operations performance testing
9. **reachability.rs** - Graph reachability algorithms
10. **symmetric_hash_join.rs** - Symmetric hash join operations
11. **upcase.rs** - String transformation operations
12. **words_diamond.rs** - Diamond-shaped dataflow patterns

## Prerequisites

- Rust (edition 2024)
- Cargo

## Running Benchmarks

### Run all benchmarks:
```bash
cargo bench -p benches
```

### Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

### Run a specific test within a benchmark:
```bash
cargo bench -p benches --bench arithmetic -- arithmetic/dfir_rs
cargo bench -p benches --bench arithmetic -- arithmetic/timely
```

## Benchmark Results

Benchmark results are generated in the `target/criterion` directory with HTML reports for easy visualization.

View the HTML report:
```bash
# After running benchmarks, open in browser:
open target/criterion/report/index.html
```

## Data Files

The benchmarks include test data files:
- **reachability_edges.txt** - Edge list for reachability tests (~524KB)
- **reachability_reachable.txt** - Expected reachable nodes (~40KB)
- **words_alpha.txt** - English word list for text processing tests (~3.7MB)
  - Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Dependencies

The benchmarks depend on:
- **criterion** - Benchmarking framework
- **dfir_rs** - Pulled from the main Hydro repository via git
- **sinktools** - Pulled from the main Hydro repository via git
- **timely** (timely-master) - For Timely Dataflow comparisons
- **differential-dataflow** (differential-dataflow-master) - For Differential Dataflow comparisons

## Performance Comparison

Each benchmark typically includes multiple implementations:
- Raw/baseline implementation (for reference)
- DFIR/Hydroflow implementation (surface and compiled variants)
- Timely Dataflow implementation
- Differential Dataflow implementation (where applicable)

This allows direct performance comparison between frameworks for the same workload.

## Contributing

When adding new benchmarks:
1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `Cargo.toml`
3. Follow the existing pattern for multi-framework comparisons
4. Include criterion benchmarking setup
5. Document the benchmark purpose and expected behavior

## Related Repositories

- **Main Hydro Repository**: https://github.com/hydro-project/hydro
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow

## Migration History

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository on 2024-11-21 to create a cleaner separation between core framework code and performance comparison benchmarks.
