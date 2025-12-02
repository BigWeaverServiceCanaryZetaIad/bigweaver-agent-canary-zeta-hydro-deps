# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code with heavy dependencies (timely-dataflow, differential-dataflow) that have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce dependency bloat while maintaining the ability to run performance comparisons.

## Contents

### Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and comparison benchmarks with timely-dataflow and differential-dataflow.

**Running all benchmarks:**
```bash
cargo bench -p benches
```

**Running specific benchmarks:**
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

Available benchmarks:
- `arithmetic` - Basic arithmetic operations
- `fan_in` - Fan-in pattern benchmarks
- `fan_out` - Fan-out pattern benchmarks
- `fork_join` - Fork-join pattern benchmarks
- `futures` - Futures-based operations
- `identity` - Identity transformation benchmarks
- `join` - Join operation benchmarks
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability benchmarks
- `symmetric_hash_join` - Symmetric hash join benchmarks
- `upcase` - String transformation benchmarks
- `words_diamond` - Word processing diamond pattern

## Performance Comparison

This repository allows you to:
1. Compare Hydro performance against timely/differential-dataflow implementations
2. Run benchmarks independently without pulling heavy dependencies into the main repository
3. Maintain performance baselines and track regressions

## Development

To work with this repository:

1. Clone the repository:
   ```bash
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Run benchmarks:
   ```bash
   cargo bench
   ```

3. The benchmarks automatically fetch the latest version of dfir_rs and related crates from the main repository via git dependencies.

## Relationship to Main Repository

This repository is a companion to the main Hydro repository. When making changes:
- The main repository contains the core implementation without heavy benchmark dependencies
- This repository contains benchmarks that depend on both Hydro and external dataflow systems
- Both repositories can be updated independently
- Benchmarks automatically track the main branch of the Hydro repository

## Contributing

For contribution guidelines, please refer to the main [bigweaver-agent-canary-hydro-zeta repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).