# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that require `timely` and `differential-dataflow` packages, separated from the main Hydro repository to keep the core repository lean and focused.

## Contents

### Benchmarks

Located in the `benches/` directory, this contains performance benchmarks comparing Hydro implementations with timely-dataflow and differential-dataflow.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations pipeline
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Async futures handling
- `identity` - Identity transformation
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String transformation (uppercase)
- `words_diamond` - Word processing diamond pattern

#### Performance Comparison with Main Repository

These benchmarks allow comparing Hydro's performance against timely-dataflow and differential-dataflow implementations. To run comparisons:

1. Run benchmarks in this repository:
   ```bash
   cargo bench -p benches
   ```

2. Results are stored in `target/criterion/` directory with HTML reports

3. Compare with equivalent implementations in the main Hydro repository

## Dependencies

This repository depends on:
- `timely` (timely-master) - For timely-dataflow benchmarks
- `differential-dataflow` (differential-dataflow-master) - For differential-dataflow benchmarks
- `dfir_rs` - Referenced from the main Hydro repository via git
- `sinktools` - Referenced from the main Hydro repository via git

## Relationship to Main Repository

The main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) no longer contains timely and differential-dataflow dependencies. This separation provides:

1. **Cleaner dependency graph** - Main repository doesn't carry unnecessary benchmark dependencies
2. **Focused development** - Core Hydro development without benchmark overhead
3. **Maintained benchmarks** - Performance comparisons remain available when needed
4. **Flexibility** - Benchmarks can be updated independently

## Development

To add new benchmarks:

1. Add benchmark file to `benches/benches/` directory
2. Register the benchmark in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```
3. Run with `cargo bench -p benches --bench your_benchmark_name`

## References

- Wordlist used in benchmarks: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Main Hydro repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta