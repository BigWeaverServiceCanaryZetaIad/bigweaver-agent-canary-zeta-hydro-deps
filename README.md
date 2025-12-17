# bigweaver-agent-canary-zeta-hydro-deps

Performance comparison benchmarks with Timely and Differential Dataflow dependencies.

## Overview

This repository contains benchmarks that compare Hydro's DFIR implementation with Timely Dataflow and Differential Dataflow implementations. These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid adding unnecessary dependencies to the core project.

## Purpose

The benchmarks in this repository enable performance comparison between:
- Hydro DFIR-native implementations
- Timely Dataflow implementations  
- Differential Dataflow implementations

This separation allows the main Hydro repository to maintain faster build times and a cleaner dependency graph while still preserving the ability to run performance comparisons.

## Contents

- **benches/** - Benchmark suite comparing Hydro with timely/differential-dataflow

## Running Benchmarks

```bash
cd benches
cargo bench
```

For more details, see:
- [QUICK_START.md](QUICK_START.md) - Quick reference for running benchmarks
- [benches/README.md](benches/README.md) - Detailed benchmark documentation

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations

## Migration

These benchmarks were migrated from the main repository on December 17, 2024. For migration details, see:
- [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) - Migration documentation in the main repository
- [MIGRATION_VERIFICATION.md](MIGRATION_VERIFICATION.md) - Migration verification checklist
- [BENCHMARK_VERIFICATION_REPORT.md](BENCHMARK_VERIFICATION_REPORT.md) - Comprehensive verification report