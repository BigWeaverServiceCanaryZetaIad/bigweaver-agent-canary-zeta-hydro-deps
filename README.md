# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that have been moved from the main `bigweaver-agent-canary-hydro-zeta` repository to improve dependency management and reduce build times in the main codebase.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks for DFIR and other dataflow frameworks, including:
- `fan_in.rs` - Fan-in dataflow pattern benchmark
- `upcase.rs` - String case transformation benchmark
- `reachability.rs` - Graph reachability benchmark
- Additional benchmarks for various dataflow patterns

The benchmarks use Criterion for performance measurement and include dependencies on:
- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow library
- `dfir_rs` - DFIR runtime (from main repository via git dependency)

## Running Benchmarks

To run the benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench fan_in
cargo bench --bench upcase
cargo bench --bench reachability
```

## Dependencies

This repository references the main `bigweaver-agent-canary-hydro-zeta` repository via git dependencies for `dfir_rs` and `sinktools` crates.