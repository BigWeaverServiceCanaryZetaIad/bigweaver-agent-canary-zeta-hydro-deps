# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks with timely and differential-dataflow dependencies that have been moved from the main bigweaver-agent-canary-hydro-zeta repository.

## Contents

### Benchmarks (`benches/`)

Microbenchmarks for Hydro and other crates, including:

- **upcase.rs** - String manipulation benchmarks comparing raw, iterator, and timely approaches
- **reachability.rs** - Graph reachability benchmarks using differential-dataflow
- **arithmetic.rs** - Arithmetic operation benchmarks
- **fan_in.rs** / **fan_out.rs** - Data flow pattern benchmarks
- **fork_join.rs** - Fork-join pattern benchmarks
- **futures.rs** - Async futures benchmarks
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **words_diamond.rs** - Word processing diamond pattern benchmarks

### Data Files

- **reachability_edges.txt** - Edge data for reachability benchmarks
- **reachability_reachable.txt** - Reachable nodes data
- **words_alpha.txt** - English word list for word processing benchmarks

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench upcase
```

## Dependencies

The benchmarks use git dependencies to reference the main Hydro repository for:
- `dfir_rs` - Hydro dataflow runtime
- `sinktools` - Utility tools

This allows performance comparisons to be run independently while maintaining access to the necessary Hydro components.