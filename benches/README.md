# Performance Comparison Benchmarks

Microbenchmarks comparing Hydro (DFIR) against Timely Dataflow and Differential Dataflow.

## Running Benchmarks

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

## Available Benchmarks

- `arithmetic` - Basic arithmetic operations
- `fan_in` - Multiple input streams converging
- `fan_out` - Single stream splitting to multiple outputs
- `fork_join` - Fork-join pattern with filtering
- `identity` - Simple pass-through operations
- `join` - Join operations between streams
- `reachability` - Graph reachability algorithms (includes Differential Dataflow)
- `upcase` - String transformation operations

## Note

These benchmarks are maintained separately from the main Hydro repository to isolate dependencies on external dataflow frameworks. For Hydro-specific benchmarks (that don't require comparison with other frameworks), see the main repository.

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
