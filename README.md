# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on timely and differential-dataflow packages.

## Benchmarks

The benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain a clean separation of core functionality from dependency-heavy benchmarking code.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

### Available Benchmarks

The following benchmarks are available:
- **arithmetic**: Arithmetic operations performance
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Async futures benchmarks
- **identity**: Identity operation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operations benchmarks
- **reachability**: Graph reachability benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase benchmarks
- **words_diamond**: Word processing diamond pattern benchmarks

### Data Files

The benchmarks use the following data files:
- `benches/benches/words_alpha.txt`: English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- `benches/benches/reachability_edges.txt`: Graph edges for reachability tests
- `benches/benches/reachability_reachable.txt`: Expected reachable nodes

### Dependencies

The benchmarks depend on:
- **timely**: Timely dataflow framework
- **differential-dataflow**: Differential dataflow framework
- **dfir_rs**: Hydro DFIR runtime (from main hydro repository)
- **sinktools**: Sink utilities (from main hydro repository)
- **criterion**: Benchmarking framework