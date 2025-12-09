# Microbenchmarks

Performance comparison benchmarks of Hydro (dfir_rs), Timely Dataflow, and Differential Dataflow.

## Purpose

These benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Keep timely and differential-dataflow dependencies separate from the core Hydro codebase
- Maintain the ability to run performance comparisons independently
- Provide a dedicated space for framework comparison benchmarks

## Benchmark Descriptions

### Core Dataflow Patterns

- **arithmetic** - Chains of arithmetic operations (+1) comparing different dataflow implementations
- **identity** - Minimal overhead passthrough operations to measure base framework performance
- **micro_ops** - Microbenchmarks for individual dataflow operations (map, filter, fold, etc.)

### Stream Operations

- **fan_in** - Multiple input streams merging into a single output stream
- **fan_out** - Single input stream distributing to multiple output streams
- **fork_join** - Parallel processing paths that fork and then join back together

### Join Operations

- **join** - Standard join operations on two keyed streams
- **symmetric_hash_join** - Hash-based symmetric join implementations

### Advanced Patterns

- **reachability** - Graph reachability computation using Differential Dataflow's iterative operators
- **words_diamond** - Diamond-shaped dataflow with word processing (filter, transform, merge)
- **upcase** - String transformation operations
- **futures** - Async/await based dataflow patterns using Tokio

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

Run a specific benchmark function:
```bash
cargo bench -p benches --bench arithmetic -- "arithmetic/timely"
```

## Benchmark Data Files

- **words_alpha.txt** - English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- **reachability_edges.txt** - Graph edge data for reachability benchmarks
- **reachability_reachable.txt** - Expected reachability results for validation

## Implementation Comparisons

Most benchmarks include multiple implementations to compare:

- **dfir_rs** - Hydro's dataflow IR implementation
- **timely** - Timely Dataflow framework implementation
- **differential** - Differential Dataflow framework implementation (for iterative computations)
- **raw/pipeline** - Baseline implementations using standard Rust patterns

This allows for direct performance comparison between Hydro and established dataflow frameworks.
