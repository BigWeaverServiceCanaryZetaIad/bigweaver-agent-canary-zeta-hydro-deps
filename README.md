# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on heavyweight dependencies like `timely-dataflow` and `differential-dataflow`. These have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid dependency bloat and improve build times.

## Contents

### Benchmarks

The `benches` directory contains performance microbenchmarks for Hydro and related crates, comparing against timely-dataflow and differential-dataflow implementations.

**Running benchmarks:**

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns
- `fork_join` - Fork-join patterns
- `futures` - Futures-based operations
- `identity` - Identity operations
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability
- `symmetric_hash_join` - Symmetric hash join
- `upcase` - String uppercasing
- `words_diamond` - Word processing diamond pattern

## Migration from Main Repository

These benchmarks were previously located in the main bigweaver-agent-canary-hydro-zeta repository. They were moved here to:

1. **Reduce dependency bloat** - The main repository no longer needs to depend on timely/differential-dataflow
2. **Improve build times** - Heavyweight dependencies are isolated
3. **Maintain separation of concerns** - Performance benchmarks are separate from core functionality
4. **Preserve performance comparison capability** - Benchmarks against timely/differential remain available

For more information about the Hydro project, see the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).