# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that have been moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks for comparing Hydro with timely and differential-dataflow implementations. These benchmarks were moved from the main repository to avoid having direct dependencies on timely and differential-dataflow in the main codebase.

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench arithmetic
```

Available benchmarks:
- `arithmetic` - Arithmetic operations performance
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `identity` - Identity operation benchmarks
- `upcase` - String uppercase transformation
- `join` - Join operation benchmarks
- `reachability` - Graph reachability benchmarks
- `micro_ops` - Micro-operations benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `words_diamond` - Word processing diamond pattern
- `futures` - Futures-based benchmarks

## Migration Notes

These benchmarks were moved from the main repository to maintain a clean separation of concerns:
- The main repository focuses on core Hydro functionality without timely/differential-dataflow dependencies
- This repository maintains the performance comparison benchmarks
- Performance comparisons can still be run by checking out this repository separately