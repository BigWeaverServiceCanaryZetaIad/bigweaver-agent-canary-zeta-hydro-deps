# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance comparison benchmarks and dependencies that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository. The primary purpose is to maintain the ability to run performance comparisons between DFIR (Hydro) and other dataflow systems (timely-dataflow and differential-dataflow) without adding those systems as dependencies in the core Hydro codebase.

## Contents

### Benchmarks

The `benches/` directory contains performance comparison benchmarks that compare DFIR implementations against timely-dataflow and differential-dataflow. These benchmarks include:

- **arithmetic** - Arithmetic operation performance tests
- **fan_in** - Fan-in pattern benchmarks
- **fan_out** - Fan-out pattern benchmarks  
- **fork_join** - Fork-join pattern with filtering
- **identity** - Identity/pass-through operations
- **join** - Join operation comparisons
- **reachability** - Graph reachability algorithms
- **upcase** - String transformation benchmarks

See `benches/README.md` for detailed information on running the benchmarks.

## Purpose

By separating these benchmarks into their own repository, we achieve:

1. **Clean Dependency Management** - The main Hydro repository doesn't require timely/differential-dataflow dependencies
2. **Performance Comparisons** - We can still run comparative benchmarks when needed
3. **Focused Development** - The main repository remains focused on Hydro/DFIR development
4. **Maintained History** - Benchmark results and performance comparisons are preserved

## Usage

To run all benchmarks:

```bash
cargo bench
```

To run specific benchmark suites:

```bash
cargo bench -p timely-differential-benchmarks --bench arithmetic
```

## Related Repositories

- **Main Hydro Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Upstream Hydro**: https://github.com/hydro-project/hydro

## Migration Information

These benchmarks were migrated from the main repository to keep the core codebase free of external dataflow system dependencies. The DFIR-native benchmarks (micro_ops, futures, symmetric_hash_join, words_diamond) remain in the main repository as they don't require external dependencies.