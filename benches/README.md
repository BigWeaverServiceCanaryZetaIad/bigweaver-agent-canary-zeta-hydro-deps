# Microbenchmarks

Performance benchmarks for Hydro that depend on `timely` and `differential-dataflow`.

## Prerequisites

These benchmarks require access to the main `bigweaver-agent-canary-hydro-zeta` repository since they reference `dfir_rs` and `sinktools` via relative paths. Ensure both repositories are cloned as siblings:

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Available Benchmarks

### Timely Dataflow Benchmarks
- `arithmetic` - Tests arithmetic operations in dataflow
- `fan_in` - Tests stream concatenation and fan-in patterns
- `fan_out` - Tests stream splitting and fan-out patterns
- `fork_join` - Tests fork-join dataflow patterns
- `identity` - Tests identity operations (baseline performance)
- `join` - Tests join operations between streams
- `upcase` - Tests string transformation operations

### Differential Dataflow Benchmarks
- `reachability` - Tests graph reachability using differential dataflow

### Other Benchmarks
- `futures` - Tests async futures integration
- `micro_ops` - Tests various micro-operations
- `symmetric_hash_join` - Tests symmetric hash join operations
- `words_diamond` - Tests diamond-pattern dataflow with word processing

## Performance Comparison

To compare performance between different versions:

1. Checkout baseline version in `bigweaver-agent-canary-hydro-zeta`
2. Run benchmarks and save results:
   ```bash
   cargo bench -- --save-baseline baseline
   ```
3. Make your changes in `bigweaver-agent-canary-hydro-zeta`
4. Run benchmarks again to compare:
   ```bash
   cargo bench -- --baseline baseline
   ```

Criterion will automatically compare results and show performance differences.

## Data Files

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes
- `words_alpha.txt` - English wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Dependencies

These benchmarks depend on:
- `timely-master` (0.13.0-dev.1) - Timely dataflow framework
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow framework
- `dfir_rs` (from main repository) - DFIR runtime
- `sinktools` (from main repository) - Sink utilities
