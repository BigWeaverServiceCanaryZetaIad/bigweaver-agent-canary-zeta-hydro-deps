# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce dependency bloat.

## Contents

### Benchmarks

The `benches/` directory contains performance comparison benchmarks between Hydro (dfir_rs) and other dataflow systems (timely-dataflow and differential-dataflow). These benchmarks were moved here to:

- Remove heavy dependencies (`timely` and `differential-dataflow`) from the main repository
- Maintain the ability to run performance comparisons
- Keep build times fast for the main repository
- Preserve historical benchmark data

## Running Benchmarks

To run the benchmarks:

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches -- <benchmark_name>

# Examples:
cargo bench -p benches -- dfir
cargo bench -p benches -- micro/ops/
```

## Available Benchmarks

- **arithmetic**: Basic arithmetic operations
- **fan_in**: Data convergence patterns
- **fan_out**: Data distribution patterns
- **fork_join**: Fork-join parallelism patterns
- **futures**: Async/futures operations
- **identity**: Identity transformations
- **join**: Join operations
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability algorithms
- **symmetric_hash_join**: Symmetric hash join implementations
- **upcase**: String transformation operations
- **words_diamond**: Diamond pattern processing

## CI/CD

Benchmarks are automatically run via GitHub Actions on:
- Push to `main` branch (when commit message contains `[ci-bench]`)
- Pull requests (when title or body contains `[ci-bench]`)
- Scheduled daily runs
- Manual workflow dispatch

Results are published to the `gh-pages` branch.

## Dependencies

The benchmarks depend on:
- `dfir_rs` and `sinktools` from the main repository (via git dependencies)
- `timely-master` and `differential-dataflow-master` (for comparison)
- Various support crates (criterion, tokio, etc.)

## Contributing

When modifying benchmarks, ensure they continue to provide fair comparisons between systems. See `CONTRIBUTING.md` for detailed guidelines.