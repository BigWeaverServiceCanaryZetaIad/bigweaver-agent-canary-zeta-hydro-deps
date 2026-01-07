# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark code and dependencies for comparing Hydro's performance against timely and differential-dataflow implementations.

## Structure

- `benches/` - Performance comparison benchmarks between Hydro, Timely, and Differential Dataflow

## Dependencies

This repository includes the following external dependencies:
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow framework

These dependencies are used for performance comparison benchmarks.

## Integration with bigweaver-agent-canary-hydro-zeta

The benchmarks reference the main Hydro implementation (`dfir_rs` and `sinktools`) from the `bigweaver-agent-canary-hydro-zeta` repository via relative paths. Both repositories should be in the same parent directory structure:

```
/projects/sandbox/
  ├── bigweaver-agent-canary-hydro-zeta/
  │   ├── dfir_rs/
  │   ├── sinktools/
  │   └── ...
  └── bigweaver-agent-canary-zeta-hydro-deps/
      └── benches/
```

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

## Available Benchmarks

- `arithmetic` - Arithmetic operations
- `fan_in` - Fan-in pattern
- `fan_out` - Fan-out pattern
- `fork_join` - Fork-join pattern
- `futures` - Async futures operations
- `identity` - Identity transformations
- `join` - Join operations
- `micro_ops` - Micro-operations
- `reachability` - Graph reachability (uses differential-dataflow)
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercasing
- `words_diamond` - Word processing diamond pattern

Each benchmark compares multiple implementations:
- Hydro/dfir_rs implementations
- Timely dataflow implementations
- Differential dataflow implementations (where applicable)
- Baseline implementations (raw Rust, iterators, channels)