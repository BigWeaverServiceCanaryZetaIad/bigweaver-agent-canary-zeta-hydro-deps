# bigweaver-agent-canary-zeta-hydro-deps

Performance comparison benchmarks with Timely and Differential-Dataflow dependencies.

## Overview

This repository contains benchmarks and code that depend on timely and differential-dataflow packages. It serves as a companion to the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository, enabling performance comparisons between different dataflow implementations.

## Setup

This repository has path dependencies on the main bigweaver-agent-canary-hydro-zeta repository. To use it, clone both repositories in the same parent directory:

```bash
# Clone both repositories
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Directory structure should look like:
# parent-directory/
# ├── bigweaver-agent-canary-hydro-zeta/
# └── bigweaver-agent-canary-zeta-hydro-deps/
```

## Purpose

The separation of these benchmarks allows:
1. **Reduced Build Dependencies** - The main repository can be developed without timely/differential-dataflow dependencies
2. **Faster Build Times** - Core development builds are faster without external dataflow dependencies
3. **Performance Comparison** - Maintained ability to compare Hydro implementations with Timely/Differential-Dataflow
4. **Clear Separation** - Clean architectural boundary between core implementation and comparative benchmarks

## Benchmarks

See the [benches/README.md](benches/README.md) for detailed information about available benchmarks and how to run them.

### Benchmark Categories

1. **Timely/Differential-Dataflow Specific**: arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase
2. **Cross-Implementation**: futures, micro_ops, symmetric_hash_join, words_diamond

## Running Benchmarks

```bash
cd benches
cargo bench
```

For specific benchmarks:
```bash
cargo bench --bench arithmetic
cargo bench --bench join
```

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations

## Migration History

This repository was created to house benchmarks migrated from bigweaver-agent-canary-hydro-zeta on December 17-18, 2024. See [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository for full migration details.