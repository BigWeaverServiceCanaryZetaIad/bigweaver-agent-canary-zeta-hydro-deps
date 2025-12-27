# Microbenchmarks

Of Hydro and other crates.

**Note**: This benchmark suite has been moved to the `bigweaver-agent-canary-zeta-hydro-deps` repository to isolate benchmark dependencies (timely and differential-dataflow) from the main Hydro codebase.

## Running Benchmarks

From the bigweaver-agent-canary-zeta-hydro-deps repository root:
```bash
cargo bench -p benches
```

Run all benchmarks from this directory:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench micro_ops
```

## Available Benchmarks

- **arithmetic**: Pipeline and operator arithmetic benchmarks
- **fan_in/fan_out**: Fan-in and fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Async futures benchmarks
- **identity**: Identity operation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operation benchmarks (map, flat_map, union, tee, fold, sort, etc.)
- **reachability**: Graph reachability benchmarks (Hydro vs Differential Dataflow)
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String transformation benchmarks
- **words_diamond**: Word processing diamond pattern benchmarks

## Data Files

- `reachability_edges.txt`: Edge data for reachability benchmarks
- `reachability_reachable.txt`: Expected reachable nodes for validation
- `words_alpha.txt`: English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Dependencies

This benchmark suite uses:
- **timely-master** (0.13.0-dev.1): For Timely Dataflow comparisons
- **differential-dataflow-master** (0.13.0-dev.1): For Differential Dataflow comparisons
- **dfir_rs**: Main Hydro DFIR runtime (referenced from main repository)
- **sinktools**: Hydro utilities (referenced from main repository)
- **criterion**: For statistical benchmarking

